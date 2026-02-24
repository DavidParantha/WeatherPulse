package com.david.weather.controller;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.david.weather.dao.PreferenceDao;
import com.david.weather.model.AlertPreferences;
import com.david.weather.model.User;
import com.david.weather.service.AlertService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

@WebServlet("/weather")
public class WeatherServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String city = request.getParameter("city");

        if (city == null || city.trim().isEmpty()) {
            request.setAttribute("error", "Please enter a city name.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }

        try {
            // Geocoding
            String geoUrl = "https://geocoding-api.open-meteo.com/v1/search?name=" + city;
            JsonObject geoJson = JsonParser.parseString(sendGet(geoUrl)).getAsJsonObject();
            JsonArray results = geoJson.getAsJsonArray("results");

            if (results == null || results.size() == 0) {
                request.setAttribute("error", "City not found.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
                return;
            }

            JsonObject first = results.get(0).getAsJsonObject();
            String lat = first.get("latitude").getAsString();
            String lon = first.get("longitude").getAsString();
            String resolvedCity = first.has("name") ? first.get("name").getAsString() : city;
            String country = first.has("country") ? first.get("country").getAsString() : "";

            // Current weather + Hourly rain + Daily forecast
            String weatherUrl = String.format(
                    "https://api.open-meteo.com/v1/forecast?latitude=%s&longitude=%s" +
                            "&current_weather=true" +
                            "&hourly=precipitation,relative_humidity_2m" +
                            "&daily=temperature_2m_max,temperature_2m_min,weathercode,precipitation_sum" +
                            "&forecast_days=5" +
                            "&timezone=auto",
                    lat, lon);
            JsonObject weatherJson = JsonParser.parseString(sendGet(weatherUrl)).getAsJsonObject();
            JsonObject current = weatherJson.getAsJsonObject("current_weather");

            double temp = current.get("temperature").getAsDouble();
            double wind = current.get("windspeed").getAsDouble();
            int weatherCode = current.get("weathercode").getAsInt();

            // Humidity (first hourly value)
            JsonArray humidityArr = weatherJson.getAsJsonObject("hourly").getAsJsonArray("relative_humidity_2m");
            int humidity = humidityArr.size() > 0 ? humidityArr.get(0).getAsInt() : 0;

            // Rain (first hourly value)
            JsonArray precipitation = weatherJson.getAsJsonObject("hourly").getAsJsonArray("precipitation");
            double rainMm = precipitation.size() > 0 ? precipitation.get(0).getAsDouble() : 0;

            // 5-Day forecast
            JsonObject daily = weatherJson.getAsJsonObject("daily");
            JsonArray dates = daily.getAsJsonArray("time");
            JsonArray maxTemps = daily.getAsJsonArray("temperature_2m_max");
            JsonArray minTemps = daily.getAsJsonArray("temperature_2m_min");
            JsonArray weatherCodes = daily.getAsJsonArray("weathercode");
            JsonArray dailyPrecip = daily.getAsJsonArray("precipitation_sum");

            List<String[]> forecast = new ArrayList<>();
            for (int i = 0; i < dates.size() && i < 5; i++) {
                String dateStr = dates.get(i).getAsString();
                LocalDate date = LocalDate.parse(dateStr);
                String dayName = i == 0 ? "Today" : date.getDayOfWeek().getDisplayName(TextStyle.SHORT, Locale.ENGLISH);

                String[] day = new String[6];
                day[0] = dayName;
                day[1] = String.valueOf(Math.round(maxTemps.get(i).getAsDouble()));
                day[2] = String.valueOf(Math.round(minTemps.get(i).getAsDouble()));
                day[3] = getWeatherEmoji(weatherCodes.get(i).getAsInt());
                day[4] = getWeatherDescription(weatherCodes.get(i).getAsInt());
                day[5] = String.format("%.1f", dailyPrecip.get(i).getAsDouble());
                forecast.add(day);
            }

            // Air quality (PM2.5)
            String airUrl = String.format(
                    "https://air-quality-api.open-meteo.com/v1/air-quality?latitude=%s&longitude=%s&hourly=pm2_5",
                    lat, lon);
            JsonObject airJson = JsonParser.parseString(sendGet(airUrl)).getAsJsonObject();
            JsonArray pm25Arr = airJson.getAsJsonObject("hourly").getAsJsonArray("pm2_5");
            double pm25 = pm25Arr.size() > 0 ? pm25Arr.get(0).getAsDouble() : 0;

            // Alerts
            User user = (User) request.getSession().getAttribute("user");
            AlertPreferences prefs = user != null ? PreferenceDao.get(user.getEmail()) : null;

            AlertService alertService = new AlertService();
            List<String> alerts = alertService.evaluate(prefs, temp, rainMm, pm25);

            // Send to UI
            request.setAttribute("city", resolvedCity);
            request.setAttribute("country", country);
            request.setAttribute("temp", temp);
            request.setAttribute("wind", wind);
            request.setAttribute("rainMm", rainMm);
            request.setAttribute("pm25", pm25);
            request.setAttribute("humidity", humidity);
            request.setAttribute("weatherEmoji", getWeatherEmoji(weatherCode));
            request.setAttribute("weatherDesc", getWeatherDescription(weatherCode));
            request.setAttribute("alerts", alerts);
            request.setAttribute("forecast", forecast);

            request.getRequestDispatcher("index.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to fetch weather. Please try again.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    private String sendGet(String urlStr) throws Exception {
        HttpURLConnection con = (HttpURLConnection) new URL(urlStr).openConnection();
        con.setRequestMethod("GET");

        BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String line;
        StringBuilder sb = new StringBuilder();
        while ((line = br.readLine()) != null)
            sb.append(line);
        br.close();

        return sb.toString();
    }

    private String getWeatherEmoji(int code) {
        if (code == 0)
            return "☀️";
        if (code <= 3)
            return "⛅";
        if (code <= 49)
            return "🌫️";
        if (code <= 59)
            return "🌦️";
        if (code <= 69)
            return "🌧️";
        if (code <= 79)
            return "🌨️";
        if (code <= 84)
            return "🌧️";
        if (code <= 86)
            return "❄️";
        if (code <= 99)
            return "⛈️";
        return "🌡️";
    }

    private String getWeatherDescription(int code) {
        if (code == 0)
            return "Clear sky";
        if (code == 1)
            return "Mainly clear";
        if (code == 2)
            return "Partly cloudy";
        if (code == 3)
            return "Overcast";
        if (code <= 49)
            return "Foggy";
        if (code <= 55)
            return "Drizzle";
        if (code <= 59)
            return "Freezing drizzle";
        if (code <= 65)
            return "Rain";
        if (code <= 69)
            return "Freezing rain";
        if (code <= 75)
            return "Snowfall";
        if (code <= 79)
            return "Snow grains";
        if (code <= 84)
            return "Rain showers";
        if (code <= 86)
            return "Snow showers";
        if (code == 95)
            return "Thunderstorm";
        if (code <= 99)
            return "Thunderstorm with hail";
        return "Unknown";
    }
}
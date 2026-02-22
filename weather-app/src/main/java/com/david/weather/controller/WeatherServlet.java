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
import java.util.List;

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

            // Weather + Rain
            String weatherUrl = String.format(
                    "https://api.open-meteo.com/v1/forecast?latitude=%s&longitude=%s&current_weather=true&hourly=precipitation",
                    lat, lon
            );
            JsonObject weatherJson = JsonParser.parseString(sendGet(weatherUrl)).getAsJsonObject();
            JsonObject current = weatherJson.getAsJsonObject("current_weather");

            double temp = current.get("temperature").getAsDouble();
            double wind = current.get("windspeed").getAsDouble();

            JsonArray precipitation = weatherJson.getAsJsonObject("hourly").getAsJsonArray("precipitation");
            double rainMm = precipitation.size() > 0 ? precipitation.get(0).getAsDouble() : 0;

            // Air quality (PM2.5)
            String airUrl = String.format(
                    "https://air-quality-api.open-meteo.com/v1/air-quality?latitude=%s&longitude=%s&hourly=pm2_5",
                    lat, lon
            );
            JsonObject airJson = JsonParser.parseString(sendGet(airUrl)).getAsJsonObject();
            JsonArray pm25Arr = airJson.getAsJsonObject("hourly").getAsJsonArray("pm2_5");
            double pm25 = pm25Arr.size() > 0 ? pm25Arr.get(0).getAsDouble() : 0;

            // Alerts
            User user = (User) request.getSession().getAttribute("user");
            AlertPreferences prefs = user != null ? PreferenceDao.get(user.getEmail()) : null;

            AlertService alertService = new AlertService();
            List<String> alerts = alertService.evaluate(prefs, temp, rainMm, pm25);

            // Send to UI
            request.setAttribute("city", city);
            request.setAttribute("temp", temp);
            request.setAttribute("wind", wind);
            request.setAttribute("rainMm", rainMm);
            request.setAttribute("pm25", pm25);
            request.setAttribute("alerts", alerts);

            request.getRequestDispatcher("index.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to fetch weather.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    private String sendGet(String urlStr) throws Exception {
        HttpURLConnection con = (HttpURLConnection) new URL(urlStr).openConnection();
        con.setRequestMethod("GET");

        BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String line;
        StringBuilder sb = new StringBuilder();
        while ((line = br.readLine()) != null) sb.append(line);
        br.close();

        return sb.toString();
    }
}
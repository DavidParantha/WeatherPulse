<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>WeatherPulse — Real-time Weather & Alerts</title>
        <link rel="stylesheet" href="css/theme.css">
    </head>

    <body>

        <nav class="navbar">
            <div class="logo">☁ WeatherPulse</div>
            <div class="links">
                <a class="active" href="index.jsp">Home</a>
                <a href="about.jsp">About</a>
                <span id="themeToggle">🌙</span>
                <% if (session.getAttribute("user") !=null) { %>
                    <a href="profile.jsp">Profile</a>
                    <a href="logout">Logout</a>
                    <% } else { %>
                        <a href="login.jsp">Login</a>
                        <button class="signup" onclick="location.href='register.jsp'">Sign Up</button>
                        <% } %>
            </div>
        </nav>

        <section class="hero">
            <h1>WeatherPulse</h1>
            <p>Real-time weather data, 5-day forecasts, air quality and smart alerts — all in one place.</p>

            <form action="weather" method="get" class="search">
                <input name="city" placeholder="🔍 Search any city..." required />
                <button type="submit">Search</button>
            </form>

            <% if (request.getAttribute("error") !=null) { %>
                <p class="error">
                    <%= request.getAttribute("error") %>
                </p>
                <% } %>

                    <% if (request.getAttribute("city")==null && request.getAttribute("error")==null) { %>
                        <p class="muted" style="margin-top: 12px;">Search for a city to see current weather, 5-day
                            forecast, and alerts.</p>
                        <% } %>

                            <%-- ═══ Current Weather Card ═══ --%>
                                <% if (request.getAttribute("city") !=null) { %>
                                    <div class="result">
                                        <div class="result-header">
                                            <span class="weather-icon float-anim">
                                                <%= request.getAttribute("weatherEmoji") %>
                                            </span>
                                            <h2>
                                                <%= request.getAttribute("city") %>
                                            </h2>
                                        </div>
                                        <% if (request.getAttribute("country") !=null &&
                                            !((String)request.getAttribute("country")).isEmpty()) { %>
                                            <div class="country">
                                                <%= request.getAttribute("country") %>
                                            </div>
                                            <% } %>
                                                <div class="weather-desc">
                                                    <%= request.getAttribute("weatherDesc") %>
                                                </div>

                                                <div class="stats">
                                                    <div class="stat">
                                                        <small>Temperature</small>
                                                        <div class="value"><span class="icon">🌡</span>
                                                            <%= request.getAttribute("temp") %>°C
                                                        </div>
                                                    </div>
                                                    <div class="stat">
                                                        <small>Wind Speed</small>
                                                        <div class="value"><span class="icon">💨</span>
                                                            <%= request.getAttribute("wind") %> km/h
                                                        </div>
                                                    </div>
                                                    <div class="stat">
                                                        <small>Rain (now)</small>
                                                        <div class="value"><span class="icon">🌧</span>
                                                            <%= request.getAttribute("rainMm") %> mm
                                                        </div>
                                                    </div>
                                                    <div class="stat">
                                                        <small>Humidity</small>
                                                        <div class="value"><span class="icon">💧</span>
                                                            <%= request.getAttribute("humidity") %>%
                                                        </div>
                                                    </div>
                                                </div>
                                    </div>

                                    <%-- ═══ 5-Day Forecast ═══ --%>
                                        <% java.util.List<String[]> forecast = (java.util.List<String[]>)
                                                request.getAttribute("forecast");
                                                if (forecast != null && !forecast.isEmpty()) {
                                                %>
                                                <div class="forecast">
                                                    <h3>📅 5-Day Forecast</h3>
                                                    <div class="forecast-grid">
                                                        <% for (String[] day : forecast) { %>
                                                            <div class="forecast-day">
                                                                <div class="day-name">
                                                                    <%= day[0] %>
                                                                </div>
                                                                <span class="day-icon">
                                                                    <%= day[3] %>
                                                                </span>
                                                                <div class="day-temps">
                                                                    <span class="high">
                                                                        <%= day[1] %>°
                                                                    </span>
                                                                    <span class="low">
                                                                        <%= day[2] %>°
                                                                    </span>
                                                                </div>
                                                                <div class="day-desc">
                                                                    <%= day[4] %>
                                                                </div>
                                                                <div class="day-rain">🌧 <%= day[5] %> mm</div>
                                                            </div>
                                                            <% } %>
                                                    </div>
                                                </div>
                                                <% } %>
                                                    <% } %>

                                                        <%-- ═══ Alerts ═══ --%>
                                                            <% java.util.List<String> alerts = (java.util.List<String>)
                                                                    request.getAttribute("alerts");
                                                                    if (alerts != null && !alerts.isEmpty()) {
                                                                    %>
                                                                    <div class="alerts">
                                                                        <h3>⚠ Smart Alerts</h3>
                                                                        <ul>
                                                                            <% for (String a : alerts) { %>
                                                                                <li>
                                                                                    <%= a %>
                                                                                </li>
                                                                                <% } %>
                                                                        </ul>
                                                                    </div>
                                                                    <% } %>
        </section>

        <script src="js/theme.js"></script>
    </body>

    </html>
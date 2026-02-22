<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WeatherPulse</title>
    <link rel="stylesheet" href="css/theme.css">
</head>
<body>

<nav class="navbar">
    <div class="logo">☁ WeatherPulse</div>
    <div class="links">
        <a class="active" href="index.jsp">Home</a>
        <a href="about.jsp">About</a>
        <span id="themeToggle">🌙</span>
        <a href="login.jsp">Login</a>
        <button class="signup" onclick="location.href='register.jsp'">Sign Up</button>
    </div>
</nav>

<section class="hero">
    <h1>WeatherPulse</h1>
    <p>Real-time weather data, forecasts, air quality and smart alerts — all in one place.</p>

    <form action="weather" method="get" class="search">
        <input name="city" placeholder="Search city..." required />
        <button type="submit">Search</button>
    </form>

    <% if (request.getAttribute("error") != null) { %>
    <p class="error"><%= request.getAttribute("error") %></p>
    <% } %>

    <% if (request.getAttribute("city") == null && request.getAttribute("error") == null) { %>
    <p class="muted">Search for a city to see current weather and alerts.</p>
    <% } %>

    <% if (request.getAttribute("city") != null) { %>
    <div class="result">
        <h2><%= request.getAttribute("city") %></h2>

        <div class="stats">
            <div class="stat">
                <small>Temperature</small>
                <div>🌡 <b><%= request.getAttribute("temp") %> °C</b></div>
            </div>
            <div class="stat">
                <small>Wind</small>
                <div>🌬 <b><%= request.getAttribute("wind") %> km/h</b></div>
            </div>
            <div class="stat">
                <small>Rain (next hour)</small>
                <div>🌧 <b><%= request.getAttribute("rainMm") %> mm</b></div>
            </div>
            <div class="stat">
                <small>PM2.5</small>
                <div>🫁 <b><%= request.getAttribute("pm25") %></b></div>
            </div>
        </div>
    </div>
    <% } %>

    <%
        java.util.List<String> alerts = (java.util.List<String>) request.getAttribute("alerts");
        if (alerts != null && !alerts.isEmpty()) {
    %>
    <div class="alerts">
        <h3>⚠ Alerts</h3>
        <ul>
            <% for (String a : alerts) { %>
            <li><%= a %></li>
            <% } %>
        </ul>
    </div>
    <% } %>

</section>

<script src="js/theme.js"></script>
</body>
</html>
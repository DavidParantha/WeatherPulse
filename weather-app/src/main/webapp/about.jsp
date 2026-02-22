<%--
  Created by IntelliJ IDEA.
  User: Hemant
  Date: 21-02-2026
  Time: 22:08
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html>
<head>
    <title>About - WeatherPulse</title>
    <link rel="stylesheet" href="css/theme.css">
</head>
<body>

<nav class="navbar">
    <div class="logo">☁ WeatherPulse</div>
    <div class="links">
        <a href="index.jsp">Home</a>
        <a class="active" href="about.jsp">About</a>
        <span id="themeToggle">🌙</span>
        <a href="#">Login</a>
        <button class="signup">Sign Up</button>
    </div>
</nav>

<section class="about">
    <h1>About WeatherPulse</h1>
    <p>A modern weather app powered by Open-Meteo with smart alerts and air quality monitoring.</p>

    <div class="cards">
        <div class="card">🌡 Real-time Weather</div>
        <div class="card">📅 5-Day Forecast</div>
        <div class="card">🫁 Air Quality (PM2.5)</div>
        <div class="card">🌧 Rain Alerts</div>
        <div class="card">🔔 Smart Alerts</div>
        <div class="card">🔐 Secure & Private</div>
    </div>
</section>

<script src="js/theme.js"></script>
</body>
</html>

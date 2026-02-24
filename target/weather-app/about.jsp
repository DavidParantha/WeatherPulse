<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>About — WeatherPulse</title>
        <link rel="stylesheet" href="css/theme.css">
    </head>

    <body>

        <nav class="navbar">
            <div class="logo">☁ WeatherPulse</div>
            <div class="links">
                <a href="index.jsp">Home</a>
                <a class="active" href="about.jsp">About</a>
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

        <%-- ═══ Hero ═══ --%>
            <section class="about-hero">
                <h1>Your Weather, Supercharged ⚡</h1>
                <p>WeatherPulse is a modern, intelligent weather platform that combines real-time data,
                    5-day forecasts, air quality monitoring, and smart alerts — all beautifully designed
                    and completely free.</p>
            </section>

            <%-- ═══ Features ═══ --%>
                <section class="features">
                    <h2>Everything You Need</h2>
                    <div class="feature-grid">
                        <div class="feature-card">
                            <span class="f-icon">🌡</span>
                            <h3>Real-time Weather</h3>
                            <p>Get instant temperature, wind speed, humidity, and precipitation data for any city
                                worldwide.</p>
                        </div>
                        <div class="feature-card">
                            <span class="f-icon">📅</span>
                            <h3>5-Day Forecast</h3>
                            <p>Plan ahead with detailed daily forecasts showing highs, lows, weather conditions, and
                                rain predictions.</p>
                        </div>
                        <div class="feature-card">
                            <span class="f-icon">🫁</span>
                            <h3>Air Quality (PM2.5)</h3>
                            <p>Monitor particulate matter levels in real-time. Know when to wear a mask or stay indoors.
                            </p>
                        </div>
                        <div class="feature-card">
                            <span class="f-icon">🔔</span>
                            <h3>Smart Alerts</h3>
                            <p>Set custom thresholds for temperature, rain, and air quality. Get warned before extreme
                                weather hits.</p>
                        </div>
                        <div class="feature-card">
                            <span class="f-icon">🌍</span>
                            <h3>Global Coverage</h3>
                            <p>Search any city on Earth. Powered by Open-Meteo's comprehensive global weather data.</p>
                        </div>
                        <div class="feature-card">
                            <span class="f-icon">🔐</span>
                            <h3>Secure Accounts</h3>
                            <p>Your data stays safe with MySQL-backed accounts. Set preferences that persist across
                                sessions.</p>
                        </div>
                    </div>
                </section>

                <%-- ═══ How It Works ═══ --%>
                    <section class="how-it-works">
                        <h2>How It Works</h2>
                        <div class="steps">
                            <div class="step">
                                <div class="step-number">1</div>
                                <h3>Search a City</h3>
                                <p>Type any city name and get instant weather data powered by Open-Meteo APIs.</p>
                            </div>
                            <div class="step">
                                <div class="step-number">2</div>
                                <h3>View Results</h3>
                                <p>See current conditions, 5-day forecast, air quality, and precipitation at a glance.
                                </p>
                            </div>
                            <div class="step">
                                <div class="step-number">3</div>
                                <h3>Set Alerts</h3>
                                <p>Create an account and configure custom alert thresholds. We'll notify you when
                                    conditions are dangerous.</p>
                            </div>
                        </div>
                    </section>

                    <%-- ═══ Tech Stack ═══ --%>
                        <section class="tech-stack">
                            <h2>Built With</h2>
                            <div class="tech-badges">
                                <span>☕ Java 21</span>
                                <span>🐱 Tomcat 10+</span>
                                <span>🐬 MySQL 8</span>
                                <span>📦 Maven</span>
                                <span>🌐 Open-Meteo API</span>
                                <span>🎨 CSS3</span>
                            </div>
                        </section>

                        <%-- ═══ CTA ═══ --%>
                            <section class="cta-section">
                                <a class="cta-btn" href="register.jsp">Get Started — It's Free →</a>
                            </section>

                            <script src="js/theme.js"></script>
    </body>

    </html>
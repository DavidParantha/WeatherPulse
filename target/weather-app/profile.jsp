<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
  <% if (session.getAttribute("user")==null) { response.sendRedirect("login.jsp"); return; }
    com.david.weather.model.User currentUser=(com.david.weather.model.User) session.getAttribute("user"); %>
    <!DOCTYPE html>
    <html>

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Profile — WeatherPulse</title>
      <link rel="stylesheet" href="css/theme.css">
    </head>

    <body>

      <nav class="navbar">
        <div class="logo">☁ WeatherPulse</div>
        <div class="links">
          <a href="index.jsp">Home</a>
          <a href="about.jsp">About</a>
          <span id="themeToggle">🌙</span>
          <a class="active" href="profile.jsp">Profile</a>
          <a href="logout">Logout</a>
        </div>
      </nav>

      <div class="auth-page">
        <div class="auth-left">
          <h2>Your Dashboard 🎯</h2>
          <p>Set up custom alert thresholds. We'll warn you about extreme weather before it hits.</p>
          <div class="feature-pills">
            <span>🔥 Heat Alerts</span>
            <span>🌧 Rain Warnings</span>
            <span>🫁 PM2.5 Monitoring</span>
            <span>⚡ Real-time</span>
          </div>
        </div>

        <div class="auth-right">
          <div class="auth-card">
            <form action="profile" method="post" class="auth">
              <h2>Alert Preferences</h2>
              <p class="subtitle">Logged in as <strong>
                  <%= currentUser.getEmail() %>
                </strong></p>

              <% if (request.getParameter("success") !=null) { %>
                <p class="success">✓ Preferences saved successfully!</p>
                <% } %>

                  <label class="field-label">Temperature Alert Above (°C)</label>
                  <input name="tempThreshold" type="number" step="0.1" value="35" placeholder="e.g. 35" required />

                  <label class="checkbox-label">
                    <input type="checkbox" name="rainAlerts" checked /> Heavy Rain Alerts (≥ 10mm)
                  </label>

                  <label class="checkbox-label">
                    <input type="checkbox" name="airAlerts" checked /> Air Quality Alerts (PM2.5 ≥ 35)
                  </label>

                  <button type="submit">Save Preferences</button>
            </form>
          </div>
        </div>
      </div>

      <script src="js/theme.js"></script>
    </body>

    </html>
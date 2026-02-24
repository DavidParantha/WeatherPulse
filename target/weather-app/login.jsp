<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html>

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login — WeatherPulse</title>
    <link rel="stylesheet" href="css/theme.css">
  </head>

  <body>

    <nav class="navbar">
      <div class="logo">☁ WeatherPulse</div>
      <div class="links">
        <a href="index.jsp">Home</a>
        <a href="about.jsp">About</a>
        <span id="themeToggle">🌙</span>
        <% if (session.getAttribute("user") !=null) { %>
          <a href="profile.jsp">Profile</a>
          <a href="logout">Logout</a>
          <% } else { %>
            <a class="active" href="login.jsp">Login</a>
            <button class="signup" onclick="location.href='register.jsp'">Sign Up</button>
            <% } %>
      </div>
    </nav>

    <div class="auth-page">
      <div class="auth-left">
        <h2>Welcome Back ☁</h2>
        <p>Access your personalized weather dashboard, smart alerts, and 5-day forecasts.</p>
        <div class="feature-pills">
          <span>🌡 Real-time Weather</span>
          <span>📅 5-Day Forecast</span>
          <span>🔔 Smart Alerts</span>
          <span>💨 Air Quality</span>
          <span>🔐 Secure Login</span>
        </div>
      </div>

      <div class="auth-right">
        <div class="auth-card">
          <form action="login" method="post" class="auth">
            <h2>Sign In</h2>
            <p class="subtitle">Enter your credentials to continue</p>

            <% if (request.getParameter("success") !=null) { %>
              <p class="success">✓ <%= request.getParameter("success") %>
              </p>
              <% } %>

                <% if (request.getParameter("error") !=null) { %>
                  <p class="error">✕ <%= request.getParameter("error") %>
                  </p>
                  <% } %>

                    <input name="email" type="email" placeholder="Email address" required />
                    <input name="password" type="password" placeholder="Password" required />
                    <button type="submit">Sign In</button>
                    <p class="link-text">Don't have an account? <a href="register.jsp">Create one</a></p>
          </form>
        </div>
      </div>
    </div>

    <script src="js/theme.js"></script>
  </body>

  </html>
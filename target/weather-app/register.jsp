<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html>

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up — WeatherPulse</title>
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
            <a href="login.jsp">Login</a>
            <button class="signup active" onclick="location.href='register.jsp'">Sign Up</button>
            <% } %>
      </div>
    </nav>

    <div class="auth-page">
      <div class="auth-left">
        <h2>Join WeatherPulse 🌍</h2>
        <p>Create an account to unlock personalized weather alerts and track your favorite cities.</p>
        <div class="feature-pills">
          <span>⚡ Instant Setup</span>
          <span>🌡 Custom Alerts</span>
          <span>📅 5-Day Forecast</span>
          <span>🫁 Air Quality</span>
          <span>🆓 100% Free</span>
        </div>
      </div>

      <div class="auth-right">
        <div class="auth-card">
          <form action="register" method="post" class="auth">
            <h2>Create Account</h2>
            <p class="subtitle">Sign up in seconds — no credit card needed</p>

            <% if (request.getParameter("error") !=null) { %>
              <p class="error">✕ <%= request.getParameter("error") %>
              </p>
              <% } %>

                <input name="email" type="email" placeholder="Email address" required />
                <input name="password" type="password" placeholder="Choose a password" required />
                <button type="submit">Create Account</button>
                <p class="link-text">Already have an account? <a href="login.jsp">Sign in</a></p>
          </form>
        </div>
      </div>
    </div>

    <script src="js/theme.js"></script>
  </body>

  </html>
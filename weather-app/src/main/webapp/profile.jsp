<%--
  Created by IntelliJ IDEA.
  User: Hemant
  Date: 21-02-2026
  Time: 22:28
  To change this template use File | Settings | File Templates.
--%>
<%
  if (session.getAttribute("user") == null) {
    response.sendRedirect("login.jsp");
    return;
  }
%>

<h2>Alert Preferences</h2>

<form action="profile" method="post">
  <label>Temperature Alert Above (°C)</label>
  <input name="tempThreshold" type="number" step="0.1" value="35" required />

  <label>
    <input type="checkbox" name="rainAlerts" checked /> Heavy Rain Alerts
  </label>

  <label>
    <input type="checkbox" name="airAlerts" checked /> Air Quality Alerts (PM2.5)
  </label>

  <button type="submit">Save Preferences</button>

  <% if (request.getParameter("success") != null) { %>
  <p class="success">Preferences saved!</p>
  <% } %>
</form>

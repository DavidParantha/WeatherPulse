<%--
  Created by IntelliJ IDEA.
  User: Hemant
  Date: 21-02-2026
  Time: 22:23
  To change this template use File | Settings | File Templates.
--%>
<form action="register" method="post" class="auth">
  <h2>Sign Up</h2>
  <input name="email" placeholder="Email" required />
  <input name="password" type="password" placeholder="Password" required />
  <button type="submit">Create Account</button>
  <% if (request.getParameter("error") != null) { %>
  <p class="error"><%= request.getParameter("error") %></p>
  <% } %>
</form>

package com.david.weather.controller;

import com.david.weather.model.User;
import com.david.weather.service.AuthService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final AuthService authService = new AuthService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User user = authService.login(email, password);
        if (user == null) {
            resp.sendRedirect("login.jsp?error=Invalid credentials");
            return;
        }

        HttpSession session = req.getSession(true);
        session.setAttribute("user", user);
        resp.sendRedirect("index.jsp");
    }
}
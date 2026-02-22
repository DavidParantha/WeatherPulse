package com.david.weather.controller;

import com.david.weather.service.AuthService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final AuthService authService = new AuthService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        boolean ok = authService.register(email, password);
        if (!ok) {
            resp.sendRedirect("register.jsp?error=User already exists");
            return;
        }
        resp.sendRedirect("login.jsp?success=Account created");
    }
}
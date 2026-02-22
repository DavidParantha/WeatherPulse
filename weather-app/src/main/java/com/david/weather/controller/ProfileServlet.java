package com.david.weather.controller;

import com.david.weather.dao.PreferenceDao;
import com.david.weather.model.AlertPreferences;
import com.david.weather.model.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        double temp = Double.parseDouble(req.getParameter("tempThreshold"));
        boolean rain = req.getParameter("rainAlerts") != null;
        boolean air = req.getParameter("airAlerts") != null;

        PreferenceDao.save(user.getEmail(), new AlertPreferences(temp, rain, air));
        resp.sendRedirect("profile.jsp?success=Saved");
    }
}
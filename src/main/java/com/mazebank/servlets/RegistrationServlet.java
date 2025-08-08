package com.mazebank.servlets;

import com.mazebank.model.HolderType;
import com.mazebank.model.User;
import com.mazebank.model.UserRole;
import com.mazebank.model.UserStatus;
import com.mazebank.service.UserService;
import com.mazebank.service.UserServiceImpl;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet; // Keep if you use @WebServlet for other servlets
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/app/register")
public class RegistrationServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        super.init();
        userService = new UserServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// Simply forward to the registration JSP
        request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = new User();
        user.setUsername(request.getParameter("username"));
        user.setPassword(request.getParameter("password")); // Temporarily holds plain password
        user.setEmail(request.getParameter("email"));
        user.setFirstName(request.getParameter("firstName"));
        user.setLastName(request.getParameter("lastName"));

        // Holder Type is now required from the form
        String holderTypeStr = request.getParameter("holderType");
        if (holderTypeStr!= null &&!holderTypeStr.isEmpty()) {
            user.setHolderType(HolderType.fromString(holderTypeStr));
        } else {
            request.setAttribute("errorMessage", "Holder Type is required.");
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
            return;
        }

        // Set default role and status for new registrations (not from form)
        user.setRole(UserRole.CUSTOMER);
        user.setStatus(UserStatus.PENDING); // Or ACTIVE, depending on your business flow

        try {
            userService.registerUser(user);
            request.setAttribute("message", "Registration successful! Your account is " + user.getStatus().name() + ". Please login.");
            response.sendRedirect(request.getContextPath() + "/app/login"); // Redirect to login page
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
        }
    }
}
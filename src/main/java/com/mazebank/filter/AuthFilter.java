package com.mazebank.filter;

import com.mazebank.model.User;
import com.mazebank.model.UserRole;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization logic if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false); // Do not create a new session

        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String pathInfo = httpRequest.getPathInfo(); // e.g., /dashboard, /customer/payments, /admin/users

        // Paths that are always allowed (public access)
        boolean isPublicPath = requestURI.equals(contextPath + "/index.jsp") ||
                               requestURI.equals(contextPath + "/register.jsp") || // New registration page
                               (pathInfo!= null && (pathInfo.equals("/login") || pathInfo.equals("/register"))); // Servlets for login/register
        boolean isStaticResource = requestURI.startsWith(contextPath + "/css/") ||
                                   requestURI.startsWith(contextPath + "/js/") ||
                                   requestURI.startsWith(contextPath + "/images/");

        User loggedInUser = (session!= null)? (User) session.getAttribute("loggedInUser") : null;

        // 1. If user is not logged in and trying to access a protected path
        if (loggedInUser == null &&!isPublicPath &&!isStaticResource) {
            System.out.println("AuthFilter: Unauthenticated access to " + requestURI + ". Redirecting to login.");
            httpResponse.sendRedirect(contextPath + "/index.jsp"); // Redirect to login page
            return;
        }

        // 2. If user is logged in, check role-based authorization for specific paths
        if (loggedInUser!= null) {
            UserRole userRole = loggedInUser.getRole();

            // Admin-only paths
            if (pathInfo!= null && pathInfo.startsWith("/admin")) {
                if (userRole!= UserRole.ADMIN) {
                    System.out.println("AuthFilter: User " + loggedInUser.getUsername() + " (Role: " + userRole + ") attempted unauthorized access to " + requestURI);
                    request.setAttribute("errorMessage", "Access Denied: You do not have permission to view this page.");
                    request.getRequestDispatcher("/WEB-INF/jsp/unauthorized.jsp").forward(request, httpResponse);
                    return;
                }
            }
            // Customer-only paths (or general user paths)
            // You can add more specific checks here if needed, e.g.,
            // if (pathInfo!= null && pathInfo.startsWith("/customer") && userRole!= UserRole.CUSTOMER && userRole!= UserRole.ADMIN) {... }
            // For now, if it's not admin, it's assumed to be customer/general access.
        }

        // If authenticated and authorized, or if it's a public path, continue the chain
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup logic if needed
    }
}
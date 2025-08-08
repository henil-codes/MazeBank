package com.mazebank.filter;

import com.mazebank.model.User;
import com.mazebank.model.UserRole;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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
		HttpSession session = httpRequest.getSession(false);

		String requestURI = httpRequest.getRequestURI();
		String contextPath = httpRequest.getContextPath();
		String pathInfo = httpRequest.getPathInfo();

	    // Paths that are publicly accessible without authentication
	    boolean isPublicPath = requestURI.equals(contextPath + "/app/login") ||
	                           requestURI.equals(contextPath + "/app/register") ||
	                           requestURI.startsWith(contextPath + "/css/") ||
	                           requestURI.startsWith(contextPath + "/js/") ||
	                           requestURI.startsWith(contextPath + "/images/");

		boolean isStaticResource = requestURI.startsWith(contextPath + "/css/")
				|| requestURI.startsWith(contextPath + "/js/") || requestURI.startsWith(contextPath + "/images/");

		User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

		// Redirect logic: if not logged in AND not a public path AND not a static
		// resource
		if (loggedInUser == null && !isPublicPath && !isStaticResource) {
			System.out.println("AuthFilter: Unauthenticated access to " + requestURI + ". Redirecting to login.");
			httpResponse.sendRedirect(contextPath + "/app/login");
			return;
		}

		// Continue the filter chain
		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {
		// Cleanup logic if needed
	}
}
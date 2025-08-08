package com.mazebank.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletRequestWrapper;
import java.io.IOException;

// A simple filter to allow HTML forms to simulate PUT/DELETE requests
// by using a hidden field "_method".
@WebFilter(urlPatterns = {"/app/*"})
public class HttpMethodOverrideFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;

        if (httpRequest.getMethod().equalsIgnoreCase("POST")) {
            String method = httpRequest.getParameter("_method");
            if (method != null && !method.isEmpty()) {
                final String upperMethod = method.toUpperCase();
                // Wrap the request to override the getMethod()
                HttpServletRequestWrapper wrapper = new HttpServletRequestWrapper(httpRequest) {
                    @Override
                    public String getMethod() {
                        return upperMethod;
                    }
                };
                chain.doFilter(wrapper, response);
                return; // Important: prevent further processing of the original request
            }
        }
        // For non-POST requests or POST requests without _method, continue with original request
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}
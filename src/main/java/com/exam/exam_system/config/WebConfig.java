package com.exam.exam_system.config;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class WebConfig implements Filter {

    @Override
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpServletRequest httpRequest   = (HttpServletRequest) request;

        String path = httpRequest.getRequestURI();

        // Apply no-cache headers to all dashboard and protected pages
        if (path.contains("/admin/") ||
                path.contains("/student/") ||
                path.contains("/examiner/")) {

            httpResponse.setHeader("Cache-Control",
                    "no-cache, no-store, must-revalidate");
            httpResponse.setHeader("Pragma", "no-cache");
            httpResponse.setDateHeader("Expires", 0);
        }

        chain.doFilter(request, response);
    }
}
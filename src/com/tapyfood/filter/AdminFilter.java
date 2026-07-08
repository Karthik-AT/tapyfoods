package com.tapyfood.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/admin/*")
public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String userRole = (session != null) ? (String) session.getAttribute("userRole") : null;

        if (userRole == null || !"admin".equals(userRole)) {
            res.sendRedirect(req.getContextPath() + "/login.jsp?error=Unauthorized access");
        } else {
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {}
}

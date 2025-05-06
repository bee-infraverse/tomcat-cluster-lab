package com.bee42;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class HelloServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static Logger log = LoggerFactory.getLogger(HelloServlet.class);
    
    public HelloServlet() {
    }
    
    @Override
    public void init() {
        log.debug("servlet init...");
    }

    @Override
    public void destroy() {
        log.debug("servlet destroy...");
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        log.debug("servlet service...");
        PrintWriter out = response.getWriter();
        out.println("hello");
    }
}

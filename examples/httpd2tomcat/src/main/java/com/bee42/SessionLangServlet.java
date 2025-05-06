package com.bee42;

import java.io.*;
import java.util.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/session")
public class SessionLangServlet extends HttpServlet {
    public static final String LANG_PARAM_NAME = "lang";

    protected void doPost(HttpServletRequest request, 
                         HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setAttribute(LANG_PARAM_NAME, 
                request.getParameter(LANG_PARAM_NAME));
    }

    protected void doGet(HttpServletRequest request, 
                         HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        PrintWriter writer = response.getWriter();
        writer.println("Language: " + session.getAttribute(LANG_PARAM_NAME));
    }
}
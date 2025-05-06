package com.bee42.catalina.core;

import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextAttributeEvent;
import jakarta.servlet.ServletContextAttributeListener;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/**
 * Logging Context Events from an application.
 * 
 * @author Peter Rossbach
 */
@WebListener
public class LogContextListener implements ServletContextListener, ServletContextAttributeListener {

    /*-- Static Variables ----------------------------------------*/
    private static final Logger log = Logger.getLogger(LogContextListener.class.getName());

    /**
     * The descriptive information about this implementation.
     */
    private static final String INFO = "com.bee42.catalina.core.LogContextListener/1.0";

    /**
     * Return descriptive information about this implementation.
     */
    public String getInfo() {
        return INFO;
    }

    /**
     * @see jakarta.servlet.ServletContextAttributeListener#attributeAdded(jakarta.servlet.ServletContextAttributeEvent)
     */
    @Override
    public void attributeAdded(ServletContextAttributeEvent event) {
        if (log.isLoggable(Level.INFO)) {
            log.log(Level.INFO, "attributeAdded: {0} attribute: {1}",
                    new Object[] { getContextName(event), event.getName() });
        }
    }

    /**
     * @see jakarta.servlet.ServletContextAttributeListener#attributeRemoved(jakarta.servlet.ServletContextAttributeEvent)
     */
    @Override
    public void attributeRemoved(ServletContextAttributeEvent event) {
        if (log.isLoggable(Level.INFO)) {
            log.log(Level.INFO, "attributeRemoved: {0} attribute: {1}",
                    new Object[] { getContextName(event), event.getName() });
        }
    }

    /**
     * @see jakarta.servlet.ServletContextAttributeListener#attributeReplaced(jakarta.servlet.ServletContextAttributeEvent)
     */
    @Override
    public void attributeReplaced(ServletContextAttributeEvent event) {
        if (log.isLoggable(Level.INFO)) {
            log.log(Level.INFO, "attributeReplaced: {0} attribute: {1}",
                    new Object[] { getContextName(event), event.getName() });
        }
    }

    /**
     * @see jakarta.servlet.ServletContextListener#contextInitialized(jakarta.servlet.ServletContextEvent)
     */
    @Override
    public void contextInitialized(ServletContextEvent event) {
        if (log.isLoggable(Level.INFO)) {
            log.log(Level.INFO, "contextInitialized: {0}",
                    event.getServletContext().getServletContextName());
        }
    }

    /**
     * @see jakarta.servlet.ServletContextListener#contextDestroyed(jakarta.servlet.ServletContextEvent)
     */
    @Override
    public void contextDestroyed(ServletContextEvent event) {
        if (log.isLoggable(Level.INFO)) {
            log.log(Level.INFO, "contextDestroyed: {0}",
                    event.getServletContext().getServletContextName());
        }
    }

    /**
     * Helper method to get the context name from an event.
     */
    private String getContextName(ServletContextAttributeEvent event) {
        ServletContext context = (ServletContext) event.getSource();
        return context.getServletContextName();
    }
}

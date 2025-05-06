package com.bee42.catalina.session;

import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSessionActivationListener;
import jakarta.servlet.http.HttpSessionAttributeListener;
import jakarta.servlet.http.HttpSessionBindingEvent;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

/**
 * Logging session events from an application.
 * 
 * @author Peter Rossbach
 */
@WebListener
public class LogSessionListener implements HttpSessionActivationListener,
        HttpSessionAttributeListener, HttpSessionListener {

    /*-- Static Variables ----------------------------------------*/
    private static final Logger log = Logger.getLogger(LogSessionListener.class.getName());

    /**
     * The descriptive information about this implementation.
     */
    private static final String INFO = "com.bee42.catalina.session.LogSessionListener/1.1";

    /**
     * Returns descriptive information about this implementation.
     */
    public String getInfo() {
        return INFO;
    }

    @Override
    public void sessionWillPassivate(HttpSessionEvent event) {
        if (log.isLoggable(Level.INFO)) {
            log.log(Level.INFO, "sessionWillPassivate: {0}", event.getSession().getId());
        }
    }

    @Override
    public void sessionDidActivate(HttpSessionEvent event) {
        if (log.isLoggable(Level.INFO)) {
            log.log(Level.INFO, "sessionDidActivate: {0}", event.getSession().getId());
        }
    }

    @Override
    public void attributeAdded(HttpSessionBindingEvent event) {
        if (log.isLoggable(Level.INFO)) {
            log.log(Level.INFO, "attributeAdded: {0} attribute: {1}",
                    new Object[]{event.getSession().getId(), event.getName()});
        }
    }

    @Override
    public void attributeRemoved(HttpSessionBindingEvent event) {
        if (log.isLoggable(Level.INFO)) {
            log.log(Level.INFO, "attributeRemoved: {0}", event.getName());
        }
    }

    @Override
    public void attributeReplaced(HttpSessionBindingEvent event) {
        if (log.isLoggable(Level.INFO)) {
            log.log(Level.INFO, "attributeReplaced: {0} attribute: {1}",
                    new Object[]{event.getSession().getId(), event.getName()});
        }
    }

    @Override
    public void sessionCreated(HttpSessionEvent event) {
        if (log.isLoggable(Level.INFO)) {
            log.log(Level.INFO, "sessionCreated: {0}", event.getSession().getId());
        }
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent event) {
        if (log.isLoggable(Level.INFO)) {
            log.log(Level.INFO, "sessionDestroyed: {0}", event.getSession().getId());
        }
    }
}

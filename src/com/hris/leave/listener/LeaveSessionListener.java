package com.hris.leave.listener;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import com.hris.leave.manager.LeaveManager;

/**
 * Application Lifecycle Listener implementation class LeaveSessionListener
 *
 */
public class LeaveSessionListener implements HttpSessionListener {

	private static int totalActiveSession = 0;

	/**
     * @see HttpSessionListener#sessionCreated(HttpSessionEvent)
     */
    public void sessionCreated(HttpSessionEvent event)  { 
    	System.out.println("===============================");
    	System.out.println("sessionCreated - LEAVE");
    	totalActiveSession++;
    	System.out.println("LEAVE - active session: " + totalActiveSession);
    }

	/**
     * @see HttpSessionListener#sessionDestroyed(HttpSessionEvent)
     */
    public void sessionDestroyed(HttpSessionEvent event)  { 
    	HttpSession session = event.getSession();
    	
    	System.out.println("===============================");
    	System.out.println("sessionDestroyed - LEAVE | "+session.getAttribute("username"));
    	if (totalActiveSession > 0)
    		totalActiveSession--;
    	System.out.println("LEAVE - active session: " + totalActiveSession);
    	
    	
    	LeaveManager objLeaveManager = new LeaveManager();
    	objLeaveManager.updateStatusLogin(session.getAttribute("username").toString(), 0);
    }
    
}

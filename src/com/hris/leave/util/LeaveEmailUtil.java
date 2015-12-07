package com.hris.leave.util;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class LeaveEmailUtil {
	
	public static void sendEmail(String name) {
		final String username = "ace.hris.hris@gmail.com";
		final String password = "emaildummy";

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		Session session = Session.getInstance(props,
		  new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		  });

		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("ace.hris.hris@gmail.com"));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse("nydiavalentina@gmail.com"));
			message.setSubject("Password Reset");
			message.setText("Dear, <b>"+name+"</b>.<br/><br/><p>Welcome to HRIS Application.<br/>"+
							"Your account has been activated.</p><br/><p>You will be able to login in the future using:<br/>"+
							"Username: <br/>Password: </p><br/>Don't forget to change your password after login."+
							"<br/><br/><br/>-- HRIS Administrator");
			
			Transport.send(message);
			System.out.println("PORTAL - Send Email Activation.");
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}
}

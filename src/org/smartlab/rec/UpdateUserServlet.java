package org.smartlab.rec;

import java.io.IOException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;

public class UpdateUserServlet extends HttpServlet {

	private final String from = "rajaths.rajaths@gmail.com";
	private final String user = "rajaths.rajaths";
	private final String passwd = "b53139P589@SK403";
	private final String host = "smtp.gmail.com";
	private final String port = "587";
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		boolean dataVerified = !(req.getParameter("cInfo")==null);
		boolean round1 = !(req.getParameter("round1")==null);
		boolean round2 = !(req.getParameter("round2")==null);
		boolean round3 = !(req.getParameter("round3")==null);
		boolean qual = !(req.getParameter("final")==null);
		boolean sendMessage = !(req.getParameter("sendMessage")==null);
		String pMessage = req.getParameter("pMessage");
		DatastoreService store = DatastoreServiceFactory.getDatastoreService();
		String email = req.getParameter("email");
		Key key = KeyFactory.createKey("emailKey",email);
		Query query = new Query(key);
		Entity entity = store.prepare(query).asSingleEntity();
		boolean prevRound1 = Boolean.parseBoolean(entity.getProperty("round1").toString());
		boolean prevRound2 = Boolean.parseBoolean(entity.getProperty("round2").toString());
		boolean prevRound3 = Boolean.parseBoolean(entity.getProperty("round3").toString());
		boolean prevFinal = Boolean.parseBoolean(entity.getProperty("final").toString());
		entity.setProperty("correctData",String.valueOf(dataVerified));
		entity.setProperty("round1",String.valueOf(round1));
		entity.setProperty("round2",String.valueOf(round2));
		entity.setProperty("round3",String.valueOf(round3));
		entity.setProperty("final",String.valueOf(qual));
		entity.setProperty("pMessage", pMessage);
		store.put(entity);
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		Session session = Session.getInstance(props,
				  new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(user, passwd);
					}
				  });
		
		StringBuffer sb = new StringBuffer();
		sb.append("Your updated status:\n\n");
		sb.append("Previous stats:\n");
		sb.append("1st Round->\t"+String.valueOf(prevRound1)+"\n");
		sb.append("2nd Round->\t"+String.valueOf(prevRound2)+"\n");
		sb.append("3nd Round->\t"+String.valueOf(prevRound3)+"\n");
		sb.append("\nCUrrent Status:\n");
		sb.append("1st Round->\t"+String.valueOf(round1)+"\n");
		sb.append("2nd Round->\t"+String.valueOf(round2)+"\n");
		sb.append("3nd Round->\t"+String.valueOf(round3)+"\n");
		sb.append("Selected->\t"+String.valueOf(qual)+"\n");
		if(req.getParameter("sendMessage")!=null)
			sb.append("\n\nPersonal Message:"+pMessage);
		
		if(sendMessage)
		{	Message message = new MimeMessage(session);
			try{
				message.setFrom(new InternetAddress(from));
				message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(email));
				message.setSubject("SmartLAB Recruitment");			
				message.setText(sb.toString());
				Transport.send(message);
			}catch(Exception e){
				System.out.println("Message not sent");
			}
		}
		resp.sendRedirect("./admin.jsp");
	}
}

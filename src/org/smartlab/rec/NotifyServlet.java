package org.smartlab.rec;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

public class NotifyServlet extends HttpServlet {

	private boolean isLoggedin = true;
	private boolean isEntity = true;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		UserService service = UserServiceFactory.getUserService();
		User cUser = service.getCurrentUser();
		
		DatastoreService store = DatastoreServiceFactory.getDatastoreService();
		
		if(cUser==null)
			isLoggedin = false;
		
		Entity entity = null;
		
		if(isLoggedin)
		{
			Key key = KeyFactory.createKey("emailKey",cUser.getEmail());
			Query query = new Query(key);
			PreparedQuery pQuery = store.prepare(query);
			try{
				entity = pQuery.asSingleEntity();
			}catch(Exception e)
			{
				isEntity = false;
			}
			
			if(entity==null)
				isEntity = false;
		}
		req.setAttribute("isLoggedin", isLoggedin);
		req.setAttribute("isEntity", isEntity);
		req.setAttribute("entity", entity);
		req.getRequestDispatcher("./notify.jsp").forward(req, resp);			
	}
}

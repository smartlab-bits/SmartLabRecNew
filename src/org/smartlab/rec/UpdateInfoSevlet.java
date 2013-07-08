package org.smartlab.rec;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.google.appengine.api.datastore.DatastoreFailureException;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserServiceFactory;

@SuppressWarnings("serial")
public class UpdateInfoSevlet extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		User user = UserServiceFactory.getUserService().getCurrentUser();
		if(user!=null)
		{
			DatastoreService store = DatastoreServiceFactory.getDatastoreService();
			Key key = KeyFactory.createKey("emailKey", user.getEmail());
			Entity entity = null;
			try{
				entity = store.get(key);
			}catch(EntityNotFoundException ex)
			{
				entity = new Entity(key);
			}
			entity.setProperty("name",req.getParameter("name"));
			entity.setProperty("id",req.getParameter("id"));
			entity.setProperty("phone",req.getParameter("phone"));
			entity.setProperty("room", req.getParameter("room"));
			entity.setProperty("email",req.getParameter("email"));
			entity.setProperty("progExp",req.getParameter("progExp"));
			entity.setProperty("eExp",req.getParameter("eExp"));
			String s = req.getParameter("bhavan");
			Map<String,String> bhavanMap = new HashMap<String,String>();
			bhavanMap.put("1", "RAM");
			bhavanMap.put("2", "BUDH");
			bhavanMap.put("3", "KRISHNA");
			bhavanMap.put("4", "GANDHI");
			bhavanMap.put("5", "VISHWAKARMA");
			bhavanMap.put("6", "BHAGIRATH");
			bhavanMap.put("7", "ASHOK");
			bhavanMap.put("8", "RANAPRATAP");
			bhavanMap.put("9", "SHANKAR");
			bhavanMap.put("10", "VYAS");
			bhavanMap.put("11", "MALAVIYA");
			bhavanMap.put("12", "MEERA");
			entity.setProperty("bhavan", bhavanMap.get(s));
			store.put(entity);
		}
		
		resp.sendRedirect("./updated.jsp");		
	}
}	

package org.smartlab.rec;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

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

public class UserPageServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		DatastoreService store = DatastoreServiceFactory.getDatastoreService();
		PrintWriter pWriter = resp.getWriter();
		resp.setContentType("text/html");
		
		String email = (String) req.getParameter("req");
		pWriter.print(email);		
		Key key = KeyFactory.createKey("emailKey",email);
		Query query = new Query(key);
		Entity entity = store.prepare(query).asSingleEntity();
		
		req.setAttribute("entity", entity);
		req.setAttribute("email", email);
		if(entity==null)
		{
			resp.sendRedirect("./admin.jsp");
		}
		else
		{
			req.getRequestDispatcher("./displayUserData.jsp").forward(req, resp);
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
								
		PrintWriter pWriter = resp.getWriter();
		resp.setContentType("text/html");
		
		DatastoreService store = DatastoreServiceFactory.getDatastoreService();
		
		String bName = (String) req.getParameter("searchSubmit");
		String bName1 = (String) req.getParameter("uploadSpreadSheet");
		String bName2 = (String) req.getParameter("downloadSpreadSheet");
		if(bName.equals("Search"))
		{
			String email = req.getParameter("search");
			Key key = KeyFactory.createKey("emailKey",email);
			Query query = new Query(key);
			Entity entity = store.prepare(query).asSingleEntity();
			if(entity==null)
			{
				resp.sendRedirect("./admin.jsp");
			}
			else
			{
				req.setAttribute("entity", entity);
				req.setAttribute("email", email);
				req.getRequestDispatcher("./displayUserData.jsp").forward(req, resp);
			}
		}
		if(bName1.equalsIgnoreCase("Upload"))
		{
			//resp.setContentType(arg0)
		}
		if(bName2.equalsIgnoreCase("Download"))
		{
			
		}
	}
}


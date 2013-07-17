package org.smartlab.rec;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
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
		
		
		DatastoreService store = DatastoreServiceFactory.getDatastoreService();				
		
			if(req.getParameter("searchSubmit")!=null)
			{
				resp.setContentType("text/html");
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
					
			{
				if(req.getParameter("downloadSpreadSheet")!=null)
				{
					StringBuffer csvBuffer = new StringBuffer();		
					csvBuffer.append("email,id,name,phone,progExp,eExp,round1,round2,round3,final\n");
					Query query = new Query("reg");
					List<Entity> users = store.prepare(query).asList(FetchOptions.Builder.withDefaults());
					for(Entity e:users)
					{
						csvBuffer.append(e.getProperty("email")+","+e.getProperty("id")+","+e.getProperty("phone")+","+e.getProperty("progExp")+","+e.getProperty("eExp")+","+e.getProperty("round1")+","+e.getProperty("round2")+","+e.getProperty("round3")+","+e.getProperty("final")+"\n");
					}
					
					byte[] buffer = csvBuffer.toString().getBytes();
					resp.addHeader("Content-Disposition", "attachment; filename=\"reg.csv\"");
					resp.getOutputStream().write(buffer, 0, buffer.length);
				}

			
		}
	}
}


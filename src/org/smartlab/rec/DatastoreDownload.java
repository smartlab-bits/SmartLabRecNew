package org.smartlab.rec;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Query;

public class DatastoreDownload extends HttpServlet {
@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
	DatastoreService store = DatastoreServiceFactory.getDatastoreService();
	StringBuffer csvBuffer = new StringBuffer();		
	csvBuffer.append("email,id,name,phone,progExp,eExp,round1,round2,round3,final\n");
	Query query = new Query("reg");
	List<Entity> users = store.prepare(query).asList(FetchOptions.Builder.withDefaults());
	List<String> props = new ArrayList<String>();
	props.add("email");
	props.add("id");
	props.add("phone");
	props.add("progExp");
	props.add("eExp");
	props.add("round1");
	props.add("round2");
	props.add("round3");
	props.add("final");	
	for(Entity e:users)
	{				
		for(String s:props)
		{
			String p = (String) e.getProperty(s);
			if(props.indexOf(s)!=8)
			{
				if(p!=null)
					csvBuffer.append(p+";");
				else
					csvBuffer.append("NULL"+";");
			}
			else
			{
				if(p!=null)
					csvBuffer.append(p+"\n");
				else
					csvBuffer.append("NULL"+"\n");
			}
		}		
	}
	
	byte[] buffer = csvBuffer.toString().getBytes();
	resp.addHeader("Content-Disposition", "attachment; filename=\"reg.csv\"");
	resp.getOutputStream().write(buffer, 0, buffer.length);
	}
}

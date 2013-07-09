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
import com.google.appengine.api.datastore.Query;

public class UpdateUserServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		boolean dataVerified = !(req.getParameter("cInfo")==null);
		boolean round1 = !(req.getParameter("round1")==null);
		boolean round2 = !(req.getParameter("round2")==null);
		boolean round3 = !(req.getParameter("round3")==null);
		boolean qual = !(req.getParameter("final")==null);
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
		store.put(entity);
		resp.sendRedirect("./admin.jsp");
	}
}

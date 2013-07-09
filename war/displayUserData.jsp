<%@ page import="com.google.appengine.api.datastore.Entity" %>
<% Entity entity = (Entity) request.getAttribute("entity"); %>
<% String email = (String) request.getAttribute("email"); %>
<h2><%=email%></h2>
<p>Name:    <%=entity.getProperty("name")%></p>
<p>ID:    <%=entity.getProperty("id")%></p>
<p>phone:    <%=entity.getProperty("phone")%></p>
<p>room:    <%=entity.getProperty("room")%></p>
<p>bhavan:    <%=entity.getProperty("bhavan")%></p>
<p>Programming Experience:    <%=entity.getProperty("progExp")%></p>
<p>Electronics Experience:    <%=entity.getProperty("eExp")%></p>
<form action="/updateUser?email=<%=email%>" method="post">
<%if(Boolean.parseBoolean(entity.getProperty("correctData").toString())){%>
	<label><input checked=checked type="checkbox"  name="cInfo">Correct User Info?</label>
<%}else{%> 
	<label><input type="checkbox"  name="cInfo">Correct User Info?</label>
<%}if(Boolean.parseBoolean(entity.getProperty("round1").toString())){%>
	<label><input checked=checked type="checkbox"  name="round1">Round 1?</label>
<%}else{%> 
	<label><input type="checkbox"  name="round1">Round1?</label>
<%}if(Boolean.parseBoolean(entity.getProperty("round2").toString())){%>
	<label><input checked=checked type="checkbox"  name="round2">Round2?</label>
<%}else{%> 
	<label><input type="checkbox"  name="round2">Round2?</label>
<%}if(Boolean.parseBoolean(entity.getProperty("round3").toString())){%>
	<label><input checked=checked type="checkbox"  name="round3">Round3?</label>
<%}else{%> 
	<label><input type="checkbox"  name="round3">Round3?</label>
<%}if(Boolean.parseBoolean(entity.getProperty("final").toString())){%>
	<label><input checked=checked type="checkbox"  name="final">Round3?</label>
<%}else{%> 
	<label><input type="checkbox"  name="final">Round3?</label>
<input type="submit" value="commit changes">
</form>
<%}%>	
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<% 
	boolean isLoggedin = Boolean.parseBoolean(request.getAttribute("isLoggedin").toString());
	boolean isEntity = Boolean.parseBoolean(request.getAttribute("isEntity").toString());
	Entity entity = (Entity) request.getAttribute("entity");
	
	if(!isLoggedin)
	{
		String s ="<HTML><HEAD><TITLE>Not logged in</TITLE>"+
		"<SCRIPT LANGUAGE=JavaScript>"+
 		"alert('Not Logged in');"+
 		"</SCRIPT>"+
   		"</HEAD>"+
  		"</HTML>";
  		out.print(s);
  		response.sendRedirect("homepage.jsp");
  	}
  	
%>
<html background="images/body-bg.png">
<head>
	<title>SmartLAB</title>
</head>
<body>
<div>
	<h2> Timeline </h2>
	<br>
	<p>Deadline 1</p>
	<p>Deadline 2</p>
	<p>Deadline 3</p>
	<p>Deadline 4</p>
	<p>Deadline 5</p>
	<br>
</div>
<% if(isEntity){
	String verified = entity.getProperty("correctData").toString();
	String round1 = entity.getProperty("round1").toString();
	String round2 = entity.getProperty("round2").toString();
	String round3 = entity.getProperty("round3").toString();
	String qual = entity.getProperty("final").toString();
 %>
<div>
	<h2>Your Application Status </h2>
	<p><em>Data Uploaded:</em>                 YES</p>
 	<p><em>Data Verified:</em>                 <%=verified%></p>
 	<p><em>Round 1 Cleared:</em>               <%=round1%></p>
 	<p><em>Round 2 Cleared:</em>               <%=round2%></p>
 	<p><em>Round 3 Cleared:</em>               <%=round3%></p>
 	<p><em>SELECTED</em>                       <%=qual%></p>
 	<p>Latest Personal Message:</p>
 	<textarea rows="5" cols="50"><%=entity.getProperty("pMessage")%></textarea>
</div>
<%}else{%>
<div>
	<h2>Your Application Status </h2>
	<p><em>Data Uploaded:</em>                 NO</p>
 	<p><em>Data Verified:</em>                 NO</p>
 	<p><em>Round 1 Cleared:</em>               NO</p>
 	<p><em>Round 2 Cleared:</em>               NO</p>
 	<p><em>Round 3 Cleared:</em>               NO</p>
 	<p><em>SELECTED</em>                       NO</p>
</div>
<%}%>

<a href="homepage.jsp">Back to Homepage</a>
</body>
</html>
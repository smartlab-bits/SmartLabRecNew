<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.EntityNotFoundException" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>

<html lang="en">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>SmartLAB</title>
    <link rel="stylesheet" type="text/css" media="screen" href="css/reset.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="css/960.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="css/global.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="css/typography.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="css/structure.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="css/menu.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="css/forms.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="css/tables.css" />        
    <link rel="stylesheet" type="text/css" media="screen" href="css/uniform.default.css" />    
</head>
<body>

<!-- 
////////////////////////
  BEGIN DEFAULT HEADER
////////////////////////
-->
<div id="bg">
<div id="page-header">
    <div class="container_12">
        <div class="grid_12">
            <a href="homepage.jsp"><img src="images/logo-banner.jpg" height="156" width="924" alt="Google Summer of Code" /></a>
        </div>
    </div>
</div>
<!-- .page-header -->
<!-- 
////////////////////////
  END DEFAULT HEADER
////////////////////////
-->

<!-- 
////////////////////////
   BEGIN MAIN CONTENT
////////////////////////
-->
<% 	UserService uService = UserServiceFactory.getUserService();
	User user = uService.getCurrentUser();
	
	if(user!=null)
	{	
		if(!user.getEmail().equals("xyz@gmail.com"))
			response.sendRedirect("./homepage.jsp");
	}
	else
		response.sendRedirect("./homepage.jsp");			
%>
<div id="main">
    <div class="container_12">

        <!-- 
        ////////////////////////
            BEGIN SITE MENU
        ////////////////////////
        -->
        <div id="main-menu" class="grid_3">
            <ul id="main-menu-list">
                <li id="menu-login"><a href="<%=uService.createLogoutURL(request.getRequestURI())%>">Logout</a></li>
                <li id="menu-about"><a href="javascript:void(0)">About</a></li>                                
                <li id="menu-connect"><a href="javascript:void(0)">Connect With Us</a></li>                
            </ul>
        </div>
        <!-- .grid_3 -->
        <!-- 
        ////////////////////////
            END SITE MENU
        ////////////////////////
        -->

        <!-- 
        ////////////////////////
           BEGIN PAGE CONTENT
        ////////////////////////
        -->
        <div class="grid_9">
            
            <div class="content">
            
                <h1 id="main-page-title">Search Applicants</h1>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod volutpat tellus, 
                vel dapibus nibh sagittis nec. Vestibulum lectus arcu, aliquam ac elementum a, porttitor lacinia augue.</p>
                
                <div class="form-search">
                    <form action="#" method="post" id="form" class="form-search">
                        <h2 id="form-search-title">Keyword Search</h2>
                        <fieldset id="form-search-fieldset">
                        <div id="form-row-search-field" class="row search-field">
                        	<input type="text" name="search" value="" class="text" />
                        </div>                        
                        <div id="form-row-button-row" class="row button-row">
                            <input name="searchSubmit" formaction="/userPage" formmethod="post" id="form-search-submit" type="submit" value="Search" class="submit"/>
                        </div>
                        </fieldset>
                        <div id="form-row-search-note" class="row search-note">
                            <span class="note">Search within "email Address" only</span>
                        </div>
                    </form>
                </div>
                <!-- .search-form -->
                
                <!-- begin table#projects -->
                <table id="projects" class="tablesorter table-projects">
                    <thead>
                        <tr>
                            <th><span>Email</span></th>
                           <th><span>Name</span></th>
                            <th><span>ID Number</span></th>
                            <th><span>Phone Number</span></th>
                        </tr>
                    </thead>
                    <tbody>
<% 	DatastoreService store = DatastoreServiceFactory.getDatastoreService();
	Query query = new Query("reg");
	List<Entity> users = store.prepare(query).asList(FetchOptions.Builder.withDefaults());
	for(Entity e:users)
	{		                        
%>
                        <tr>
                            <td><a href="<%="/userPage?"+"req="+e.getProperty("email")%>"><%=e.getProperty("email")%></a></td>
                            <td><%=e.getProperty("name")%></td>
                            <td><%=e.getProperty("id")%></td>
                            <td><%=e.getProperty("phone")%></td>
                        </tr>
<%}%>                       
                    </tbody>
                </table>
                <!-- end table#projects -->                                            	    
            </div>
            <!-- .content -->
        </div>
        <!-- .grid_9 -->
        <!-- 
        ////////////////////////
           END PAGE CONTENT
        ////////////////////////
        -->

    </div>
    <!-- .container_12 -->
</div>
<!-- .main -->
<!-- 
////////////////////////
   END MAIN CONTENT
////////////////////////
-->

<!-- 
////////////////////////
  BEGIN DEFAULT FOOTER
////////////////////////
-->
</body>
</html>
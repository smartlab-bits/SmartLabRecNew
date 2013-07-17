<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html lang="en">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>SmartLAB - BITS Pilani</title>
    <link rel="stylesheet" type="text/css" media="screen" href="css/reset.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="css/960.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="css/global.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="css/typography.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="css/structure.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="css/menu.css" />
</head>
<body>
<%	UserService u_service = UserServiceFactory.getUserService();
    User currentUser = u_service.getCurrentUser();
    boolean exists;
	List<String> admins = new ArrayList<String>();
	admins.add("rajaths.rajaths@gmail.com");
	admins.add("varadgautam@gmail.com");
	admins.add("prannoyp.1994@gmail.com");
    
    if(currentUser==null) 
    	exists = false;
    else
    	exists = true;
    
    if(exists)
    	if(admins.contains(currentUser.getEmail()))
    		response.sendRedirect("admin.jsp");
    
    
%>
<div id="bg">
<div id="page-header">
    <div class="container_12">
        <div class="grid_12">            
            <a href="homepage.jsp"><img src="images/logo-banner.jpg" height="156" width="924" alt="SmartLAB" /></a>
        </div>
    </div>
</div>

<!-- 
////////////////////////
   BEGIN MAIN CONTENT
////////////////////////
-->
<div id="main">
    <div class="container_12">
        
        <!-- 
        ////////////////////////
            BEGIN SITE MENU
        ////////////////////////
        -->
  
        <div id="main-menu" class="grid_3">
            <ul id="main-menu-list">
<%	if(exists){	%>           
                <li id="menu-login"><a href="<%=u_service.createLogoutURL(request.getRequestURI())%>">Logout</a></li>
                <li id="menu-apply"><a href="./updateInformation.jsp">Update Information</a></li>
                <li id="menu-events"><a href="/notifyUser">Notifications</a></li>
<%	}	else{ %>              
				<li id="menu-login"><a href="<%=u_service.createLoginURL(request.getRequestURI())%>">Login</a></li>
<% } %>				
                <li id="menu-about"><a href="./about.html">About</a></li>
                <li id="menu-about"><a href="./about.html">Connect With Us</a></li>

                
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
            
                <div id="user-login">
<%	if(exists){ %>              
                    <p>You are signed in as <%out.print(currentUser.getEmail());%> <a href="<%=u_service.createLogoutURL(request.getRequestURI())%>">(Not you?)</a></p>
<%	}else{ %>                   
			        <p>Login to Continue. <a href="<%=u_service.createLoginURL(request.getRequestURI())%>">Login</a></p>
<%	}	%>					     
                </div>
                
                <div id="how-it-works" class="block full home-block-1">
                    <h2 id="title-section-how-it-works">Details</h2>                        
                    <div id="block-how-it-works-description" class="description">
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris nec lectus lacus, a blandit ante. Sed lorem ipsum, 
                        aliquam ac tincidunt ac, luctus ut felis. Sed lobortis dapibus semper. Sed lorem ipsum, aliquam ac tincidunt ac, 
                        luctus ut felis.</p>
                    </div>
                </div>
                <!-- .home-block-1 -->
<% if(exists){ %>                
                <div class="content_column_1">
                    <!-- begin block -->
                    <div id="apply-students" class="block block-students">                        
                        <h3 id="title-section-apply-students">Update you Information now!</h3>
                        <p id="block-apply-students-text-action" class="action"><a href="/updateInformation.jsp">Update Information</a></p>
                        <p id="block-apply-students-text-small" class="small">Accounts with incomplete or wrong information will be rejected</p>
                    </div>
                    <!-- end block -->                    
                </div>
<%}%>              
                <!-- .content_column_1 -->
                
                <div class="content_column_2">                    
                    <!-- begin block -->
                    <div id="connect-with-us" class="block block-connect">
                        <h4 id="title-section-connect-with-us">Connect With Us</h4>
                        <div id="block-connect-with-us-content" class="block-content">
                            <a href="javascript:void(0)" id="connect-block-facebook" class="social fb">Facebook</a>
                            <a href="javascript:void(0)" id="connect-block-twitter" class="social tw">Twitter</a>                            
                            <a href="javascript:void(0)" id="connect-block-email" class="social em">Email</a>                            
                        </div>
                    </div>
                    <!-- end block -->                    
                </div>
                <!-- .content_column_2 -->

            </div>
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
<div id="footer">
    <div class="container_12">
            <div class="grid_3">&nbsp;</div>
            <!-- .grid_3 -->
            <div class="grid_9">
                <div class="footer-menu">
                    <ul id="footer-menu-list">
                        <li id="footer-menu-about"><a href="./about.html">About</a></li>
                        <li id="footer-menu-contact"><a href="javascript:void(0)">Contact</a></li>
                        <li id="footer-menu-facebook" class="social"><a href="javascript:void(0)" class="fb">Facebook</a></li>
                        <li id="footer-menu-twitter" class="social"><a href="javascript:void(0)" class="tw">Twitter</a></li>                        
                        <li id="footer-menu-email" class="social"><a href="javascript:void(0)" class="em">Email</a></li>                                                
                    </ul>
                </div>                
            </div>
            <!-- .grid_9 -->
        </div>
        <!-- .container_12 -->
</div>
<!-- .footer -->
</div>
<!-- #bg -->
<!-- 
////////////////////////
  END DEFAULT FOOTER
////////////////////////
-->

</body>
</html>
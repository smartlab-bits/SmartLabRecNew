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
<%@ page import="com.google.appengine.api.datastore.PreparedQuery" %>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery.TooManyResultsException" %>

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
    <link rel="stylesheet" type="text/css" media="screen" href="css/uniform.default.css" />    
    
</head>
<body>
<%
	UserService u_service = UserServiceFactory.getUserService();			
    User currentUser = u_service.getCurrentUser();
           
%>
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
<div id="main">
    <div class="container_12">

        <!-- 
        ////////////////////////
            BEGIN SITE MENU
        ////////////////////////
        -->
        <div id="main-menu" class="grid_3">
            <ul id="main-menu-list">
                <li id="menu-login"><a href="<%=u_service.createLogoutURL(request.getRequestURI())%>">Logout</a></li>                
                <li id="menu-about"><a href="javascript:void(0)">About</a></li>                                                
                <li id="menu-events"><a href="javascript:void(0)">Events &amp; Updates</a></li>                
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
            
                <h1 id="main-page-title">Update your Information for SmartLAB recruitment</h1>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod volutpat tellus, vel dapibus 
                nibh sagittis nec. Vestibulum lectus arcu, aliquam ac elementum a, porttitor lacinia augue. Cras eu ante 
                nec ipsum ultricies consequat imperdiet vitae lacus. Sed nec neque eget mi scelerisque aliquam. Curabitur 
                porttitor tempor interdum.</p>
                
                <!-- begin form -->
            	<form action="/submitData" method="post" id="form" class="form-register">
            	
            	    <div id="loggedin-message" class="loggedin">
            	        <p><strong>You are logged in as <em><%out.print(currentUser.getEmail());%></em>.</strong> <a href="<%=u_service.createLogoutURL(request.getRequestURI())%>">(Not you?)</a></p>
            	        <p>Applications with incorrect and wrong information will be rejected.</p>
            	    </div>
            	
            	    <h2 id="form-register-title">Update Information</h2> <p id="form-register-req" class="req">* fields required</p>
<% 	Entity entity = null;
	DatastoreService data = null;
	Key key = null;
	boolean newEntity = false;
	try{	
	data = DatastoreServiceFactory.getDatastoreService();
	key = KeyFactory.createKey("emailKey",currentUser.getEmail());	
	}catch(Exception e)
	{
	response.sendRedirect("homepage.jsp");
	}
	try
	{
		Query query = new Query(key);
		PreparedQuery pQuery = data.prepare(query);
		entity = pQuery.asSingleEntity();
	}
	catch(Exception ex)
	{	
		out.print(ex.getMessage());
		newEntity = true;	
	}
	if(entity==null)
		newEntity = true;
					
	if(newEntity){
%>            	
                	<fieldset id="form-register-fieldset-basicinfo" class="fieldset-basicinfo">
			    <legend><span>Personal Information</span></legend>
                		<div id="form-row-fname" class="row fname">
                			<label>Name<span class="req">*</span></label>
                			<input type="text" name="name" value="" class="text" />
                		</div>         
                		<div id="form-row-lname" class="row lname">
                			<label>ID Number<span class="req">*</span></label>
                			<input type="text" name="id" value="" class="text" />
                		</div>       		                		                	
						<div id="form-row-phone" class="row phone">
                			<label>Phone Number<span class="req">*</span></label>
                			<input type="text" name="phone" value="" class="text" />
                		</div>                		
                	</fieldset>
                	
                	<fieldset id="form-register-fieldset-address" class="fieldset-address">
			    <legend><span>Address Information</span></legend>
                		<div id="form-row-address1" class="row address1">
                			<label>Room Number<span class="req">*</span></label>
                			<input type="text" name="room" value="" class="text" />
                		</div>                		
				
				<div id="form-row-country" class="row country error">
                    		<select name="bhavan">
                    			<option selected="selected" disabled="disabled">Bhavan</option>
                    				<option value="1">RAM</option>
                    				<option value="2">BUDH</option>
                    				<option value="3">KRISHNA</option>
                    				<option value="4">GANDHI</option>
                    				<option value="5">VISHWAKARMA</option>
                    				<option value="6">BHAGIRATH</option>
                    				<option value="7">ASHOK</option>
                    				<option value="8">RANAPRATAP</option>
                    				<option value="9">SHANKAR</option>
                    				<option value="10">VYAS</option>
                    				<option value="11">MALAVIYA</option>
                    				<option value="12">MEERA</option>                    				
                    		</select><span class="req">*</span>
				<div class="error-message">*Select a bhavan</div>
                		</div>
                	</fieldset>
                	<fieldset id="form-register-fieldset-school" class="fieldset-school">
			    <legend><span>Techincal Experience</span></legend>
			    		<div id="form-row-schoolurl" class="row schoolurl">
                			<label>Programming Experience<span class="req">*</span></label>
                			<textarea name="progExp" class="text" rows="4" cols="50"></textarea>
                		</div>
                		<div id="form-row-schoolurl" class="row schoolurl">
                			<label>Electronics Experience<span class="req">*</span></label>
                			<textarea name="eExp" class="text" rows="4" cols="50"></textarea>
                		</div>
                	</fieldset>
<% } else { %>
				    	<fieldset id="form-register-fieldset-basicinfo" class="fieldset-basicinfo">
			    <legend><span>Personal Information</span></legend>
                		<div id="form-row-fname" class="row fname">
                			<label>Name<span class="req">*</span></label>
                			<input type="text" name="name" value="<%=entity.getProperty("name")%>" class="text" />
                		</div>         
                		<div id="form-row-lname" class="row lname">
                			<label>ID Number<span class="req">*</span></label>
                			<input type="text" name="id" value="<%=entity.getProperty("id")%>" class="text" />
                		</div>       		                		                					
                		<div id="form-row-phone" class="row phone">
                			<label>Phone Number<span class="req">*</span></label>
                			<input type="text" name="phone" value="<%=entity.getProperty("phone")%>" class="text" />
                		</div>                		
                	</fieldset>
                	
                	<fieldset id="form-register-fieldset-address" class="fieldset-address">
			    <legend><span>Address Information</span></legend>
                		<div id="form-row-address1" class="row address1">
                			<label>Room Number<span class="req">*</span></label>
                			<input type="text" name="room" value="<%=entity.getProperty("room")%>" class="text" />
                		</div>                		
				
				<div id="form-row-country" class="row country error">
                    		<select name="bhavan">
                    			<option selected="selected" disabled="disabled">Bhavan</option>
                    				<option value="1">RAM</option>
                    				<option value="2">BUDH</option>
                    				<option value="3">KRISHNA</option>
                    				<option value="4">GANDHI</option>
                    				<option value="5">VISHWAKARMA</option>
                    				<option value="6">BHAGIRATH</option>
                    				<option value="7">ASHOK</option>
                    				<option value="8">RANAPRATAP</option>
                    				<option value="9">SHANKAR</option>
                    				<option value="10">VYAS</option>
                    				<option value="11">MALAVIYA</option>
                    				<option value="12">MEERA</option>                    				
                    		</select><span class="req">*</span>
				<div class="error-message">Previous selection: <%=entity.getProperty("bhavan")%></div>
                		</div>
                	</fieldset>
                	<fieldset id="form-register-fieldset-school" class="fieldset-school">
			    <legend><span>Techincal Experience</span></legend>
			    		<div id="form-row-schoolurl" class="row schoolurl">
                			<label>Programming Experience<span class="req">*</span></label>
                			<textarea name="progExp" class="text" rows="4" cols="50"><%=entity.getProperty("progExp")%></textarea>
                		</div>
                		<div id="form-row-schoolurl" class="row schoolurl">
                			<label>Electronics Experience<span class="req">*</span></label>
                			<textarea name="eExp" class="text" rows="4" cols="50"><%=entity.getProperty("eExp")%></textarea>
                		</div>
                	</fieldset>	
<%}%>                
            	    <div id="form-register-fieldset-button-row" class="row button-row">
            		    <input id="form-register-submit" type="submit" value="Submit" class="submit" />
                    </div>
            	</form>
            	<!-- end form -->
    
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
<div id="footer">
    <div class="container_12">
            <div class="grid_3">&nbsp;</div>
            <!-- .grid_3 -->
            <div class="grid_9">
                <div class="footer-menu">
                    <ul id="footer-menu-list">
                        <li id="footer-menu-about"><a href="javascript:void(0)">About</a></li>
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
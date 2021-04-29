<!DOCTYPE html>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<HTML>
  <HEAD>
  <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
  <link href="<c:url value="/resources/css/login.css" />" rel="stylesheet">
    <TITLE>Card Keeper - Login</TITLE>
  </HEAD>
  <BODY>
	  <div class="sidenav">
      </div>
      <div class="main">
         <div class="col-md-10 col-sm-12">
         <div class="login-main-text">
            <h2><img src="<c:url value="/resources/images/card-keeper-logo.png"/>"/></h2>
            <p>Login or register from <a href="register.htm">here</a> to get started</p>
            <p id="error-message">${requestScope.message}</p>
         </div>
            <div class="login-form">
               <form action="login.htm" method="POST" role="form" cssClass="form-horizontal">
                  <div class="form-group">
                     <input type="text" maxlength="15" required class="form-control" placeholder="User Name" id="username" name="username">
                  </div>
                  <div class="form-group">
                     <input type="password" maxlength="20" required class="form-control" placeholder="Password" id="password" name="password">
                  </div>
                  <button type="submit" class="btn btn-black">Login</button>
               </form>
            </div>
         </div>
      </div>
	<script src="<c:url value="/resources/js/jquery-3.6.0.min.js" />"></script>
	<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
	<script src="<c:url value="/resources/js/popper.min.js" />"></script>
  </BODY>
</HTML>

<!DOCTYPE html>

<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<HTML>
  <HEAD>
<link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/login.css" />" rel="stylesheet">
    <TITLE>Card Keeper - Register</TITLE>
  </HEAD>
  <BODY>
<div class="sidenav">
      </div>
      <div class="main">
         <div class="col-md-10 col-sm-12">
         <div class="login-main-text">
            <h2><img src="<c:url value="/resources/images/card-keeper-logo.png"/>"/><br></h2>
            <p>Back to <a href="logout.htm">Login</a></p>
            <p id="error-message">${requestScope.message}</p>
         </div>
            <div class="login-form">
            <form:form action="addUser.htm" modelAttribute="user">
                <div class="form-group">
                  <label for="name">Name</label>
                  <form:input maxlength="20" required="required" class="reg-input right" path="name"/>       
                </div>
                <div class="form-group">
                  <label for="username">Username</label>
                  <form:input maxlength="15" required="required" class="reg-input right" path="username"/>
                </div>
                <div class="form-group">
                  <label for="password">Password</label>
                  <form:password maxlength="16" required="required" class="reg-input right" path="password"/>
                </div>      
                 <button type="submit" class="btn btn-black">Register</button>
            </form:form>
            </div>
         </div>
      </div>
	<script src="<c:url value="/resources/js/jquery-3.6.0.min.js" />"></script>
	<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
	<script src="<c:url value="/resources/js/popper.min.js" />"></script>
  </BODY>
</HTML>


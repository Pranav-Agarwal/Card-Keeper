<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<HTML>
  <HEAD>
    <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/colorpicker.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/dash.css" />" rel="stylesheet">
    <TITLE>Workspace - ${sessionScope.workspace.name}</TITLE>
  </HEAD>
  <BODY>
  <jsp:useBean id="now" class="java.util.Date"/>
  <c:set target="${now}" property="time" value="${now.time - 86400000}" />
  <div class = "topnav">
  <div class="row">
  <div class="col-sm-4"><img src="<c:url value="/resources/images/card-keeper-logo.png"/>"/></div>
  <div class="col-sm-4">  	<form action="/App/workspace/addCardList.htm" method="get" class = "form-inline">
		<input type="text" maxlength="20" required id="name" name="name" placeholder="List Name"><br>
		<input type="submit" value="Create New List">
   	</form></div>
  <div class="col-sm-2"><button type="submit" class="btn btn-secondary" onclick="handleSettingsClick();" <c:if test="${not sessionScope.admin}">disabled</c:if>>User Settings</button></div>
  <div class="col-sm-2"><form action="/App/dashboard/dashboard.htm"><button type="submit" class="btn btn-secondary">Dashboard</button></form></div>
  
  </div>
	</div>
  	<div class = "top">
  	<div class="row no-gutters">
  	<div class="col-sm-1">
  	<div class="sidenav"></div></div>
  	<div class="col-sm-11">
	<div class="main" style="background-image: url('/App/resources/images/backgrounds/${sessionScope.workspace.workspaceBg.filename}');">
	<div class="top-message"><b>${sessionScope.workspace.name}</b><div style="color:red;"><div class="ws-desc-text">${sessionScope.workspace.description}</div><div class="error-text">${requestScope.message}</div></div></div>
	<c:forEach var="entry" items = "${requestScope.cardlists}">
	<div class="list-header">
	<div class="row">
    <div class="col-sm-2"><h4 class="font-weight-bold mb-2">${entry.key.name}</h4></div>
      		<div class="col-sm-8"><form action="/App/workspace/addCard.htm" method="get" class="form-inline">
	    	<input type="hidden" id="cardList" name="cardList" value="${entry.key.id}">
			<input type="text" maxlength="15" required id="name" name="name" placeholder="Card Name">
			<input type="submit" value="Add Card">
   		</form></div>
  		<div class="col-sm-2"><form action="/App/workspace/deleteCardList.htm" method="get" class="form-inline">
		<input type="hidden" id="cardList" name="cardList" value="${entry.key.id}">
		<input type="submit"class="btn btn-secondary" value="Delete List" <c:if test="${not sessionScope.admin}">disabled</c:if>>
   	    </form></div>
   	</div></div>
  		    <div class="d-flex flex-wrap flex-row element-row">
            <!-- Card-->
            <c:forEach var="card" items = "${entry.value}">
			<div class="card card-card" style="width: 18rem;">
			  <div class="card-top" style="background-color:${card.color}e6">
			  <h5 class="card-title-text">${card.title}</h5>
 			  <c:if test="${not empty card.dueDate}"><p class="card-due-text">Due - <fmt:formatDate type = "date" value="${card.dueDate}"/></p></c:if>
				  <c:choose>
  				  <c:when test="${card.isDone}">
				    <div class="card-status-text" style="color:#00ff00"><b>Complete</b></div>
				  </c:when>
   				  <c:when test="${empty card.dueDate}">
				    <div class="card-status-text" style="color:blue"><b>Untimed</b></div>
				  </c:when>
				  <c:when test="${card.dueDate > now}">
				    <div class="card-status-text" style="color:orange"><b>Upcoming</b></div>
				  </c:when>
				  <c:otherwise>
				    <div class="card-status-text" style="color:red"><b>Past Due</b></div>
				  </c:otherwise>
				</c:choose>
				</div>
			  <div class="card-body">			    
			    <p class="card-desc-text">${card.description}</p>
				<input type="submit" value="Edit" class="view-card-button card-button btn btn-secondary" id = "${card.id}" onclick="editCardClick(this.id);" <c:if test="${not sessionScope.admin}">disabled</c:if>>
       			<input type="submit" value="View" class="view-card-button card-button btn btn-secondary" id = "${card.id}" onclick="viewCardClick(this.id);"><br>
			  </div>
			</div>
            </c:forEach>
        </div>
        </c:forEach>
	</div>
	</div>
	</div>
	</div>	
    
<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
	<script src="<c:url value="/resources/js/jquery-3.6.0.min.js" />"></script>
		<script src="<c:url value="/resources/js/popper.min.js" />"></script>
	<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
	<script src="<c:url value="/resources/js/colorpicker.js" />"></script>
    <script src="<c:url value="/resources/js/workspace.js" />"></script>
  </BODY>
</HTML>

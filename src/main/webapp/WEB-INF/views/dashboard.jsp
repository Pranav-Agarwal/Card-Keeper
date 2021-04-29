<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<HTML>
  <HEAD>
    <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/dash.css" />" rel="stylesheet">
    <TITLE>Dashboard</TITLE>
  </HEAD>
  <BODY>
  <div class = "topnav">
  <div class="row">
  <div class="col-sm-6"><img src="<c:url value="/resources/images/card-keeper-logo.png"/>"/></div>
  <div class="col-sm-2"><button type="submit" class="btn btn-secondary" onclick="addWorkspaceClick();">Add Workspace</button></div>
  <div class="col-sm-2"><button type="submit" class="btn btn-secondary" onclick="viewInvitesClick();">View Invites</button></div>
  <div class="col-sm-2"><form action="/App/logout.htm"><button type="submit" class="btn btn-secondary">Logout</button></form></div>
  
  </div>
	</div>
  	<div class = "top">
  	<div class="row no-gutters">
  	<div class="col-sm-2">
  	<div class="sidenav"></div></div>
  	<div class="col-sm-10">
	<div class="main">
  	<div class="top-message">Welcome ${sessionScope.user.name}</div>
    <c:if test="${not empty sessionScope.workspaces}"><h4 class="font-weight-bold mb-2 dash-header">Workspaces</h4></c:if>
  		    <div class="d-flex flex-wrap flex-row element-row">
            <!-- Card-->
            <c:forEach var="workspace" items = "${sessionScope.workspaces}">
			<div class="card" style="width: 18rem;">
			  <img class="card-img-top" src="/App/resources/images/backgrounds/${workspace.workspaceBg.filename}" alt="Card image cap">
			  <div class="card-body">
			    <h5 class="card-title">${workspace.name}</h5>
			    <p class="card-text">${workspace.description}</p>
   	        	<form action="/App/workspace/workspace.htm" method="get">
	        		<input type="hidden" id="workspaceId" name="workspaceId" value="${workspace.id}">
	        		<button type="submit" class="btn btn-secondary">Go To Workspace</button>
	        	</form>
			  </div>
			</div>
            </c:forEach>
        </div>
            <c:if test="${not empty sessionScope.cards}"><h4 class="font-weight-bold mb-2 dash-header">Assigned Incomplete Cards</h4></c:if>
  		    <div class="d-flex flex-wrap flex-row element-row">
            <!-- Card-->
            <jsp:useBean id="now" class="java.util.Date"/>
  			<c:set target="${now}" property="time" value="${now.time - 86400000}" />
            <c:forEach var="card" items = "${sessionScope.cards}">
				<div class="card" style="width: 18rem;">
			  	<div class="card-top" style="background-color:${card.color}">
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
			    <h5 class="card-title">${card.title}</h5>
			   <c:if test="${not empty card.dueDate}"><p class="card-text">Due - <fmt:formatDate type = "date" value="${card.dueDate}"/></p></c:if>
   	        	<form action="/App/workspace/workspace.htm" method="get">
	        		<input type="hidden" id="workspaceId" name="workspaceId" value="${card.cardlist.workspace.id}">
	        		<button type="submit" class="btn btn-secondary">Go To Workspace</button>
	        	</form>
			  </div>
			</div>
            </c:forEach>
        </div>
	</div>
	</div>
	</div>
	</div>	
		<!-- Modal -->
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
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>
	<script src="<c:url value="/resources/js/jquery-3.6.0.min.js" />"></script>
	<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
	<script src="<c:url value="/resources/js/popper.min.js" />"></script>
    <script src="<c:url value="/resources/js/dash.js" />"></script>
  </BODY>
</HTML>
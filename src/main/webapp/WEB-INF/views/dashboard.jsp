<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<HTML>
  <HEAD>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href="<c:url value="/resources/css/dash.css" />" rel="stylesheet">
    <TITLE>Dashboard</TITLE>
  </HEAD>
  <BODY>
  	<div class="container">
  	<div class = "row">
  		<a href="addWorkspace.htm">Add Workspace</a>
  	</div>
  		<div class = "row">
  		<div class="col">
	    <div class="card mx-auto" style="width: 24rem;">
	        <div class="card-body">
	        	<c:forEach var="workspace" items = "${sessionScope.workspaces}">
	        		${workspace.name}<br>
	        		<form action="workspace.htm" method="get">
	        			<input type="hidden" id="workspaceId" name="workspaceId" value="${workspace.id}">
	        			<input type="submit" value="Show">
	        		</form>
	        	</c:forEach>
        	</div>
        </div>
        </div>
        </div>
   		<div class = "row">
  		<div class="col">
	    <div class="card mx-auto" style="width: 24rem;">
	        <div class="card-body">
	        	<c:forEach var="invite" items = "${sessionScope.invites}">
	        		Workspace - ${invite.workspace.name}<br>
	        		Invite From - ${invite.sender.name}<br>
	        		Invite for Admin Role - ${invite.isAdminInvite}<br>
	        		<form action="invite.htm" method="get">
	        			<input type="hidden" id="inviteId" name="inviteId" value="${invite.id}">
	        			<input type="radio" id="accept" name="choice" value="accept">
						<label for="accept">Accept</label><br>
						<input type="radio" id="reject" name="choice" value="reject">
						<label for="reject">Reject</label><br>
	        			<input type="submit" value="Show">
	        		</form>
	        	</c:forEach>
	        </div>
        </div>
        </div>
        </div>
   		<div class = "row">
  		<div class="col">
	    <div class="card mx-auto" style="width: 24rem;">
	        <div class="card-body">
	        	<c:forEach var="card" items = "${sessionScope.cards}">
	        		Title - ${card.title}<br>
	        		Description - ${card.description}<br>
	        		Workspace - ${card.cardList.workspace.name}<br>
	        		<form action="workspace.htm" method="get">
	        			<input type="hidden" id="workspaceId" name="workspaceId" value="${card.cardList.workspace.id}">
	        			<input type="submit" value="Go To Workspace">
	        		</form>
	        	</c:forEach>
	        </div>
        </div>
        </div>
        </div>
	</div>
    <script src="<c:url value="/resources/js/dash.js" />"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  </BODY>
</HTML>
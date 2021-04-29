<!DOCTYPE html>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<HTML>
<HEAD>
  <TITLE>Card</TITLE>
</HEAD>
<BODY>
		<c:if test="${empty requestScope.invites}"><div style="color:white">No Invites Pending</div></c:if>
       	<c:forEach var="invite" items = "${requestScope.invites}">
       	   <div class="card mx-auto" style="width: 24rem;">
       <div class="card-body">
       		Workspace - ${invite.workspace.name}<br>
       		Invite From - ${invite.sender.name}<br>
       		<c:if test="${invite.isAdminInvite}">*Invite is for administrator role</c:if>
       		<form action="/App/dashboard/invite.htm" method="post">
       			<input type="hidden" id="inviteId" name="inviteId" value="${invite.id}">
       			<input type="radio" id="accept" name="choice" value="accept">
				<label for="accept">Accept</label><br>
				<input type="radio" id="reject" name="choice" value="reject">
				<label for="reject">Reject</label><br>
       			<button type="submit" class="btn btn-black">Confirm</button>
       		</form>
       		       </div>
      </div>
       	</c:forEach>
</BODY>
</HTML>
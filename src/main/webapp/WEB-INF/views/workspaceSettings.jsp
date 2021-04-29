<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<HTML>
  <HEAD>
    <TITLE>Workspace Settings</TITLE>
  </HEAD>
  <BODY>
  ${requestScope.message}
    <div class="card mx-auto" style="width: 24rem;">
        <div class="card-body">
            <h5 class="card-title" style="text-align:center">User Permissions</h5>
            <form action="/App/workspace/editMember.htm" method="GET" role="form">
                <div class="form-group">
                  <label for="userId">User</label>
                  <select id="userId" name="userId" class="form-control">
                  <c:forEach var="user" items = "${requestScope.admins}">
                  	<option value="${user.id}">${user.name} [Admin]</option>
                  </c:forEach>
                  <c:forEach var="user" items = "${requestScope.members}">
                  	<option value="${user.id}">${user.name}</option>
                  </c:forEach>
                  </select>
                </div>
                <div class="form-group">
                  <label for="operation">Operation</label>
                  <select id="operation" name="operation" class="form-control">
                    <option selected value="make_admin">Make Admin</option>
                    <option value="remove_admin">Remove Admin</option>
                    <option value="delete">Delete</option>
                  </select>
                </div>
                <button type="submit" class="btn btn-secondary">Confirm</button>
            </form>
        </div>
    </div>
    <div class="card mx-auto" style="width: 24rem;">
    <div class="card-body">
    <h5 class="card-title" style="text-align:center">Invite User</h5>
    <form action="/App/workspace/sendInvite.htm" method="GET" role="form">    	
		<input type="text" id="username" name="username" placeholder="Enter Username"><br>
     	<input type="radio" id="yes" name="isAdmin" value="yes">
		<label for="yes">Admin</label><br>
		<input type="radio" id="no" name="isAdmin" value="no" checked-->
		<label for="no">Regular Member</label><br>
    	<button type="submit" class="btn btn-secondary">Send</button>
    </form>
    </div>
    </div>
    <a href="/App/deleteWorkspace.htm" style="color:red">DELETE WORKSPACE</a>
  </BODY>
</HTML>
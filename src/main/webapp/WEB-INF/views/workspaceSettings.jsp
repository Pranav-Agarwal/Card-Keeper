<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<HTML>
  <HEAD>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <TITLE>Workspace Settings</TITLE>
  </HEAD>
  <BODY>
  ${requestScope.message}
    <div class="card mx-auto" style="width: 24rem;">
        <div class="card-body">
            <h5 class="card-title" style="text-align:center">Workspace settings</h5>
            <form action="editMember.htm" method="GET" role="form">
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
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
        </div>
    </div>
    <div class="card mx-auto" style="width: 24rem;">
    <form action="sendInvite.htm" method="GET" role="form">
    	Invite User<br>
    	<label for="username">username:</label><br>
		<input type="text" id="username" name="username"><br>
     	<input type="radio" id="yes" name="isAdmin" value="yes">
		<label for="yes">Admin</label><br>
		<input type="radio" id="no" name="isAdmin" value="no">
		<label for="no">Regular Member</label><br>
    	<button type="submit" class="btn btn-primary">Send</button>
    </form>
    </div>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  </BODY>
</HTML>
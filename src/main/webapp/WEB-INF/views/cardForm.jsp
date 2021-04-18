<!DOCTYPE html>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<HTML>
  <HEAD>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <TITLE>Card</TITLE>
  </HEAD>
  <BODY>
    <div class="card mx-auto" style="width: 24rem;">
        <div class="card-body">
            <h5 class="card-title" style="text-align:center">${sessionScope.card.title}</h5>
            <form action="editCard.htm" method="GET">
			  <div class="form-group">
			    <label for="title">Title</label>
			    <input type="text" class="form-control" id="title" placeholder="${sessionScope.card.title}"  name="title">
			  </div>
			  <div class="form-group">
			    <label for="desc">Description</label>
			    <textarea class="form-control" id="desc" rows="3" placeholder="${sessionScope.card.description}"  name="desc"></textarea>
			  </div>
			  <div class="form-group">
			    <label for="assignedTo">Assigned To</label>
			    <select class="form-control" id="assignedTo"  name="assignedTo">
			      <option value="NA">Unassigned</option>
                  <c:forEach var="user" items = "${requestScope.users}">
                  	<option value="${user.id}">${user.name}</option>
                  </c:forEach>
			    </select>
			  </div>
			  <div class="form-group">
			    <label for="cardList">List</label>
			    <select class="form-control" id="cardList"  name="cardList">
                  <c:forEach var="list" items = "${requestScope.cardlists}">
                  	<option value="${list.key.id}">${list.key.name}</option>
                  </c:forEach>
			    </select>
			  </div>
		  	  <div class="form-group">
			  <label for="duedate">Due Date</label>
			  <input type="datetime-local" id="duedate" name="duedate">
			  </div>
		      <div class="form-check">
              <input type="checkbox" class="form-check-input" id="isDone"  name="isDone">
              <label class="form-check-label" for="isDone">Completed</label>
              </div>
              <input type="submit" value="Confirm"/>
			</form>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  </BODY>
</HTML>

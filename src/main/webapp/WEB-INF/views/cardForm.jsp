<!DOCTYPE html>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<HTML>
  <HEAD>
    <TITLE>Card</TITLE>
  </HEAD>
  <BODY>
    <div class="card mx-auto" style="width: 24rem;">
        <div class="card-body cardform-body">
            <h5 class="card-title" style="text-align:center">${requestScope.card.title}</h5>
            <form action="/App/workspace/editCard.htm" method="POST">
            	<input type="hidden" id="id" name="id" value="${requestScope.card.id}"/>
			  <div class="form-group">
			    <label for="title">Title</label>
			    <input type="text" maxlength="15" required class="form-control" id="title" value="${requestScope.card.title}"  name="title">
			  </div>
			  <div class="form-group">
			    <label for="desc">Description</label>
			    <textarea class="form-control" maxlength="99" id="desc" rows="3" name="desc">${requestScope.card.description}</textarea>
			  </div>
  			  <div class="form-group">
			    <label for="color">Color</label>
			  	<input id="cp-component" name="color" type="text" value="${requestScope.card.color}" class="form-control" />
  			  </div>
			  <div class="form-group">
			    <label for="assignedTo">Assigned To</label>
			    <select class="form-control" id="assignedTo"  name="assignedTo">
			      <option value="NA"  <c:if test="${empty requestScope.card.assignedTo}">selected</c:if>>Choose a User</option>
                  <c:forEach var="user" items = "${requestScope.users}">
                  	<option value="${user.id}" <c:if test="${requestScope.card.assignedTo.id eq user.id}">selected</c:if>>${user.name}</option>
                  </c:forEach>
			    </select>
			  </div>
			  <div class="form-group">
			    <label for="cardList">List</label>
			    <select class="form-control" id="cardList"  name="cardList">
                  <c:forEach var="list" items = "${requestScope.cardlists}">
                  	<option value="${list.key.id}" <c:if test = "${requestScope.card.cardlist.id eq list.key.id}">selected</c:if>>${list.key.name}</option>
                  </c:forEach>
			    </select>
			  </div>
		  	  <div class="form-group">
			  <label for="duedate">Due Date</label>
			  <input type="date" id="duedate" name="duedate" value = "${fn:substring(requestScope.card.dueDate, 0, 10)}">
			  </div>
		      <div class="form-check">
              <input type="checkbox" class="form-check-input" id="isDone"  name="isDone" <c:if test = "${requestScope.card.isDone}">checked</c:if>>
              <label class="form-check-label" for="isDone">Completed</label>
              </div>
              <input type="submit" class="btn btn-secondary" value="Confirm"/>
			</form>

        </div>
    </div>
   			<a href="/App/workspace/deleteCard.htm?cardId=${requestScope.card.id}" style="color:red;margin-top:10px;">DELETE CARD</a>
  </BODY>
</HTML>

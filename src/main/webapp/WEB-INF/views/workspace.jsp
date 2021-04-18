<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<HTML>
  <HEAD>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href="<c:url value="/resources/css/dash.css" />" rel="stylesheet">
    <TITLE>Workspace - ${sessionScope.workspace.name}</TITLE>
  </HEAD>
  <BODY>
  	${sessionScope.workspace.name}<br>
	${sessionScope.workspace.description}<br>
  	<form action="addCardList.htm" method="get">
		<label for="name">name:</label><br>
		<input type="text" id="name" name="name"><br>
		<input type="submit" value="ADD CARDLIST">
   	</form>
  	<div class="container">
  	<div class = "row">
  		<a href="settings.htm">Workspace Settings</a>
  	</div>
  	<c:forEach var="entry" items = "${requestScope.cardlists}">
  		${entry.key.name}<br>
  		<form action="addCard.htm" method="get">
	    	<input type="hidden" id="cardList" name="cardList" value="${entry.key.id}">
			<label for="name">name:</label><br>
			<input type="text" id="name" name="name"><br>
			<input type="submit" value="ADD CARD">
   		</form>
  		<div class = "row">
  		<div class="col">
	    <div class="card mx-auto" style="width: 24rem;">
	        <div class="card-body">
	        	<c:forEach var="card" items = "${entry.value}">
	        		${card.title}<br>
	        		<form action="updateCard.htm" method="get">
	        			<input type="hidden" id="cardId" name="cardId" value="${card.id}">
	        			<input type="submit" value="Edit">
	        		</form>
	        		<form action="viewCard.htm" method="get">
	        			<input type="hidden" id="cardId" name="cardId" value="${card.id}">
	        			<input type="submit" value="View">
	        		</form>
	        	</c:forEach>
        	</div>
        </div>
        </div>
        </div>
    </c:forEach>
	</div>
    <script src="<c:url value="/resources/js/dash.js" />"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  </BODY>
</HTML>
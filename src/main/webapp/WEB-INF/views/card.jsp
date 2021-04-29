<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<div class = "card-view-body" style="background-color:${requestScope.card.color}">
	<div class="card-view-item"><div class="card-view-item-title"><b>Title</b></div>${requestScope.card.title}</div>
	<c:if test="${not empty requestScope.card.description}"><div class="card-view-item"><div class="card-view-item-title"><b>Description</b></div>${requestScope.card.description}</div></c:if>
	<c:if test="${not empty requestScope.card.assignedTo}"><div class="card-view-item"><div class="card-view-item-title"><b>Assigned To</b></div>${requestScope.card.assignedTo.name}</div></c:if>
	<div class="card-view-item"><div class="card-view-item-title"><b>List</b></div>${requestScope.card.cardlist.name}</div>
	<c:if test="${not empty requestScope.card.dueDate}"><div class="card-view-item"><div class="card-view-item-title"><b>Due Date</b></div><fmt:formatDate type = "date" value="${card.dueDate}"/></div></c:if>
	</div>
</body>
</html>
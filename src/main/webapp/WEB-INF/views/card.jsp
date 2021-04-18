<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	${sessionScope.card.title}<br>
	${sessionScope.card.description}<br>
	${sessionScope.card.assignedTo.name}<br>
	${sessionScope.card.cardlist.name}<br>
	${sessionScope.card.dueDate}<br>
	${sessionScope.card.isDone}<br>
</body>
</html>
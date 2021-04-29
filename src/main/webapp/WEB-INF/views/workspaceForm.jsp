<!DOCTYPE html>

<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<HTML>
  <HEAD>
    <TITLE>Add Workspace</TITLE>
  </HEAD>
  <BODY>
      <div class="card mx-auto" style="width: 30rem;">
        <div class="card-body cardform-body">
        <h5 class="card-title" style="text-align:center">Create Workspace</h5>
            <form:form action="/App/dashboard/addWorkspace.htm" modelAttribute="workspace" method="POST">
                <div class="form-group">
                  <label for="name">Name</label>
                  <form:input maxlength="20" required="required" class="forminput" path="name"/>       
                </div>
                <div class="form-group">
                  <label for="description">Description</label>
                  <form:textarea maxlength="99" class="forminput" path="description"/>
                </div>
                <label>Background</label>
                <div class="images-container d-flex flex-wrap flex-row">
                <c:forEach var="image" items = "${requestScope.images}">
                	<div style="text-align: center;height=120px !important;display:block">
                     <div class="bg-image" style="background-image:url('<c:url value="/resources/images/backgrounds/${image.filename}"/>')">
  					 </div><br>
  					 <form:radiobutton path="workspaceBg" value="${image.id}"/>
  					 </div>
                </c:forEach>
                </div>
                 <button type="submit" class="btn btn-secondary">Create</button>
            </form:form>            
        </div>
    </div>
  </BODY>
</HTML>
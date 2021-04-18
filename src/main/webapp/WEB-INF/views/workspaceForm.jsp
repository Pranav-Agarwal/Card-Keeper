<!DOCTYPE html>

<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<HTML>
  <HEAD>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <TITLE>Add Workspace</TITLE>
  </HEAD>
  <BODY>
    <div class="card mx-auto" style="width: 24rem;">
        <div class="card-body">
            <h5 class="card-title" style="text-align:center">Please enter details below</h5>
            <form:form action="addWorkspace.htm" modelAttribute="workspace" method="POST">
                <div class="form-group">
                  <label for="name">Name</label>
                  <form:input path="name"/>       
                </div>
                <div class="form-group">
                  <label for="description">Description</label>
                  <form:textarea path="description"/>
                </div>   
                 <input type="submit" value="ADD"/>
            </form:form>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  </BODY>
</HTML>
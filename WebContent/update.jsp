<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "com.collabera.dao.*" %>
<%@ page import = "com.collabera.model.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Update</title>
</head>
<body>
<% 
	String sid = request.getParameter("id");
	int id = Integer.parseInt(sid);
	
	//if (id<0) -> insert else  -> update
	Employee emp = new Employee(-1, "", "");
	String readOnly = "";
	out.print("id = " + id);
	
	if (id>0){
		readOnly = "readonly";
		emp = EmployeeDao.getEmployee(id);
	}
%>
<h2>Update Employee</h2>
	<form action = "doUpdate.jsp" method ="post">
		<label>ID:</label><input type = "text" name = "id"><br><br>
		<label>First Name:</label><input type= "text" name= firstName><br><br>
		<label>Last Name:</label><input type=  "text" name = lastName><br><br>
		<input type = "submit" value  = "Save">
	</form>
</body>
</html>
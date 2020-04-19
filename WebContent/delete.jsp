<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "com.collabera.dao.*" %>
<%@ page import = "com.collabera.model.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
String id = request.getParameter("id");
int deleteId = Integer.parseInt(id);
Employee deleted = EmployeeDao.delete(deleteId);

out.print("<h1>Deleted employee: " + deleted + "</h1>");
%>
<a href="view.jsp?pageNo=2&pageSize=5">Return</a>
</body>
</html>

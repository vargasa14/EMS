<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "com.collabera.dao.*" %>
<%@ page import = "com.collabera.model.*" %>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Employee Management System</title>

<style>
body {
  text-align: center;
}


table {
margin:auto;
background-color: #FFF8DC;
font: 14 px arail, sans-serif;
margin-botton: 10px;
}
table.emp-table tr: hover{
background-color: lightgray
}
 tr: nth-child(odd) {background-color: lightblue;}
 tr: nth-child(even){background-color: #FFAFA;}
 th{
 background-color: #FFDEAD;
 padding: 8px 0;
 }
 td{
 min-width:100px;
 }
 .page-link{
margin :2px;
padding: 4px 6px;
text-decoration:none;
border: solid 1px #FFFFF;
}

.page-link:hover{
border: solid 1px #4cAF50:
}

.page-link.active{
background-color: #4CAF50;
color: white;
font-weight: bold;
}
.container{
width:100%;
}
  
</style>
    
</head>
<body>
    <%
    	int pageNum;
    	int pageSize;
        
        //displays number of employees per page : default is 10 employees by page
     	try {
    		pageSize = Integer.parseInt(request.getParameter("pageSize"));
    	} catch (Exception e) 
        	{	pageSize = 10; }

    	int numPages = (int) Math.ceil(EmployeeDao.getTotalRecords() / (double) pageSize);
    	try {
    		String sPageNum = request.getParameter("page");
    		pageNum = Integer.parseInt(sPageNum);
    	} catch (Exception e) {
    		pageNum = 1;
    	}

    	List<Employee> list = EmployeeDao.getList(pageNum, pageSize);
    	out.print("<hr>Page Number: " + pageNum + "</hr>");
    	out.print("<table border ='1' cellpadding='4' width='60%'>");
    %>
 
 <table class = "emp-table"  border = '1' >
    <tr>
    <th>Id</th>
    <th>First Name</th>
    <th>Last Name</th>
    <th>Action</th>
 	</tr>  
 <%
 for (Employee e : list){
	 out.print("<tr><td>" + e.getId() +
				 "</td><td>" + e.getFirstName() +
				 "</td><td>" + e.getLastName() + 
				 "</td><td><a href = 'delete.jsp?id=" + e.getId() + "'>Delete</a>" +
				 "&nbsp;<a href ='update.jsp?id=" + e.getId() + "'>Update</a>" + 
				 "</td></tr>");
 }
 %>
</table>  
   
<div class="pagination">
<span>Pages:</span>
    <%
    String cssActive="";
    for(int i = 1; i <= numPages; i++)
    {
        if(i == pageNum) {
            cssActive="active";
        }
        else
            cssActive="";
%><a class = "page-link <%=cssActive%>" href="view.jsp?page=<%=i%>"><%=i%>| </a>
<%}%>
</div>

	<form action="view.jsp">
		Page Size:
		<select name="pageSize" onchange="this.form.submit()" >
			<option <%if (pageSize == 3)
				out.print("selected=\"selected\"");%>
				value="3">3</option>
			<option <%if (pageSize == 5)
				out.print("selected=\"selected\"");%>
				value="5">5</option>
			<option <%if (pageSize == 8)
				out.print("selected=\"selected\"");%>
				value="8">8</option>
			<option <%if (pageSize == 10)
				out.print("selected=\"selected\"");%>
				value="10">10</option>
			<option <%if (pageSize == 12)
				out.print("selected=\"selected\"");%>
				value="12">12</option>
		</select> <input type="hidden" value ="1" name="<%=pageNum%> >">
	</form>


</body>
</html>
	
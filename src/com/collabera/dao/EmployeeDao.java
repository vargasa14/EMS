package com.collabera.dao;

import java.sql.*;
import java.util.*;
import com.collabera.model.Employee;

public class EmployeeDao {
	
static Connection conn;
	
	static {
		try {
	    	DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
			conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/week5", "root", "root");;
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
	
	public static List<Employee> getList(int pageNo, int pageSize) throws SQLException{
		List<Employee> list = new ArrayList<Employee>();
		int start = (pageNo - 1)* pageSize;
		
		PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM employees limit ?, ?");
		pstmt.setInt(1, start);
		pstmt.setInt(2, pageSize);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			Employee toAdd = new Employee(rs.getInt("id"), rs.getString("firstName"), rs.getString("lastName"));
			list.add(toAdd);
		}
		return list;
	}
	
	public static Employee insert(Employee emp) throws SQLException {
		PreparedStatement pstmt = conn.prepareStatement("INSERT INTO Employees Values (?,?,?)");
		pstmt.setInt(1,  emp.getId());
		pstmt.setString(2, emp.getFirstName());
		pstmt.setString(3, emp.getLastName());
		pstmt.executeUpdate();
		return emp;
	}
	
	
	public static Employee update(Employee emp) throws SQLException {
		PreparedStatement pstmt = conn.prepareStatement("UPDATE Employees SET firstName = ?, lastName = ? WHERE id = ?");
		pstmt.setString(1, emp.getFirstName());
		pstmt.setString(2, emp.getLastName());
		pstmt.setInt(3,  emp.getId());
		pstmt.executeUpdate();
		return emp;
	}
	
	public static Employee delete(int id) throws SQLException {	
		Employee emp = new Employee(-1,"","");
		
		PreparedStatement pstmt1 = conn.prepareStatement("SELECT * FROM Employees WHERE id = ?");
		pstmt1.setInt(1, id);
		ResultSet resultSet = pstmt1.executeQuery();
		while(resultSet.next()) {
			emp.setId(resultSet.getInt("id"));
			emp.setFirstName(resultSet.getString("firstName"));
			emp.setLastName(resultSet.getString("lastName"));
		}
		
		PreparedStatement pstmt2 = conn.prepareStatement("DELETE FROM Employees WHERE id = ?");
		pstmt2.setInt(1, id);
		pstmt2.executeUpdate();
		
		return emp;
	}

	public static int getTotalRecords() throws SQLException {
		PreparedStatement pstmt = conn.prepareStatement("SELECT COUNT(*) FROM Employees");
		ResultSet resultSet = pstmt.executeQuery();
		resultSet.next();
		int count = resultSet.getInt("COUNT(*)");
		return count;
	}
	
	public static Employee getEmployee(int id) throws SQLException {
		PreparedStatement pStatement = conn.prepareStatement("SELECT * FROM Employees WHERE id = ?");
		pStatement.setInt(1, id);
		
		ResultSet rs = pStatement.executeQuery();
		rs.next();
		return new Employee(rs.getInt("id"), rs.getString("firstName"), rs.getString("lastName"));
	}
}
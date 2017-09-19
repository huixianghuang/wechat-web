<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: Programmer
  Date: 2016/12/16
  Time: 14:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>Title</title>
</head>
<body>
<%!
	Connection connection = null;
	PreparedStatement preparedStatement = null;
	String name = null;
	String password = null;
	String OfficeName = null;
	
	String encode(String string){
		if (string.contains("<") || string.contains(">"))
			string = string.replaceAll("<", "&lt");
		
		return string;
	};
%>
<%
	try {
		
		Class.forName("com.mysql.jdbc.Driver");
		//	connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/xiang?useUnicode=true&characterEncoding=utf-8", "root", "mysql.158");
		connection = DriverManager.getConnection("jdbc:mysql://119.29.53.249:3306/xiang?useUnicode=true&characterEncoding=utf-8", "root", "mysql.158");

		//获取账号密码
		if (request.getParameter("txtName")!=null) {
			name = encode(request.getParameter("txtName"));
		}
		if (request.getParameter("txtPwd")!=null){
			password = encode(request.getParameter("txtPwd"));
		}
		
		
		if ( request.getParameter("txtPwd1")!=null ){
			//注册成为普通用户
			String sql = "INSERT INTO NUSER(NAME, PASSWORD) VALUES (?, PASSWORD(?))";
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, name);
			preparedStatement.setString(2, password);
			preparedStatement.executeUpdate();
			
			//注册成功
			response.setStatus(200);
			System.out.println("register successfully!");
			
		}
		
	}
	catch (SQLException e){
		//用户名已存在
		response.sendError(601);
		e.printStackTrace();
	}
	finally {
		if (preparedStatement!=null) preparedStatement.close();
		if (connection!=null) connection.close();
	}
	
%>
</body>
</html>

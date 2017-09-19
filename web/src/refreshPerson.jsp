<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: Programmer
  Date: 2016/12/20
  Time: 16:52
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
	String sex = null;
	String school = null;
	String major = null;
	String age = null;
	String style = null;
	String username = null;
	
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
		sex = encode(request.getParameter("sex"));
		school = encode(request.getParameter("school"));
		major = encode(request.getParameter("major"));
		age = encode(request.getParameter("age"));
		style = encode(request.getParameter("style"));
		username = (String) session.getAttribute("user");
		
		String sql = "update NUSER set SEX=?, SCHOOL=?, MAJOR=?, AGE=?, STYLE=? where NAME=?";
		preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setString(1, sex);
		preparedStatement.setString(2, school);
		preparedStatement.setString(3, major);
		preparedStatement.setString(4, age);
		preparedStatement.setString(5, style);
		preparedStatement.setString(6, username);
		int i = preparedStatement.executeUpdate();
		
	}
	catch (SQLException e){
		e.printStackTrace();
	}
	finally {
		if (preparedStatement!=null) preparedStatement.close();
		if (connection!=null) connection.close();
	}

%>
</body>
</html>

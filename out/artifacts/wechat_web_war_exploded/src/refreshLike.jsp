<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: Programmer
  Date: 2016/12/24
  Time: 11:44
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
	int ID = 0;
	int likenum = 0;
	
	//html字符转义函数
	String encode(String string){
		
		if (string.contains("<") || string.contains(">"))
			string = string.replaceAll("<", "&lt");
		
		return string;
	};
%>
<%
	Class.forName("com.mysql.jdbc.Driver");
	//	connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/xiang?useUnicode=true&characterEncoding=utf-8", "root", "mysql.158");
	connection = DriverManager.getConnection("jdbc:mysql://119.29.53.249:3306/xiang?useUnicode=true&characterEncoding=utf-8", "root", "mysql.158");
	
	ID = Integer.valueOf(request.getParameter("ID"));
	likenum = Integer.valueOf(request.getParameter("likeNum"));
	
	String sql = "update OACCOUNT set LIKENUM=? where ID=?";
	preparedStatement = connection.prepareStatement(sql);
	preparedStatement.setInt(1, likenum);
	preparedStatement.setInt(2, ID);
	preparedStatement.executeUpdate();
	
%>
</body>
</html>

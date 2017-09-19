<%@ page import="java.awt.image.RescaleOp" %>
<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: Programmer
  Date: 2016/12/16
  Time: 21:21
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
	String imgUrl = "http://img05.tooopen.com/images/20150330/tooopen_sy_115918776168.jpg";
	
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
		name = encode(request.getParameter("txtName"));
		password = encode(request.getParameter("txtPwd"));
		OfficeName = encode(request.getParameter("OfficeName"));
		
		//向用户表插入该用户信息
		String sql = "INSERT INTO NUSER(NAME, PASSWORD) VALUES (?, PASSWORD(?))";
		preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setString(1, name);
		preparedStatement.setString(2, password);
		preparedStatement.executeUpdate();
	
		//向公众号用户表插入该用户信息
		String sql1 = "INSERT INTO OUSER(NAME, PASSWORD, OFFICAL, IMG) VALUES (?, PASSWORD(?), ?, ?)";
		preparedStatement = connection.prepareStatement(sql1);
		preparedStatement.setString(1, name);
		preparedStatement.setString(2, password);
		preparedStatement.setString(3, OfficeName);
		preparedStatement.setString(4, imgUrl);
		preparedStatement.executeUpdate();
//		//获取公众号唯一的ID
//		String sql2 = "SELECT OFFICALID FROM OUSER WHERE NAME=?";
//		preparedStatement = connection.prepareStatement(sql2);
//		preparedStatement.setString(1, name);
//		ResultSet result = preparedStatement.executeQuery();
//		result.next();
//		String ID = result.getString("OFFICALID");
		
		//注册成功
		response.setStatus(200);
		System.out.println("register successfully!");
		
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

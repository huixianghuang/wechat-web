<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: Programmer
  Date: 2016/12/14
  Time: 13:51
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
	
	//html字符转义函数
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
		
		String sql = "select PASSWORD from NUSER where NAME=? and PASSWORD=PASSWORD(?)";
		preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setString(1, name);
		preparedStatement.setString(2, password);
		ResultSet resultSet = preparedStatement.executeQuery();
		
		if (!resultSet.next()){
			//用户名或密码错误
			response.sendError(603);
		}
		else {
			//登录成功，保存登录信息
			session.setAttribute("user", name);
			response.setStatus(200);
		}
		
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

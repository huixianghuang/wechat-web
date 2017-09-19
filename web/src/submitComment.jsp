<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Date" %><%--
  Created by IntelliJ IDEA.
  User: Programmer
  Date: 2016/12/23
  Time: 22:38
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
	String comment = null;
	int ID = 0;
	String username = null;
	
	//html字符转义函数
	String encode(String string){
		
		if (string.contains("<") || string.contains(">"))
			string = string.replaceAll("<", "&lt");
		
		return string;
	};
%>
<%
	if (session.getAttribute("user")!=null) {
		
		Class.forName("com.mysql.jdbc.Driver");
		//	connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/xiang?useUnicode=true&characterEncoding=utf-8", "root", "mysql.158");
		connection = DriverManager.getConnection("jdbc:mysql://119.29.53.249:3306/xiang?useUnicode=true&characterEncoding=utf-8", "root", "mysql.158");

		//获取账号密码
		comment = encode(request.getParameter("comment"));
		username = (String) session.getAttribute("user");
		ID = Integer.valueOf(encode(request.getParameter("ID")));
		
		String sql = "insert into COMMENT(ID, CTEXT, USER, TIME) VALUES (?,?,?,now())";
		preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setInt(1, ID);
		preparedStatement.setString(2, comment);
		preparedStatement.setString(3, username);
		
		preparedStatement.executeUpdate();
		
		connection.close();
		preparedStatement.close();
		
	}
	else {
		response.sendError(603);
	}
%>
</body>
</html>

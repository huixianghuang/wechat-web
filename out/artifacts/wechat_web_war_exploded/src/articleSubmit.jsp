<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.sun.xml.internal.bind.v2.model.core.ID" %><%--
  Created by IntelliJ IDEA.
  User: Programmer
  Date: 2016/12/23
  Time: 9:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>article-submit</title>
</head>
<body>
<%!
	Connection connection = null;
	PreparedStatement preparedStatement = null;
	String title = null;
	String author = null;
	String atext = null;
	String userName = null;
	String imgUrl = "http://www.graphic-exchange.com/images/00designers/etcorporate/365_005.jpg";
	//html字符转义函数
	String encode(String string){
		
		if (string.contains("<") || string.contains(">"))
			string = string.replaceAll("<", "&lt");
		
		return string;
	};
%>
<%
	title = encode(request.getParameter("title-input"));
	author = encode(request.getParameter("author-input"));
	atext = request.getParameter("content");

	userName = (String) session.getAttribute("user");
	
	if (userName!=null) {

		Class.forName("com.mysql.jdbc.Driver");
//	connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/xiang?useUnicode=true&characterEncoding=utf-8", "root", "mysql.158");
		connection = DriverManager.getConnection("jdbc:mysql://119.29.53.249:3306/xiang?useUnicode=true&characterEncoding=utf-8", "root", "mysql.158");

		String sql = "select * from OUSER where NAME=?";
		preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setString(1, userName);
		ResultSet resultSet = preparedStatement.executeQuery();
		if (resultSet.next()){
			int OID = Integer.valueOf(resultSet.getString("OFFICALID"));

			String sql1 = "insert into OACCOUNT(OFFICALID, TITLE, ATEXT, AUTHOR, PTIME, IMG)" +
					"values(?, ?, ?, ?, now(), ?)";
			preparedStatement = connection.prepareStatement(sql1);
			preparedStatement.setInt(1, OID);
			preparedStatement.setString(2, title);
			preparedStatement.setString(3, atext);
			preparedStatement.setString(4, author);
			preparedStatement.setString(5, imgUrl);
			preparedStatement.executeUpdate();

		}

		preparedStatement.close();
		connection.close();

	}
	
	
%>
</body>
</html>

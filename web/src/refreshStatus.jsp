<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: Programmer
  Date: 2016/12/24
  Time: 21:39
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
	String oname = null;
	String uname = null;
	String status = null;
	String imgUrl = null;
%>
<%
	if (session.getAttribute("user")!=null) {
		
		Class.forName("com.mysql.jdbc.Driver");
		//	connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/xiang?useUnicode=true&characterEncoding=utf-8", "root", "mysql.158");
		connection = DriverManager.getConnection("jdbc:mysql://119.29.53.249:3306/xiang?useUnicode=true&characterEncoding=utf-8", "root", "mysql.158");
		
//		status = new String(request.getParameter("status").getBytes("ISO-8859-1"),"UTF-8");
//		oname = new String(request.getParameter("oname").getBytes("ISO-8859-1"),"UTF-8");
		request.setCharacterEncoding("UTF-8");
		status = request.getParameter("status");
		oname = request.getParameter("oname");
		
		uname = (String) session.getAttribute("user");
		
		if (status.equals("0")) {
			String sql = "update CONNECT set UNAME=null,ONAME=null,IMG=null where UNAME=? and ONAME=?";
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, uname);
			preparedStatement.setString(2, oname);
			preparedStatement.executeUpdate();
		} else {
			String sql1 = "select * from OUSER where NAME=?";
			preparedStatement = connection.prepareStatement(sql1);
			preparedStatement.setString(1, oname);
			ResultSet r = preparedStatement.executeQuery();
			while (r.next()) {
				imgUrl = r.getString("IMG");
			}
			String sql = "insert into CONNECT(ONAME, UNAME, IMG) values(?, ?, ?)";
			
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, oname);
			preparedStatement.setString(2, uname);
			preparedStatement.setString(3, imgUrl);
			preparedStatement.executeUpdate();
			
		}
		
		connection.close();
		preparedStatement.close();
	}
	else {
		response.sendError(603);
	}
	
%>
</body>
</html>

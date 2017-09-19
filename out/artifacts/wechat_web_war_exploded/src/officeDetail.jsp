<%--
  Created by IntelliJ IDEA.
  User: Programmer
  Date: 2016/12/23
  Time: 9:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--suppress ALL --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>wechat</title>
	<link rel="stylesheet" href="../style/style.css">
	<link rel="stylesheet" href="../style/login.css">
	<script src="jquery-3.1.1.min.js"></script>
	<script src="../js/check.js"></script>
	<script src="jquery.scrollLoading.js"></script>

</head>
<%!
	Connection connection = null;
	PreparedStatement preparedStatement = null;
	String uname = null;
	String status = null;
	String oname = null;
	String onameOne = null;
	String officeID = null;
%>
<%
	Class.forName("com.mysql.jdbc.Driver");
	//	connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/xiang?useUnicode=true&characterEncoding=utf-8", "root", "mysql.158");
	connection = DriverManager.getConnection("jdbc:mysql://119.29.53.249:3306/xiang?useUnicode=true&characterEncoding=utf-8", "root", "mysql.158");
	
//	oname = new String(request.getParameter("oname").getBytes("ISO-8859-1"),"UTF-8");
	request.setCharacterEncoding("UTF-8");
	oname = request.getParameter("oname");
	
	uname = (String)session.getAttribute("user");
	
	String sql2 = "select * from CONNECT where UNAME=? and ONAME=?";
	preparedStatement = connection.prepareStatement(sql2);
	preparedStatement.setString(1, uname);
	preparedStatement.setString(2, oname);
	ResultSet resultSet1 = preparedStatement.executeQuery();
	if (resultSet1.next()){
		status="取消订阅";
	}
	else {
		status="订阅";
	}
	
	//获取公众号名称
	String sqla = "select * from OUSER where NAME=?";
	preparedStatement = connection.prepareStatement(sqla);
	preparedStatement.setString(1, oname);
	resultSet1 = preparedStatement.executeQuery();
	if (resultSet1.next()){
		onameOne = resultSet1.getString("OFFICAL");
		if (onameOne.length()>3){
			onameOne = onameOne.substring(0, 4)+"...";
		}
	}
	
%>

<body>

<div class="bgimg">
	<div id="divBt">
		<h2 class="font-style h2-style">A WeChat Official Account in Web by a rookie in ShenZhen University</h2>
	</div>
	<div style="padding-top: 100px"></div>
</div>
<div class="clear"></div>

<%--文章展示--%>
<div style="min-width: 900px; width: 950px; height: 100%; margin: 0 auto">
	<div id="div2" style="margin: 60px 0px 0px 0px;">
		<ul style="list-style: none;padding-left: 2px ">
			<li style="float: left; margin: 0px;width: 80px;height: 40px;position: relative; text-align: center;font-family: 微软雅黑;">
				<a style=" display: block; padding-top: 10px; color: dodgerblue; cursor: hand">最新文章</a></li>
			<ul style="float: right; list-style: none;padding-left: 2px">
				<li id="status-li" style="float: left; margin: 0px;width: 80px;height: 40px;position: relative; text-align: center;font-family: 微软雅黑;">
					<a style=" display: block; padding-top: 10px; color: dodgerblue; cursor: hand"><%= status%></a></li>
				
				<li style="float: left; margin: 0px;width: 80px;height: 40px;position: relative; text-align: center;font-family: 微软雅黑;">
					<a id="oname-a" style=" display: block; padding-top: 10px; color: dodgerblue;"><%= onameOne%></a></li>
				<li style="display: none">
					<a id="oname-aa"><%= oname%></a></li>
			</ul>
			
		</ul>
		
	</div>
	<div class="clear"></div>
	
	<%--文章，公众号展示--%>
	<div id="tab1">
		<hr style="height: 1px; width:98%; border: none; background-color: dodgerblue"/>
		
		<%
			String sql = "select * from OUSER where NAME=?";
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, oname);
			ResultSet resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				officeID = resultSet.getString("OFFICALID");
			}
			
			String sql1 = "select * from OACCOUNT where OFFICALID=?";
			preparedStatement = connection.prepareStatement(sql1);
			preparedStatement.setString(1, officeID);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()){
				String ID = resultSet.getString("ID");
				String imgUrl = resultSet.getString("IMG");
				String title = resultSet.getString("TITLE");
		
		%>
			<div style="width: 45%; padding-left: 2%; padding-right: 2%; padding-bottom: 2%; display: inline; float: left">
				<div style="width: 100%; display: inline;">
					<img style="width: 100%; height: 300px; padding-bottom: 15px; padding-left: 10px; cursor: hand"
						 data-url="<%= imgUrl%>" id="<%= ID%>"/>
				</div>
				<div style="width: 100%;padding-left: 2%; text-align: center; word-wrap: break-word">
					<span style="width: 20px; font-family: 微软雅黑"><%= title%></span>
				</div>
			
			</div>
		<%
			}
			
			preparedStatement.close();
			connection.close();
		%>
	</div>
	
	<div class="clear"></div>

</div>

</body>
</html>

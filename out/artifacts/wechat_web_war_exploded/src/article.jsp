<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: Programmer
  Date: 2016/12/23
  Time: 9:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>article</title>
	<link rel="stylesheet" href="../style/article.css">
	<script src="jquery-3.1.1.min.js"></script>
	<script src="../js/checkOne.js"></script>
	<script src="jquery.scrollLoading.js"></script>
	
</head>
<%!
	Connection connection = null;
	PreparedStatement preparedStatement = null;
	
	int ID = 0;
	String imgUrl = null;
	String title = null;
	String atext = null;
	String author = null;
	String ptime = null;
	int like = 0;
	int read = 0;
	int officalID = 0;
	String officalName = null;
	String officalUName = null;
%>
<%
	ID = Integer.valueOf(request.getParameter("ID"));
	imgUrl = request.getParameter("imgUrl");
	
	Class.forName("com.mysql.jdbc.Driver");//119.29.53.249
//	connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/xiang?useUnicode=true&characterEncoding=utf-8", "root", "mysql.158");
	connection = DriverManager.getConnection("jdbc:mysql://119.29.53.249:3306/xiang?useUnicode=true&characterEncoding=utf-8", "root", "mysql.158");

	//获取文章概览
	String sql = "select * from OACCOUNT where ID=?";
	preparedStatement = connection.prepareStatement(sql);
	preparedStatement.setInt(1, ID);
	ResultSet resultSet = preparedStatement.executeQuery();
	
	while (resultSet.next()){
		title = resultSet.getString("TITLE");
		atext = resultSet.getString("ATEXT");
		author = resultSet.getString("AUTHOR");
		ptime = String.valueOf(resultSet.getDate("PTIME"));
		like = resultSet.getInt("LIKENUM");
		read = resultSet.getInt("READNUM");
		officalID = resultSet.getInt("OFFICALID");
	}
	
	//获取公众号名称
	String sql1 = "select * from OUSER where OFFICALID=?";
	preparedStatement = connection.prepareStatement(sql1);
	preparedStatement.setInt(1, officalID);
	resultSet = preparedStatement.executeQuery();
	while (resultSet.next()){
		officalName = resultSet.getString("OFFICAL");
		officalUName = resultSet.getString("NAME");
	}
%>

<body>
	<%--文章概览，作者，图片等等--%>
	<div id="headerAndNav">
		<div id="headerContainer" class="container">
			
			<div id="header">
				<h1>
					<a id="logo">
						<div class="article-logo">
							<img src=<%= imgUrl%> title="prograk"/>
						</div>
					</a>
				</h1>
				<%--公众号名称--%>
				<div id="blogDesc" style="cursor: hand">
					<%= officalName%>
				</div>
				<div id="blogDesc1" style="display: none"><%= officalUName%></div>
				
			</div>
		</div>
	</div>

	<%--文章内容--%>
	<div id="postsContainer">
		<div id="posts">
			<div class="each-post">
				<%--文章标题，时间，作者--%>
				<div class="title" id=<%= ID%>>
					<%= title%>
				</div>
				<div class="created-time">
					<span class="fa fa-eye">Public Time :&nbsp;&nbsp;</span><%= ptime%>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<span class="fa fa-eye">author :&nbsp;&nbsp;</span><%= author%>
					
				</div>
				
				<%--文本内容--%>
				<div class="desc" id="content">
					<p>
						<%= atext%>
					</p>
				</div>
				
			</div>
		</div>
		
		<%--like--%>
		<div>
			<div>
				<button class="btn" id="likeBtn">
					<span id="likeNum"><%= like%></span> 赞
				</button>
				
				<b class="read-b" id="readBtn">
					<%= read%>
				</b>
				<b class="read-b">人读过</b>
			</div>
		</div>
		
		<%--评论--%>
		<div class="comment-div">
			<form class="form-style">
				<textarea class="comment-input" type="text" name="comment" placeholder="评论" ></textarea>
				<button class="sub-btn" id="submit-btn">提交评论</button>
			</form>
			
			<%--展示已通过审核的评论, 标记为1--%>
			<%
				String sql2 = "select * from COMMENT where ID=? and STATUE=1";
				preparedStatement = connection.prepareStatement(sql2);
				preparedStatement.setInt(1, ID);
				resultSet = preparedStatement.executeQuery();
				
				while (resultSet.next()){
					String cuser = resultSet.getString("USER");
					String ctime = String.valueOf(resultSet.getDate("TIME"));
					String ctext = resultSet.getString("CTEXT");
			%>
				<div style="width: 600px;">
					<hr align="left" width="100%" style="border-color: whitesmoke"/>
					<img src="../image/userHead.jpg"  class="display-style img-style">
					<div class="display-style name-style"><%= cuser%></div>
					<div class="display-style time-style"><%= ctime%></div>
					<div class="display-style comment-style">
						<a>
							<%= ctext%>
						</a>
					</div>
				</div>
			<%
				}
			%>
			
		</div>
		
	</div>
	
</body>
<%
	connection.close();
	preparedStatement.close();
%>
</html>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: Programmer
  Date: 2016/12/25
  Time: 11:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>ueditor demo</title>
	<link rel="stylesheet" href="../style/style.css">
	<link rel="stylesheet" href="../style/login.css">
	<link rel="stylesheet" href="../style/edit.css">
	<link rel="stylesheet" href="../style/article.css">
	
	<script src="../src/jquery-3.1.1.min.js"></script>
	<script src="../js/check.js"></script>
	<script src="../js/checkOne.js"></script>
	<script src="../src/jquery.scrollLoading.js"></script>
	
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
	if (session.getAttribute("user") == null){
%>
	<script type="text/javascript">
		window.location.href="../src/home.jsp";
	</script>
<%
	}
	else {
		String user = (String)session.getAttribute("user");
		Class.forName("com.mysql.jdbc.Driver");
        //	connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/xiang?useUnicode=true&characterEncoding=utf-8", "root", "mysql.158");
        connection = DriverManager.getConnection("jdbc:mysql://119.29.53.249:3306/xiang?useUnicode=true&characterEncoding=utf-8", "root", "mysql.158");

		String sql = "select * from OUSER where NAME=?";
		preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setString(1, user);
		ResultSet resultSet = preparedStatement.executeQuery();
		if (!resultSet.next()){
%>
		<script type="text/javascript">
			window.location.href="../src/home.jsp";
		</script>
<%
		}
		else {
%>

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
					<a style=" display: block; padding-top: 10px; color: dodgerblue; cursor: hand">编辑文章</a></li>
			</ul>
		
		</div>
		<div class="clear"></div>
		
		<%--文章，公众号展示--%>
		<div id="tab1">
			<hr style="height: 1px; width:98%; border: none; background-color: dodgerblue"/>
			<form id="article-from">
				<%--文章标题输入框--%>
				<input type="text" name="title-input" placeholder="请输入文章标题" class="title-style"/>
				<input type="text" name="author-input" placeholder="请输入文章作者" class="title-style"/>
				<!-- 加载编辑器的容器 -->
				<script id="container" name="content" type="text/plain">
					
				</script>
				
			</form>
			
			<button class="sub-btn" id="submit-article">提交</button>
			<script type="text/javascript">
				//提交文章
				$("#submit-article").click(function () {
					
					var s1 = $("#article-from input[name='title-input']").val();
					var s2 = $("#article-from input[name='author-input']").val();
					if (s1==null || s1==""){
						alert("请填写标题");
						return false;
					}
					if (s2==null || s2==""){
						alert("请填写作者");
						return false;
					}
					
					$.ajax({
						url: "../src/articleSubmit.jsp",
						type: "POST",
						data: $("#article-from").serialize(),
						success: function () {
							alert("submit successfully!");
						}
					});
					return false;
					
				});
				
			</script>
			
			<!-- 配置文件 -->
			<script type="text/javascript" src="ueditor.config.js"></script>
			<!-- 编辑器源码文件 -->
			<script type="text/javascript" src="ueditor.all.js"></script>
			<!-- 实例化编辑器 -->
			<script type="text/javascript">
				var ue = UE.getEditor('container');
			</script>
			
		</div>
		
		<div class="clear"></div>
	
	</div>
<%
		}
	}
%>

</body>
</html>

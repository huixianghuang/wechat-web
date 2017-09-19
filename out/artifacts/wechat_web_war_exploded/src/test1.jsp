<%--
  Created by IntelliJ IDEA.
  User: Programmer
  Date: 2016/12/13
  Time: 21:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>Title</title>
	<link href="../style/login.css" rel="stylesheet">
	<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<div class="mask"></div>
	<div id="login">
		<div class="row1">
			<ul class="ul-style">
				<li class="li-style-1 li-style-1-1" id="loginbtn1"><a class="a-style-1">登录</a></li>
				<%--<span style="color: grey; position: relative; float: left; padding-top: 12px; margin: 0">|</span>--%>
				<li class="li-style-1"  id="registerbtn1"><a class="a-style-1">注册</a></li>
				<li class="li-style-2"><a class="a-style-2">×</a></li>
			</ul>
		</div>
		<div class="clear"></div>
		<%--<hr style="width: 90%; margin-top: 0">--%>
		<div id="login1">
			<div class="div-style-1">
				账号:
					<input type="text" id="txtName" placeholder="账号/邮箱" class="input-style"/>
			</div>
			<div class="div-style-1">
				密码:
					<input type="password" id="txtPwd" placeholder="密码" class="input-style" />
			</div>
			<div style="text-align: center">
				<button class="bt-style-1">
					<a href="http://prograkhhy.leanote.com/">
						<b style="font-family: 微软雅黑; font-size: 15px; padding: 5px; color: aliceblue">登录</b>
					</a>
				</button>
			</div>
		</div>
		
		<div id="register1" class="displayNone">
			<div class="div-style-1">
				账号:
				<input type="text" id="txtName1" placeholder="账号/邮箱" class="input-style"/>
			</div>
			<div class="div-style-1">
				密码:
				<input type="password" id="txtPwd1" placeholder="密码" class="input-style" />
			</div>
			<div class="div-style-1 div-style-1-1">
				&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;确认密码:
				<input type="password" id="txtPwd2" placeholder="确认密码" class="input-style input-style-1" />
			</div>
			<div style="text-align: center">
				<button class="bt-style-1">
					<a href="http://prograkhhy.leanote.com/">
						<b style="font-family: 微软雅黑; font-size: 15px; padding: 5px; color: aliceblue">注册</b>
					</a>
				</button>
			</div>
		</div>
		
	</div>

	<script src="jquery-3.1.1.min.js"></script>
	<script type="text/javascript">
		<%-- 登录，注册显示 --%>
		$(document).ready(function () {
			$("#loginbtn1").click(function () {
				$(this).addClass("li-style-1-1")
				$("#registerbtn1").removeClass("li-style-1-1")
				$("#login1").show();
				$("#register1").hide();
			});
			$("#registerbtn1").click(function () {
				$(this).addClass("li-style-1-1")
				$("#loginbtn1").removeClass("li-style-1-1")
				$("#register1").show();
				$("#login1").hide();
			})
		});
	</script>
</body>
</html>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--suppress ALL --%>
<%--
  Created by IntelliJ IDEA.
  User: Programmer
  Date: 2016/12/12
  Time: 15:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>wechat</title>
	<link rel="stylesheet" href="../style/style.css">
	<link rel="stylesheet" href="../style/login.css">
	<script src="jquery-3.1.1.min.js"></script>
	<script src="../js/check.js"></script>
	<script src="jquery.scrollLoading.js"></script>
	<script src="jquerysession.js"></script>
	
</head>
<%!
	Connection connection = null;
	PreparedStatement preparedStatement = null;
	String name = null;
	String password = null;
	String userName = null;
	String userName1 = null;
	int userFlag = 0;
	
%>
<%
	Class.forName("com.mysql.jdbc.Driver");
//	connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/xiang?useUnicode=true&characterEncoding=utf-8", "root", "mysql.158");
	connection = DriverManager.getConnection("jdbc:mysql://119.29.53.249:3306/xiang?useUnicode=true&characterEncoding=utf-8", "root", "mysql.158");

	if (session.getAttribute("user")!=null) {
		
		userName = (String) session.getAttribute("user");
		if (userName.length() > 7) {
			userName1 = userName.substring(0, 4);
			userName1 = userName1+"...";
		}
		else {
			userName1 = userName;
		}
		
		//判断是为普通用户还是公众号用户
		String sql3 = "select * from OUSER where NAME=?";
		preparedStatement = connection.prepareStatement(sql3);
		preparedStatement.setString(1, userName);
		ResultSet resultSet = preparedStatement.executeQuery();
		if (resultSet.next()){
			userFlag=1;
		}
		else {
			userFlag=0;
		}
		
	}
%>

<body>
	<%--导航，菜单--%>
	<header class="hd">
		<div class="hd-container">
			<h1 class="text-desg">
				<img class="img-style" src="../image/WeChat.png">
				<a>WeChat</a>
			</h1>
			
			<div class="div-style">
				<ul id="ulone">
					<li><a class="a-style" href="http://blog.csdn.net/programmerhhy">CSDN</a></li>
					<li><a class="a-style" href="https://github.com/huixianghuang">GitHub</a></li>
					<li><a class="a-style" href="http://prograkhhy.leanote.com/">LeaNote</a></li>
					<li><a class="a-style" href="http://prograkhhy.leanote.com/">联系我们</a></li>
					<li style="cursor: hand;" id="loginLi"><a class="a-style" id="loginbtn">登录/注册</a></li>
					<li style="cursor: hand; display: none; width: 57px" id="personLi">
						<a class="a-style" id="personbtn"><%= userName1%></a>
					</li>
					
				</ul>
				
			</div>
			<div class="clear"></div>
		</div>
		
		<ul id="ultwo" style="list-style: none; float: right; margin: 0px; padding-right: 4.9%; display: none">
			<li style="padding-left: 29px; padding-right: 29px; padding-top: 10px; padding-bottom: 10px;
			 border-bottom: 1px solid whitesmoke; cursor: hand">
				<a style="display: block; font-family: 微软雅黑; font-size: 15px; color: whitesmoke"
				   id="personifmt">个人资料</a>
			</li>
			<li style="padding-left: 29px; padding-right: 29px; padding-top: 10px; padding-bottom: 10px;
			cursor: hand">
				<a style="display: block; font-family: 微软雅黑; font-size: 15px; color: whitesmoke; text-align: center"
				   id="logout">注销</a>
			</li>
		</ul>
		
		<%
			if ( session.getAttribute("user")!=null ) {
		%>
			<script type="text/javascript">
				$(document).ready(function () {
					$("#loginLi").hide();
					$("#personLi").show();
				});
			</script>
		<%
			}
		%>
	</header>
	
	<div class="bgimg">
		<div id="divBt">
			<h2 class="font-style h2-style">A WeChat Official Account in Web by a rookie in ShenZhen University</h2>
			<%
				if (userFlag==1){
			%>
				<button class="bt-style" id="article-public">
					<a href="http://prograkhhy.leanote.com/">
						<b style="font-family: 微软雅黑; font-size: 15px; padding: 5px; color: aliceblue">发表推文</b>
					</a>
				</button>
			<%
				}
				else {
			%>
				<button class="bt-style" id="article-public-1">
					<a href="http://prograkhhy.leanote.com/">
						<b style="font-family: 微软雅黑; font-size: 15px; padding: 5px; color: aliceblue">发表推文</b>
					</a>
				</button>
			<%
				}
			%>
			
		</div>
	</div>
	<div class="clear"></div>
	
	<%--文章展示--%>
	<div style="min-width: 900px; width: 950px; height: 100%; margin: 0 auto">
		<div id="div2" style="margin: 60px 0px 0px 0px;">
			<ul style="list-style: none;padding-left: 2px ">
				<li style="float: left; margin: 0px;width: 80px;height: 40px;position: relative; text-align: center;font-family: 微软雅黑;">
					<a style=" display: block; padding-top: 10px; color: dodgerblue; cursor: hand">最新文章</a></li>
				<span style="color: dodgerblue; position: relative; float: left; padding-top: 12px">|</span>
				<li style="float: left; margin: 0px;width: 80px;height: 40px;position: relative; text-align: center;font-family: 微软雅黑">
					<a style="display: block; padding-top: 10px; color: dodgerblue; cursor: hand">公众号</a></li>
			</ul>
			
		</div>
		<div class="clear"></div>
		
		<%--文章，公众号展示--%>
		<div id="tab1">
			<hr style="height: 1px; width:98%; border: none; background-color: dodgerblue"/>
			
			<%
				//用户没登录，显示推荐的文章
				if (session.getAttribute("user") == null){
					String sql = "select * from OACCOUNT order by LIKENUM desc";
					preparedStatement = connection.prepareStatement(sql);
					ResultSet resultSet = preparedStatement.executeQuery();
					while (resultSet.next()){
						String ID = resultSet.getString("ID");
						String imgUrl = resultSet.getString("IMG");
						String title = resultSet.getString("TITLE");
						if(title.length() > 25){
							title = title.substring(0, 22)+"...";
						}
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
				}
				//用户已登录，显示订阅的文章
				else {
						
					String sql = "select * from OACCOUNT order by PTIME desc";
					preparedStatement = connection.prepareStatement(sql);
					ResultSet resultSet = preparedStatement.executeQuery();
					while (resultSet.next()) {
						String ID = resultSet.getString("ID");
						String imgUrl = resultSet.getString("IMG");
						String title = resultSet.getString("TITLE");
						if(title.length() > 25){
							title = title.substring(0, 22)+"...";
						}
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
				}
			%>
		</div>
		<div style="clear: both"></div>
		
		<%--公众号--%>
		<div class="div-hide" id="tab2">
			<hr style="height: 1px; width:98%;  border: none; background-color: dodgerblue"/>
			
			<%
				//用户已登录，显示已订阅的公众号
				int flag=0;
				if (session.getAttribute("user")!=null){
					String sql1 = "select * from CONNECT where UNAME=?";
					preparedStatement = connection.prepareStatement(sql1);
					preparedStatement.setString(1, userName);
					ResultSet resultSet1 = preparedStatement.executeQuery();
					while (resultSet1.next()){
						flag=1;
						String oname = resultSet1.getString("ONAME");
						String onameOne=null;
						
						//通过公众号用户名查询公众号名称
						String sqla = "select * from OUSER where NAME=?";
						preparedStatement = connection.prepareStatement(sqla);
						preparedStatement.setString(1, oname);
						ResultSet r = preparedStatement.executeQuery();
						if (r.next()){
							onameOne = r.getString("OFFICAL");
						}
						
						String imgUrl = resultSet1.getString("IMG");
						
						if (onameOne.length()>25){
							onameOne = onameOne.substring(0, 22)+"...";
						}
			%>
				
				<div style="width: 45%; padding-left: 2%; padding-right: 2%; padding-bottom: 2%; display: inline; float: left">
					<div style="width: 100%; display: inline;">
						<img style="width: 100%; height: 300px; padding-bottom: 15px; padding-left: 10px; cursor: hand"
							 data-url="<%= imgUrl%>" id="<%= oname%>"/>
					</div>
					<div style="width: 100%;padding-left: 2%; text-align: center; word-wrap: break-word">
						<span style="width: 20px; font-family: 微软雅黑"><%= onameOne%></span>
					</div>
				
				</div>
			<%
					}
				}
				//没登录或者没订阅公众号，显示推荐的公众号
				if(flag==0 || session.getAttribute("user")==null) {
						String sql1 = "select * from OUSER order by LOOKNUM desc";
						preparedStatement = connection.prepareStatement(sql1);
						ResultSet resultSet1 = preparedStatement.executeQuery();
						while (resultSet1.next()){
							String oname = resultSet1.getString("NAME");
							String onameOne = resultSet1.getString("OFFICAL");
							String imgUrl = resultSet1.getString("IMG");
							if (onameOne.length()>25){
								onameOne = onameOne.substring(0, 22)+"...";
							}
			%>
				
				<div style="width: 45%; padding-left: 2%; padding-right: 2%; padding-bottom: 2%; display: inline; float: left">
					<div style="width: 100%; display: inline;">
						<img style="width: 100%; height: 300px; padding-bottom: 15px; padding-left: 10px; cursor: hand"
							 data-url="<%= imgUrl%>" id="<%= oname%>"/>
					</div>
					<div style="width: 100%;padding-left: 2%; text-align: center; word-wrap: break-word">
						<span style="width: 20px; font-family: 微软雅黑"><%= onameOne%></span>
					</div>
				
				</div>
			<%
					}
				}
			%>
			
		</div>
		
		<div class="clear"></div>
		
	</div>
	
	
	<%--登录注册页面--%>
	<div id="login">
		<div class="row1">
			<ul class="ul-style">
				<li class="li-style-1 li-style-1-1" id="loginbtn1"><a class="a-style-1">登录</a></li>
				<li class="li-style-1"  id="registerbtn1"><a class="a-style-1">注册</a></li>
				<li class="li-style-2" id="closebtn"><a class="a-style-2">×</a></li>
			</ul>
		</div>
		<div class="clear"></div>

		<form id="loginForm">
			<div id="login1">
				<div class="div-style-1">
					账号:
					<input type="text" name="txtName" placeholder="账号/邮箱" class="input-style"/>
				</div>
				<div class="div-style-1">
					密码:
					<input type="password" name="txtPwd" placeholder="密码" class="input-style" />
				</div>
				<div style="text-align: center">
					<button class="bt-style-1" name="btn">
						<a>
							<b style="font-family: 微软雅黑; font-size: 15px; padding: 5px; color: aliceblue">登录</b>
						</a>
					</button>
				</div>
			</div>
		</form>
		
		<%--注册普通用户--%>
		<form id="registerForm">
			<div id="register1" class="displayNone">
				<div class="div-style-1">
					账号:
					<input type="text" name="txtName" placeholder="账号/邮箱" class="input-style"/>
				</div>
				<div class="div-style-1">
					密码:
					<input type="password" name="txtPwd" placeholder="密码" class="input-style" />
				</div>
				<div class="div-style-1 div-style-1-1">
					&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;确认密码:
					<input type="password" name="txtPwd1" placeholder="确认密码" class="input-style input-style-1" />
				</div>
				<div style="text-align: center">
					<button class="bt-style-1" name="btn">
						<a>
							<b style="font-family: 微软雅黑; font-size: 15px; padding: 5px; color: aliceblue">注册</b>
						</a>
					</button>
				</div>
				<div style="text-align: right; margin: 0px; padding-right: 5px">
						<a style="cursor: hand" id="officeBtn">
							<b style="font-family: 微软雅黑; font-size: 10px; color: dodgerblue; text-decoration: underline">注册成为公众号用户</b>
						</a>
				</div>
			</div>
		</form>
		
		<%--注册公众号用户--%>
		<form id="registerForm1">
			<div id="register1-1" class="displayNone">
				<div class="div-style-1">
					账号:
					<input type="text" name="txtName" placeholder="账号/邮箱" class="input-style"/>
				</div>
				<div class="div-style-1">
					密码:
					<input type="password" name="txtPwd" placeholder="密码" class="input-style" />
				</div>
				<div class="div-style-1 div-style-1-1">
					&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;公众号名:
					<input type="text" name="OfficeName" placeholder="公众号名称" class="input-style input-style-1" />
				</div>
				<div style="text-align: center">
					<button class="bt-style-1" name="btn">
						<a>
							<b style="font-family: 微软雅黑; font-size: 15px; padding: 5px; color: aliceblue">注册</b>
						</a>
					</button>
				</div>
			</div>
			
		</form>
	</div>
	
	<%--个人信息页面--%>
	<div id="personMesgsDiv" style="position:absolute;left: 30%;top: 30%;background:whitesmoke;width:426px;
		border:2px solid whitesmoke;border-radius:8px;z-index:10001;display:none;">
		<div class="row1">
			<ul class="ul-style">
				<li class="li-style-1 li-style-1-1" id="personbtn1"><a class="a-style-1">个人信息</a></li>
				<li class="li-style-2" id="closebtn1"><a class="a-style-2">×</a></li>
			</ul>
		</div>
		<div class="clear"></div>
		
		<%
			String sql2 = "select * from NUSER where NAME=?";
			preparedStatement = connection.prepareStatement(sql2);
			preparedStatement.setString(1, userName);
			ResultSet resultSet2 = preparedStatement.executeQuery();
			String sex=null, school=null, major=null, age=null, style=null;
			while (resultSet2.next()){
				sex = resultSet2.getString("SEX");
				school = resultSet2.getString("SCHOOL");
				major = resultSet2.getString("MAJOR");
				age = resultSet2.getString("AGE");
				style = resultSet2.getString("STYLE");
			}
			
			preparedStatement.close();
			connection.close();
		%>
		<%--//信息展示--%>
		<div id="personShow">
			<div class="div-style-1">
				性别:
				<b><%= sex%></b>
			</div>
			<div class="div-style-1">
				学校:
				<b><%= school%></b>
			</div>
			<div class="div-style-1">
				专业:
				<b><%= major%></b>
			</div>
			<div class="div-style-1">
				年龄:
				<b><%= age%></b>
			</div>
			<div class="div-style-1">
				签名:
				<b><%= style%></b>
			</div>
			<div style="text-align: center; padding-bottom: 20px">
				<button class="bt-style-1" name="btn">
					<a>
						<b style="font-family: 微软雅黑; font-size: 15px; padding: 5px; color: aliceblue">重新编辑</b>
					</a>
				</button>
			</div>
		</div>
		
		<%--//信息编辑--%>
		<div id="personForm" class="displayNone">
		<form>
			<div id="person1">
				<div class="div-style-1">
					性别:
					<input type="text" name="sex" placeholder="您的性别" class="input-style"/>
				</div>
				<div class="div-style-1">
					学校:
					<input type="text" name="school" placeholder="您所在的学校" class="input-style" />
				</div>
				<div class="div-style-1">
					专业:
					<input type="text" name="major" placeholder="您的专业" class="input-style" />
				</div>
				<div class="div-style-1">
					年龄:
					<input type="text" name="age" placeholder="您的年龄" class="input-style" />
				</div>
				<div class="div-style-1">
					签名:
					<input type="text" name="style" placeholder="个性签名" class="input-style" />
				</div>
				<div style="text-align: center">
					<button class="bt-style-1" name="btn">
						<a>
							<b style="font-family: 微软雅黑; font-size: 15px; padding: 5px; color: aliceblue">提交</b>
						</a>
					</button>
				</div>
			</div>
		</form>
		</div>
	</div>
	
	<%--改变header--%>
	<script type="text/javascript">
		$(window).scroll(function()
		{
			if ($(window).scrollTop() > 0)
			{
				$("header div").addClass("changeHeader");
			}
			else
			{
				$("header div").removeClass("changeHeader");
			}
		});
		
		
	</script>
</body>
</html>

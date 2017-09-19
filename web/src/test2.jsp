<%--
  Created by IntelliJ IDEA.
  User: Programmer
  Date: 2016/12/20
  Time: 15:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>information</title>
</head>
<body>
<%
	String string = "<a></a>";
	string = string.replaceAll("<", "&lt");
	out.println(string);
%>
</body>
</html>

<%@page import="com.msg.util.ValidateUtil"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户登录</title>
</head>
<jsp:include page="inc.jsp">
	<jsp:param value="添加" name="op"/>
</jsp:include>
<body>
	<form action="add.jsp" method="post">
	<table align="center" width="500" bord="1">
		<tr>
			<td>用户名称：</td>
			<td>
				<input type="text" name="username" value="${param.username }"/>
				<%=ValidateUtil.showError(request, "username")%>
				 
			</td>
		</tr>
		<tr>
			<td>用户密码：</td>
			<td><input type="password" name="password"/>
			<%-- <%=ValidateUtil.showError(request, "password")%> --%>
			<c:out value="${ValidateUtil.showError.request.password}"></c:out>
				 
			</td>
		</tr>
		<tr>
			<td>用户昵称：</td>
			<td><input type="text" name="nickname"  value="${param.nickname }"/>
			<%=ValidateUtil.showError(request, "nickname")%>
				 
			</td>
			
		</tr>
		<tr colspan="2">
			<td><input type="submit" name="添加用户"/></td>
		</tr>
	</table>
	</form>

</body>
</html>
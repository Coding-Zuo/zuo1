<%@page import="com.msg.dao.DaoFactory"%>
<%@page import="com.msg.dao.IUserDao"%>
<%@page import="com.msg.model.ShopException"%>
<%@page import="com.msg.util.ValidateUtil"%>
<%@page import="com.msg.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
	/* User iu=(User)session.getAttribute("loginUser");
	if(iu.getType()==0)throw new ShopException("您不是管理员，不能操作"); */
	int userid= Integer.parseInt(request.getParameter("id"));
	IUserDao ud=DaoFactory.getUserDao();
	User u=ud.load(userid);
	
%>
</head>
<jsp:include page="inc.jsp">
	<jsp:param value="更新" name="op"/>
</jsp:include>
<body>

<form action="updateSelf.jsp" method="post">
	<table align="center" width="500" bord="1">
		<input type="hidden" name="id" value="<%=u.getId() %>">
		<tr>
			<td>用户名称：</td>
			<td><%=u.getUsername() %></td>
				 
			</td>
		</tr>
		<tr>
			<td>用户密码：</td>
			<td><input type="password" name="password" value="<%=u.getPassword() %>"/>
			<%-- <%=ValidateUtil.showError(request, "password")%> --%>
				 
			</td>
		</tr>
		<tr>
			<td>用户昵称：</td>
			<td><input type="text" name="nickname"  value="<%=u.getNickname() %>"/>
			<%-- <%=ValidateUtil.showError(request, "nickname")%> --%>
				 
			</td>
			
		</tr>
		<tr>
			<td colspan="2"><input type="submit" name="修改用户"/>
			<input type="reset" value="重置"></td>
		</tr>
	</table>
	</form>

</body>
</html>
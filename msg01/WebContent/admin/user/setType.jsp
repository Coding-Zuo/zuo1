<%@page import="com.msg.model.User"%>
<%@page import="com.msg.dao.DaoFactory"%>
<%@page import="com.msg.dao.IUserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
    <%@include file="/top/adminCheck.jsp" %>
<body>
<%
		int id=Integer.parseInt(request.getParameter("id"));
		IUserDao ud=DaoFactory.getUserDao();
		User u=ud.load(id);
		if(u.getType()==0){
			u.setType(1);
		}else{
			u.setType(0);
		}
		ud.update(u);
		response.sendRedirect("list.jsp");
	%>

</body>
</html>
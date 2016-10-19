<%@page import="com.msg.dao.UserDao"%>
<%@page import="com.msg.util.ValidateUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.msg.model.ShopException"%>
<%@page import="com.msg.dao.DaoFactory"%>
<%@page import="com.msg.dao.IUserDao"%>
<%@page import="com.msg.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@include file="/top/adminCheck.jsp" %>
<%
	int id=Integer.parseInt(request.getParameter("id"));
	String password=request.getParameter("password");
	String nickname=request.getParameter("nickname");
	boolean validate = ValidateUtil.validateNull(request, new String[]{"password","nickname"});
	
	if(!validate){
		%>
		<jsp:forward page="updateInput.jsp"/>
		<%
	}
	IUserDao userDao=DaoFactory.getUserDao();
	User user=userDao.load(id);
	user.setNickname(nickname);
	user.setPassword(password);
	
	try{
		userDao.update(user);
		response.sendRedirect("list.jsp");
	}catch(ShopException e){
		
		
		%>
		<h2 style="color:red;">发生错误:<%=e.getMessage() %></h2>
		<%
		
	}
	

%>
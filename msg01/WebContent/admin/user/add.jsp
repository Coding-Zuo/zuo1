<%@page import="com.msg.util.ValidateUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.msg.model.ShopException"%>
<%@page import="com.msg.dao.DaoFactory"%>
<%@page import="com.msg.dao.IUserDao"%>
<%@page import="com.msg.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String username=request.getParameter("username");
	String password=request.getParameter("password");
	String nickname=request.getParameter("nickname");
	boolean validate = ValidateUtil.validateNull(request, new String[]{"username","password","nickname"});
	
	if(!validate){
		%>
		<jsp:forward page="addInput.jsp"/>
		<%
	}
	User user=new User();
	user.setNickname(nickname);
	user.setPassword(password);
	user.setUsername(username);
	user.setType(0);
	user.setType(0);
	
	IUserDao userDao=DaoFactory.getUserDao();
	try{
		userDao.add(user);
		response.sendRedirect("list.jsp");
	}catch(ShopException e){
		
		
		%>
		<h2 style="color:red;">发生错误:<%=e.getMessage() %></h2>
		<%
		
	}
	

%>
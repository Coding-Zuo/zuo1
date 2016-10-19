<%@page import="java.util.Date"%>
<%@page import="com.msg.model.Message"%>
<%@page import="com.msg.dao.DaoFactory"%>
<%@page import="com.msg.dao.ImessageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
try{
	ImessageDao magDao=DaoFactory.getMsgDao();
	String title=request.getParameter("title");
	String content=request.getParameter("content");
	int userId=Integer.parseInt(request.getParameter("userId"));
	Message msg=new Message();
	msg.setTitle(title);
	msg.setContent(content);
	msg.setPost_date(new Date());
	magDao.add(msg, userId);
	response.sendRedirect(request.getContextPath()+"/msg/list.jsp");
}catch(Exception e){
	%>
	<h1 style="color:red">发现异常：<%=e.getMessage() %></h1>
	<%
}
%>
<%@page import="com.msg.util.ValidateUtil"%>
<%@page import="com.msg.dao.DaoFactory"%>
<%@page import="com.msg.dao.ImessageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 

	int id=Integer.parseInt(request.getParameter("id"));
	ImessageDao msgDao=DaoFactory.getMsgDao();
	boolean flag=ValidateUtil.checkAdminOrSelf(session, msgDao.load(id).getUserId());
	if(!flag){
		%>
		<h2>您没有权限删除该留言</h2>
		<%
	}else{
		msgDao.delete(id);
		response.sendRedirect(request.getContextPath()+"/msg/list.jsp");
		
	}


%>
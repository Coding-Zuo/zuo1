<%@page import="com.msg.model.User"%>
<%@page import="com.msg.model.ShopException"%>
<%@page import="com.msg.dao.DaoFactory"%>
<%@page import="com.msg.dao.IUserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
try{
	int id=Integer.parseInt(request.getParameter("id"));
	IUserDao userDao=DaoFactory.getUserDao();
	User iu=(User)session.getAttribute("loginUser");
	if(iu.getType()==0)throw new ShopException("您不是管理员，不能操作");
	userDao.delete(id);
	response.sendRedirect("list.jsp");
}catch(ShopException e){
	%>
	<h2 style="color:red">发生错误：<%=e.getMessage() %></h2>
	<%
}
%>
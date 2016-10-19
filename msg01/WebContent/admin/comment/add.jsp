<%@page import="com.msg.model.User"%>
<%@page import="com.msg.model.Comment"%>
<%@page import="com.msg.dao.DaoFactory"%>
<%@page import="com.msg.dao.ICommentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	int msgId=Integer.parseInt(request.getParameter("msgId"));
 	String content=request.getParameter("content");
 	ICommentDao commentDao=DaoFactory.getCommentDao();
 	Comment comment=new Comment();
 	comment.setContent(content);
 	int userId=((User) session.getAttribute("loginUser")).getId();
 	commentDao.add(comment, userId, msgId);
 	response.sendRedirect(request.getContextPath()+"/msg/show.jsp?id="+msgId);
 %>
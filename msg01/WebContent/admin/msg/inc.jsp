<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/top/top.jsp" %>                                                       
	<h2 align="center">留言<%=request.getParameter("op") %>功能</h2>
    <a href="addInput.jsp">添加留言</a>&nbsp;<a href="<%=request.getContextPath() %>/msg/list.jsp">留言列表</a>
    
    <hr/>

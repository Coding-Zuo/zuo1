<%@page import="com.small.util.DepartmentDao"%>
<%@page import="com.small.util.Department"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String action=request.getParameter("action");
	if("add".equals(action)){
		Department department=new Department();
		department.setName(request.getParameter("name"));
		DepartmentDao.insert(department);
	}

%>
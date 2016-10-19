<%@page import="com.small.util.EmployeeDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%
    	List employList=EmployeeDao.listAllEmployee();
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="operatorPerson.jsp" method="get">
	<table bgcolor="#CCCCCC" cellspacing=1 cellpadding=5 width=100%>
		<tr>
			<th></th>
			<th>ID</th>
			<th>姓名</th>
			<th>部门</th>
			<th>性别</th>
			<th>入职日期</th>
			<th>操作</th>
		</tr>
		<c:forEach items="${employeeList }" var="employee">
			<tr bgcolor="#FFFFFF">
				<td><input type="checkbox" name="id" value="${employee.id }"/></td>
				<td>${employee.id }</td>
				<td>${employee.name }</td>
				<td>${employee.department.name }</td>
				<td>${employee.sex }</td>
				<td>${employee.employedDate }</td>
				<td><a href="addEmployee.jsp?action=edit&id=${employee.id }">修改</a>
					<a href="addEmployee.jsp?action=del&id=${employee.id }" onclick="return confirm('确定删除？')">删除</a>
				</td>
			</tr>
		</c:forEach>
	</table>
</form>

</body>
</html>















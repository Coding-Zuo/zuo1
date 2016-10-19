<%@page import="com.msg.model.SystemContext"%>
<%@page import="com.msg.dao.UserDao"%>
<%@page import="com.msg.model.Pager"%>
<%@page import="com.msg.model.User"%>
<%@page import="java.util.List"%>
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
<jsp:include page="inc.jsp">
	<jsp:param value="列表" name="op"/>
</jsp:include>
<%	
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
	
	String con=request.getParameter("con"); 
	/* String con=new String(request.getParameter("con").getBytes("iso-8859-1"),"utf-8"); */
	if(con==null){
		con="";
	}
	System.out.println(con+"1");
	IUserDao userDao=DaoFactory.getUserDao();
	Pager<User> pages=userDao.list(con);
	List<User> users=pages.getDatas();
	User iu=(User)session.getAttribute("loginUser");
	int pageIndex=pages.getPageIndex();
	int pageSize=pages.getPageSize();
%>
<body>

	<table align="center" border="1" width="1000">
		<tr>
			<td colspan="7">
				<form action="list.jsp" method="post">
				输入用户名或者昵称：<input type="text" name="con" value="<%=con %>">
				<input type="submit" value="查询">
				</form>
			</td>
		</tr>
		<tr>
			<td colspan="7">
				一共有:<%=pages.getTotalRecord() %>条记录，当前是第<%=pages.getPageIndex() %>页
				每页显示<%=pages.getPageSize() %>条记录
				
			</td>
		
		</tr>
		<tr>
			<td>用户标识</td><td>用户名</td><td>用户密码</td><td>用户昵称</td>
			<td>用户类型</td><td>用户状态</td>
			<td>操作</td>
		</tr>
			<%
			for(User u:users){
			%>
				<tr>
					<td><%=u.getId() %></td>
					<td><%=u.getUsername() %></td>
					<td><%=u.getPassword() %></td>
					<td><%=u.getNickname() %></td>
					<td>
						<%
							if(u.getType()==0){
								%>
								普通用户
								<%
									if(iu.getType()==1){
										%>
								<a href="setType.jsp?id=<%=u.getId()%>">设置管理员</a>
										<%
									}
								%>
								<% 
							}else{
								%>
								管理员
								<%
									if(iu.getType()==1){
										%>
								<a href="setType.jsp?id=<%=u.getId()%>">取消管理员</a>
								<%
									}
								%>
								<% 
							}
						%>
					</td>
					<td>
						<%
							if(u.getStatus()==0){
								%>
								启用
								<%
									if(iu.getType()==1){
										%>
								<a href="setStatus.jsp?id=<%=u.getId()%>">停用</a>
								<%
									}
								%>
								<% 
							}else{
								%>
								<span style="color:red">停用</span>
								<%
									if(iu.getType()==1){
										%>
								<a href="setStatus.jsp?id=<%=u.getId()%>">启用</a>
								<%
									}
								%>
								<% 
							}
						%>
					</td>
					<td>
					<%
						if(iu.getType()==1){
					%>
					<a href="delete.jsp?id=<%=u.getId() %>">删除</a>&nbsp;
					<a href="updateInput.jsp?id=<%=u.getId() %>">更新</a></td>
					<%
						}
					%>
				</tr>
				
				<%
			}
		%>
		<tr>
			<td colspan="7">
				
				
			</td>
		
		</tr>
		<tr>
		<td colspan="7" >
			<jsp:include page="/top/pager.jsp">
				<jsp:param value="<%=pages.getTotalRecord() %>" name="items" />
				<jsp:param value="con" name="params"/>
			</jsp:include>
			</td>
		</tr>
	</table>

	

</body>
</html>










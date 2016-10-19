<%@page import="com.msg.util.ValidateUtil"%>
<%@page import="com.msg.dao.ImessageDao"%>
<%@page import="com.msg.model.Message"%>
<%@page import="com.msg.model.User"%>
<%@page import="com.msg.model.ShopException"%>
<%@page import="com.msg.dao.DaoFactory"%>
<%@page import="com.msg.dao.IUserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>留言更新</title>
<%
	int id=Integer.parseInt(request.getParameter("id"));
	ImessageDao msgDao=DaoFactory.getMsgDao();
	Message msg=msgDao.load(id);
	boolean flag=ValidateUtil.checkAdminOrSelf(session, msg.getUserId());
	if(!flag){
		response.sendRedirect(request.getContextPath()+"/msg/list.jsp");
		return;
	}
	String title=request.getParameter("title");
	String content=request.getParameter("content");
	msg.setContent(content);
	msg.setTitle(title);
	msgDao.update(msg);
	response.sendRedirect(request.getContextPath()+"/msg/show.jsp?id="+msg.getId());
%>
</head>

<body>

</body>
</html>













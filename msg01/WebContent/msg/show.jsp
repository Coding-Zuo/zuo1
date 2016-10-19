<%@page import="com.msg.model.User"%>
<%@page import="com.msg.model.Comment"%>
<%@page import="com.msg.model.Pager"%>
<%@page import="com.msg.dao.ICommentDao"%>
<%@page import="com.msg.util.ValidateUtil"%>
<%@page import="com.msg.dao.IUserDao"%>
<%@page import="com.msg.util.MsgUtil"%>
<%@page import="com.msg.model.Message"%>
<%@page import="com.msg.dao.DaoFactory"%>
<%@page import="com.msg.dao.ImessageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<%=request.getContextPath()%>/xhEditor/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/xhEditor/xheditor-1.2.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/xhEditor/zh-cn.js"></script>
<title>留言显示</title>
<script type="text/javascript">
$(function(){
	/* $("#content").xheditor({tools:'full'});
	$("#content").xheditor({tools:'mfull'}); */
	$("#content").xheditor({
		tools:'simple',
		skin:'o2007silver',
		})
	
})
</script>
<%
	ImessageDao msgDao=DaoFactory.getMsgDao();
	ICommentDao commentDao=DaoFactory.getCommentDao();
	IUserDao userDao=DaoFactory.getUserDao();
	int id=Integer.parseInt(request.getParameter("id"));
	Pager<Comment>comments=commentDao.list(id);
	Message msg=msgDao.load(id);
	User iu=(User)session.getAttribute("loginUser");
	
%>
</head>
<jsp:include page="/msg/inc.jsp">
	<jsp:param value="显示" name="op"/>
</jsp:include>
<body>

<table width="900" align="center" border="1">
		<tr>
			<td><h3><%=msg.getTitle() %></h3></td>
		</tr>
		<tr>
			<td>发表日期:<%=MsgUtil.formatDate(msg.getPost_date()) %>
			&nbsp;&nbsp;发布人：<%=userDao.load(msg.getUserId()).getNickname() %>
			<%
				if(ValidateUtil.checkAdminOrSelf(session, msg.getUserId())){
					%>
					<a href="<%=request.getContextPath()%>/admin/msg/updateInput.jsp?id=<%=msg.getId()%>">更新</a>
					&nbsp;<a href="<%=request.getContextPath()%>/admin/msg/delete.jsp?id=<%=msg.getId()%>">删除</a>
					<%
				}
			%>
			</td>
		</tr>
		<tr>
			<td><%=msg.getContent() %></td>
		</tr>
</table>
<table width="900" align="center" border="1">
<%
	for(Comment comment :comments.getDatas()){
%>
	<tr>
		<td width="600px"><%=comment.getContent() %></td>
		<td><%=MsgUtil.formatDate(comment.getPostDate()) %>&nbsp;
		<%=userDao.load(comment.getUserId()).getNickname() %>&nbsp;
		<%
			if(ValidateUtil.checkAdminOrSelf(session, comment.getUserId())){
				%>
				<a href="<%=request.getContextPath()%>/admin/comment/delete.jsp?id=<%=comment.getId()%>&msgId=<%=msg.getId()%>">删除</a>
				<% 
			}
		%>
		</td>
		<%
	}
%>	
		<tr colspan="2">
			<jsp:include page="/top/pager.jsp">
				<jsp:param value="<%=comments.getTotalRecord() %>" name="items"/>
				<jsp:param value="id" name="params"/>
			</jsp:include>
		</tr>
		
	</tr>

	
</table>
<%
	if(iu!=null){
		%>
	<form action="<%=request.getContextPath()%>/admin/comment/add.jsp" method="post">
		<input type="hidden" name="msgId" value="<%=msg.getId() %>">
		<table width="900" align="center" border="1">
	
		<tr>
			<td>添加回复</td>
		</tr>
		<tr>
			<td><textarea id="content" class="xheditor" cols="150" rows="10" name="content">
			</textarea></td>
		</tr>
		<tr>
			<td><input type="submit" value="回复"></td>
		</tr>
		

		</table>
	</form>
		<% 
	}
%>


</body>
</html>








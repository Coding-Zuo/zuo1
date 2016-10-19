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
<script src="<%=request.getContextPath()%>/xhEditor/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/xhEditor/xheditor-1.2.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/xhEditor/zh-cn.js"></script>
<script>
$(function(){
	/* $("#content").xheditor({tools:'full'});
	$("#content").xheditor({tools:'mfull'}); */
	$("#content").xheditor({
		tools:'simple',
		skin:'o2007silver',
		})
	
})
</script>
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
%>
</head>
<jsp:include page="/msg/inc.jsp">
	<jsp:param value="更新" name="op"/>
</jsp:include>
<body>
<form action="update.jsp" method="post">
<input type="hidden" name="id" value="<%=msg.getId()%>">
<table width="800" align="center" border="1">
	<tr>
		<td width="130">标题</td>
		<td><input type="text" name="title" size="100" value="<%=msg.getTitle()%>"></td>
	</tr>
	<tr>
		<td colspan="2">内容</td>
	</tr>
	<tr>
		<td colspan="2">
			<textarea rows="20" cols="150" name="content" id="content" class="xheditor">
			<%=msg.getContent() %>
			</textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="更新留言"/><input type="reset"/> 
		</td>
	</tr>

</table>
</form>
</body>
</html>













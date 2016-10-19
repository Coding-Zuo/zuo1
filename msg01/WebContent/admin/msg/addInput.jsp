<%@page import="com.msg.model.User"%>
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
	}
})
</script>
<title>留言添加</title>
<%
	User iu=(User)session.getAttribute("loginUser");
%>
</head>
<jsp:include page="/msg/inc.jsp">
	<jsp:param value="添加" name="op"/>
</jsp:include>
<body>
<form action="add.jsp" method="post">
<input type="hidden" name="userId" value="<%=iu.getId()%>">
<table width="800" align="center" border="1">
	<tr>
		<td width="130">标题</td>
		<td><input type="text" name="title" size="100"></td>
	</tr>
	<tr>
		<td colspan="2">内容</td>
	</tr>
	<tr>
		<td colspan="2">
			<textarea rows="20" cols="150" name="content" id="content" class="xheditor"></textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="添加留言"/><input type="reset"/> 
		</td>
	</tr>

</table>
</form>
</body>
</html>













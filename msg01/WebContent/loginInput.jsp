<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath }/xhEditor/jquery-1.11.2.min.js"></script>
<script>
$(function(){
	$(":input[name='username']").change(function(){
		var val=$(this).val();
		val=$.trim(val); 
		if(val!=""){
			var url="${pageContext.request.contextPath}/valiateUsername";
			var args={"username":val,"time":new Date()};
			$.post(url,args,function(data){
				$("#tishi").html(data);
			})
		}
	})
	$(":input[name='password']").change(function(){
		var val=$(this).val();
		val=$.trim(val); 
		if(val!=""){
			var url="${pageContext.request.contextPath}/valiateUsername";
			var args={"password":val,"time":new Date()};
			$.post(url,args,function(data){
				$("#tishi1").html(data);
			})
		}
	})
	
})

</script>


</head>
<jsp:include page="/top/top.jsp" />



<body>

<div style="text-align:right;border-bottom:1px solid #000;">
	<%-- <%
		if(u!=null){
			%>
	欢迎[<%=u.getNickname() %>]使用我们的系统！
	&nbsp;<a href="<%=request.getContextPath() %>/admin/user/updateSelf.jsp?id=<%=u.getId() %>">修改个人信息</a>
	<a href="<%=request.getContextPath()%>/admin/user/list.jsp ">用户管理</a>
	&nbsp;<a href="<%=request.getContextPath() %>/logout.jsp">退出</a>
			
			<%
		}
	%> --%>
	<%-- <a href="<%=request.getContextPath()%>/loginInput.jsp">登录</a>
	&nbsp;<a href="<%=request.getContextPath()%>/msg/list.jsp">留言列表</a> --%>
</div>
	<h2 align="left">用户登录</h2>
	<hr>
	<form method="post" action="login.jsp">
		用户名：<input type="text" name="username"><br><pre id="tishi"></pre>
		用户密码：<input type="password" name="password"></br><pre id="tishi1"></pre>
		<input type="submit" value="用户登录">
	</form>

</body>
</html>
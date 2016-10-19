<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<pg:pager items="1000" maxPageItems="15" export="number">
<%=number %>
	<pg:first>
		<a href="<%=pageUrl %>">首页</a>
	</pg:first>
	<pg:prev><a href="<%=pageUrl %>">上一页</a></pg:prev>
	<pg:pages>
		<%
			if(number==pageNumber){
				%>
				[<%=number %>]
				<% 
			}else{
				%>
		<a href="<%=pageUrl%>"><%=pageNumber %></a>
				<% 
			}
		%>
	</pg:pages>
	<pg:next><a href="<%=pageUrl %>">下一页</a></pg:next>
	<pg:last><a href="<%=pageUrl %>">尾页</a></pg:last>
</pg:pager>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager" %>
    <%
    	request.setCharacterEncoding("utf-8");
    	request.setCharacterEncoding("UTF-8");
    	int items=Integer.parseInt(request.getParameter("items"));
    	String params=request.getParameter("params");
    	if(params==null)
    		params="";
    %>
	<pg:pager items="<%=items %>" maxPageItems="15" export="number">
		<pg:param name="<%=params %>"/>
		<pg:last>
			一共有:<%=items %>条记录，当前是第<%=pageNumber %>页
				<%-- 每页显示<%=pages.getPageSize() %>条记录 --%>
		</pg:last>
					<pg:param name="con"/>
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
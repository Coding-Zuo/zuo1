<%@page import="java.sql.SQLException"%>
<%@page import="com.small.util.Pagination"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@page import="com.small.util.DbManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	final int pageSize=10;//每页记录数
	int pageNum=1;//当前页数，默认1
	int pageCount=1;//总页数
	int recordCount=0;//总记录数
	try{
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}catch(Exception e){}
	String sql=null;
	Connection conn=null;
	PreparedStatement preStmt=null;
	ResultSet rs=null;
	try{
		sql="select count(*) from tb_person ";
		recordCount=DbManager.getCount(sql);
		pageCount=(recordCount+pageSize-1);
		int startRecord=(pageNum-1)*pageSize;
		sql="select *from tb_person limit ?,?";
		conn=DbManager.getConnection();
		preStmt=conn.prepareStatement(sql);
		DbManager.setParams(preStmt, startRecord,pageSize);
		rs=preStmt.executeQuery();
	

%>    
	
    
    
    
    
    
    
    
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="operatePerson.jsp" method="get">
	<table>
		<tr background=#DDDDDD>
			<td>姓名</td>
			<td>英文名</td>
			<td>性别</td>
			<td>年龄</td>
			<td>生日</td>
			<td>备注</td>
			<td>记录创建时间</td>
			<td>操作</td>
		</tr>
		<%
			while(rs.next()){
				int id=rs.getInt("id");
				int age=rs.getInt("age");
				String name=rs.getString("name");
				String englishName=rs.getString("english_name");
				String sex=rs.getString("sex");
				String description=rs.getString("description");
				Date birthday=rs.getDate("birthday");
				Timestamp ts=rs.getTimestamp("create_time");
				
				out.println("<tr background=#FFFFFF>");
				out.println(" <td>"+id+"<td>");
				out.println(" <td>"+name+"<td>");
				out.println(" <td>"+englishName+"<td>");
				out.println(" <td>"+sex+"<td>");
				out.println(" <td>"+age+"<td>");
				out.println(" <td>"+birthday+"<td>");
				out.println(" <td>"+description+"<td>");
				out.println(" <td>"+ts+"<td>");
				out.println("<td>");
				out.println("<a href='operatePerson.jsp?action=del&id='"+id+"onclick='return confirm(\"确定要删除？\")'>删除</a>");
				out.println("<a href='operatePerson.jsp?action=del&id="+id+"'>修改</a>");
				out.println("</td>");
				out.println("</tr>");
			}
		%>
	</table>
	<table align="right">
		<tr>
			<td><%=Pagination.getPagination(pageNum, pageCount, recordCount, request.getRequestURI()) %></td>
		</tr>
	</table>
<br><br><br>
	<table align="left">
			<tr>
				<td>SQL:<%=sql %></td>
			</tr>
	</table>
</form>
<%
}catch(SQLException e){
	out.print("执行"+sql+"发生异常"+e.getMessage());
	e.printStackTrace();
}finally{
	if(rs!=null)
		rs.close();
	if(preStmt!=null)
		preStmt.close();
	if(conn!=null)
		conn.close();
}
%>












</body>
</html>
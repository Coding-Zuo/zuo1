<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="com.small.util.DbManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	request.setCharacterEncoding("utf-8");
    %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
		textarea { width: 300px; height: 100px; font-size: 12px; }
		body {font-size: 12px; }
		table, td, th {font-size: 12px; }
		table {border-collapse: collapse; border: 1px solid #000000; }
		th {background: #CCCCCC; }
		td, th {border: 1px solid #000000; padding: 2px; text-align: center; padding-left:4px; padding-right:4px; }
		.error {font-size:12px; color:#FF0000; }
	</style>

</head>
<body>
<form action="${pageContext.request.requestURL }" method="get">
	<textarea name="sql">${param.sql }</textarea><input type="submit" value="提交">
</form>

<%
	String sql=request.getParameter("sql");
	out.println("SQL语句:"+sql);
	if(sql!=null&&sql.trim().length()>0){
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		try{
			conn=DbManager.getConnection();
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			
			int columnCount = rs.getMetaData().getColumnCount();
	  		String[] columns = new String[columnCount];
	  		for(int i=1; i<=columnCount; i++){
	  			columns[i-1] = rs.getMetaData().getColumnLabel(i);
	  		}
			StringBuffer buffer=new StringBuffer();
			buffer.append("<table>");
			buffer.append("<tr>");
			for(String column:columns){
				buffer.append("<th>"+column+"</th>");
			}
			buffer.append("</tr>");
			while(rs.next()){
				buffer.append("<tr>");
				for(String column:columns){
					buffer.append("<td>"+rs.getString(column)+"</td>");
				}
				buffer.append("</tr>");
			}
			buffer.append("</table>");
			out.println(buffer.toString());
		}catch(SQLException e){
			out.print("<div>执行sql"+sql+"时出错"+e.getMessage()+"</div>");
			e.printStackTrace();
		}finally{
    		if(rs!=null)
    			rs.close();
    		if(stmt!=null)
    			stmt.close();
    		if(conn!=null)
    			conn.close();
    	}
		
		
	}
		
%>








</body>
</html>
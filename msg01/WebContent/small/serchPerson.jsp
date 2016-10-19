<%@page import="com.small.util.Pagination"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.small.util.DbManager"%>
<%@page import="java.util.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%!
    	public String forSQL(String sql){
    		return sql.replace("'", "\\'");
    	}
    %>
    <%
    	request.setCharacterEncoding("utf-8");
    	final int pageSize=5;
    	int pageNum=1;
    	try{
    		pageNum=new Integer(request.getParameter("pageNum"));
    	}catch(Exception e){
    	}
    	String nameSearch=request.getParameter("name");
    	String sexSearch=request.getParameter("sex");
    	String englishNameSearch=request.getParameter("englishName");
    	String descriptionSearch=request.getParameter("description");
    	String birthdayStart=request.getParameter("birthdayStart");
    	String birthdayEnd=request.getParameter("birthdayEnd");
    	String whereClause="";
    	
    	
    	if(nameSearch!=null&&nameSearch.trim().length()!=0){
    		if(whereClause.length()==0)
    			whereClause+=" name like '%"+forSQL(nameSearch)+"%' ";
    		else
    			whereClause+=" and name like '%"+forSQL(nameSearch)+"%' ";
    	}
    	if(sexSearch!=null&&sexSearch.trim().length()!=0){
    		if(whereClause.length()==0)
    			whereClause+=" sex = "+forSQL(sexSearch)+"' ";
    		else
    			whereClause+=" and sex '%"+forSQL(sexSearch)+"' ";
    	}
    	if(englishNameSearch!=null&&englishNameSearch.trim().length()!=0){
    		if(whereClause.length()==0)
    			whereClause+=" english_name like '%"+forSQL(englishNameSearch)+"%' ";
    		else
    			whereClause+=" and english_name like '%"+forSQL(nameSearch)+"%' ";
    	}
    	if(descriptionSearch!=null&&descriptionSearch.trim().length()!=0){
    		if(whereClause.length()==0)
    			whereClause+=" description like '%"+forSQL(descriptionSearch)+"%' ";
    		else
    			whereClause+=" and description like '%"+forSQL(descriptionSearch)+"%' ";
    	}
    	if(birthdayStart!=null&&birthdayStart.trim().length()!=0){
    		if(whereClause.length()==0)
    			whereClause+=" birthday >='"+birthdayStart+"' ";
    		else
    			whereClause+=" and birthday >= '"+birthdayStart+"' ";
    	}
    	if(birthdayEnd!=null&&birthdayEnd.trim().length()!=0){
    		if(whereClause.length()==0)
    			whereClause+=" birthday <='"+birthdayEnd+"' ";
    		else
    			whereClause+=" and birthday <="+birthdayEnd+"' ";
    	}
    	if(whereClause.length()!=0){
    		whereClause=" where " +whereClause;
    	}
    	String countSQL=" select count(*) from tb_person "+whereClause+" ";
    	
    	int recordCount=DbManager.getCount(countSQL);
    	int pageCount=(recordCount+pageSize)/pageSize;
    	
    	String querySQl=" select * from tb_person "+whereClause+" limit "+(pageNum-1)*pageSize+","+pageSize+" ";
    	
    	Connection conn=null;
		Statement stmt=null;
    	ResultSet rs=null;
    	try{
    		conn=DbManager.getConnection();
    		stmt=conn.createStatement();
    		rs=stmt.executeQuery(querySQl);
    		
    	
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form action="searchPerson.jsp">
		<fieldset style="width:80%">
			<legend>查询条件</legend>
			<table>
				<tr>
					<td style="text-align:right">姓名</td>
					<td style="text-align:left">
						<input type="text" name="name" value="${param.name }"/>
					</td>
					<td style="text-align:right">性别</td>
					<td style="text-align:left">
						<select name="sex" >
							<option value="">无限制</option>
							<option value="男" ${'男' != param.sex ?  '' : 'selected' }>男</option>
							<option value="女" ${'女' != param.sex ?  '' : 'selected' }>女</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="text-align:right;">英文名</td>
					<td style="text-align: left">
						<input type="text" name='englishName' value="${param.englishName }">
					</td>
					<td style="text-align:right">备注</td>
					<td style="text-align: left">
						<input type="text" name='description' value="${param.description }">
					</td>
				</tr>
				<tr>
					<td colspan="4">
						出生日期
						从<input type="text" name="birthdayStart" onfocus="setday(birthdayStart);" value="${param.birthdayStart }">
						<img src="images/calendar.gif" onclick="setday(birthdayStart);">&nbsp;&nbsp;
						到<input type="text" name="birthdayEnd" onfocus="setday(birthdayEnd);" value="${param.birthdayEnd }"/>
						<img src="images/calendar.gif" onclick="setday(birthdayEnd);"/>
					</td>
				</tr>
				<tr>
					<td colspan=4>
						<input type="submit" value="提交查询">
						<input type="reset" value="复位">
					</td>
				</tr>
			</table>
		</fieldset>
		<br>
		<table background-color="#CCCCCC" cellspacing=1 cellpadding=5 width=100%>
			<tr background-color="#DDDDDD">
				<td>ID</td>
				<td>姓名</td>
				<td>英文名</td>
				<td>性别</td>
				<td>年龄</td>
				<td>生日</td>
				<td>备注</td>
				<td>记录创建时间</td>
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
		 </table>
  <table align=right><tr><td>
  	<%= Pagination.getPagination(pageNum, pageCount, recordCount, request.getRequestURI()) %>
  </td></tr></table><br/><br/>
  <table width='100%'><tr><td style='text-align:center; '>
  	<br/><br/> <%= "Count SQL: " + countSQL %>
  </td></tr></table>
  </form>
	</form>
	<%
    	}catch(SQLException e){
    		out.println("执行sql"+querySQl+"时出错"+e.getMessage());
    	}finally{
    		if(rs!=null)
    			rs.close();
    		if(stmt!=null)
    			stmt.close();
    		if(conn!=null)
    			conn.close();
    	}
	%>
	 <script type="text/javascript" src="js/calendar.js"></script>
</body>
</html>














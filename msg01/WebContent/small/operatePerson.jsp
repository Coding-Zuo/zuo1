<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<jsp:directive.page import="java.sql.ResultSet" />
<jsp:directive.page import="java.sql.SQLException" />
<jsp:directive.page import="java.sql.PreparedStatement"/>
<jsp:directive.page import="java.text.SimpleDateFormat"/>
<jsp:directive.page import="java.sql.Timestamp"/>
<jsp:directive.page import="java.sql.Date"/>
<%!
	/** SQL 值中的单引号(')需要转化为 \'  */
	public String forSQL(String sql){
		return sql.replace("'", "\\'");
	}
%>
<%
	request.setCharacterEncoding("UTF-8");

	String name = request.getParameter("name");
	String englishName = request.getParameter("englishName");
	String age = request.getParameter("age");
	String birthday = request.getParameter("birthday");
	String sex = request.getParameter("sex");
	String description = request.getParameter("description");
	
	String action = request.getParameter("action");

	if("add".equals(action)){

		// INSERT SQL 语句
		String sql = "INSERT INTO tb_person " +
					" ( name, english_name, " +
					"   age, sex, birthday,  " +
					"   description ) values " +
					" ( '" + forSQL(name) + "', '" + forSQL(englishName) + "', " +
					"   '" + age + "', '" + sex + "', '" + birthday + "', " +
					"   '" + forSQL(description) + "' ) " ;
		
		
		Connection conn = null;
		Statement stmt = null;
		int result = 0;
		
		try{
		
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			conn = DriverManager.getConnection(
							"jdbc:mysql://localhost:3306/databaseWeb?characterEncoding=UTF-8", 
							"root", 
							"root");
		
			stmt = conn.createStatement();
			
			// 使用 Statement 执行 SQL 语句
			result = stmt.executeUpdate(sql);
			
		}catch(SQLException e){
			out.println("执行SQL\"" + sql + "\"时发生异常：" + e.getMessage());
			return;
		}finally{
			if(stmt != null)	stmt.close();
			if(conn != null)	conn.close();
		}
		
		out.println("<html><style>body{font-size:12px; line-height:25px; }</style><body>");
		out.println(result + " 条记录被添加到数据库中。");
		out.println("<a href='listPerson.jsp'>返回人员列表</a>");
		
		// 将执行的 SQL 语句输出到客户端
		out.println("<br/><br/>执行的 SQL 语句为：<br/>" + sql);
		
		return;
		
	}
	else if("del".equals(action)){
		
		// 取一个或者多个 ID 值
		String[] id = request.getParameterValues("id");
		if(id == null || id.length == 0){	out.println("没有选中任何行");	return;	}
		
		String condition = "";
		
		for(int i=0; i<id.length; i++){
			if(i == 0)	condition = "" + id[i];
			else		condition += ", " + id[i];
		}
		
		String sql = "DELETE FROM tb_person WHERE id IN (" + condition + ") ";		
		
		Connection conn = null;
		Statement stmt = null;
		
		try{
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			conn = DriverManager.getConnection(
								"jdbc:mysql://localhost:3306/databaseWeb?characterEncoding=UTF-8", 
								"root", 
								"root");
			
			stmt = conn.createStatement();
			
			// 使用 Statement 执行 SQL 语句
			int result = stmt.executeUpdate(sql);
	
			out.println("<html><style>body{font-size:12px; line-height:25px; }</style><body>");
			out.println(result + " 条记录被删除。");
			out.println("<a href='listPerson.jsp'>返回人员列表</a>");
			
			// 将执行的 SQL 语句输出到客户端
			out.println("<br/><br/>执行的 SQL 语句为：<br/>" + sql);
			
		}catch(SQLException e){
			out.println("执行SQL\"" + sql + "\"时发生异常：" + e.getMessage());
			e.printStackTrace();
		}finally{
			if(stmt != null)	stmt.close();
			if(conn != null)	conn.close();
		}
	}
	else if("edit".equals(action)){
		
		String id = request.getParameter("id");
		String sql = "SELECT * FROM tb_person WHERE id = " + id;
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try{
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			conn = DriverManager.getConnection(
								"jdbc:mysql://localhost:3306/databaseWeb?characterEncoding=UTF-8", 
								"root", 
								"admin");
			
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
	
			if(rs.next()){
				// 有记录 将响应字段从数据库中取出 保存到 request 中，显示到 修改页面
				request.setAttribute("id", rs.getString("id"));
				request.setAttribute("name", rs.getString("name"));
				request.setAttribute("englishName", rs.getString("english_name"));
				request.setAttribute("age", rs.getString("age"));
				request.setAttribute("sex", rs.getString("sex"));
				request.setAttribute("birthday", rs.getString("birthday"));
				request.setAttribute("description", rs.getString("description"));
				
				request.setAttribute("action", action);
				
				// 转到修改页面
				request.getRequestDispatcher("/addPerson.jsp").forward(request, response);
			}
			else{
				// 没有数据
				out.println("没有找到 id 为 " + id + " 的记录。");
			}
		}catch(SQLException e){
			out.println("执行SQL\"" + sql + "\"时发生异常：" + e.getMessage());
			e.printStackTrace();
		}finally{
			if(rs != null)		rs.close();
			if(stmt != null)	stmt.close();
			if(conn != null)	conn.close();
		}
	}
	else if("save".equals(action)){
		
		String id = request.getParameter("id");
		
		String sql = "UPDATE tb_person SET " +
					" 	name = '" + forSQL(name) + "', " +
					" 	english_name = '" + forSQL(englishName) + "', " +
					" 	sex = '" + sex + "', " +
					"	age = '" + age + "', " +
					" 	birthday = '" + birthday + "', " +
					" 	description = '" + forSQL(description) + "' " +
					" WHERE id = " + id;
		
		Connection conn = null;
		Statement stmt = null;
		try{
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			conn = DriverManager.getConnection(
								"jdbc:mysql://localhost:3306/databaseWeb?characterEncoding=UTF-8", 
								"root", 
								"admin");
			
			stmt = conn.createStatement();
			
			// 使用 Statement 执行 SQL 语句
			int result = stmt.executeUpdate(sql);
	
			out.println("<html><style>body{font-size:12px; line-height:25px; }</style><body>");
			
			if(result == 0)		out.println("影响数目为 0, 修改失败. ");
			else	out.println(result + " 条记录被修改。");
			
			out.println("<a href='listPerson.jsp'>返回人员列表</a>");
			
			// 将执行的 SQL 语句输出到客户端
			out.println("<br/><br/>执行的 SQL 语句为：<br/>" + sql);
			
		}catch(SQLException e){
			out.println("执行SQL\"" + sql + "\"时发生异常：" + e.getMessage());
			e.printStackTrace();
		}finally{
			if(stmt != null)	stmt.close();
			if(conn != null)	conn.close();
		}
	}
	else{
		String id = request.getParameter("id");
		String sql = "UPDATE tb_person SET name = ?, english_name = ?, sex = ?, age = ?, birthday = ?, description = ? WHERE id = ? ";
		
		Connection conn = null;
		PreparedStatement preStmt = null;
		
		try{
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
			conn = DriverManager.getConnection(
								"jdbc:mysql://localhost:3306/databaseWeb?characterEncoding=UTF-8", 
								"root", 
								"admin");
			
			preStmt = conn.prepareStatement(sql);
			preStmt.setString(1, name);
			preStmt.setString(2, englishName);
			preStmt.setString(3, sex);
			preStmt.setInt(4, Integer.parseInt(age));
			preStmt.setDate(5, new Date(new SimpleDateFormat("yyyy-MM-dd").parse(birthday).getTime()));
			preStmt.setString(6, description);
			preStmt.setInt(7, Integer.parseInt(id));
			
			// 使用 preStmt 执行 SQL 语句
			int result = preStmt.executeUpdate(sql);
	
			out.println("<html><style>body{font-size:12px; line-height:25px; }</style><body>");
			
			if(result == 0)		out.println("影响数目为 0, 修改失败. ");
			else	out.println(result + " 条记录被修改。");
			
			out.println("<a href='listPerson.jsp'>返回人员列表</a>");
			
			// 将执行的 SQL 语句输出到客户端
			out.println("<br/><br/>执行的 SQL 语句为：<br/>" + sql);
			
		}catch(SQLException e){
			out.println("执行SQL\"" + sql + "\"时发生异常：" + e.getMessage());
			e.printStackTrace();
		}finally{
			if(preStmt != null)	preStmt.close();
			if(conn != null)	conn.close();
		}
	}

%>

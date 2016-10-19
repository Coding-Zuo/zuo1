package com.msg.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class JDBCUtil {
	public static Connection getConnection(){
		Properties prop=PropUtil.getJdbcProp();
		
		try {
//			Class.forName("com.mysql.jdbc.Driver");
			Class.forName(prop.getProperty("driver"));
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		}
		String username=prop.getProperty("user");
		String password=prop.getProperty("password");
		String url=prop.getProperty("dburl");
//		String url="jdbc:mysql://127.0.0.1:3306/itat_shop?useSSL=false&useUnicode=true&characterEncoding=utf8";
		
		Connection conn=null;
		try {
			conn=DriverManager.getConnection(url,username,password);
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
		
//		Connection con=null;
//		try {
//			Context initCtx = new InitialContext();
//			Context envCtx = (Context) initCtx.lookup("java:comp/env");
//			DataSource ds = (DataSource)
//			  envCtx.lookup("jdbc/msg");
//			con=ds.getConnection();
//			
//		} catch (NamingException e) {
//			e.printStackTrace();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return con;
//		
		
	}
	public static void close(Connection conn){
			try {
				if(conn!=null)
					conn.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
	}
	public static void close(PreparedStatement ps){
		try {
			if(ps!=null)
				ps.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public static void close(ResultSet rs){
		try {
			if(rs!=null)
				rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}








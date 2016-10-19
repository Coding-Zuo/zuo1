package com.small.util;

import java.sql.Types;
import java.util.Date;

import sun.org.mozilla.javascript.internal.ObjArray;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

public class DbManager {
	public static Connection getConnection() throws SQLException{
		return getConnection("databaseWeb","root","root");
	}
	public static Connection getConnection(String dbName,String userName,String password) throws SQLException{
		String url="jdbc:mysql://localhost:3306/"+dbName+"?useUnicode=true&characterEcoding=utf-8";
		DriverManager.registerDriver(new com.mysql.jdbc.Driver());
		return DriverManager.getConnection(url,userName,password);
	}
	public static void setParams(PreparedStatement preStmt,Object...params) throws SQLException{
		if(params==null||params.length==0)
			return ;
		for(int i=1;i<=params.length;i++){
			Object param=params[i-1];
			if(param==null){
				preStmt.setNull(i, Types.NULL);
			}else if (param instanceof Integer) {
				preStmt.setInt(i, (Integer)param);
			}else if (param instanceof String) {
				preStmt.setString(i, (String)param);
			}else if (param instanceof Double) {
				preStmt.setDouble(i, (Double)param);
			}else if (param instanceof Long) {
				preStmt.setLong(i, (long) param);
			}else if (param instanceof Timestamp) {
				preStmt.setTimestamp(i, (Timestamp) param);
			}else if (param instanceof Boolean) {
				preStmt.setBoolean(i, (boolean) param);
			}else if (param instanceof Date) {
				preStmt.setDate(i, (java.sql.Date) param);
			}
		}
	}
	public static int executeUpdate(String sql)throws SQLException{
		return excuteUpdate(sql,new Object[]{});
	}
	public static int excuteUpdate(String sql,Object...params)throws SQLException{
		Connection conn=null;
		PreparedStatement preStmt=null;
		try {
			conn=getConnection();
			preStmt=conn.prepareStatement(sql);
			setParams(preStmt, params);
			return preStmt.executeUpdate();
		} finally {
			if(preStmt!=null)
				preStmt.close();
			if(conn!=null){
				conn.close();
			}
		}
			
		
	}
	public static int getCount(String sql)throws SQLException{
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		try {
			conn=getConnection();
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			while(rs.next()){
				return rs.getInt(1);
			}
		} finally {
			if(rs!=null)
				rs.close();
			if(stmt!=null)
				stmt.close();
			if(conn!=null)
				conn.close();
		}
		return 0;
	}
	

}













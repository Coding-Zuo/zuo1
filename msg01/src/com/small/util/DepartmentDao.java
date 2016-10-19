package com.small.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DepartmentDao {
	
	public static int insert(Department department) throws Exception{
		String sql="insert into tb_department(name) values(?)";
		return DbManager.excuteUpdate(sql, department.getName());
	}
	public static int save(Department department)throws Exception{
		String sql="update tb_department set name=? where id=?";
		return DbManager.excuteUpdate(sql, department.getName(),department.getId());
	}
	public static int delete(Integer id) throws Exception{
		String sql="delete from tb_department where id=?";
		return DbManager.excuteUpdate(sql, id);
	}
	public static Department find(Integer id) throws Exception{
		String sql="select * from tb_department where id=?";
		Connection conn=null;
		PreparedStatement preStmt=null;
		ResultSet rs=null;
		try {
			conn=DbManager.getConnection();
			preStmt=conn.prepareStatement(sql);
			preStmt.setInt(1, id);
			rs=preStmt.executeQuery();
			if(rs.next()){
				Department department=new Department();
				department.setId(id);
				department.setName(rs.getString("name"));
				return department;
			}else {
				return null;
			}
		}finally{
			if(rs!=null)
				rs.close();
			if(preStmt!=null)
				preStmt.close();
			if(conn!=null)
				conn.close();
		}
	}
	public static List<Department> listDepartments() throws Exception{
		List<Department> list=new ArrayList<>();
		String sql="select * from tb_department order by id desc";
		Connection conn=null;
		PreparedStatement preStmt=null;
		ResultSet rs=null;
		try {
			conn=DbManager.getConnection();
			preStmt=conn.prepareStatement(sql);
			rs=preStmt.executeQuery();
			while(rs.next()){
				Department department=new Department();
				department.setId(rs.getInt("id"));
				department.setName(rs.getString("name"));
				list.add(department);
			}
		} finally{
			if(rs!=null)
				rs.close();
			if(preStmt!=null)
				preStmt.close();
			if(conn!=null)
				conn.close();
		}
		return list;
	}
}














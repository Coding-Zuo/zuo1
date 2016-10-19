package com.small.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDao {
	
	public static int insert(Employee employee) throws Exception{
		String sql="insert into tb_employee "+" (department_id,name,sex,employd_date) values(?,?,?,?)";
		return DbManager.excuteUpdate(sql, employee.getDepartment().getId(),employee.getName(),employee.getName(),employee.getSex(),employee.getEmployedDate());
	}
	public static int save(Employee employee)throws Exception{
		String sql="update tb_employee "+" set department_id=?,name=?,sex=?,employed_date=? "+" where id=?";
		return DbManager.excuteUpdate(sql, employee.getDepartment().getId(),employee.getName(),employee.getSex(),employee.getEmployedDate());
	}
	public static Employee find(Integer id)throws Exception{
		String sql="select * from tb_employee where id=?";
		Connection conn=null;
		PreparedStatement preStmt=null;
		ResultSet rs=null;
		try {
			conn=DbManager.getConnection();
			preStmt=conn.prepareStatement(sql);
			preStmt.setInt(1, id);
			rs=preStmt.executeQuery();
			if(rs.next()){
				Employee employee=new Employee();
				employee.setId(id);
				employee.setName(rs.getString("name"));
				employee.setEmployedDate(rs.getDate("employed_date"));
				employee.setSex("sex");
				
				Department d=new DepartmentDao().find(rs.getInt("department_d"));
				employee.setDepartment(d);
				return employee;
			}else {
				return null;
			}
		} finally{
			if(rs!=null)
				rs.close();
			if(preStmt!=null)
				preStmt.close();
			if(conn!=null)
				conn.close();
		}
	}
	public static List<Employee> listAllEmployee() throws Exception{
		
		List<Employee>list=new ArrayList<>();
		String sql="select * from tb_employee order by id desc";
		Connection conn=null;
		PreparedStatement preStmt=null;
		ResultSet rs=null;
		
		try {
			conn=DbManager.getConnection();
			preStmt=conn.prepareStatement(sql);
			rs=preStmt.executeQuery();
			while(rs.next()){
				Employee employee=new Employee();
				employee.setId(rs.getInt("id"));
				employee.setName(rs.getString("name"));
				employee.setEmployedDate(rs.getDate("employed_date"));
				employee.setSex(rs.getString("sex"));
				Department d=DepartmentDao.find(rs.getInt("department_id"));
				employee.setDepartment(d);
				list.add(employee);
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





















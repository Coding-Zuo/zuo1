package com.msg.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.msg.model.Pager;
import com.msg.model.ShopException;
import com.msg.model.SystemContext;
import com.msg.model.User;
import com.msg.util.JDBCUtil;

public class UserDao implements IUserDao{

	@Override
	public void add(User user) {
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		conn=JDBCUtil.getConnection();
		try {
			String sql="select count(*) from t_user where username=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, user.getUsername());
			rs=ps.executeQuery();
			while(rs.next()){
				if(rs.getInt(1)>0)throw new ShopException("添加的用户已经存在，不能继续添加");
			}
			String sql1="insert into t_user (username,password,nickname,type,status) values(?,?,?,?,?)";
			ps=conn.prepareStatement(sql1);
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPassword());
			ps.setString(3, user.getNickname());
			ps.setInt(4, user.getType());
			ps.setInt(5, user.getStatus());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(rs);
			JDBCUtil.close(ps);
			JDBCUtil.close(conn);
		}
	}

	@Override
	public void delete(int id) {
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		try {
			conn=JDBCUtil.getConnection();
			User u=this.load(id);
			if(u.getUsername().equals("zuo")) throw new ShopException("超级管理员zuo不能被删除");
			String sql="delete from t_user where id=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, id);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(ps);
			JDBCUtil.close(conn);
		}
	}

	@Override
	public void update(User user) {
		Connection conn=null;
		PreparedStatement ps=null;
		
		conn=JDBCUtil.getConnection();
		try {
			String sql="update t_user set password=?,nickname=?,type=?,status=? where id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, user.getPassword());
			ps.setString(2, user.getNickname());
			ps.setInt(3, user.getType());
			ps.setInt(4, user.getStatus());
			ps.setInt(5, user.getId());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(ps);
			JDBCUtil.close(conn);
		}
	}

	@Override
	public User load(int id) {
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		User u=null;
		conn=JDBCUtil.getConnection();
		try {
			String sql="select * from t_user where id=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, id);
			rs=ps.executeQuery();
			while(rs.next()){
				u=new User();
				u.setId(rs.getInt("id"));
				u.setNickname(rs.getString("nickname"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setStatus(rs.getInt("status"));
				u.setType(rs.getInt("type"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(rs);
			JDBCUtil.close(ps);
			JDBCUtil.close(conn);
		}
		return u;
	}

	@Override
	public Pager<User> list(String condition) {
		int pageOffset=SystemContext.getPageOffset();
		int pageSize=SystemContext.getPageSize();
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		Pager<User> pags=new Pager<>();
		List<User> users=new ArrayList<>();
		User u=null;
		conn=JDBCUtil.getConnection();
		try {
			String sql="select * from t_user ";
			String sqlCount="select count(*) from t_user ";
			if(condition!=null||!"".equals(condition)){
				sql+="where username like "+"'%"+condition+"%'"+" or nickname like "+"'%"+condition+"%'"+"";
				sqlCount+="where username like "+"'%"+condition+"%'"+" or nickname like "+"'%"+condition+"%'"+"";
			}
			sql+=" limit ?,?";
			System.out.println(condition+"2");
			ps=conn.prepareStatement(sql);
			ps.setInt(1, pageOffset);
			ps.setInt(2, pageSize);
//			if(condition==null||"".equals(condition)){
//				sql+="limit ?,?";
//				ps=conn.prepareStatement(sql);
//				ps.setInt(1, start);
//				ps.setInt(2, pageSize);
//			}else{
//				sql+=" where username like ? or nickname like ? ";
//				ps=conn.prepareStatement(sql);
////				ps.setString(1, condition);
////				ps.setString(2, condition);
//				ps.setString(1, "%"+condition+"%");
//				ps.setString(2, "%"+condition+"%");
//			}
			rs=ps.executeQuery();
			while(rs.next()){
				u=new User();
				u.setId(rs.getInt("id"));
				u.setNickname(rs.getString("nickname"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setStatus(rs.getInt("status"));
				u.setType(rs.getInt("type"));
				users.add(u);
			}
			ps=conn.prepareStatement(sqlCount);
			rs=ps.executeQuery();
			int totalRecord=0;
			while(rs.next()){
				totalRecord=rs.getInt(1);
			}
			int totalPage=(totalRecord-1)/pageSize+1;
			pags.setPageIndex(pageOffset);
			pags.setPageSize(pageSize);
			pags.setTotalPage(totalPage);
			pags.setTotalRecord(totalRecord);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(rs);
			JDBCUtil.close(ps);
			JDBCUtil.close(conn);
		}
		pags.setDatas(users);
		return pags;
	}

	@Override
	public User login(String username, String password) {
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		User u=null;
		try {
			conn=JDBCUtil.getConnection();
			String sql="select * from t_user where username=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, username);
			rs=ps.executeQuery();
			while(rs.next()){
				u=new User();
				u.setId(rs.getInt("id"));
				u.setNickname(rs.getString("nickname"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setStatus(rs.getInt("status"));
				u.setType(rs.getInt("type"));
			}
			if(u==null) throw new ShopException("用户名不存在");
			if(!u.getPassword().equals(password))throw new ShopException("用户密码不同");
			if(u.getStatus()==1) throw new ShopException("用户处于停用状态，不能登录");
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(rs);
			JDBCUtil.close(ps);
			JDBCUtil.close(conn);
		}
		return u;
	}
	public User valiate(String username) {
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		User u=null;
		try {
			conn=JDBCUtil.getConnection();
			String sql="select * from t_user where username=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, username);
			rs=ps.executeQuery();
			while(rs.next()){
				u=new User();
				u.setId(rs.getInt("id"));
				u.setNickname(rs.getString("nickname"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setStatus(rs.getInt("status"));
				u.setType(rs.getInt("type"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(rs);
			JDBCUtil.close(ps);
			JDBCUtil.close(conn);
		}
		return u;
	}

}


























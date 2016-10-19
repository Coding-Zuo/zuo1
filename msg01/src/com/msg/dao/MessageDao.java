package com.msg.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.msg.model.Message;
import com.msg.model.Pager;
import com.msg.model.ShopException;
import com.msg.model.SystemContext;
import com.msg.util.JDBCUtil;

public class MessageDao implements ImessageDao{
	private IUserDao userDao;
	public MessageDao(){
		userDao=DaoFactory.getUserDao();
	}

	@Override
	public void add(Message msg, int userId) {
		Connection con=null;
		PreparedStatement ps=null;
		if(userDao.load(userId)==null)throw new ShopException("添加的用户不存在");
		con=JDBCUtil.getConnection();
		String sql="insert into t_msg (title,content,post_date,user_id) values (?,?,?,?)";
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, msg.getTitle());
			ps.setString(2, msg.getContent());
			ps.setTimestamp(3, new Timestamp(new Date().getTime()));
			ps.setInt(4, userId);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(ps);
			JDBCUtil.close(con);
		}
		
		
		
	}

	@Override
	public void update(Message msg) {
		Connection con=null;
		PreparedStatement ps=null;
		con=JDBCUtil.getConnection();
		String sql="update t_msg set title=?,content=? where id=?";
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, msg.getTitle());
			ps.setString(2, msg.getContent());
			ps.setInt(3, msg.getId());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(ps);
			JDBCUtil.close(con);
		}
	}

	@Override
	public void delete(int id) {
		Connection con=null;
		PreparedStatement ps=null;
		con=JDBCUtil.getConnection();
		//删除评论
		String sql="delete from t_comment where msg_id=?";
		try {
			con.setAutoCommit(false);//取消自动提交
			ps=con.prepareStatement(sql);
			ps.setInt(1, id);
			ps.executeUpdate();
//			int a=10;
//			if(a==10){
//				throw new ShopException("aa");
//			}
			sql="delete from t_msg where id=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, id);
			ps.executeUpdate();
			con.commit();//在这提交
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				con.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}finally {
			JDBCUtil.close(ps);
			JDBCUtil.close(con);
		}		
	}

	@Override
	public Message load(int id) {
		Message msg=null;
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		con=JDBCUtil.getConnection();
		//删除评论
		String sql="select * from t_msg where id=?";
		try {
			ps=con.prepareStatement(sql);
			ps.setInt(1, id);
			rs=ps.executeQuery();
			while(rs.next()){
				msg=new Message();
				msg.setContent(rs.getString("content"));
				msg.setId(rs.getInt("id"));
				msg.setPost_date(new Date(rs.getTimestamp("post_date").getTime()));
				msg.setTitle(rs.getString("title"));
				msg.setUserId(rs.getInt("user_id"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(rs);
			JDBCUtil.close(ps);
			JDBCUtil.close(con);
		}	
		return msg;
	}
	
	@Override
	public Pager<Message> list() {
		Pager<Message> pages=new Pager<>();
		Message msg=null;
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		int pageOffset=SystemContext.getPageOffset();
		int pageSize=SystemContext.getPageSize();
		pages.setPageOffset(pageOffset);
		pages.setPageSize(pageSize);
		con=JDBCUtil.getConnection();
		List<Message> datas=new ArrayList<>();
		pages.setDatas(datas);
		//删除评论
		String sql="select * from t_msg order by post_date desc limit ?,? ";
		String sqlCount="select count(*) from t_msg";
		try {
			ps=con.prepareStatement(sql);
			ps.setInt(1, pageOffset);
			ps.setInt(2, pageSize);
			rs=ps.executeQuery();
			while(rs.next()){
				msg=new Message();
				msg.setContent(rs.getString("content"));
				msg.setId(rs.getInt("id"));
				msg.setPost_date(new Date(rs.getTimestamp("post_date").getTime()));
				msg.setTitle(rs.getString("title"));
				msg.setUserId(rs.getInt("user_id"));
				datas.add(msg);
			}
			ps=con.prepareStatement(sqlCount);
			rs=ps.executeQuery();
			while(rs.next()){
				int totalRecord=rs.getInt(1);
				int totalPage=(totalRecord-1)/pageSize+1;
				pages.setTotalPage(totalPage);
				pages.setTotalRecord(totalRecord);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(rs);
			JDBCUtil.close(ps);
			JDBCUtil.close(con);
		}
		return pages;
	}

	@Override
	public int getCommentCount(int msgId) {
		Message msg=null;
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		int count=0;
		con=JDBCUtil.getConnection();
		//删除评论
		String sql="select count(*) from t_comment where msg_id=?";
		try {
			ps=con.prepareStatement(sql);
			ps.setInt(1, msgId);
			rs=ps.executeQuery();
			while(rs.next()){
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(rs);
			JDBCUtil.close(ps);
			JDBCUtil.close(con);
		}	
		return count;
	}
	

}





















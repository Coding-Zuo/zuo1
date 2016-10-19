package com.msg.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.msg.model.Comment;
import com.msg.model.Pager;
import com.msg.model.ShopException;
import com.msg.model.SystemContext;
import com.msg.util.JDBCUtil;

public class CommentDao implements ICommentDao{
	private IUserDao userDao;
	private ImessageDao msgDao;
	public CommentDao() {
		userDao=DaoFactory.getUserDao();
		msgDao=DaoFactory.getMsgDao();
	}
	
	@Override
	public void add(Comment comment, int userId, int msgId) {
		Connection con=null;
		PreparedStatement ps=null;
		if(userDao.load(userId)==null)throw new ShopException("添加评论的用户不存在");
		if(msgDao.load(msgId)==null)throw new ShopException("添加评论的留言不存在");
		con=JDBCUtil.getConnection();
		String sql="insert into t_comment(content,post_date,user_id,msg_id) values(?,?,?,?)";
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, comment.getContent());
			ps.setTimestamp(2, new Timestamp(new Date().getTime()));
			ps.setInt(3, userId);
			ps.setInt(4, msgId);
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
		String sql="delete from t_comment where id=?";
		try {
			ps=con.prepareStatement(sql);
			ps.setInt(1, id);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(ps);
			JDBCUtil.close(con);
		}		
	}

	@Override
	public Comment load(int id) {
		Connection con=null;
		Comment comment=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		con=JDBCUtil.getConnection();
		String sql="select * from t_comment where id=?";
		try {
			ps=con.prepareStatement(sql);
			ps.setInt(1, id);
			rs=ps.executeQuery();
			while(rs.next()){
				comment.setContent(rs.getString("content"));
				comment.setId(rs.getInt("id"));
				comment.setMsgId(rs.getInt("msg_id"));
				comment.setPostDate(new Date(rs.getTimestamp("post_date").getTime()));
				comment.setUserId(rs.getInt("user_id"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(rs);
			JDBCUtil.close(ps);
			JDBCUtil.close(con);
		}
		return comment;
	}
	public Pager<Comment> list1(int msgId){
		Pager<Comment> pages=new Pager<>();
		Connection conn=null;
		Comment comment=null;
		PreparedStatement pstm=null;
		ResultSet rs=null;
		int pageOffset=SystemContext.getPageOffset();
		int pageSize=SystemContext.getPageSize();
		List<Comment> datas=new ArrayList<>();
		pages.setDatas(datas);
		pages.setPageOffset(pageOffset);
		pages.setPageSize(pageSize);
		conn=JDBCUtil.getConnection();
		String sql="select * from t_comment where msg_id=? order by post_date asc limit ?,?";
		String sqlCount="select count(*) from t_comment where msg_id=? ord by post_date asc";
		try {
			pstm=conn.prepareStatement(sql);
			pstm.setInt(1, msgId);
			pstm.setInt(2, pageOffset);
			pstm.setInt(3, pageSize);
			rs=pstm.executeQuery();
			while(rs.next()){
				comment=new Comment();
				comment.setContent(rs.getString("content"));
				comment.setId(rs.getInt("id"));
				comment.setMsgId(rs.getInt("msg_id"));
				comment.setPostDate(new Date(rs.getTimestamp("post_date").getTime()));
				comment.setUserId(rs.getInt("user_id"));
				datas.add(comment);
			}
			pstm=conn.prepareStatement(sqlCount);
			pstm.setInt(1, msgId);
			rs=pstm.executeQuery();
			while(rs.next()){
				int totalRicord=rs.getInt(1);
				int totalPage=(totalRicord-1)/pageSize+1;
				pages.setTotalPage(totalPage);
				pages.setTotalRecord(totalRicord);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(rs);
			JDBCUtil.close(pstm);
			JDBCUtil.close(conn);
		}
		return pages;
				
	}

	//根据留言获取该留言的所有评论
	@Override
	public Pager<Comment> list(int msgId) {
		Pager<Comment> pages=new Pager<>();
		Connection con=null;
		Comment comment=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		int pageOffset=SystemContext.getPageOffset();
		int pageSize=SystemContext.getPageSize();
		List<Comment> datas=new ArrayList<>();
		pages.setDatas(datas);
		pages.setPageOffset(pageOffset);
		pages.setPageSize(pageSize);
		con=JDBCUtil.getConnection();
		String sql="select * from t_comment where msg_id=? order by post_date asc limit ?,?";
		String sqlCount="select count(*) from t_comment where msg_id=? order by post_date asc";
		try {
			ps=con.prepareStatement(sql);
			ps.setInt(1, msgId);
			ps.setInt(2, pageOffset);
			ps.setInt(3, pageSize);
			rs=ps.executeQuery();
			while(rs.next()){
				comment=new Comment();
				comment.setContent(rs.getString("content"));
				comment.setId(rs.getInt("id"));
				comment.setMsgId(rs.getInt("msg_id"));
				comment.setPostDate(new Date(rs.getTimestamp("post_date").getTime()));
				comment.setUserId(rs.getInt("user_id"));
				datas.add(comment);
			}
			ps=con.prepareStatement(sqlCount);
			ps.setInt(1, msgId);
			rs=ps.executeQuery();
			while(rs.next()){
				int totalRecord=rs.getInt(1);
				int totalPage=(totalRecord-1)/pageSize+1;
				pages.setTotalRecord(totalRecord);
				pages.setTotalPage(totalPage);
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

}

















package com.msg.dao;

public class DaoFactory {
	public static IUserDao getUserDao(){
		return new UserDao();
	}
	
	public static ImessageDao getMsgDao(){
		return new MessageDao();
	}
	public static ICommentDao getCommentDao(){
		return new CommentDao();
	}
}

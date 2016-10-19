package com.msg.dao;

import com.msg.model.Message;
import com.msg.model.Pager;

public interface ImessageDao {
	public void add(Message msg,int userId);
	public void update(Message msg);
	public void delete(int id);
	public Message load(int id);
	public Pager<Message> list();
	public int getCommentCount(int msgId);
}

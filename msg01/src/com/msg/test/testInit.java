package com.msg.test;

import java.util.Random;


import com.msg.dao.DaoFactory;
import com.msg.dao.IUserDao;
import com.msg.model.User;

public class testInit {
	static String[] firstNam=new String[]{"张","刘"
			,"牛","李","左","付","王","汪","赵","于","许","徐","林","候"
			,"乌","左","盖","周","曹","宋","张","孙","陈","白"};
	static String[] lastName=new String[]{"玉晖","海燕","鑫","清伟","强","中建","丽娜","晓宁","子傲","君妍"
			,"思竹","嘉敏","宇宁","博","依函","一涵","迪","宇","东海","昭君","鸿飞","成林","承烨","日更","铎文","杰伦"};
	static Random rand=new Random();
	
	public static void main(String[] args) {
		IUserDao ud=DaoFactory.getUserDao();
		for(int i=0;i<500;i++){
			User u=new User();
			u.setNickname(ranName());
			u.setPassword("123");
			u.setStatus(0);
			u.setType(0);
			u.setUsername("kh"+i);
			ud.add(u);
		}
		
	}
	public static String ranName(){
		return firstNam[rand.nextInt(firstNam.length)]+lastName[rand.nextInt(lastName.length)];
		
	}

}
















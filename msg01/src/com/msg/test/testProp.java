package com.msg.test;

import java.io.IOException;
import java.util.Properties;

import com.msg.util.PropUtil;

public class testProp {
	public static void main(String[] args) {
		Properties prop=new Properties();
		try {
			prop.load(testProp.class.getClassLoader().getResourceAsStream("dbconfig.properties"));
			String user=prop.getProperty("user");
			System.out.println(user);
		} catch (IOException e) {
			e.printStackTrace();
		}
		Properties p1=PropUtil.getJdbcProp();
		Properties p2=PropUtil.getJdbcProp();
		System.out.println(p1==p2);
	}
}

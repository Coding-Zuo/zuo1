package com.msg.util;

import java.io.IOException;
import java.util.Properties;

public class PropUtil {
	private static Properties jdbcProp;
	public static Properties getJdbcProp(){
		if(jdbcProp==null){
			jdbcProp=new Properties();
			try {
				jdbcProp.load(PropUtil.class.getClassLoader().getResourceAsStream("dbconfig.properties"));
				
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return jdbcProp;
	}

}

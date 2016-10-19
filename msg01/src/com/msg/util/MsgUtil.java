package com.msg.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class MsgUtil {
	private static final String dateFormat="yyyy-MM-dd HH:mm";
	private static final SimpleDateFormat stf=new SimpleDateFormat(dateFormat);
	
	public static String formatDate(Date date){
		return stf.format(date);
	}

}

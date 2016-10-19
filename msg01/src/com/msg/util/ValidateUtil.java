package com.msg.util;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.msg.model.User;



public class ValidateUtil {
	public static boolean validateNull(HttpServletRequest request,String[] fileds){
		boolean validate=true;
		Map<String,String>errorMsg=new HashMap<String,String>();
		for(String field:fileds){
			String value=request.getParameter(field);
			if(value==null||"".equals(value.trim())){
				validate=false;
				errorMsg.put(field, field+"不能为空");
			}
			
		}
		if(!validate) request.setAttribute("errorMsg", errorMsg);
		return validate;
	}
	public static String showError(HttpServletRequest request,String field){
		@SuppressWarnings("unchecked")
		Map<String , String> msg=(Map<String, String>) request.getAttribute("errorMsg");
		if(msg==null){
			return "";	
		}
		String msString=msg.get(field);
		if(msString==null)
			return "";
		return msString;
	}
	public static boolean checkAdminOrSelf(HttpSession session,int userId){
		User u=(User)session.getAttribute("loginUser");
		if(u==null)
			return false;
		if(u.getType()==1)
			return true;
		if(u.getId()==userId)
			return true;
		return false;
	}
}











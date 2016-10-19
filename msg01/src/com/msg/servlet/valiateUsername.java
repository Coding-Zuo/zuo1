package com.msg.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.msg.dao.DaoFactory;
import com.msg.dao.IUserDao;
import com.msg.dao.ImessageDao;
import com.msg.model.User;

/**
 * Servlet implementation class valiateUsername
 */
public class valiateUsername extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public valiateUsername() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("UTF-8");
		IUserDao userDao=DaoFactory.getUserDao();
		String username=request.getParameter("username");
		User user=userDao.valiate(username);
		String result=null;
		
		System.out.println(username);
		String string;
		try {
			string = user.getUsername();
			if(string!=null&&!"".equals(string)){
				result="<font color='red'>有该用户</font>";
			}			
		} catch (Exception e) {
			result="<font color='green'>无该用户</font>";
		}
//		System.out.println(user.getUsername());
		
		response.getWriter().print(result);
	
	}

}


















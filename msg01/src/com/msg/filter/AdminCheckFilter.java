package com.msg.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.msg.model.User;

public class AdminCheckFilter implements Filter{

	@Override
	public void destroy() {
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain arg2)
			throws IOException, ServletException {
		HttpServletRequest request=(HttpServletRequest) req;
		HttpServletResponse response=(HttpServletResponse) resp;
		HttpSession session=request.getSession();
		User u=(User) session.getAttribute("loginUser");
		if(u==null){
			response.sendRedirect(request.getContextPath()+"/loginInput.jsp");
			return ;
		}
		arg2.doFilter(req, resp);
		
		
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		
	}

}

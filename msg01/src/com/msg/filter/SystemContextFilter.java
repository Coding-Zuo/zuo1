package com.msg.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import com.msg.model.SystemContext;

/**
 * Servlet Filter implementation class SystemContextFilter
 */
public class SystemContextFilter implements Filter {
	int pageSize;

    public SystemContextFilter() {
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		try {
			int pageOffset=0;
			int pageSize=15;
			try {
				pageOffset=Integer.parseInt(request.getParameter("pager.offset"));
			} catch (NumberFormatException e) {
			}
			SystemContext.setPageOffset(pageOffset);
			SystemContext.setPageSize(pageSize);
			chain.doFilter(request, response);
		} finally {
			SystemContext.removerPageOffset();
			SystemContext.removePageSize();
		}
	
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		try {
			pageSize=Integer.parseInt(fConfig.getInitParameter("pageSize"));
		} catch (NumberFormatException e) {
			pageSize=15;
		}
	}

}

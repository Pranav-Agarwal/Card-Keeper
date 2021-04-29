package com.Trello.Interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.Trello.DAO.CardDAO;
import com.Trello.DAO.GenericDAO;
import com.Trello.DAO.WorkspaceDAO;
import com.Trello.pojo.Card;
import com.Trello.pojo.User;
import com.Trello.pojo.Workspace;

public class DashboardInterceptor extends HandlerInterceptorAdapter{		
	
	@Autowired
	private WorkspaceDAO workspaceDao;
	
	@Autowired
	private CardDAO cardDao;

	@Override
	public void postHandle(HttpServletRequest request,HttpServletResponse response, Object handler,ModelAndView modelandview) throws Exception {
	    User user = (User) request.getSession().getAttribute("user");
	    if (user==null) {
	    	response.sendRedirect("/App/");
	    }
	    else{
    		List<Workspace> res = workspaceDao.getWorkspacesByUser(user);
    		List<Card> cards = cardDao.getAssignedCardsByUser(user);
    		request.getSession().setAttribute("workspaces", res);
    		request.getSession().setAttribute("cards", cards);
	    }
	}
}

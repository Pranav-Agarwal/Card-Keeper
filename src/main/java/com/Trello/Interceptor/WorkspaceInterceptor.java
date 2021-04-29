package com.Trello.Interceptor;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.Trello.DAO.GenericDAO;
import com.Trello.DAO.WorkspaceDAO;
import com.Trello.pojo.Card;
import com.Trello.pojo.CardList;
import com.Trello.pojo.User;
import com.Trello.pojo.Workspace;

public class WorkspaceInterceptor extends HandlerInterceptorAdapter{
	
	@Autowired
	private GenericDAO dao;
	
	@Autowired
	private WorkspaceDAO workspaceDao;

	 @Override
	    public void postHandle(HttpServletRequest request,HttpServletResponse response, Object handler, ModelAndView modelandview) throws Exception {
	        User user = (User) request.getSession().getAttribute("user");
	        String id = request.getParameter("workspaceId");
	        Workspace workspace = null;
	        if (user==null) {
	        	response.sendRedirect("/App/");
	        	return;
	        }
	        if(id!=null) {
	        	workspace = dao.get(Workspace.class,Integer.parseInt(id));
	        	request.getSession().setAttribute("workspace",workspace);
	        }
	        else workspace = (Workspace) request.getSession().getAttribute("workspace");
	        if(workspace==null) {
	        	response.sendRedirect("/App/dashboard/dashboard.htm");
	        	return;
	        }
	        if(workspaceDao.getAdmin(user, workspace)==null && workspaceDao.getMember(user, workspace)==null) {
	        	response.sendRedirect("/App/");
	        	return;
	        }
	    	List<User> admins = workspaceDao.getAdmins(workspace);
	    	if(admins.contains(user)) {
	    		request.getSession().setAttribute("admin",true);
	    	}
	    	else {
	    		request.getSession().setAttribute("admin",false);
	    	}
	    	Map<CardList,List<Card>> map = workspaceDao.getCardlistsByWorkspace(workspace);
	    	request.setAttribute("cardlists", map);
	    }
}

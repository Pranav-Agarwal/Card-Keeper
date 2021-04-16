package com.Trello.Controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.Trello.DAO.GenericDAO;
import com.Trello.DAO.UserDAO;
import com.Trello.DAO.WorkspaceDAO;
import com.Trello.pojo.User;
import com.Trello.pojo.Workspace;

@Controller
public class DashController {
	
	@Autowired
	private GenericDAO dao;
	
	@Autowired
	private UserDAO userDao;
	
	@Autowired
	private WorkspaceDAO workspaceDao;
	
    @RequestMapping(value="/workspace.htm", method=RequestMethod.GET)
    public String login(@RequestParam String workspaceId, HttpServletRequest request){
    	System.out.println(workspaceId);
    	Workspace workspace = dao.get(Workspace.class, Integer.parseInt(workspaceId));
    	System.out.println(workspace.getId());
    	request.setAttribute("workspace", workspace);
    	return "workspace";
    }
}

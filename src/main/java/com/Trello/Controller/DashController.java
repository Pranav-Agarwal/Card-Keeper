package com.Trello.Controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.Trello.DAO.GenericDAO;
import com.Trello.DAO.InviteDAO;
import com.Trello.DAO.WorkspaceDAO;
import com.Trello.pojo.Admin;
import com.Trello.pojo.Card;
import com.Trello.pojo.CardList;
import com.Trello.pojo.Invite;
import com.Trello.pojo.Member;
import com.Trello.pojo.User;
import com.Trello.pojo.Workspace;
import com.Trello.pojo.WorkspaceBg;

@Controller
public class DashController {
	
	@Autowired
	private GenericDAO dao;
	
	@Autowired
	private WorkspaceDAO workspaceDao;
	
	@Autowired
	private InviteDAO inviteDao;
	
    @RequestMapping(value="/workspace/workspace.htm", method=RequestMethod.GET)
    public String login(@RequestParam(required=false) String workspaceId, HttpServletRequest request){
    	return "workspace";
    }
    
    @RequestMapping(value="/viewInvites.htm", method=RequestMethod.GET)
    public String viewInvites(HttpServletRequest request) {
    	User user = (User) request.getSession().getAttribute("user");
    	List<Invite> inv = inviteDao.getInvitesByUser(user);
    	request.setAttribute("invites", inv);
    	return "invites";
    }
    
    @RequestMapping(value="/logout.htm", method=RequestMethod.GET)
    public String logout(HttpServletRequest request) {
    	request.getSession().invalidate();
    	return "home";
    }
    
    @RequestMapping(value="/dashboard/invite.htm", method=RequestMethod.POST)
    public String handleInvite(@RequestParam String inviteId,@RequestParam String choice, HttpServletRequest request){
    	Invite invite = dao.get(Invite.class, Integer.parseInt(inviteId));
    	User user = invite.getRecipient();
    	if(choice.equals("accept")) {
    		invite.setStatus(Invite.Status.ACCEPTED);
    		if(invite.getIsAdminInvite()) {
    			Admin a = new Admin();
    			a.setUser(user);
    			a.setWorkspace(invite.getWorkspace());
    			dao.save(a);
    		}
    		else {
    			Member m = new Member();
    			m.setUser(user);
    			m.setWorkspace(invite.getWorkspace());
    			dao.save(m);
    		}
    	}
    	else {
    		invite.setStatus(Invite.Status.REJECTED);
    	}
    	dao.saveOrUpdate(invite);
		List<Workspace> res = workspaceDao.getWorkspacesByUser(user);
		request.getSession().setAttribute("workspaces", res);
    	return "dashboard";
    }
    
    @RequestMapping(value="/addWorkspace.htm", method=RequestMethod.GET)
    public String workspaceForm(@ModelAttribute("workspace") Workspace workspace, HttpServletRequest request){
    	List<WorkspaceBg> images = dao.getAll(WorkspaceBg.class);
    	request.setAttribute("images", images);
    	return "workspaceForm";
    }
    
    @RequestMapping(value="/dashboard/addWorkspace.htm", method=RequestMethod.POST)
    public String addWorkspace(@ModelAttribute("workspace") Workspace workspace, HttpServletRequest request){
    	if(workspace.getWorkspaceBg()==null) workspace.setWorkspaceBg(dao.get(WorkspaceBg.class, 1));
    	dao.save(workspace);
    	User user = (User) request.getSession().getAttribute("user");
		Admin a = new Admin();
		a.setUser(user);
		a.setWorkspace(workspace);
		dao.save(a);
		List<Workspace> res = workspaceDao.getWorkspacesByUser(user);
		request.getSession().setAttribute("workspaces", res);
    	return "dashboard";
    }
}

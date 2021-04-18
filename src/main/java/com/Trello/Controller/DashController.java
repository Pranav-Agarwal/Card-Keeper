package com.Trello.Controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.Trello.DAO.CardDAO;
import com.Trello.DAO.GenericDAO;
import com.Trello.DAO.InviteDAO;
import com.Trello.DAO.UserDAO;
import com.Trello.DAO.WorkspaceDAO;
import com.Trello.pojo.Admin;
import com.Trello.pojo.Card;
import com.Trello.pojo.CardList;
import com.Trello.pojo.Invite;
import com.Trello.pojo.Member;
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
	
	@Autowired
	private InviteDAO inviteDao;
	
	@Autowired
	private CardDAO cardDao;
	
    @RequestMapping(value="/workspace.htm", method=RequestMethod.GET)
    public String login(@RequestParam String workspaceId, HttpServletRequest request){
    	//System.out.println(workspaceId);
    	Workspace workspace = dao.get(Workspace.class, Integer.parseInt(workspaceId));
    	//System.out.println(workspace.getId());
    	Map<CardList,List<Card>> map = workspaceDao.getCardlistsByWorkspace(workspace);
    	request.setAttribute("cardlists", map);
    	request.getSession().setAttribute("workspace", workspace);
    	return "workspace";
    }
    
    @RequestMapping(value="/invite.htm", method=RequestMethod.GET)
    public String handleInvite(@RequestParam String inviteId,@RequestParam String choice, HttpServletRequest request){
    	System.out.println(inviteId);
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
		List<Invite> inv = inviteDao.getInvitesByUser(user);
		//System.out.println(user.getName());
		request.getSession().setAttribute("workspaces", res);
		request.getSession().setAttribute("invites", inv);
		//System.out.println(inv.size());
    	return "dashboard";
    }
    
    @RequestMapping(value="/addWorkspace.htm", method=RequestMethod.GET)
    public String workspaceForm(@ModelAttribute("workspace") Workspace workspace){
    	return "workspaceForm";
    }
    
    @RequestMapping(value="/addWorkspace.htm", method=RequestMethod.POST)
    public String addWorkspace(@ModelAttribute("workspace") Workspace workspace, HttpServletRequest request){
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

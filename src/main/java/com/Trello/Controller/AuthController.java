package com.Trello.Controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.Trello.DAO.CardDAO;
import com.Trello.DAO.GenericDAO;
import com.Trello.DAO.InviteDAO;
import com.Trello.DAO.UserDAO;
import com.Trello.DAO.WorkspaceDAO;
import com.Trello.pojo.Card;
import com.Trello.pojo.Invite;
import com.Trello.pojo.User;
import com.Trello.pojo.Workspace;

@Controller
public class AuthController {
	
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
	
    @RequestMapping(value="/login.htm", method=RequestMethod.GET)
    public String login(@RequestParam String username,@RequestParam String password, HttpServletRequest request){
    	User user = userDao.getUserByUsername(username);
    	if(user!=null && user.getPassword().equals(password)) {
    		request.getSession().setAttribute("user", user);
    		List<Workspace> res = workspaceDao.getWorkspacesByUser(user);
    		List<Invite> inv = inviteDao.getInvitesByUser(user);
    		List<Card> cards = cardDao.getAssignedCardsByUser(user);
    		//System.out.println(user.getName());
    		request.getSession().setAttribute("workspaces", res);
    		request.getSession().setAttribute("invites", inv);
    		request.getSession().setAttribute("cards", cards);
    		//System.out.println(inv.size());
    		return "dashboard";
    	}
    	else {
    		request.setAttribute("message", "Invalid Credentials");
    		return "loginFailed";
    	}
    }
    
    @RequestMapping(value="/register.htm", method=RequestMethod.GET)
    public String register(@ModelAttribute("user") User user){
    	return "register";
    }
    
    @RequestMapping(value="/addUser.htm", method=RequestMethod.POST)
    public String addUser(@ModelAttribute("user") User user, HttpServletRequest request){
    	if(userDao.getUserByUsername(user.getUsername())==null) {
    		dao.save(user);
    		request.getSession().setAttribute("user", user);
    		return "dashboard";
    	}
    	else {
    		request.setAttribute("message", "Username Taken");
    		return "loginFailed";
    	}
    }
    
}

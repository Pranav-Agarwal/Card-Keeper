package com.Trello.Controller;

import java.time.LocalDate;
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
public class WorkspaceController {
	
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
	
    @RequestMapping(value="/sendInvite.htm", method=RequestMethod.GET)
    public String sendInvite(@RequestParam String username, String isAdmin, HttpServletRequest request){
    	User recipient = userDao.getUserByUsername(username);
    	User user = (User) request.getSession().getAttribute("user");
    	Workspace workspace = (Workspace) request.getSession().getAttribute("workspace");
    	List<User> admins = workspaceDao.getAdmins(workspace);
    	List<User> members = workspaceDao.getMembers(workspace);
    	request.setAttribute("admins",admins);
    	request.setAttribute("members",members);
    	if(recipient==null) {
    		request.setAttribute("message","user not found");
    		return "workspaceSettings";
    	}
    	else if(admins.contains(recipient) || members.contains(recipient)) {
    		request.setAttribute("message","user already part of workspace");
    		return "workspaceSettings";
    	}
    	else if(inviteDao.hasBeenInvited(recipient, workspace)) {
    		request.setAttribute("message","user already been invited");
    		return "workspaceSettings";
    	}
    	Invite invite = new Invite();
    	invite.setRecipient(recipient);
    	invite.setSender(user);
    	invite.setStatus(Invite.Status.PENDING);
    	invite.setWorkspace(workspace);
    	if(isAdmin.equals("yes")) invite.setIsAdminInvite(true);
    	else invite.setIsAdminInvite(false);
    	dao.save(invite);
    	request.setAttribute("message","Invite Sent");
    	return "workspaceSettings";
    }
    
    @RequestMapping(value="/editMember.htm", method=RequestMethod.GET)
    public String editMember(@RequestParam String userId, String operation, HttpServletRequest request){
    	User user = dao.get(User.class, Integer.parseInt(userId));
    	//User user = (User) request.getSession().getAttribute("user");
    	Workspace workspace = (Workspace) request.getSession().getAttribute("workspace");
    	Admin adminship = workspaceDao.getAdmin(user, workspace);
    	Member membership = workspaceDao.getMember(user, workspace);
    	if(operation.equals("delete")) {
    		if(adminship==null) dao.delete(membership);
    		else dao.delete(adminship);
    		request.setAttribute("message","User "+user.getName()+" Removed");
    	}
    	else if(operation.equals("make_admin")) {
    		if(membership==null) {
        		request.setAttribute("message","User "+user.getName()+" is already an admin");
    		}
    		else {
    			dao.delete(membership);
    			adminship = new Admin();
    			adminship.setUser(user);
    			adminship.setWorkspace(workspace);
    			dao.save(adminship);
        		request.setAttribute("message","User "+user.getName()+" made into admin");
    		}

    	}
    	else {
    		if(adminship==null) {
        		request.setAttribute("message","User "+user.getName()+" is already not an admin");
    		}
    		else {
    			dao.delete(adminship);
    			membership = new Member();
    			membership.setUser(user);
    			membership.setWorkspace(workspace);
    			dao.save(membership);
        		request.setAttribute("message","User "+user.getName()+" removed as admin");
    		}
    	}
    	List<User> admins = workspaceDao.getAdmins(workspace);
    	List<User> members = workspaceDao.getMembers(workspace);
    	request.setAttribute("admins",admins);
    	request.setAttribute("members",members);
    	return "workspaceSettings";
    }
    
    @RequestMapping(value="/settings.htm", method=RequestMethod.GET)
	public String viewSettings(HttpServletRequest request){
    	Workspace workspace = (Workspace) request.getSession().getAttribute("workspace");
    	List<User> admins = workspaceDao.getAdmins(workspace);
    	List<User> members = workspaceDao.getMembers(workspace);
    	request.setAttribute("admins",admins);
    	request.setAttribute("members",members);
    	return "workspaceSettings";
    }
    
    @RequestMapping(value="/addCardList.htm", method=RequestMethod.GET)
    public String addCardList(@RequestParam String name, HttpServletRequest request){
    	CardList cardList = new CardList();
    	Workspace workspace = (Workspace) request.getSession().getAttribute("workspace");
    	cardList.setName(name);
    	cardList.setWorkspace(workspace);
    	dao.save(cardList);
    	Map<CardList,List<Card>> map = workspaceDao.getCardlistsByWorkspace(workspace);
    	request.setAttribute("cardlists", map);
    	return "workspace";
    }
    
    @RequestMapping(value="/addCard.htm", method=RequestMethod.GET)
    public String addCard(@RequestParam String name, @RequestParam String cardList,HttpServletRequest request){
    	Card card = new Card();
    	card.setTitle(name);
    	card.setCardlist(dao.get(CardList.class,Integer.parseInt(cardList)));
    	dao.save(card);
    	Map<CardList,List<Card>> map = workspaceDao.getCardlistsByWorkspace(card.getCardlist().getWorkspace());
    	request.setAttribute("cardlists", map);
    	return "workspace";
    }
    
    @RequestMapping(value="/updateCard.htm",method = RequestMethod.GET)
    public String showCardForm(@RequestParam String cardId,HttpServletRequest request) {
    	Card card = dao.get(Card.class,Integer.parseInt(cardId));
    	request.getSession().setAttribute("card", card);
    	Map<CardList,List<Card>> map = workspaceDao.getCardlistsByWorkspace(card.getCardlist().getWorkspace());
    	request.setAttribute("cardlists", map);
    	List<User> users = workspaceDao.getUsers(card.getCardlist().getWorkspace());
    	request.setAttribute("users",users);
    	return "cardForm";
    }
    
    @RequestMapping(value="/editCard.htm",method = RequestMethod.GET)
    public String editCard(@RequestParam String title,@RequestParam String desc,@RequestParam String assignedTo,@RequestParam String cardList,@RequestParam String duedate,@RequestParam String isDone,HttpServletRequest request) {
    	Card card = (Card) request.getSession().getAttribute("card");
    	if(title!=null) card.setTitle(title);
    	if(desc!=null) card.setDescription(desc);
    	if(assignedTo!=null) card.setAssignedTo(dao.get(User.class,Integer.parseInt(assignedTo)));
    	if(cardList!=null) card.setCardlist(dao.get(CardList.class, Integer.parseInt(cardList)));
    	if(duedate!=null) card.setDueDate(LocalDate.parse(duedate));
    	if(isDone!=null) card.setIsDone(true);
    	dao.merge(card);
    	Map<CardList,List<Card>> map = workspaceDao.getCardlistsByWorkspace(card.getCardlist().getWorkspace());
    	request.setAttribute("cardlists", map);
    	return "workspace";
    }
    
    @RequestMapping(value="/viewCard.htm",method = RequestMethod.GET)
    public String viewCard(@RequestParam String cardId,HttpServletRequest request) {
    	Card card = dao.get(Card.class,Integer.parseInt(cardId));
    	request.getSession().setAttribute("card", card);
    	return "card";
    }
    
    @RequestMapping(value="/moveCard.htm",method = RequestMethod.POST)
    public String moveCard(@RequestParam String cardList,HttpServletRequest request) {
    	Card card = (Card) request.getSession().getAttribute("card");
    	card.setCardlist(dao.get(CardList.class, Integer.parseInt(cardList)));
    	dao.merge(card);
    	Map<CardList,List<Card>> map = workspaceDao.getCardlistsByWorkspace(card.getCardlist().getWorkspace());
    	request.setAttribute("cardlists", map);
    	return "workspace";
    }
}

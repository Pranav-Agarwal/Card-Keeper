package com.Trello.Controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	
    @RequestMapping(value="/workspace/sendInvite.htm", method=RequestMethod.GET)
    public String sendInvite(@RequestParam String username, String isAdmin, HttpServletRequest request){
    	User recipient = userDao.getUserByUsername(username);
    	User user = (User) request.getSession().getAttribute("user");
    	Workspace workspace = (Workspace) request.getSession().getAttribute("workspace");
    	List<User> admins = workspaceDao.getAdmins(workspace);
    	List<User> members = workspaceDao.getMembers(workspace);
    	if(recipient==null) {
    		request.setAttribute("message","user not found");
    		return "workspace";
    	}
    	else if(admins.contains(recipient) || members.contains(recipient)) {
    		request.setAttribute("message","user already part of workspace");
    		return "workspace";
    	}
    	else if(inviteDao.hasBeenInvited(recipient, workspace)) {
    		request.setAttribute("message","user already been invited");
    		return "workspace";
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
    	return "workspace";
    }
    
    @RequestMapping(value="/workspace/editMember.htm", method=RequestMethod.GET)
    public String editMember(@RequestParam String userId, String operation, HttpServletRequest request){
    	User user = dao.get(User.class, Integer.parseInt(userId));
    	User currentUser = (User) request.getSession().getAttribute("user");
    	Workspace workspace = (Workspace) request.getSession().getAttribute("workspace");
    	Admin adminship = workspaceDao.getAdmin(user, workspace);
    	Member membership = workspaceDao.getMember(user, workspace);
    	if(operation.equals("delete")) {
    		if(adminship==null) dao.delete(membership);
    		else dao.delete(adminship);
    		request.setAttribute("message","User "+user.getName()+" Removed");
    		if(user.getId()==currentUser.getId()) {
    			return "dashboard";
    		}
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
    			if(currentUser.equals(user)) request.getSession().setAttribute("admin", true);
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
    			if(currentUser.equals(user)) request.getSession().setAttribute("admin", false);
        		request.setAttribute("message","User "+user.getName()+" removed as admin");
    		}
    	}
    	return "workspace";
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
    
    @RequestMapping(value="/deleteWorkspace.htm", method=RequestMethod.GET)
	public String deleteWorkspace(HttpServletRequest request){
    	Workspace workspace = (Workspace) request.getSession().getAttribute("workspace");
    	dao.delete(workspace);
    	return "redirect:/dashboard/dashboard.htm";
    }
    
    @RequestMapping(value="/workspace/deleteCardList.htm", method=RequestMethod.GET)
	public String deleteCardList(@RequestParam String cardList,HttpServletRequest request){
    	CardList cardlist = dao.get(CardList.class, Integer.parseInt(cardList));
    	dao.delete(cardlist);
    	return "workspace";
    }
    
    @RequestMapping(value="/workspace/deleteCard.htm", method=RequestMethod.GET)
	public String deleteCard(@RequestParam String cardId, HttpServletRequest request){
    	Card card = dao.get(Card.class,Integer.parseInt(cardId));
    	dao.delete(card);
    	return "workspace";
    }
    
    @RequestMapping(value="/dashboard/dashboard.htm", method=RequestMethod.GET)
    public String goToDashboard(HttpServletRequest request){
		return "dashboard";
    }
    
    @RequestMapping(value="/workspace/addCardList.htm", method=RequestMethod.GET)
    public String addCardList(@RequestParam String name, HttpServletRequest request){
    	CardList cardList = new CardList();
    	Workspace workspace = (Workspace) request.getSession().getAttribute("workspace");
    	cardList.setName(name);
    	cardList.setWorkspace(workspace);
    	dao.save(cardList);
    	return "workspace";
    }
    
    @RequestMapping(value="/workspace/addCard.htm", method=RequestMethod.GET)
    public String addCard(@RequestParam String name, @RequestParam String cardList,HttpServletRequest request){
    	Card card = new Card();
    	card.setTitle(name);
    	card.setCardlist(dao.get(CardList.class,Integer.parseInt(cardList)));
    	String[] colors = new String[] {"#5cb85c","#0275d8","#f0ad4e","#d9534f","#5bc0de"};
    	card.setColor(colors[(int)(System.currentTimeMillis() % colors.length)]);
    	card.setIsDone(false);
    	dao.save(card);
    	return "workspace";
    }
    
    @RequestMapping(value="/updateCard.htm",method = RequestMethod.GET)
    public String showCardForm(@RequestParam String cardId,HttpServletRequest request) {
    	Card card = dao.get(Card.class,Integer.parseInt(cardId));
    	request.setAttribute("card", card);
    	Map<CardList,List<Card>> map = workspaceDao.getCardlistsByWorkspace(card.getCardlist().getWorkspace());
    	request.setAttribute("cardlists", map);
    	List<User> users = workspaceDao.getUsers(card.getCardlist().getWorkspace());
    	request.setAttribute("users",users);
    	return "cardForm";
    }
    
    @RequestMapping(value="/workspace/editCard.htm",method = RequestMethod.POST)
    public String editCard(@RequestParam(required=true) String id,@RequestParam(required=false) String title,@RequestParam(required=false) String desc,@RequestParam(required=false) String color,@RequestParam(required=false) String assignedTo,@RequestParam(required=false) String cardList,@RequestParam(required=false) String duedate,@RequestParam(required=false) String isDone,HttpServletRequest request) throws ParseException {
    	Card card = dao.get(Card.class,Integer.parseInt(id));
    	if(!title.equals("")) card.setTitle(title);
    	if(!desc.equals("")) card.setDescription(desc);
    	card.setColor(color);
    	if(!assignedTo.equals("NA")) card.setAssignedTo(dao.get(User.class,Integer.parseInt(assignedTo)));
    	else card.setAssignedTo(null);
    	if(cardList!=null) card.setCardlist(dao.get(CardList.class, Integer.parseInt(cardList)));
    	if(!duedate.equals("")) card.setDueDate(new SimpleDateFormat("yyyy-MM-dd").parse(duedate));
    	if(isDone!=null) card.setIsDone(true);
    	else card.setIsDone(false);
    	dao.merge(card);
    	return "redirect:/workspace/workspace.htm";
    }
    
    @RequestMapping(value="/viewCard.htm",method = RequestMethod.GET)
    public String viewCard(@RequestParam String cardId,HttpServletRequest request) {
    	Card card = dao.get(Card.class,Integer.parseInt(cardId));
    	request.setAttribute("card", card);
    	return "card";
    }
}

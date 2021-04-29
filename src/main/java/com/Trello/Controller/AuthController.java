package com.Trello.Controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolationException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.Trello.DAO.CardDAO;
import com.Trello.DAO.GenericDAO;
import com.Trello.DAO.UserDAO;
import com.Trello.DAO.WorkspaceDAO;
import com.Trello.pojo.Card;
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
	private CardDAO cardDao;
	
    @RequestMapping(value="/login.htm", method=RequestMethod.POST)
    public String login(@RequestParam String username,@RequestParam String password, HttpServletRequest request){
    	User user = userDao.getUserByUsername(username);
    	if(user!=null && user.getPassword().equals(password)) {
    		request.getSession().setAttribute("user", user);
    		return "redirect:/dashboard/dashboard.htm";
    	}
    	else {
    		request.setAttribute("message", "Incorrect Username or Password");
    		return "home";
    	}
    }
    
    
    
    @RequestMapping(value="/register.htm", method=RequestMethod.GET)
    public String register(@ModelAttribute("user") User user){
    	return "register";
    }
    
    @RequestMapping(value="/addUser.htm", method=RequestMethod.POST)
    public String addUser(@ModelAttribute("user") User user, HttpServletRequest request){
    	if(userDao.getUserByUsername(user.getUsername())==null) {
    		try{
    			dao.save(user);
    		}
    		catch (ConstraintViolationException e) {
        		request.setAttribute("message", "Please Enter a password between 8 and 16 characters");
        		return "register";
    		}
    		request.getSession().setAttribute("user", user);
    		return "redirect:/dashboard/dashboard.htm";
    	}
    	else {
    		request.setAttribute("message", "Username Already Taken");
    		return "register";
    	}
    }
    
}

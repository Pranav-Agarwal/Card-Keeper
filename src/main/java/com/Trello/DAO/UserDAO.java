package com.Trello.DAO;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;

import com.Trello.pojo.User;

public class UserDAO extends DAO{
	
	
    public User getUserByUsername(final String username){
    	System.out.println(username);
    	Criteria cr = getSession().createCriteria(User.class);
    	cr.add(Restrictions.eq("username", username));
    	User result = (User) cr.uniqueResult();
    	return result;
    }
}

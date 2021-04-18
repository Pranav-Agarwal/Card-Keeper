package com.Trello.DAO;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;

import com.Trello.pojo.Card;
import com.Trello.pojo.Invite;
import com.Trello.pojo.User;

public class CardDAO extends DAO{
    public List<Card> getAssignedCardsByUser(User user){
    	//System.out.println(username);
    	Criteria cr = getSession().createCriteria(Card.class);
    	cr.add(Restrictions.eq("assignedTo", user));
    	cr.add(Restrictions.eq("isDone",false));
    	List<Card> result = cr.list();
    	return result;
    }
}

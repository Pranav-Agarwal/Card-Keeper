package com.Trello.DAO;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;

import com.Trello.pojo.Invite;
import com.Trello.pojo.User;
import com.Trello.pojo.Workspace;

public class InviteDAO extends DAO{
    public List<Invite> getInvitesByUser(User user){
    	Criteria cr = getSession().createCriteria(Invite.class);
    	cr.add(Restrictions.eq("recipient", user));
    	cr.add(Restrictions.eq("status",Invite.Status.PENDING));
    	List<Invite> result = cr.list();
    	close();
    	return result;
    }
    
    public boolean hasBeenInvited(User user, Workspace workspace) {
    	Criteria cr = getSession().createCriteria(Invite.class);
    	cr.add(Restrictions.eq("recipient", user));
    	cr.add(Restrictions.eq("status",Invite.Status.PENDING));
    	cr.add(Restrictions.eq("workspace",workspace));
    	List<Invite> result = cr.list();
    	close();
    	if(result.size()==0) return false;
    	else return true;
    }
}

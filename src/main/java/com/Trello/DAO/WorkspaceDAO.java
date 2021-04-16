package com.Trello.DAO;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;

import com.Trello.pojo.Admin;
import com.Trello.pojo.Member;
import com.Trello.pojo.User;
import com.Trello.pojo.Workspace;

public class WorkspaceDAO extends DAO{
	
    public List<Workspace> getWorkspacesByUser(final User user){
    	List<Workspace> result = new ArrayList();
    	Criteria cr1 = getSession().createCriteria(Member.class);
    	cr1.add(Restrictions.eq("user", user));
    	List<Member> tempm = cr1.list();
    	for(Member m : tempm) {
    		result.add(m.getWorkspace());
    	}
    	Criteria cr2 = getSession().createCriteria(Admin.class);
    	cr2.add(Restrictions.eq("user", user));
    	List<Admin> tempa = cr2.list();
    	for(Admin a : tempa) {
    		result.add(a.getWorkspace());
    	}
    	
    	return result;
    }
    
    public void addWorkspaceToUser(User user, Workspace workspace, boolean isAdmin) {
    	beginTransaction();
    	if(isAdmin) {
    		Admin admin = new Admin();
    		admin.setUser(user);
    		admin.setWorkspace(workspace);
    		getSession().save(admin);
    	}
    	else {
    		Member member = new Member();
    		member.setUser(user);
    		member.setWorkspace(workspace);
    		getSession().save(member);
    	}
		commit();
    }
    
}

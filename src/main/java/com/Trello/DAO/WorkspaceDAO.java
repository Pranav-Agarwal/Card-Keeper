package com.Trello.DAO;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import com.Trello.pojo.Admin;
import com.Trello.pojo.Card;
import com.Trello.pojo.CardList;
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
    	close();
    	return result;
    }
    
    public Admin getAdmin(final User user, final Workspace workspace){
    	Criteria cr1 = getSession().createCriteria(Admin.class);
    	cr1.add(Restrictions.eq("user", user));
    	cr1.add(Restrictions.eq("workspace", workspace));
    	Admin a = (Admin) cr1.uniqueResult();
    	close();
    	return a;
    }
    
    public Member getMember(final User user, final Workspace workspace){
    	Criteria cr1 = getSession().createCriteria(Member.class);
    	cr1.add(Restrictions.eq("user", user));
    	cr1.add(Restrictions.eq("workspace", workspace));
    	Member m = (Member) cr1.uniqueResult();
    	close();
    	return m;
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
		close();
    }
    
    public List<User> getUsers(Workspace workspace){
    	List<User> result = new ArrayList();
    	result.addAll(getAdmins(workspace));
    	result.addAll(getMembers(workspace));
    	return result;
    }
    
    public List<User> getAdmins(Workspace workspace){
    	List<User> result = new ArrayList();
    	Criteria cr1 = getSession().createCriteria(Admin.class);
    	cr1.add(Restrictions.eq("workspace",workspace));
    	List<Admin> tempa = cr1.list();
    	for(Admin admin : tempa) result.add(admin.getUser());
    	close();
    	return result;
    }
    
    public List<User> getMembers(Workspace workspace){
    	List<User> result = new ArrayList();
    	Criteria cr2 = getSession().createCriteria(Member.class);
    	cr2.add(Restrictions.eq("workspace",workspace));
    	List<Member> tempm = cr2.list();
    	for(Member member : tempm) result.add(member.getUser());
    	close();
    	return result;
    }
    
    public List<Card> getCardsByCardlist(CardList cardlist){
    	Session s = getSession();
    	List<Card> cards;
    	Criteria cr1 = s.createCriteria(Card.class);
    	cr1.add(Restrictions.eq("cardlist",cardlist));
    	cards = cr1.list();
		cards.sort((Card a, Card b) -> a.getId() - b.getId());
    	return cards;
    }
    
    public Map<CardList,List<Card>> getCardlistsByWorkspace(Workspace workspace){
    	Session s = getSession();
    	Map<CardList,List<Card>> listMap = new LinkedHashMap();
    	Criteria cr1 = s.createCriteria(CardList.class);
    	cr1.add(Restrictions.eq("workspace",workspace));
    	List<CardList> lists = cr1.list();
		lists.sort((CardList a, CardList b) -> a.getId() - b.getId());
    	for(CardList cl : lists) {
    		listMap.put(cl, getCardsByCardlist(cl));
    	}
    	close();
    	return listMap;
    }
    
}

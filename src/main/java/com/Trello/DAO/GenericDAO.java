package com.Trello.DAO;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class GenericDAO extends DAO{

    public <T> void save(final T o){
    	Session s = getSession();
		Transaction t = s.beginTransaction();
		s.save(o);
		s.refresh(o);
		
		t.commit();
		close();
    }


    public void delete(final Object object){
    	Session s = getSession();
    	Transaction t = s.beginTransaction();
    	s.delete(object);
    	t.commit();
    	close();
    }

    /***/
    public <T> T get(final Class<T> type, final int id){
    	Session s = getSession();
    	T t =  (T) s.get(type, id);
    	if(!(t==null)) s.refresh(t);
    	close();
    	return t;
    }
    
    /***/
    public <T> void merge(final T o)   {
    	Session s = getSession();
    	Transaction t = s.beginTransaction();
    	s.merge(o);
    	t.commit();
    	close();
    }

    /***/
    public <T> void saveOrUpdate(final T o){
    	Session s = getSession();
    	Transaction t = s.beginTransaction();
		s.saveOrUpdate(o);
		t.commit();
		close();
    }

    public <T> List<T> getAll(final Class<T> type) {
    	Session s = getSession();
    	final Criteria crit = s.createCriteria(type);
    	close();
    	return crit.list();
    }
}

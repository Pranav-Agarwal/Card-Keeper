package com.Trello.DAO;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;

public class GenericDAO extends DAO{

    public <T> void save(final T o){
		beginTransaction();
		getSession().save(o);
		commit();
    }


    public void delete(final Object object){
    	beginTransaction();
    	getSession().delete(object);
    	commit();
    }

    /***/
    public <T> T get(final Class<T> type, final int id){
    	return (T) getSession().get(type, id);
    }
    
    /***/
    public <T> void merge(final T o)   {
    	beginTransaction();
    	getSession().merge(o);
    	commit();
    }

    /***/
    public <T> void saveOrUpdate(final T o){
    	beginTransaction();
		getSession().saveOrUpdate(o);
		commit();
    }

    public <T> List<T> getAll(final Class<T> type) {
    	final Session session = getSession();
    	final Criteria crit = session.createCriteria(type);
    	return crit.list();
    }
}

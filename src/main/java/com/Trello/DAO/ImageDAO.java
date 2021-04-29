package com.Trello.DAO;


import org.springframework.core.convert.converter.Converter;

import com.Trello.pojo.WorkspaceBg;

public class ImageDAO extends DAO implements Converter<String, WorkspaceBg> {
	
  public WorkspaceBg convert(String source) {
	  WorkspaceBg image;
	  image = getSession().get(WorkspaceBg.class, Integer.parseInt(source));
	  return image;
  }
}

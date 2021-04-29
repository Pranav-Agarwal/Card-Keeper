package com.Trello.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity(name="workspacebg")
public class WorkspaceBg {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
    
	@Column(name = "filename")
	private String filename;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

}

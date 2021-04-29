package com.Trello.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity(name="workspace")
public class Workspace {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name="name")
	private String name;

	@Column(name="description")
	private String description;
		
    @ManyToOne
    @JoinColumn(name="bg_id", nullable=true)
	private WorkspaceBg workspaceBg;
	
	public WorkspaceBg getWorkspaceBg() {
		return workspaceBg;
	}

	public void setWorkspaceBg(WorkspaceBg workspaceBg) {
		this.workspaceBg = workspaceBg;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	
	
	
}

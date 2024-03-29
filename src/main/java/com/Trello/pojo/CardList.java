package com.Trello.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity(name="cardlist")
public class CardList {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
    @ManyToOne
    @JoinColumn(name="workspace_id", nullable=false)
	private Workspace workspace;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	@Column(name="name")
	private String name;
	
	public Workspace getWorkspace() {
		return workspace;
	}
	public void setWorkspace(Workspace workspace) {
		this.workspace = workspace;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}

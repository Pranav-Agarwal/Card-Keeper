package com.Trello.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity(name="invite")
public class Invite {
	
	public static enum Status{
		PENDING,
		ACCEPTED,
		REJECTED
	}
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
    @ManyToOne
    @JoinColumn(name="sender_id", nullable=false)
	private User sender;
    @ManyToOne
    @JoinColumn(name="recipient_id", nullable=false)
	private User recipient;
    @ManyToOne
    @JoinColumn(name="workspace_id", nullable=false)
	private Workspace workspace;
	@Column(name = "status")
	@Enumerated(EnumType.STRING)
	private Status status;
	@Column(name = "isadmininvite")
	private Boolean isAdminInvite;
	
	private void reject() {
		status = Status.REJECTED;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public User getSender() {
		return sender;
	}

	public void setSender(User sender) {
		this.sender = sender;
	}

	public User getRecipient() {
		return recipient;
	}

	public void setRecipient(User recipient) {
		this.recipient = recipient;
	}

	public Workspace getWorkspace() {
		return workspace;
	}

	public void setWorkspace(Workspace workspace) {
		this.workspace = workspace;
	}

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public Boolean getIsAdminInvite() {
		return isAdminInvite;
	}

	public void setIsAdminInvite(Boolean isAdminInvite) {
		this.isAdminInvite = isAdminInvite;
	}
	
	
	
	

}

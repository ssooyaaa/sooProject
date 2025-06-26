package com.my.diary_admin.vo;

public class TransportComment {

	private int transport_comment_idx=0;
	private int transport_idx=0;
	private String nickname=null;
	private String transport_comment=null;
	private int user_idx=0;
	
	
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public int getTransport_comment_idx() {
		return transport_comment_idx;
	}
	public void setTransport_comment_idx(int transport_comment_idx) {
		this.transport_comment_idx = transport_comment_idx;
	}
	public int getTransport_idx() {
		return transport_idx;
	}
	public void setTransport_idx(int transport_idx) {
		this.transport_idx = transport_idx;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getTransport_comment() {
		return transport_comment;
	}
	public void setTransport_comment(String transport_comment) {
		this.transport_comment = transport_comment;
	}
	
	
}

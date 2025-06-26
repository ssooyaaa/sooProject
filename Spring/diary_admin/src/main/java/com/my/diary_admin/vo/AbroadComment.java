package com.my.diary_admin.vo;

public class AbroadComment {
	
	private int abroad_comment_idx=0;
	private int abroad_idx=0;
	private String nickname=null;
	private String abroad_comment=null;
	private int user_idx=0;
	
	
	
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public int getAbroad_comment_idx() {
		return abroad_comment_idx;
	}
	public void setAbroad_comment_idx(int abroad_comment_idx) {
		this.abroad_comment_idx = abroad_comment_idx;
	}
	public int getAbroad_idx() {
		return abroad_idx;
	}
	public void setAbroad_idx(int abroad_idx) {
		this.abroad_idx = abroad_idx;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getAbroad_comment() {
		return abroad_comment;
	}
	public void setAbroad_comment(String abroad_comment) {
		this.abroad_comment = abroad_comment;
	}
	

}

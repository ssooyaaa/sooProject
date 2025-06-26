package com.my.diary_admin.vo;

public class EatComment {

	private int eat_comment_idx=0;
	private int eat_idx=0;
	private String nickname=null;
	private String eat_comment=null;
	private int user_idx=0;
	
	
	
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public int getEat_comment_idx() {
		return eat_comment_idx;
	}
	public void setEat_comment_idx(int eat_comment_idx) {
		this.eat_comment_idx = eat_comment_idx;
	}
	public int getEat_idx() {
		return eat_idx;
	}
	public void setEat_idx(int eat_idx) {
		this.eat_idx = eat_idx;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEat_comment() {
		return eat_comment;
	}
	public void setEat_comment(String eat_comment) {
		this.eat_comment = eat_comment;
	}
	
}


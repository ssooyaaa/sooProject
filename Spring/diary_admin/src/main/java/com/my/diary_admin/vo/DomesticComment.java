package com.my.diary_admin.vo;

public class DomesticComment {

	private int domestic_comment_idx=0;
	private int domestic_idx=0;
	private String nickname=null;
	private String domestic_comment=null;
	private int user_idx=0;
	
	
	
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public int getDomestic_comment_idx() {
		return domestic_comment_idx;
	}
	public void setDomestic_comment_idx(int domestic_comment_idx) {
		this.domestic_comment_idx = domestic_comment_idx;
	}
	public int getDomestic_idx() {
		return domestic_idx;
	}
	public void setDomestic_idx(int domestic_idx) {
		this.domestic_idx = domestic_idx;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getDomestic_comment() {
		return domestic_comment;
	}
	public void setDomestic_comment(String domestic_comment) {
		this.domestic_comment = domestic_comment;
	}
	
	
}

package com.my.diary_admin.vo;

public class AccomodationComment {

	private int accomodation_comment_idx=0;
	private int accomodation_idx=0;
	private String nickname=null;
	private String accomodation_comment=null;
	private int user_idx=0;
	
	
	
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public int getAccomodation_comment_idx() {
		return accomodation_comment_idx;
	}
	public void setAccomodation_comment_idx(int accomodation_comment_idx) {
		this.accomodation_comment_idx = accomodation_comment_idx;
	}
	public int getAccomodation_idx() {
		return accomodation_idx;
	}
	public void setAccomodation_idx(int accomodation_idx) {
		this.accomodation_idx = accomodation_idx;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getAccomodation_comment() {
		return accomodation_comment;
	}
	public void setAccomodation_comment(String accomodation_comment) {
		this.accomodation_comment = accomodation_comment;
	}
	
	
	
}

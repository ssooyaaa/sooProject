package com.my.diary.vo;

public class EtcComment {

	private int etc_comment_idx=0;
	private int etc_idx=0;
	private String nickname=null;
	private String etc_comment=null;
	private int user_idx=0;
	
	
	
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public int getEtc_comment_idx() {
		return etc_comment_idx;
	}
	public void setEtc_comment_idx(int etc_comment_idx) {
		this.etc_comment_idx = etc_comment_idx;
	}
	public int getEtc_idx() {
		return etc_idx;
	}
	public void setEtc_idx(int etc_idx) {
		this.etc_idx = etc_idx;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEtc_comment() {
		return etc_comment;
	}
	public void setEtc_comment(String etc_comment) {
		this.etc_comment = etc_comment;
	}
	
}

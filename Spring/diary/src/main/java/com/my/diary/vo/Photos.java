package com.my.diary.vo;

import java.util.List;

public class Photos {
	
	private int photos_idx=0;
	private int mydiary_idx=0;
	private String photos=null;
	private int sequence=0;
	
	//photos_desc
	private String explain_text=null;

	
	public int getPhotos_idx() {
		return photos_idx;
	}
	public void setPhotos_idx(int photos_idx) {
		this.photos_idx = photos_idx;
	}
	public int getMydiary_idx() {
		return mydiary_idx;
	}
	public void setMydiary_idx(int mydiary_idx) {
		this.mydiary_idx = mydiary_idx;
	}
	public String getPhotos() {
		return photos;
	}
	public void setPhotos(String photo) {
		this.photos = photo;
	}
	
	public int getSequence() {
		return sequence;
	}
	public void setSequence(int sequence) {
		this.sequence = sequence;
	}
	public String getExplain_text() {
		return explain_text;
	}
	public void setExplain_text(String explain_text) {
		this.explain_text = explain_text;
	}
	
	
}

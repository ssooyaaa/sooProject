package com.my.diary.vo;

public class PhotosDesc {

	private int photos_desc_idx=0;
	private int mydiary_idx=0;
	private int sequence=0;
	private String explain_text=null;
	
	
	public int getPhotos_desc_idx() {
		return photos_desc_idx;
	}
	public void setPhotos_desc_idx(int photos_desc_idx) {
		this.photos_desc_idx = photos_desc_idx;
	}
	public int getMydiary_idx() {
		return mydiary_idx;
	}
	public void setMydiary_idx(int mydiary_idx) {
		this.mydiary_idx = mydiary_idx;
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

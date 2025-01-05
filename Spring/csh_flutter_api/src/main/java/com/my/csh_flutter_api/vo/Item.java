package com.my.csh_flutter_api.vo;

public class Item {

	private int item_idx=0;
	   private int user_idx=0;
	   private String title=null;
	   private String content=null;
	   private String img_url=null;
	   private String created_date=null;
	   
	   
	   public int getItem_idx() {
	      return item_idx;
	   }
	   public void setItem_idx(int item_idx) {
	      this.item_idx = item_idx;
	   }
	   public int getUser_idx() {
	      return user_idx;
	   }
	   public void setUser_idx(int user_idx) {
	      this.user_idx = user_idx;
	   }
	   public String getTitle() {
	      return title;
	   }
	   public void setTitle(String title) {
	      this.title = title;
	   }
	   public String getContent() {
	      return content;
	   }
	   public void setContent(String content) {
	      this.content = content;
	   }
	   public String getImg_url() {
	      return img_url;
	   }
	   public void setImg_url(String img_url) {
	      this.img_url = img_url;
	   }
	   public String getCreated_date() {
	      return created_date;
	   }
	   public void setCreated_date(String created_date) {
	      this.created_date = created_date;
	   }

}

package com.my.diary_admin.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary_admin.vo.AccomodationComment;

public class AccomodationCommentDao extends SqlSessionDaoSupport{

	public int getAccomComCount() {
		return this.getSqlSession().selectOne("accomodationComment.getAccomComCount");
	}
	
	public List<AccomodationComment> getAccomComAll(HashMap<String, Object> map){
		return this.getSqlSession().selectList("accomodationComment.getAccomComAll",map);
	}
	
	public int delAccomCom(int i) {
		return this.getSqlSession().delete("accomodationComment.delAccomCom",i);
	}
	
	public int getAccomCountByIdx(int i) {
		return this.getSqlSession().selectOne("accomodationComment.getAccomCountByIdx",i);
	}
	
}

package com.my.diary_admin.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary_admin.vo.DomesticComment;

public class DomesticCommentDao extends SqlSessionDaoSupport{
	
	public int getDomComCount() {
		return this.getSqlSession().selectOne("domesticComment.getDomComCount");
	}
	
	public List<DomesticComment> getDomComAll(HashMap<String, Object> map){
		return this.getSqlSession().selectList("domesticComment.getDomComAll",map);
	}
	
	public int delDomCom(int i) {
		return this.getSqlSession().delete("domesticComment.delDomCom",i);
	}
	
	public int getDomCountByIdx(int i) {
		return this.getSqlSession().selectOne("domesticComment.getDomCountByIdx",i);
	}

}

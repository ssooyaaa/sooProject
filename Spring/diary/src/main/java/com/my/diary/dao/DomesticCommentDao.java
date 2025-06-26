package com.my.diary.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary.vo.DomesticComment;
import com.my.diary.vo.TransportComment;

public class DomesticCommentDao extends SqlSessionDaoSupport{

	public List<DomesticComment> getDomCom(int i) {
		return this.getSqlSession().selectList("getDomCom",i);
	}
	
	public int addDomCom(DomesticComment domCom) {
		return this.getSqlSession().insert("addDomCom",domCom);
	}
	
	public int delDomCom(int i) {
		return this.getSqlSession().delete("delDomCom",i);
	}
}

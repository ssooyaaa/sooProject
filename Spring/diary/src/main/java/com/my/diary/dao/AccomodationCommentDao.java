package com.my.diary.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary.vo.AccomodationComment;

public class AccomodationCommentDao extends SqlSessionDaoSupport{
	
	public List<AccomodationComment> getAccomCom(int i) {
		return this.getSqlSession().selectList("getAccomCom",i);
	}
	
	public int addAccomCom(AccomodationComment accomCom) {
		return this.getSqlSession().insert("addAccomCom",accomCom);
	}
	
	public int delAccomCom(int i) {
		return this.getSqlSession().delete("delAccomCom",i);
	}
}

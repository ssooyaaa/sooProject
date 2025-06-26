package com.my.diary.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary.vo.EatComment;

public class EatCommentDao extends SqlSessionDaoSupport{

	public List<EatComment> getEatCom(int i) {
		return this.getSqlSession().selectList("getEatCom",i);
	}
	
	public int addEatCom(EatComment eatCom) {
		return this.getSqlSession().insert("addEatCom",eatCom);
	}
	
	public int delEatCom(int i) {
		return this.getSqlSession().delete("delEatCom",i);
	}
}

package com.my.diary.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary.vo.TransportComment;

public class TransportCommentDao extends SqlSessionDaoSupport {
	
	public List<TransportComment> getTransCom(int i) {
		return this.getSqlSession().selectList("getTransCom",i);
	}
	
	public int addCom(TransportComment transCom) {
		return this.getSqlSession().insert("addCom",transCom);
	}
	
	public int delCom(int i) {
		return this.getSqlSession().delete("delCom",i);
	}
}

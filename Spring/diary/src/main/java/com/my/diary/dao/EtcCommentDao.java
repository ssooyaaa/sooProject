package com.my.diary.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary.vo.EtcComment;

public class EtcCommentDao extends SqlSessionDaoSupport{

	public List<EtcComment> getEtcCom(int i) {
		return this.getSqlSession().selectList("getEtcCom",i);
	}
	
	public int addEtcCom(EtcComment etcCom) {
		return this.getSqlSession().insert("addEtcCom",etcCom);
	}
	
	public int delEtcCom(int i) {
		return this.getSqlSession().delete("delEtcCom",i);
	}
}

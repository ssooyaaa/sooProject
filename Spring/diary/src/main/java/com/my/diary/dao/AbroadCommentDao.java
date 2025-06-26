package com.my.diary.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary.vo.AbroadComment;

public class AbroadCommentDao extends SqlSessionDaoSupport{

	public List<AbroadComment> getAbCom(int i) {
		return this.getSqlSession().selectList("getAbCom",i);
	}
	
	public int addAbCom(AbroadComment abCom) {
		return this.getSqlSession().insert("addAbCom",abCom);
	}
	
	public int delAbCom(int i) {
		return this.getSqlSession().delete("delAbCom",i);
	}
}

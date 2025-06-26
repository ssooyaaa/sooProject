package com.my.diary_admin.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary_admin.vo.TransportComment;

public class TransportCommentDao extends SqlSessionDaoSupport{

	public int getTransComCount() {
		return this.getSqlSession().selectOne("transportComment.getTransComCount");
	}
	
	public List<TransportComment> getTransComAll(HashMap<String, Object> map){
		return this.getSqlSession().selectList("transportComment.getTransComAll",map);
	}
	
	public int delTransCom(int i) {
		return this.getSqlSession().delete("transportComment.delTransCom",i);
	}
	
	public int getTransCountByIdx(int i) {
		return this.getSqlSession().selectOne("transportComment.getTransCountByIdx",i);
	}
}

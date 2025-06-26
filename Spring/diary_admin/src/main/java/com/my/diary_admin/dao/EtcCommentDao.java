package com.my.diary_admin.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary_admin.vo.EtcComment;

public class EtcCommentDao extends SqlSessionDaoSupport{
	
	public int getEtcComCount() {
		return this.getSqlSession().selectOne("etcComment.getEtcComCount");
	}
	
	public List<EtcComment> getEtcComAll(HashMap<String, Object> map){
		return this.getSqlSession().selectList("etcComment.getEtcComAll",map);
	}
	
	public int delEtcCom(int i) {
		return this.getSqlSession().delete("etcComment.delEtcCom",i);
	}
	
	public int getEtcCountByIdx(int i) {
		return this.getSqlSession().selectOne("etcComment.getEtcCountByIdx",i);
	}
}

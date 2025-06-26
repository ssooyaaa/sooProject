package com.my.diary_admin.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary_admin.vo.AbroadComment;

public class AbroadCommentDao extends SqlSessionDaoSupport{

	public int getAbComCount() {
		return this.getSqlSession().selectOne("abroadComment.getAbComCount");
	}
	
	public List<AbroadComment> getAbComAll(HashMap<String, Object> map){
		return this.getSqlSession().selectList("abroadComment.getAbComAll",map);
	}
	
	public int delAbCom(int i) {
		return this.getSqlSession().delete("abroadComment.delAbCom",i);
	}
	
	public int getAbCountByIdx(int i) {
		return this.getSqlSession().selectOne("abroadComment.getAbCountByIdx",i);
	}
	
}

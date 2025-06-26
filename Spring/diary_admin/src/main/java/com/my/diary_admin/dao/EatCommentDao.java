package com.my.diary_admin.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary_admin.vo.EatComment;

public class EatCommentDao extends SqlSessionDaoSupport {

	public int getEatComCount() {
		return this.getSqlSession().selectOne("eatComment.getEatComCount");
	}
	
	public List<EatComment> getEatComAll(HashMap<String, Object> map){
		return this.getSqlSession().selectList("eatComment.getEatComAll",map);
	}
	
	public int delEatCom(int i) {
		return this.getSqlSession().delete("eatComment.delEatCom",i);
	}
	
	public int getEatCountByIdx(int i) {
		return this.getSqlSession().selectOne("eatComment.getEatCountByIdx",i);
	}
	
}

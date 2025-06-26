package com.my.diary_admin.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary_admin.vo.Eat;
import com.my.diary_admin.vo.Transport;

public class EatDao extends SqlSessionDaoSupport{

	public int getEatCount() {
		return this.getSqlSession().selectOne("eat.getEatCount");
	}
	
	public List<Eat> getEatAll(HashMap<String,Object> map){
		return this.getSqlSession().selectList("eat.getEatAll",map);
	}
	
	public int getEatCountAfterSch(int i) {
		return this.getSqlSession().selectOne("eat.getEatCountAfterSch",i);
	}
	
	public List<Eat> getEatChunkAfterSch(HashMap<String,Object> map){
		return this.getSqlSession().selectList("eat.getEatChunkAfterSch",map);
	}
	
	public int delEat(Eat eat) {
		return this.getSqlSession().delete("eat.delEat",eat);
	}
	
	public Eat getEatForUp(int i) {
		return this.getSqlSession().selectOne("eat.getEatForUp",i);
	}
	
	public int updateEat(Eat eat) {
		return this.getSqlSession().update("eat.updateEat",eat);
	}
}

package com.my.diary.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary.vo.Eat;
import com.my.diary.vo.Eat;

public class EatDao extends SqlSessionDaoSupport{
	
	public int addEat(Eat eat) {
		return this.getSqlSession().insert("eat.addEat",eat);
	}
	
	public int getEatCount() {
		return this.getSqlSession().selectOne("eat.getEatCount");
	}
	
	public List<Eat> getEatAll(HashMap<String,Object> map){
		return this.getSqlSession().selectList("eat.getEatAll",map);
	}
	
	public List<Eat> getEatByIdx(Eat eat) {
		return this.getSqlSession().selectList("eat.getEatByIdx", eat);
	}
	
	public int getEatCountAfterSch(Eat eat) {
		return this.getSqlSession().selectOne("eat.getEatCountAfterSch",eat);
	}
	
	public List<Eat> getEatChunkAfterSch(HashMap<String,Object> map){
		return this.getSqlSession().selectList("eat.getEatChunkAfterSch",map);
	}
	
	public int delEat(Eat eat) {
		return this.getSqlSession().delete("eat.delEat",eat);
	}
	
	public Eat getEatForCom(int i) {
		return this.getSqlSession().selectOne("eat.getEatForCom",i);
	}

}

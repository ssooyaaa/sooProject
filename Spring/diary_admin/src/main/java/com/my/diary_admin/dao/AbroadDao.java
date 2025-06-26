package com.my.diary_admin.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary_admin.vo.Abroad;

public class AbroadDao extends SqlSessionDaoSupport{

	public int getAbroadCount() {
		return this.getSqlSession().selectOne("abroad.getAbroadCount");
	}
	
	public List<Abroad> getAbroadAll(HashMap<String,Object> map){
		return this.getSqlSession().selectList("abroad.getAbroadAll", map);
	}
	
	public int getAbroadCountAfterSch(int i) {
		return this.getSqlSession().selectOne("abroad.getAbroadCountAfterSch",i);
	}
	
	public List<Abroad> getAbroadChunkAfterSch(HashMap<String,Object> map){
		return this.getSqlSession().selectList("abroad.getAbroadChunkAfterSch",map);
	}
	
	public int delAbroad(Abroad abroad) {
		return this.getSqlSession().delete("abroad.delAbroad",abroad);
	}
	
	public Abroad getAbForUp(int i) {
		return this.getSqlSession().selectOne("abroad.getAbForUp",i);
	}
	
	public int updateAb(Abroad ab) {
		return this.getSqlSession().update("abroad.updateAb",ab);
	}
	
}

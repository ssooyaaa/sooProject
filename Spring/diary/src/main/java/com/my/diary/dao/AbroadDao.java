package com.my.diary.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary.vo.Abroad;
import com.my.diary.vo.Domestic;
import com.my.diary.vo.Eat;

public class AbroadDao extends SqlSessionDaoSupport {

	public int addAbroad(Abroad abroad) {
		return this.getSqlSession().insert("abroad.addAbroad",abroad);
	}
	
	public int getAbroadCount() {
		return this.getSqlSession().selectOne("abroad.getAbroadCount");
	}
	
	public List<Abroad> getAbroadAll(HashMap<String,Object> map){
		return this.getSqlSession().selectList("abroad.getAbroadAll", map);
	}
	
	public List<Abroad> getAbroadPics(){
		return this.getSqlSession().selectList("abroad.getAbroadPics");
	}
	
	public Abroad getAbroadByIdx(Abroad abroad){
		return this.getSqlSession().selectOne("abroad.getAbroadByIdx",abroad);
	}
	
	public int getAbroadCountAfterSch(Abroad abroad) {
		return this.getSqlSession().selectOne("abroad.getAbroadCountAfterSch",abroad);
	}
	
	public List<Abroad> getAbroadChunkAfterSch(HashMap<String,Object> map){
		return this.getSqlSession().selectList("abroad.getAbroadChunkAfterSch",map);
	}
	
	public int delAbroad(Abroad abroad) {
		return this.getSqlSession().delete("abroad.delAbroad",abroad);
	}
	
	public Abroad getAbForCom(int i) {
		return this.getSqlSession().selectOne("abroad.getAbForCom",i);
	}
}

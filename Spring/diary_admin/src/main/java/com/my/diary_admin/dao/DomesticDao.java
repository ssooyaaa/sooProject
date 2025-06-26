package com.my.diary_admin.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary_admin.vo.Domestic;

public class DomesticDao extends SqlSessionDaoSupport {

	public int getDomesticCount() {
		return this.getSqlSession().selectOne("domestic.getDomesticCount");
	}
	
	public List<Domestic> getDomesticAll(HashMap<String,Object> map){
		return this.getSqlSession().selectList("domestic.getDomesticAll", map);
	}
	
	public int getDomCountAfterSch(int i) {
		return this.getSqlSession().selectOne("domestic.getDomCountAfterSch",i);
	}
	
	public List<Domestic> getDomChunkAfterSch(HashMap<String,Object> map){
		return this.getSqlSession().selectList("domestic.getDomChunkAfterSch",map);
	}
	
	public int delDomestic(Domestic dom) {
		return this.getSqlSession().delete("domestic.delDomestic",dom);
	}
	
	public Domestic getDomForUp(int i) {
		return this.getSqlSession().selectOne("domestic.getDomForUp",i);
	}
	
	public int updateDom(Domestic dom) {
		return this.getSqlSession().update("domestic.updateDom",dom);
	}
}

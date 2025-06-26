package com.my.diary.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary.vo.Abroad;
import com.my.diary.vo.Domestic;
import com.my.diary.vo.Eat;
import com.my.diary.vo.Transport;

public class DomesticDao extends SqlSessionDaoSupport{
	
	public int addDomestic(Domestic domestic) {
		return this.getSqlSession().insert("domestic.addDomestic",domestic);
	}
	
	public int getDomesticCount() {
		return this.getSqlSession().selectOne("domestic.getDomesticCount");
	}
	
	public List<Domestic> getDomesticAll(HashMap<String,Object> map){
		return this.getSqlSession().selectList("domestic.getDomesticAll", map);
	}

	public List<Domestic> getDomesticPics() {
		return this.getSqlSession().selectList("domestic.getDomesticPics");
	}
	
	public Domestic getDomesticByIdx(Domestic domestic){
		return this.getSqlSession().selectOne("domestic.getDomesticByIdx",domestic);
	}
	
	public int getDomCountAfterSch(Domestic dom) {
		return this.getSqlSession().selectOne("domestic.getDomCountAfterSch",dom);
	}
	
	public List<Domestic> getDomChunkAfterSch(HashMap<String,Object> map){
		return this.getSqlSession().selectList("domestic.getDomChunkAfterSch",map);
	}
	
	public Domestic getDomForCom(int i) {
		return this.getSqlSession().selectOne("domestic.getDomForCom",i);
	}
	
	public int delDomestic(Domestic dom) {
		return this.getSqlSession().delete("domestic.delDomestic",dom);
	}
}

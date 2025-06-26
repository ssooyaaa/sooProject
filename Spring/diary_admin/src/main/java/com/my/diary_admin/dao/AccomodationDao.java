package com.my.diary_admin.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary_admin.vo.Accomodation;
import com.my.diary_admin.vo.Transport;

public class AccomodationDao extends SqlSessionDaoSupport{

	public int getAccomodationCount() {
		return this.getSqlSession().selectOne("accomodation.getAccomodationCount");
	}
	
	public List<Accomodation> getAccomodationAll(HashMap<String, Object> map){
		return this.getSqlSession().selectList("accomodation.getAccomodationAll", map); 
	}
	
	public int delAccom(Accomodation accom) {
		return this.getSqlSession().delete("accomodation.delAccom",accom);
	}
	
	public int getAccomCountAfterSch(int i) {
		return this.getSqlSession().selectOne("accomodation.getAccomCountAfterSch",i);
	}
	
	public List<Accomodation> getAccomChunkAfterSch(HashMap<String,Object> map){
		return this.getSqlSession().selectList("accomodation.getAccomChunkAfterSch",map);
	}
	
	public Accomodation getAccomForUp(int i) {
		return this.getSqlSession().selectOne("accomodation.getAccomForUp",i);
	}
	
	public int updateAccom(Accomodation accom) {
		return this.getSqlSession().update("accomodation.updateAccom",accom);
	}
	
}

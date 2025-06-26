package com.my.diary.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary.vo.Accomodation;
import com.my.diary.vo.Transport;

public class AccomodationDao extends SqlSessionDaoSupport{

	public int addAccomodation(Accomodation accomodation) {
		return this.getSqlSession().insert("accomodation.addAccomodation",accomodation);
	}
	
	public int getAccomodationCount() {
		return this.getSqlSession().selectOne("accomodation.getAccomodationCount");
	}
	
	public List<Accomodation> getAccomodationAll(HashMap<String, Object> map){
		return this.getSqlSession().selectList("accomodation.getAccomodationAll", map); 
	}
	
	public List<Accomodation> getAccomByIdx(Accomodation accomodation) {
		return this.getSqlSession().selectList("accomodation.getAccomByIdx", accomodation);
	}
	
	public int getAccomCountAfterSch(Accomodation accom) {
		return this.getSqlSession().selectOne("accomodation.getAccomCountAfterSch",accom);
	}
	
	public List<Accomodation> getAccomChunkAfterSch(HashMap<String,Object> map){
		return this.getSqlSession().selectList("accomodation.getAccomChunkAfterSch",map);
	}
	
	public int delAccomodation(Accomodation accom) {
		return this.getSqlSession().delete("accomodation.delAccomodation", accom);
	}
	
	public Accomodation getAccomForCom(int i) {
		return this.getSqlSession().selectOne("accomodation.getAccomForCom",i);
	}
}

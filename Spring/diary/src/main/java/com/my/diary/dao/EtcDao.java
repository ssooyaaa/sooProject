package com.my.diary.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary.vo.Eat;
import com.my.diary.vo.Etc;
import com.my.diary.vo.Transport;

public class EtcDao extends SqlSessionDaoSupport{

	public int addEtc(Etc etc) {
		return this.getSqlSession().insert("etc.addEtc", etc);
	}
	
	public int getEtcCount() {
		return this.getSqlSession().selectOne("etc.getEtcCount");
	}
	
	public List<Etc> getEtcAll(HashMap<String,Object> map){
		return this.getSqlSession().selectList("etc.getEtcAll",map);
	}
	
	public List<Etc> getEtcByIdx(Etc etc) {
		return this.getSqlSession().selectList("etc.getEtcByIdx", etc);
	}
	
	public int getEtcCountAfterSch(Etc etc) {
		return this.getSqlSession().selectOne("etc.getEtcCountAfterSch",etc);
	}
	
	public List<Etc> getEtcChunkAfterSch(HashMap<String,Object> map){
		return this.getSqlSession().selectList("etc.getEtcChunkAfterSch",map);
	}
	
	public int delEtc(Etc etc) {
		return this.getSqlSession().delete("etc.delEtc",etc);
	}
	
	public Etc getEtcForCom(int i) {
		return this.getSqlSession().selectOne("etc.getEtcForCom",i);
	}
	
}

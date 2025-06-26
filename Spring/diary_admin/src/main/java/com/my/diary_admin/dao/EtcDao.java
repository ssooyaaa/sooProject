package com.my.diary_admin.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary_admin.vo.Etc;
import com.my.diary_admin.vo.Transport;

public class EtcDao extends SqlSessionDaoSupport{

	public int getEtcCount() {
		return this.getSqlSession().selectOne("etc.getEtcCount");
	}
	
	public List<Etc> getEtcAll(HashMap<String,Object> map){
		return this.getSqlSession().selectList("etc.getEtcAll",map);
	}
	
	public int getEtcCountAfterSch(int i) {
		return this.getSqlSession().selectOne("etc.getEtcCountAfterSch",i);
	}
	
	public List<Etc> getEtcChunkAfterSch(HashMap<String,Object> map){
		return this.getSqlSession().selectList("etc.getEtcChunkAfterSch",map);
	}
	
	public int delEtc(Etc etc) {
		return this.getSqlSession().delete("etc.delEtc",etc);
	}
	
	public Etc getEtcForUp(int i) {
		return this.getSqlSession().selectOne("etc.getEtcForUp",i);
	}
	
	public int updateEtc(Etc etc) {
		return this.getSqlSession().update("etc.updateEtc",etc);
	}
}

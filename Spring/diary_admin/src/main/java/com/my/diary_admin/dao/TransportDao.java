package com.my.diary_admin.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary_admin.vo.Transport;

public class TransportDao extends SqlSessionDaoSupport{

	public int getTransportCount() {
		return this.getSqlSession().selectOne("transport.getTransportCount");
	}
	
	public List<Transport> getTransportAll(HashMap<String, Object> map) {
		return this.getSqlSession().selectList("transport.getTransportAll",map);
	}
	
	public int delTrans(Transport trans) {
		return this.getSqlSession().delete("transport.delTrans",trans);
	}
	
	public int getTransCountAfterSch(int i) {
		return this.getSqlSession().selectOne("transport.getTransCountAfterSch",i);
	}
	
	public List<Transport> getTransChunkAfterSch(HashMap<String,Object> map){
		return this.getSqlSession().selectList("transport.getTransChunkAfterSch",map);
	}
	
	public Transport getTransForUp(int i) {
		return this.getSqlSession().selectOne("transport.getTransForUp",i);
	}
	
	public int updateTrans(Transport trans) {
		return this.getSqlSession().update("transport.updateTrans",trans);
	}
}

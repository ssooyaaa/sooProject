package com.my.diary.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary.vo.Mydiary;
import com.my.diary.vo.Transport;

public class TransportDao extends SqlSessionDaoSupport{
	
	public int addTransport(Transport transport) {
		return this.getSqlSession().insert("transport.addTransport",transport);
	}
	
	public int getTransportCount() {
		return this.getSqlSession().selectOne("transport.getTransportCount");
	}
	
	public List<Transport> getTransportAll(HashMap<String, Object> map) {
		return this.getSqlSession().selectList("transport.getTransportAll",map);
	}

	public List<Transport> getTransByIdx(Transport transport) {
		return this.getSqlSession().selectList("transport.getTransByIdx", transport);
	}
	
	public int getTransCountAfterSch(Transport trans) {
		return this.getSqlSession().selectOne("transport.getTransCountAfterSch",trans);
	}
	
	public List<Transport> getTransChunkAfterSch(HashMap<String,Object> map){
		return this.getSqlSession().selectList("transport.getTransChunkAfterSch",map);
	}
	
	
	public int delTransport(Transport trans) {
		return this.getSqlSession().delete("transport.delTransport",trans);
	}
	
	public Transport getTransForCom(int i) {
		return this.getSqlSession().selectOne("transport.getTransForCom",i);
	}

}

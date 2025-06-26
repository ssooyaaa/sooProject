package com.my.diary_admin.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary_admin.vo.Phreport;

public class PhreportDao extends SqlSessionDaoSupport{

	public int getPhotosCount() {
		return this.getSqlSession().selectOne("phreport.getPhotosCount");
	}
	
	public List<Phreport> getPhotosAll(HashMap<String,Object> map) {
		return this.getSqlSession().selectList("phreport.getPhotosAll",map);
	}
	
	public int updateCheck(int i) {
		return this.getSqlSession().update("phreport.updateCheck",i);
	}
	
	public int returnCheck(int i) {
		return this.getSqlSession().update("phreport.returnCheck",i);
	}
}

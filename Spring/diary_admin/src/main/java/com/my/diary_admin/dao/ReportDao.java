package com.my.diary_admin.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary_admin.vo.Report;

public class ReportDao extends SqlSessionDaoSupport{

	public int getTipsCount() {
		return this.getSqlSession().selectOne("report.getTipsCount");
	}
	
	public List<Report> getTipsAll(HashMap<String,Object> map) {
		return this.getSqlSession().selectList("report.getTipsAll",map);
	}
	
	public int updateCheck(int i) {
		return this.getSqlSession().update("report.updateCheck",i);
	}
	
	public int returnCheck(int i) {
		return this.getSqlSession().update("report.returnCheck",i);
	}
}

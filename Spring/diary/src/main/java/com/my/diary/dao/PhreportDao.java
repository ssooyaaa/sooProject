package com.my.diary.dao;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary.vo.Phreport;

public class PhreportDao extends SqlSessionDaoSupport{
	
	public int addPhreport(Phreport ph) {
		return this.getSqlSession().insert("phreport.addPhreport",ph);
	}

}

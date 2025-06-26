package com.my.diary.dao;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary.vo.Report;

public class ReportDao extends SqlSessionDaoSupport{

	public int addReport(Report report) {
		return this.getSqlSession().insert("report.addReport",report);
	}
}

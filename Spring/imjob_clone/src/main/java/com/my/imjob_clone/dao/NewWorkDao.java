package com.my.imjob_clone.dao;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.imjob_clone.vo.NewWork;

public class NewWorkDao extends SqlSessionDaoSupport{
	
	public int addNewWork(NewWork newwork) {
		return this.getSqlSession().insert("newWork.addNewWork",newwork);
	}

}

package com.my.imjob_clone.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.imjob_clone.vo.Project;

public class ProjectDao extends SqlSessionDaoSupport{
	
	public int getCount() {
		return this.getSqlSession().selectOne("project.getCount");
	}
	
	public List<Project> getProjectAll(HashMap<String,Object> map){
		return this.getSqlSession().selectList("project.getProjectAll",map);
	}
	
	public Project getProjectByIdx(int i) {
		return this.getSqlSession().selectOne("project.getProjectByIdx",i);
	}

	
	public int searchProjectCount(HashMap<String, Object> map){
		return this.getSqlSession().selectOne("project.searchProjectCount",map);
	}
	
	public List<Project> searchProjectList(HashMap<String,Object> map){
		return this.getSqlSession().selectList("project.searchProjectList",map);
	}
	
	public int getCheckedCount(String s) {
		return this.getSqlSession().selectOne("project.getCheckedCount",s);
	}
	
	public List<Project> getCheckedAll(HashMap<String, Object> map){
		return this.getSqlSession().selectList("project.getCheckedAll",map);
	}
}

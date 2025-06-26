package com.my.imjob_clone.dao;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.imjob_clone.vo.User;

public class UserDao extends SqlSessionDaoSupport{

	public int addUser(User user) {
		return this.getSqlSession().insert("user.addUser",user);
	}
	
	public User idCheck(String id) {
		return this.getSqlSession().selectOne("user.idCheck",id);
	}
	
	public User login(User user) {
		return this.getSqlSession().selectOne("user.login",user);
	}
	
	public String searchId(User user) {
		return this.getSqlSession().selectOne("user.searchId",user);
	}
	
	public String searchPw(User user) {
		return this.getSqlSession().selectOne("user.searchPw",user);
	}
	
	public int updatePw(User user) {
		return this.getSqlSession().update("user.updatePw",user);
	}
}


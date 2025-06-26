package com.my.diary.dao;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary.vo.User;

public class UserDao extends SqlSessionDaoSupport{
	
	public int addUser(User user) {
		return this.getSqlSession().insert("user.addUser",user);
	}
	
	public User getUserById(User user) {
		return this.getSqlSession().selectOne("user.getUserById",user);
	}
	
	public User getUserByNick(User user) {
		return this.getSqlSession().selectOne("user.getUserByNick",user);
	}
	
	public User getUserByIdAndPw(User user) {
		return this.getSqlSession().selectOne("user.getUserByIdAndPw",user);
	}
	
	public int deleteUser(User user) {
		return this.getSqlSession().update("user.deleteUser",user);
	}
	
}

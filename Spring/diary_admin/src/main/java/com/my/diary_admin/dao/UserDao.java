package com.my.diary_admin.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.my.diary_admin.vo.User;

public class UserDao extends SqlSessionDaoSupport {
	
	public int getUserCount() {
		return this.getSqlSession().selectOne("user.getUserCount");
	}
	
	public List<User> getUserAll(HashMap<String,Object>map){
		return this.getSqlSession().selectList("user.getUserAll",map);
	}
	
	public int delUser(User user) {
		return this.getSqlSession().delete("user.delUser",user);
	}
	
	public int addAdmin(User user) {
		return this.getSqlSession().insert("user.addAdmin",user);
	}
	
	public User getUserById(User user) {
		return this.getSqlSession().selectOne("user.getUserById",user);
	}
	
	public User getAdminByIdAndPw(User user) {
		return this.getSqlSession().selectOne("user.getAdminByIdAndPw",user);
	}

}

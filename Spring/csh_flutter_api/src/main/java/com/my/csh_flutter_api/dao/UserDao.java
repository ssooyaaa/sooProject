package com.my.csh_flutter_api.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.my.csh_flutter_api.vo.User;

@Repository
public class UserDao {

	@Autowired
	SqlSession s;
	
	public int save(User user) {
		return s.insert("UserMapper.save", user);
	}
	
	
	public User findByIdAndPw(User user) {
		return s.selectOne("UserMapper.findByIdAndPw", user);
	}
	
	public User findByIdx(int idx) {
		return s.selectOne("UserMapper.findByIdx", idx);
	}
}

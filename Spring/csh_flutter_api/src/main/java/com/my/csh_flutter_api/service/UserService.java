package com.my.csh_flutter_api.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.csh_flutter_api.dao.UserDao;
import com.my.csh_flutter_api.vo.User;

@Service
public class UserService {

	@Autowired
	UserDao userDao;
	
	public int save(User user) {
		return userDao.save(user);
	}
	
	
	public User findByIdAndPw(User user) {
		return userDao.findByIdAndPw(user);
	}
}

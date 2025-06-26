package com.my.diary_admin.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;



public class MydiaryDao extends SqlSessionDaoSupport{

	public int getDiaryCount(int user_idx) {
		return this.getSqlSession().selectOne("mydiary.getDiaryCount", user_idx);
	}
	
}

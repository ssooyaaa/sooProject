package com.my.diary.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.diary.vo.Mydiary;
import com.my.diary.vo.User;

public class MydiaryDao extends SqlSessionDaoSupport{

	public int addMydiary(Mydiary mydiary) {
		return this.getSqlSession().insert("mydiary.addMydiary",mydiary);
	}
	
	public int getCount(int user_idx) {
		return this.getSqlSession().selectOne("mydiary.getCount", user_idx);
	}
	
	public List<Mydiary> getMydiaryChunk(HashMap<String, Object> map){
		return this.getSqlSession().selectList("mydiary.getMydiaryChunk",map);
	}
	
	public Mydiary getMydiaryByIdx(Mydiary mydiary) {
		return this.getSqlSession().selectOne("mydiary.getMydiaryByIdx", mydiary);
	}
	
	public int getCountAfterSearch(HashMap<String,Object> map){
		return this.getSqlSession().selectOne("mydiary.getCountAfterSearch",map);
	}
	
	public List<Mydiary> getMydiaryChunkAfterSearch(HashMap<String, Object> map){
		return this.getSqlSession().selectList("mydiary.getMydiaryChunkAfterSearch",map);
	}
	
	public int delMydiary(Mydiary my) {
		return this.getSqlSession().delete("mydiary.delMydiary",my);
	}
	
	public List<Mydiary> getNation(int i){
		return this.getSqlSession().selectList("mydiary.getNation",i);
	}

			
}

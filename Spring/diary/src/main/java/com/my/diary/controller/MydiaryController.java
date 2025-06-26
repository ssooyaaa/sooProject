package com.my.diary.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.diary.dao.MydiaryDao;
import com.my.diary.vo.Mydiary;
import com.my.diary.vo.User;

@Controller
@RequestMapping(value="/mydiary")
public class MydiaryController {

	@Resource(name="MydiaryDao")
	private MydiaryDao mydiaryDao;
	
	
	//다이어리작성 총 개수
	@RequestMapping(value="/getCount", method=RequestMethod.GET)
	public @ResponseBody int getCount(HttpSession session) {
		
		User loginUser = (User)session.getAttribute("loginUser");
		Integer loginUserIdx = loginUser.getUser_idx();
		
		int count = mydiaryDao.getCount(loginUserIdx);
				
		return count;
	}
	
	
	//다이어리 보여주기
	@RequestMapping(value="/getMydiaryChunk", method=RequestMethod.GET)
	public @ResponseBody List<Mydiary> getMydiaryChunk(
				@RequestParam(value="start") int start,
				@RequestParam(value="cnt") int cnt,
				HttpSession session
			) {
		
		User loginUser = (User)session.getAttribute("loginUser");
		int loginUserIdx = loginUser.getUser_idx();
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("user_idx", loginUserIdx);
		map.put("start", start);
		map.put("cnt", cnt);
		
		List<Mydiary> mydiaryList = mydiaryDao.getMydiaryChunk(map);
		
		return mydiaryList;
		
	}
	

	//다이어리 검색-개수
	@RequestMapping(value="/getCountAfterSearch", method=RequestMethod.GET)
	public @ResponseBody int getCountAfterSearch(
				@RequestParam(value="nation") String nation,
				HttpSession session
			) {
		
		User loginUser = (User)session.getAttribute("loginUser");
		int loginUserIdx = loginUser.getUser_idx();
		
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("nation", nation);
		map.put("user_idx", loginUserIdx);
		
		int count = mydiaryDao.getCountAfterSearch(map);
		return count;
	}
	
	//다이어리 검색-리스트
	@RequestMapping(value="/getMydiaryChunkAfterSearch", method=RequestMethod.GET)
	public @ResponseBody List<Mydiary> getMydiaryChunkAfterSearch(
				@RequestParam(value="nation") String nation,
				@RequestParam(value="start") int start,
				@RequestParam(value="cnt") int cnt,
				HttpSession session
			){
		
		User loginUser = (User)session.getAttribute("loginUser");
		int loginUserIdx = loginUser.getUser_idx();
		
		Mydiary mydiary = new Mydiary();
		mydiary.setNation(nation);
		mydiary.setUser_idx(loginUserIdx);

		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("nation", nation);
		map.put("user_idx", loginUserIdx);
		map.put("start", start);
		map.put("cnt", cnt);
		
		List<Mydiary> list = mydiaryDao.getMydiaryChunkAfterSearch(map);
		
		return list;
		
	}
	
	
	//다이어리더보기-MydiaryDao
	@RequestMapping(value="/getMydiaryByIdx", method=RequestMethod.GET)
	public @ResponseBody Mydiary getMydiaryByIdx(
			@RequestParam(value="mydiary_idx") int mydiary_idx
			) {
		
		Mydiary mydiary = new Mydiary();
		mydiary.setMydiary_idx(mydiary_idx);
		
		Mydiary mydiaryContents = mydiaryDao.getMydiaryByIdx(mydiary);
		
		return mydiaryContents;
	}
	
	
	//Map-마커표시
	@RequestMapping(value="/getNation", method=RequestMethod.GET)
	public @ResponseBody List<Mydiary> getNation(
				@RequestParam(value="user_idx") int user_idx
			){
		
		List<Mydiary> nationList = mydiaryDao.getNation(user_idx);
		
		return nationList;
	}
	
	
	
	
	
}

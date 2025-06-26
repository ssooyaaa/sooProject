package com.my.diary_admin.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.diary_admin.dao.MydiaryDao;

@Controller
@RequestMapping(value="/mydiary")
public class MydiaryController {

	
	@Resource(name="MydiaryDao")
	private MydiaryDao mydiaryDao;
	
	@RequestMapping(value="/getDiaryCount", method = RequestMethod.GET)
	public @ResponseBody int getDiaryCount(
				@RequestParam(value="user_idx") int user_idx
			) {
		
		int count = mydiaryDao.getDiaryCount(user_idx);
		
		return count;
	}
}

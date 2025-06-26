package com.my.imjob_clone.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.imjob_clone.dao.NewWorkDao;
import com.my.imjob_clone.vo.NewWork;

@Controller
@RequestMapping(value="/newWork")
public class NewWorkController {

	
	@Resource(name="NewWorkDao")
	private NewWorkDao newWorkDao;
	
	@RequestMapping(value="/addNewWork", method=RequestMethod.POST)
	public @ResponseBody String addNewWork(
			@RequestParam(value="title") String title,
			@RequestParam(value="company") String company,
			@RequestParam(value="head") String head,
			@RequestParam(value="phone_number") String phone_number,
			@RequestParam(value="number") String number,
			@RequestParam(value="email") String email,
			@RequestParam(value="content") String content
			) {
		
		NewWork newwork = new NewWork();
		newwork.setTitle(title);
		newwork.setCompany(company);
		newwork.setHead(head);
		newwork.setPhone_number(phone_number);
		newwork.setNumber(number);
		newwork.setEmail(email);
		newwork.setContent(content);
		
		newWorkDao.addNewWork(newwork);
		
		return "ok";
	}
	
}

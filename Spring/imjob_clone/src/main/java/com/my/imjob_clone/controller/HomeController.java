package com.my.imjob_clone.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.my.imjob_clone.vo.User;

@Controller
public class HomeController {
	
	void setUserSession(HttpSession s, Model m) {
		User loginUser = (User)s.getAttribute("loginUser");
		m.addAttribute("loginUser", loginUser);
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		
		return "home";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		
		return "login";
	}
	
	@RequestMapping(value ="/membership", method = RequestMethod.GET)
	public String membership() {
		
		return "membership";
	}
	
	@RequestMapping(value="/membershipForm", method=RequestMethod.GET)
	public String membershipForm() {
		
		return "membershipForm";
	}
	
	@RequestMapping(value="/newWork", method=RequestMethod.GET)
	public String newWork() {
		
		return "newWork";
	}
	
	@RequestMapping(value="/projectList", method=RequestMethod.GET)
	public String projectList() {
		
		return "projectList";
	}
	
	@RequestMapping(value="/registerFreelancer", method=RequestMethod.GET)
	public String registerFreelancer() {
		
		return "registerFreelancer";
	}
	
	@RequestMapping(value="/commission", method=RequestMethod.GET)
	public String commission() {
		
		return "commission";
	}
	
	@RequestMapping(value="/findMember", method=RequestMethod.GET)
	public String findMember() {
		
		return "findMember";
	}
	
	@RequestMapping(value="/detail", method=RequestMethod.GET)
	public String detail(
			@RequestParam(value="project_idx") int project_idx,
			Model model
			) {
		
		model.addAttribute("project_idx",project_idx);
		
		return "detail";
	}
	
	@RequestMapping(value="/checkedList" ,method=RequestMethod.GET)
	public String checkedList(
			@RequestParam(value="field") String field,
			Model model
			) {
		
		model.addAttribute("field",field);
		
		return "projectList";
	}
}

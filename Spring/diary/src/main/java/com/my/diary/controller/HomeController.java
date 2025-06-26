package com.my.diary.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.my.diary.vo.User;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	void setUserSession(HttpSession s, Model m) {
		User loginUser = (User)s.getAttribute("loginUser");
		m.addAttribute("loginUser", loginUser);
	}
	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		
		model.addAttribute("header","home");
		return "home";
	}
	
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		
		return "login";
	}
	
	
	@RequestMapping(value = "/mydiary", method = RequestMethod.GET)
	public String mydiary(Model model,HttpSession session) {
		
		
		User loginUser = (User)session.getAttribute("loginUser");
		
		if(loginUser==null) {
			return "redirect:/login";
		}else {
			model.addAttribute("header","mydiary");
			return "mydiary";
		}
		
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String write() {
		
		
		return "write";
	}
	
	
	@RequestMapping(value = "/tips", method = RequestMethod.GET)
	public String chatGPT(Model model) {
		
		model.addAttribute("header","tips");
		return "chatGPT";
	}
	
	@RequestMapping(value = "/tips-transport", method = RequestMethod.GET)
	public String tips_transport(Model model) {
		
		
		model.addAttribute("tips_menu","transport");
		return "tips_transport";
	}
	
	@RequestMapping(value = "/tips-accomodation", method = RequestMethod.GET)
	public String tips_accomodation(Model model, @RequestParam(value="nation") String nation) {
		
		model.addAttribute("tips_menu","accomodation");
		model.addAttribute("nation",nation);
		return "tips_accomodation";
	}
	
	@RequestMapping(value = "/tips-eat", method = RequestMethod.GET)
	public String tips_eat(Model model, @RequestParam(value="nation") String nation) {
		
		model.addAttribute("tips_menu","eat");
		model.addAttribute("nation",nation);
		return "tips_eat";
	}
	
	@RequestMapping(value = "/tips-etc", method = RequestMethod.GET)
	public String tips_etc(Model model, @RequestParam(value="nation") String nation) {
		
		model.addAttribute("tips_menu","etc");
		model.addAttribute("nation",nation);
		return "tips_etc";
	}
	
	@RequestMapping(value = "/photo", method = RequestMethod.GET)
	public String photo_domestic(Model model) {
		
		model.addAttribute("header","photo");
		model.addAttribute("photo_menu","domestic");
		return "photo_domestic";
	}
	
	@RequestMapping(value = "/photo_abroad", method = RequestMethod.GET)
	public String photo_abroad(Model model) {
		
		model.addAttribute("photo_menu","abroad");
		return "photo_abroad";
	}
	
	
	//다이어리 더보기
	@RequestMapping(value="/detail", method=RequestMethod.GET)
	public String detail(
				@RequestParam(value="mydiary_idx") int mydiary_idx,
				Model model
			) {
		
		model.addAttribute("mydiary_idx",mydiary_idx);
		
		return "detail";
	}
	
	
	//다이어리 수정하기
	@RequestMapping(value="/update", method=RequestMethod.GET)
	public String update(
				@RequestParam(value="mydiary_idx") int mydiary_idx,
				Model model
			) {
		
		model.addAttribute("mydiary_idx",mydiary_idx);
		
		return "update";
	}
	
}

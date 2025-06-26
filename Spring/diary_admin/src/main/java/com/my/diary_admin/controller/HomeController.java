package com.my.diary_admin.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.diary_admin.dao.MydiaryDao;
import com.my.diary_admin.dao.UserDao;
import com.my.diary_admin.vo.User;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Resource(name="UserDao")
	private UserDao userDao;
	
	
	void setUserSession(HttpSession s, Model m) {
		User loginUser = (User)s.getAttribute("loginUser");
		m.addAttribute("loginUser", loginUser);
	}
	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpSession s) {
		
		User loginUser = (User)s.getAttribute("loginUser");
		
		if(loginUser==null) {
			return "redirect:/login";
		}else { 

			model.addAttribute("header","home");
		
			return "home";
		}
		
	}
	
	
	@RequestMapping(value="/getUserCount", method=RequestMethod.GET)
	public @ResponseBody int getUserCount() {
		int count = userDao.getUserCount();
		
		return count;
	}
	
	
	@RequestMapping(value="/getUserAll", method=RequestMethod.GET)
	public @ResponseBody List<User> getUserAll(
				@RequestParam(value="start") int start,
				@RequestParam(value="cnt") int cnt
			){
		
		HashMap<String, Object> map = new HashMap<String,Object>();
		
		map.put("start", start);
		map.put("cnt", cnt);
		
		List<User> userList = userDao.getUserAll(map);
		
		return userList;
	}
	
	
	@RequestMapping(value="/delUser", method=RequestMethod.GET)
	public @ResponseBody String delUser(
			@RequestParam(value="user_idx") int user_idx
			) {
		
		User user = new User();
		user.setUser_idx(user_idx);
		
		userDao.delUser(user);
		
		return "ok";
	}
	
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		
		return "login";
	}
	
	@RequestMapping(value = "/tips_report", method = RequestMethod.GET)
	public String tips_report(Model model, HttpSession s) {
		
		User loginUser = (User)s.getAttribute("loginUser");
		
		if(loginUser==null) {
			return "redirect:/login";
		}else {
			model.addAttribute("header","tips_report");
			
			return "tips_report";
		}
		
		
	}
	
	@RequestMapping(value = "/photo_report", method = RequestMethod.GET)
	public String photo_report(Model model, HttpSession s) {
		
		User loginUser = (User)s.getAttribute("loginUser");
		
		if(loginUser==null) {
			return "redirect:/login";
		}else {
			model.addAttribute("header","photo_report");
			
			return "photo_report";
		}
		
	}

	
	@RequestMapping(value = "/tips", method = RequestMethod.GET)
	public String tips_transport(Model model, HttpSession s) {
		
		User loginUser = (User)s.getAttribute("loginUser");
		
		if(loginUser==null) {
			return "redirect:/login";
		}else { 

			model.addAttribute("header","tips");
			model.addAttribute("tips_menu","transport");
			
			return "tips_transport";
		}
		
		
	}
	
	@RequestMapping(value = "/tips-accomodation", method = RequestMethod.GET)
	public String tips_accomodation(Model model) {
		
		model.addAttribute("tips_menu","accomodation");
		return "tips_accomodation";
	}
	
	@RequestMapping(value = "/tips-eat", method = RequestMethod.GET)
	public String tips_eat(Model model) {
		
		model.addAttribute("tips_menu","eat");
		return "tips_eat";
	}
	
	@RequestMapping(value = "/tips-etc", method = RequestMethod.GET)
	public String tips_etc(Model model) {
		
		model.addAttribute("tips_menu","etc");
		return "tips_etc";
	}
	
	@RequestMapping(value = "/photo", method = RequestMethod.GET)
	public String photo_domestic(Model model, HttpSession s) {
		
		User loginUser = (User)s.getAttribute("loginUser");
		
		if(loginUser==null) {
			return "redirect:/login";
		}else { 
			model.addAttribute("header","photo");
			model.addAttribute("photo_menu","domestic");
			
			return "photo_domestic";
		}
		
		
	}
	
	@RequestMapping(value = "/photo_abroad", method = RequestMethod.GET)
	public String photo_abroad(Model model) {
		
		model.addAttribute("photo_menu","abroad");
		return "photo_abroad";
	}
	
	@RequestMapping(value = "/com_transport", method = RequestMethod.GET)
	public String com_transport(Model model, HttpSession s) {
		
		User loginUser = (User)s.getAttribute("loginUser");
		
		if(loginUser==null) {
			return "redirect:/login";
		} else {
			model.addAttribute("header","comment");
			model.addAttribute("comment","transport");
			
			return "com_transport";
		}
		
	}
	
	@RequestMapping(value = "/com_accomodation", method = RequestMethod.GET)
	public String com_accomodation(Model model) {
		
		model.addAttribute("comment","accomodation");
		
		return "com_accomodation";
	}
	
	@RequestMapping(value = "/com_eat", method = RequestMethod.GET)
	public String com_eat(Model model) {
		
		model.addAttribute("comment","eat");
		
		return "com_eat";
	}
	
	@RequestMapping(value = "/com_etc", method = RequestMethod.GET)
	public String com_etc(Model model) {
		
		model.addAttribute("comment","etc");
		
		return "com_etc";
	}
	
	@RequestMapping(value = "/com_domestic", method = RequestMethod.GET)
	public String com_domestic(Model model) {
		
		model.addAttribute("comment","domestic");
		
		return "com_domestic";
	}
	
	@RequestMapping(value = "/com_abroad", method = RequestMethod.GET)
	public String com_abroad(Model model) {
		
		model.addAttribute("comment","abroad");
		
		return "com_abroad";
	}
	
}

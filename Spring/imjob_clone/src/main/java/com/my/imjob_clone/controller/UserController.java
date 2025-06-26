package com.my.imjob_clone.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.imjob_clone.dao.UserDao;
import com.my.imjob_clone.vo.User;

@Controller
@RequestMapping(value="/user")
public class UserController {
	
	@Resource(name="UserDao")
	private UserDao userDao;
	
	
	@RequestMapping(value="/addUser", method=RequestMethod.POST)
	public @ResponseBody String add(
			@RequestParam(value="name") String name,
			@RequestParam(value="id") String id,
			@RequestParam(value="pw") String pw,
			@RequestParam(value="email") String email,
			@RequestParam(value="phone_number") String phone_number,
			@RequestParam(value="zipcode") int zipcode,
			@RequestParam(value="address") String address,
			@RequestParam(value="address_more") String address_more,
			@RequestParam(value="sms") String sms
			) {
		
		User newUser = new User();
		newUser.setName(name);
		newUser.setId(id);
		newUser.setPw(pw);
		newUser.setEmail(email);
		newUser.setPhone_number(phone_number);
		newUser.setZipcode(zipcode);
		newUser.setAddress(address);
		newUser.setAddress_more(address_more);
		newUser.setSms(sms);
		
		userDao.addUser(newUser);
		return "ok";
	}
	
	
	@RequestMapping(value="/idCheck", method=RequestMethod.GET)
	public @ResponseBody String idCheck(
			@RequestParam(value="id") String id
			) {
		
		User resultUser = userDao.idCheck(id);
				
		if(resultUser==null) {
			return "ok";
		}else {
			return "dup";
		}
		
	}
	
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public @ResponseBody User login(
			@RequestParam(value="id") String id,
			@RequestParam(value="pw") String pw,
			HttpSession session
			) {
		
		User user = new User();
		user.setId(id);
		user.setPw(pw);
		
		User result = userDao.login(user);
		
		if(result==null) {
			return null;
		}else {
			session.setAttribute("loginUser", result);
			
			return result;
		}
		
	}
	
	
	@RequestMapping(value="/logout", method=RequestMethod.POST)
	public @ResponseBody String logout(
			HttpSession session
			) {
		
		session.invalidate();
		return "ok";
	}

	
	@RequestMapping(value="/searchId", method=RequestMethod.GET)
	public @ResponseBody String searchId(
			@RequestParam(value="name") String name,
			@RequestParam(value="email") String email
			) {
		
		User user = new User();
		user.setName(name);
		user.setEmail(email);
		
		String userId = userDao.searchId(user);
		return userId;
	}
	
	@RequestMapping(value="/searchPw", method=RequestMethod.GET)
	public @ResponseBody String searchPw(
			@RequestParam(value="id") String id,
			@RequestParam(value="name") String name,
			@RequestParam(value="email") String email
			) {
		
		User user = new User();
		user.setId(id);
		user.setName(name);
		user.setEmail(email);
		
		String userPw = userDao.searchPw(user);
		
		return userPw;
	}
	
	@RequestMapping(value="/updatePw", method=RequestMethod.POST)
	public @ResponseBody String updatePw(
			@RequestParam(value="id") String id,
			@RequestParam(value="name") String name,
			@RequestParam(value="email") String email,
			@RequestParam(value="pw") String pw
			) {
		
		User user = new User();
		user.setId(id);
		user.setName(name);
		user.setEmail(email);
		user.setPw(pw);
		
		userDao.updatePw(user);
		
		return "ok";
	}
}

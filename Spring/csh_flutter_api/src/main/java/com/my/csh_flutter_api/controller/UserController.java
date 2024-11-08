package com.my.csh_flutter_api.controller;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.my.csh_flutter_api.service.UserService;
import com.my.csh_flutter_api.vo.User;

@RestController
@RequestMapping(value="/api/user")
public class UserController {
	
	
	@Autowired
	UserService userService;
	
	
	
	@GetMapping("findByIdx")
	public User findByIdx(
			@RequestParam(value="idx") int user_idx
			) {
		
		return userService.findByIdx(user_idx);
	}
	
	
	
	@GetMapping("findByIdAndPw")
	public User findByIdAndPw(
			@RequestParam(value="id") String id,
			@RequestParam(value="pw") String pw
			) {
		
		User user = new User();
		user.setId(id);
		user.setPw(pw);
		
		return userService.findByIdAndPw(user);
		
		
	}
	
	
	
	@PostMapping("create")
	public String create(
			@RequestParam(value="id") String id,
			@RequestParam(value="pw") String pw,
			@RequestParam(value="nick") String nick,
			@RequestParam(value="address") String address
			) {
		
		
		
		
		User user = new User();
		user.setUser_code(RandomStringUtils.randomAlphanumeric(10));
		user.setId(id);
		user.setPw(pw);
		user.setNick(nick);
		user.setAddress(address);
		
		userService.save(user);
		
		return "ok";
	}
	

}

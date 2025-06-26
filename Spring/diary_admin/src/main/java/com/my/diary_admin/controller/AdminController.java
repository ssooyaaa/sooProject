package com.my.diary_admin.controller;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

import com.my.diary_admin.dao.UserDao;
import com.my.diary_admin.vo.User;


@Controller
@RequestMapping(value="/admin")
public class AdminController {

	@Resource(name="UserDao")
	private UserDao userDao;

	@RequestMapping(value="/addAdmin", method=RequestMethod.GET)
	public @ResponseBody String add(
				@RequestParam(value="id") String id,
				@RequestParam(value="pw") String pw,
				@RequestParam(value="nickname") String nickname
			) {
		
		User admin = new User();
		admin.setId(id);
		admin.setPw(pw);
		admin.setNickname(nickname);
		
		
		User resultUserById = userDao.getUserById(admin);
		
		if(resultUserById == null) {
			//기존 아이디 X
			userDao.addAdmin(admin);
			return "ok";
			
		}else {
			return "dup";
		}
	}
	
	
	@RequestMapping(value="/logout", method=RequestMethod.POST)
	public @ResponseBody String logout(HttpSession session,
				HttpServletRequest request,
				HttpServletResponse response) {
		
		session.invalidate();
		
		Cookie loginCookie = WebUtils.getCookie(request, "loginId");
		
		if(loginCookie != null) {
			loginCookie.setPath("/");
			loginCookie.setMaxAge(0);
			response.addCookie(loginCookie);
			
			return "ok";
		} else {
			return "ok";
		}
			
	}
	
	
	@RequestMapping(value="/getAdminForLogin", method=RequestMethod.POST)
	public @ResponseBody User getUserForLogin(
			@RequestParam(value="id") String id,
			@RequestParam(value="pw") String pw,
			@RequestParam(value="loginCheckbox") boolean loginCheckbox,
			HttpSession session,
			HttpServletResponse response
			) {
		
		User user = new User();
		user.setId(id);
		user.setPw(pw);
		
		User result = userDao.getAdminByIdAndPw(user);
	
		if(result==null){
			//기존 정보 존재X
			return null;
		}else {
			
			if(loginCheckbox == true) {
				session.setAttribute("loginUser", result);
				String loginId = session.getId();
				
				Cookie cookie = new Cookie("loginId",loginId);
				cookie.setPath("/");
                cookie.setMaxAge(60*60*24*7);
				response.addCookie(cookie);
                
				
				return result;
				
			} else {
				session.setAttribute("loginUser", result);
				session.setMaxInactiveInterval(60*60*24); //초단위
				String loginId = session.getId();
				
				return result;
			}
			
		}
	}
}

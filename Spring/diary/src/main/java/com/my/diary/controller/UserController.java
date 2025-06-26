package com.my.diary.controller;

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

import com.my.diary.dao.UserDao;
import com.my.diary.vo.User;

@Controller
@RequestMapping(value="/user")
public class UserController {
	
	@Resource(name="UserDao")
	private UserDao userDao;

	@RequestMapping(value="/addUser", method=RequestMethod.GET)
	public @ResponseBody String add(
				@RequestParam(value="id") String id,
				@RequestParam(value="pw") String pw,
				@RequestParam(value="nickname") String nickname
			) {
		
		User newUser = new User();
		newUser.setId(id);
		newUser.setPw(pw);
		newUser.setNickname(nickname);
		
		
		User resultUserById = userDao.getUserById(newUser);
		User resultUserByNick = userDao.getUserByNick(newUser);
		
		if(resultUserById == null) {
			//기존 아이디 X
			if(resultUserByNick == null) {
				//기존 닉네임 X
				userDao.addUser(newUser);
				return "ok";
			}else {
				return "noNick";
			}
		}else {
			return "dup";
		}
		
	}
	
	
	@RequestMapping(value="/getUserForLogin", method=RequestMethod.POST)
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
		
		User result = userDao.getUserByIdAndPw(user);
	
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
	
	
	@RequestMapping(value="/deleteUser", method=RequestMethod.POST)
	public @ResponseBody String deleteUser(HttpSession s) {
		
		User loginUser = (User)s.getAttribute("loginUser");
		
		loginUser.setAccount("N");
		
		userDao.deleteUser(loginUser);
		
		s.invalidate();
		
		return "ok";
		
	}
}

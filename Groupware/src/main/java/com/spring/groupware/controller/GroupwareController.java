package com.spring.groupware.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.service.InterGroupwareService;

@Component
@Controller
public class GroupwareController {

	
	@Autowired	// Type에 따라 알아서 Bean 을 주입해준다.
	private InterGroupwareService service;
	
	
	// === #36. 메인페이지 요청 === //
	@RequestMapping(value="/*")
	public String index() {
		return "index";
	}

	
	
	///////////// AOP 테스트 부분 ////////////////
	// aopTestStart.action -> requiredLogin() 로그인 검사 -> login.action -> loginEnd.action -> aopTestStart.action 
	// loginEnd.action 에서 임의로 loginuser 값을 생성함.
	
	@RequestMapping(value="/aopTestStart.action")
	public String requiredLogin_aopTestStart(HttpServletRequest request, HttpServletResponse response) {
	
		return "aopTestStart";
	}
	
	// login test
	@RequestMapping(value="/login.action")
	public String login(HttpServletRequest request) {

		return "home";
	}
	
	// loginEnd test
	@RequestMapping(value="/loginEnd.action")
	public ModelAndView loginEnd(HttpServletRequest request, ModelAndView mav) {
		
		// login 성공했다고 가정하고 테스트
		HttpSession session = request.getSession();
		session.setAttribute("loginuser", "leess");
		
		String goBackURL = (String) session.getAttribute("goBackURL");
		
		// 막바로 페이지 이동을 시킨다.
		if (goBackURL != null) {
			mav.setViewName("redirect:/"+ goBackURL);
			session.removeAttribute("goBackURL"); // 세션에서 반드시 제거해주어야 한다.
		}
		else {
			mav.setViewName("redirect:/index.action");
		}
		
		return mav;
	}
	///////////////////////////////////////////
}

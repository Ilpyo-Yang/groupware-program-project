package com.spring.groupware.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.member.service.InterMemberService;


@Controller
public class MemberController {

   @Autowired // Type에 따라 알아서 Bean 을 주입해준다.
   private InterMemberService service;
      
   
	   // === 로그인 메인에 회사명 띄우기 === //
	   @RequestMapping(value="/login.opis")
	   public ModelAndView login(HttpServletRequest request, ModelAndView mav) {
		 String com_name = service.getCompanyName();
		 request.setAttribute("com_name", com_name);
		 mav.setViewName("login");
	 	 return mav;
	   }
	   
   
   	  // === 로그인하기 === //
      @RequestMapping(value="/loginCheck.opis", method= {RequestMethod.POST})
      public ModelAndView loginCheck(HttpServletRequest request, ModelAndView mav) {
    	  String id = request.getParameter("idInput");
    	  String pwd = request.getParameter("pwdInput");
    	  
    	  int n = service.loginCheck(id, pwd);
    	  
    	  return mav;
      }      
      
      
      // === 조직도 === //
      @RequestMapping(value="/mbrchart.opis")
      public ModelAndView mbrchart(ModelAndView mav) {   	  
    	 mav.setViewName("member/mbrchart.tiles1");
    	 return mav;
      }
      

}
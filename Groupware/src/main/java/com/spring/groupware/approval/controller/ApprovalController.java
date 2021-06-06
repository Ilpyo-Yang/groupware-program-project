package com.spring.groupware.approval.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.approval.service.InterApprovalService;
import com.spring.groupware.common.MyUtil;
import com.spring.groupware.member.model.MemberVO;

@Controller
public class ApprovalController {

   @Autowired // Type에 따라 알아서 Bean 을 주입해준다.
   private InterApprovalService service;
      
        
      // === 기안문작성 메인 === //
      @RequestMapping(value="/approvalMain.opis")
      public ModelAndView approvalMain(ModelAndView mav) {   	  
    	 mav.setViewName("approval/approvalMain.tiles1");
    	 return mav;
      }
      
      
      // === 일반결의서 === //
      @RequestMapping(value="/approvalForm1.opis")
      public ModelAndView approvalForm1(ModelAndView mav) {
  		 String today = MyUtil.getToday();
  		 String fileNo = service.getFileNo(); 
  		 
  		 mav.addObject("today",today);
  		 mav.addObject("fileNo",fileNo);
    	 mav.setViewName("approval/approvalForm1.tiles1");
    	 return mav;
      }
      
      // === 지출결의서 === //
      @RequestMapping(value="/approvalForm2.opis")
      public ModelAndView approvalForm2(ModelAndView mav) {   	  
    	 mav.setViewName("approval/approvalForm2.tiles1");
    	 return mav;
      }
      
      // === 휴가계획서 === //
      @RequestMapping(value="/approvalForm3.opis")
      public ModelAndView approvalForm3(ModelAndView mav) {   	  
    	 mav.setViewName("approval/approvalForm3.tiles1");
    	 return mav;
      }
           
      // === 모달창에 입력될 전체 사원명 가져오기  === //
      @RequestMapping(value="/getMemberList.opis")
      public String getMemberList(HttpServletRequest request, ModelAndView mav) {
    	 List<MemberVO> memberList = service.getMemberList(); 
    	 JSONObject jsonObj = new JSONObject();
 		 jsonObj.put("memberList", memberList); 		
    	 return jsonObj.toString();    		 
      }
      
      // === 결재진행함 === //
      @RequestMapping(value="/approvalProcess.opis")
      public ModelAndView approvalProcess(ModelAndView mav) {   	  
    	 mav.setViewName("approval/approvalProcess.tiles1");
    	 return mav;
      }
      
      
      // === 서명관리 === //
      @RequestMapping(value="/sign.opis")
      public ModelAndView sign(ModelAndView mav) {   	  
    	 mav.setViewName("approval/sign.tiles1");
    	 return mav;
      }
      

}
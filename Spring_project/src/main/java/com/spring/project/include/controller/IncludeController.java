package com.spring.project.include.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.project.include.service.IncludeService;
import com.spring.project.login.service.LoginService;

@Controller
public class IncludeController {
	@Autowired
	private IncludeService includeService;
	@Autowired
	private LoginService loginService;
	
	//헤더 정보 가져오기 요청 처리
	@RequestMapping("/include/header.do")
	public String infoHeader(HttpServletRequest request, ModelAndView mView){
		//loginService를 이용해서 로그인된 정보를 가져온다.
		loginService.getLoginInfo(request, mView);
		//view 페이지로 forward 이동 시킨다.
		return "home";
	}
}

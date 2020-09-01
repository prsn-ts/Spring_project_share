package com.spring.project;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.project.login.service.LoginService;

@Controller
public class HomeController {
	@Autowired
	private LoginService loginService;
	
	@RequestMapping("/home.do")
	public ModelAndView home(HttpServletRequest request, ModelAndView mView) {
		//로그인된 정보를 가져온다.
		loginService.getLoginInfo(request, mView);
		//view 페이지 정보를 담는다.
		mView.setViewName("home");
		return mView;
	}
	
}

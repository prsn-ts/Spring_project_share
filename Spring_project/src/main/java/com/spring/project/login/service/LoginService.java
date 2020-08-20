package com.spring.project.login.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.spring.project.login.dto.LoginDto;

public interface LoginService {
	//로그인 정보를 가져오는 추상 메소드
	public void getLoginInfo(HttpServletRequest request, ModelAndView mView);
}

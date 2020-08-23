package com.spring.project.login.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.spring.project.login.dto.LoginDto;

public interface LoginService {
	//로그인 정보를 가져오는 추상 메소드
	public void getLoginInfo(HttpServletRequest request, ModelAndView mView);
	//쿠키 정보를 가져오는 추상 메소드
	public ModelAndView getCookie(HttpServletRequest request, ModelAndView mView);
	//로그인 처리를 위한 추상 메소드
	public void loginProcess(LoginDto dto, HttpServletRequest request,
			HttpServletResponse response, ModelAndView mView);
	//회원가입 요청을 처리하는 메소드
	public void addUser(LoginDto dto, ModelAndView mView);
}

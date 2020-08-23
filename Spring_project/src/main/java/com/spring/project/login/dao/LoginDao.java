package com.spring.project.login.dao;

import org.springframework.web.servlet.ModelAndView;

import com.spring.project.login.dto.LoginDto;

public interface LoginDao {
	//로그인된 정보를 가져오기 위한 추상 메소드
	public LoginDto getData(String id);
	//회원가입 처리를 수행하기 위한 추상 메소드
	public void insert(LoginDto dto, ModelAndView mView);
	//아이디 중복검사를 수행하기 위한 추상 메소드
	public boolean isExist(String inputId);
}

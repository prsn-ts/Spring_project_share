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
	//비밀번호 수정 요청 처리하는 추상 메소드
	public void updatePwd(LoginDto dto);
	//업데이트된 프로필 및 이미지 정보를 DB에 저장하는 추상 메소드
	public void update(LoginDto dto);
}

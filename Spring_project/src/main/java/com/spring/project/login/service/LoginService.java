package com.spring.project.login.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
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
	//회원가입 요청을 처리하는 추상 메소드
	public void addUser(LoginDto dto, ModelAndView mView);
	//비밀번호 수정 요청을 처리하는 추상 메소드
	public void updateUserPwd(LoginDto dto, HttpServletRequest request, ModelAndView mView);
	//프로필 파일 선택하기 요청을 처리하는 추상 메소드
	public Map<String, Object> saveProfile(MultipartFile image, HttpServletRequest request);
	//회원정보 수정 요청 처리를 위한 추상 메소드
	public void updateUser(LoginDto dto, HttpServletRequest request, ModelAndView mView);
	//프로필 사진 지우기 요청을 처리하는 추상 메소드
	public void deleteProfile(LoginDto dto, HttpServletRequest request);
	//회원 탈퇴 요청 관련 추상 메소드
	public void deleteUser(HttpSession session);
}

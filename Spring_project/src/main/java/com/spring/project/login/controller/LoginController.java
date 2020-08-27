package com.spring.project.login.controller;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.project.login.dao.LoginDao;
import com.spring.project.login.dto.LoginDto;
import com.spring.project.login.service.LoginService;

@Controller
public class LoginController {
	@Autowired
	private LoginService loginService;
	@Autowired
	private LoginDao logindao;
	
	//로그인 폼 요청 처리
	@RequestMapping("/login/login_form")
	public ModelAndView loginform(HttpServletRequest request, ModelAndView mView) {
		// url 파라미터가 넘어오는지 읽어와 보기 
		String url=request.getParameter("url");
		if(url==null){//목적지 정보가 없다면
			String cPath=request.getContextPath();
			url=cPath+"/home.do"; //로그인후 인덱스 페이지로 가도록 하기 위해 
		}
		//쿠키에 저장된 정보를 가져오기 위함.
		mView = loginService.getCookie(request, mView);
		//url 파라미터가 있는 경우 request 에 담는다.
		request.setAttribute("url", url);
		//view 페이지로 이동한다.
		mView.setViewName("login/login_form");
		return mView;
	}
	
	//로그인 요청 처리
	@RequestMapping("/login/login")
	public ModelAndView login(LoginDto dto, HttpServletRequest request,
			HttpServletResponse response, ModelAndView mView) {
		//로그인 후 가야하는 목적지 정보
		String url = request.getParameter("url");
		//목적지 정보도 미리 인코딩 해 놓는다.
		String encodedUrl = URLEncoder.encode(url);

		//로그인 처리 후 가야할 url 정보를 ModelAndView 객체에 담는다.
		mView.addObject("url", url);
		mView.addObject("encodedUrl", encodedUrl);
		
		//로그인 처리하는 메소드
		loginService.loginProcess(dto, request, response, mView);
		
		//로그인 처리 후 view 페이지로 이동한다.
		mView.setViewName("login/login");
		return mView;
	}
	
	//로그아웃 요청 처리
	@RequestMapping("/login/logout")
	public String logout(HttpSession session) {
		//세션을 초기화 해서 로그아웃 처리를 한다.
		session.invalidate();
		//view 페이지로 이동한다.
		return "login/logout";
	}
	
	//회원 가입 폼 요청 처리
	@RequestMapping("/login/signup_form")
	public ModelAndView signupForm(ModelAndView mView) {
		
		mView.setViewName("login/signup_form");
		return mView;
	}
	
	//회원 가입 요청 처리
	@RequestMapping("/login/signup")
	public ModelAndView signup(LoginDto dto, ModelAndView mView) {
		//loginService 객체를 이용해서 사용자 정보를 추가한다.
		loginService.addUser(dto, mView);
		//view 페이지로 이동해서 응답하기.
		mView.setViewName("login/signup");
		return mView;
	}
	
	//아이디 중복 검사 요청 처리
	@RequestMapping("/login/checkid")
	@ResponseBody
	public Map<String, Object> checkId(@RequestParam String inputId) {
		//UsersDao  를 이용해서 해당 아이디가 존재 하는지 여부를 리턴받는다. 
		boolean isExist=logindao.isExist(inputId);
		//map 객체를 생성한다.
		Map<String, Object> map = new HashMap<String, Object>();
		//json 형식으로 저장하기위해 isExist 키에 select 결과를 담는다.
		map.put("isExist", isExist);
		//map을 리턴한다.
		return map;
	}
	
	//회원 정보 보기 요청 처리
	@RequestMapping("/login/private/info.do")
	public ModelAndView info(HttpServletRequest request, ModelAndView mView) {
		//로그인된 정보를 가져온다.
		loginService.getLoginInfo(request, mView);
		//ModelAndView 객체에 view 페이지 정보를 담는다.
		mView.setViewName("login/private/info");
		//view 페이지로 forward 이동한다.
		return mView;
	}
}

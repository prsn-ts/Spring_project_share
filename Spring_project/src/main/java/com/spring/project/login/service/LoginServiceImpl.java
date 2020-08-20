package com.spring.project.login.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.spring.project.login.dao.LoginDao;
import com.spring.project.login.dto.LoginDto;

@Service
public class LoginServiceImpl implements LoginService{
	@Autowired
	private LoginDao loginDao;

	@Override
	public void getLoginInfo(HttpServletRequest request, ModelAndView mView) {
		//로그인된 아이디가 있는지 가져와본다.
		String id=(String)request.getSession().getAttribute("id");
		//로그인된 정보를 dto에 담는다.
		LoginDto dto = loginDao.getData(id);
		//view 페이지에서 사용하기 위해서 ModelAndView 객체에 dto를 담는다.
		mView.addObject("dto", dto);
	}
}

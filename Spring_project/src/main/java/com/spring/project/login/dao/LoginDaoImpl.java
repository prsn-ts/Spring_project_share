package com.spring.project.login.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.ModelAndView;

import com.spring.project.login.dto.LoginDto;

@Repository
public class LoginDaoImpl implements LoginDao{
	@Autowired
	private SqlSession session;

	//로그인된 정보를 가져오는 메소드
	@Override
	public LoginDto getData(String id) {
		return session.selectOne("login.getData", id);
	}
	//회원가입 처리를 수행하기 위한 메소드
	@Override
	public void insert(LoginDto dto, ModelAndView mView) {
		int result = session.insert("login.insert", dto);
		if(result <= 0) {//회원가입이 실패한 경우
			boolean isSuccess = false;
			mView.addObject("isSuccess", isSuccess);
		}else if(result > 0) {//회원가입이 성공한 경우
			boolean isSuccess = true;
			mView.addObject("isSuccess", isSuccess);
		}
	}
	//아이디 중복 검사를 수행하기 위한 메소드
	@Override
	public boolean isExist(String inputId) {
		String id = session.selectOne("login.isExist", inputId);
		if(id==null) {
			return false;
		}else {
			return true;
		}
	}
	//비밀번호를 수정하기 위한 메소드
	@Override
	public void updatePwd(LoginDto dto) {
		session.update("login.updatePwd", dto);
	}
	//업데이트된 프로필 및 이미지 정보를 DB에 저장하는 메소드
	@Override
	public void update(LoginDto dto) {
		session.update("login.update", dto);
	}
	//프로필 사진을 지우는 메소드
	@Override
	public void profile_delete(LoginDto dto) {
		session.update("login.profile_delete", dto);
	}
	//탈퇴 처리하는 메소드
	@Override
	public void delete(String id) {
		session.delete("login.delete", id);
	}
	
}

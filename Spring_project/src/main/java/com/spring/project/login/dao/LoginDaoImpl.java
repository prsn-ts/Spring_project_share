package com.spring.project.login.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
}

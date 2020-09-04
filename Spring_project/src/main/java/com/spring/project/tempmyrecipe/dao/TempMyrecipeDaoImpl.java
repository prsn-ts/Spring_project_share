package com.spring.project.tempmyrecipe.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.project.tempmyrecipe.dto.TempMyrecipeDto;

@Repository
public class TempMyrecipeDaoImpl implements TempMyrecipeDao{
	@Autowired
	private SqlSession session;
	//임시 저장된 회원 한명의 글쓰기 정보를 가져오는 메소드
	@Override
	public TempMyrecipeDto getTempWriteData(String tmp_writer) {
		
		return session.selectOne("tempmyrecipe.getTempWriteData", tmp_writer);
	}
}

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
	//임시 저장된 특정 회원의 글 정보가 존재하는지 확인하는 메소드
	@Override
	public boolean temp_insert_Confirm(String tmp_writer) {
		Integer result = session.selectOne("tempmyrecipe.temp_insert_Confirm", tmp_writer);
		//셀렉트 결과에 따라 true or false 를 넣을 변수
		boolean isExist = false;
		if(result != null) {
			isExist = true;
		}else {
			isExist = false;
		}
		return isExist;
	}
	//임시 저장된 글 내용을 수정하는 메소드
	@Override
	public void temp_update(TempMyrecipeDto dto) {
		session.update("tempmyrecipe.temp_update", dto);
	}
	//글 내용을 임시 저장하는 메소드
	@Override
	public void temp_insert(TempMyrecipeDto dto) {
		session.insert("tempmyrecipe.temp_insert", dto);
	}
}

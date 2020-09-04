package com.spring.project.tempmyrecipe.dao;

import com.spring.project.tempmyrecipe.dto.TempMyrecipeDto;

public interface TempMyrecipeDao {

	//임시 저장된 회원 한명의 글쓰기 정보를 가져오는 추상 메소드
	public TempMyrecipeDto getTempWriteData(String tmp_writer);
}

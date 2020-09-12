package com.spring.project.tempmyrecipe.dao;

import com.spring.project.tempmyrecipe.dto.TempMyrecipeDto;

public interface TempMyrecipeDao {

	//임시 저장된 회원 한명의 글쓰기 정보를 가져오는 추상 메소드
	public TempMyrecipeDto getTempWriteData(String tmp_writer);
	//임시 저장된 특정 회원의 글 정보가 존재하는지 확인하는 추상 메소드
	public boolean temp_insert_Confirm(String tmp_writer);
	//임시 저장된 글 내용을 수정하는 추상 메소드
	public void temp_update(TempMyrecipeDto dto);
	//글 내용을 임시 저장하는 추상 메소드
	public void temp_insert(TempMyrecipeDto dto);
}

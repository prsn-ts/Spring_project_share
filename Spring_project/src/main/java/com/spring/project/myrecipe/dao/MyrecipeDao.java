package com.spring.project.myrecipe.dao;

import java.util.List;

import com.spring.project.myrecipe.dto.MyrecipeDto;


public interface MyrecipeDao {
	//검색 키워드에 맞는(또는 검색 키워드 X) 나만의 조리법 페이지 리스트를 가져오는 추상 메소드
	public List<MyrecipeDto> getList(MyrecipeDto dto);
	//검색 키워드에 맞는(또는 검색 키워드 X) 전체 글의 개수를 가져오는 추상 메소드
	public int getCount(MyrecipeDto dto);
	//회원 한명의 글쓰기 정보를 가져오는 추상 메소드
	public MyrecipeDto getWriteData(String writer);
}

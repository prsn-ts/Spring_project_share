package com.spring.project.myrecipe.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.project.myrecipe.dto.MyrecipeDto;

@Repository
public class MyrecipeDaoImpl implements MyrecipeDao{
	@Autowired
	private SqlSession session;

	//검색 키워드에 맞는 나만의 조리법 페이지 리스트를 가져오는 메소드
	@Override
	public List<MyrecipeDto> getList(MyrecipeDto dto) {
		
		return session.selectList("myrecipe.getList", dto);
	}
	//검색 키워드에 맞는(또는 검색 키워드 X) 전체 글의 개수를 가져오는 메소드
	@Override
	public int getCount(MyrecipeDto dto) {
		return session.selectOne("myrecipe.getCount", dto);
	}
}

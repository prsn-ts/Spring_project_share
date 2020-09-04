package com.spring.project.myrecipe.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import com.spring.project.myrecipe.dto.MyrecipeDto;


public interface MyrecipeService {
	//나만의 조리법 페이지 리스트를 가져오는 추상 메소드
	public List<MyrecipeDto> getRecipeList(HttpServletRequest request);
	//나만의 조리법 페이지 페이징 처리 요청 관련 추상 메소드
	public Map<String, Object> getPagingList(HttpServletRequest request);
	//레시피 작성하기 폼 요청 관련 추상 메소드
	public Map<String, Object> getAjaxData(HttpSession session, ModelAndView mView);
}

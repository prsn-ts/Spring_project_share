package com.spring.project.myrecipe.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.project.myrecipe.dto.MyrecipeDto;
import com.spring.project.myrecipe.service.MyrecipeService;

@Controller
public class MyrecipeController {
	@Autowired
	private MyrecipeService myrecipeService;
	
	//나만의 조리법 페이지 보기 요청 처리
	@RequestMapping("/my_recipe/myrecipe")
	public String myrecipePage() {
		
		return "my_recipe/myrecipe";
	}
	
	//나만의 조리법 페이지 리스트 요청 처리
	@RequestMapping("/myrecipe/ajax_list.do")
	@ResponseBody
	public List<MyrecipeDto> myrecipeAjaxList(HttpServletRequest request) {
		//서비스 객체를 통해 조립법 페이지 리스트를 가져와서 리턴한다.
		return myrecipeService.getRecipeList(request);
	}
	
	//나만의 조리법 페이지 페이징 요청 처리
	@RequestMapping("/myrecipe/ajax_paging_list.do")
	@ResponseBody
	public Map<String, Object> myrecipePagingList(HttpServletRequest request){
		//서비스 객체를 통해 조립법 페이지 페이징 처리 결과를 가져와서 리턴한다.
		return myrecipeService.getPagingList(request);
	}
}

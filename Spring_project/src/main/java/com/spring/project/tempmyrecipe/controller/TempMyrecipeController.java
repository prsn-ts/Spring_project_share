package com.spring.project.tempmyrecipe.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.project.tempmyrecipe.dto.TempMyrecipeDto;
import com.spring.project.tempmyrecipe.service.TempMyrecipeService;

@Controller
public class TempMyrecipeController {
	@Autowired
	private TempMyrecipeService tempMyrecipeService;
	
	//임시 저장하는 요청 처리
	@RequestMapping("/my_recipe/private/temp_save.do")
	public String tempSave(TempMyrecipeDto dto, HttpServletRequest request) {
		//임시 저장 처리할 서비스 객체를 생성한다.
		tempMyrecipeService.tempSaveWrite(dto, request);
		//view 페이지로 이동한다.
		return "my_recipe/private/temp_save";
	};
}

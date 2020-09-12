package com.spring.project.tempmyrecipe.service;

import javax.servlet.http.HttpServletRequest;

import com.spring.project.tempmyrecipe.dto.TempMyrecipeDto;

public interface TempMyrecipeService {
	//임시 저장하는 요청 관련 추상 메소드
	public void tempSaveWrite(TempMyrecipeDto dto, HttpServletRequest request);
}

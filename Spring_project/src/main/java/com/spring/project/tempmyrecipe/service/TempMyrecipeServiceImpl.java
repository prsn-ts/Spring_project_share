package com.spring.project.tempmyrecipe.service;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.spring.project.login.dao.LoginDao;
import com.spring.project.login.dto.LoginDto;
import com.spring.project.myrecipe.dao.MyrecipeDao;
import com.spring.project.myrecipe.dto.MyrecipeDto;
import com.spring.project.tempmyrecipe.dao.TempMyrecipeDao;
import com.spring.project.tempmyrecipe.dto.TempMyrecipeDto;

@Service
public class TempMyrecipeServiceImpl implements TempMyrecipeService{
	@Autowired
	private TempMyrecipeDao tempMyrecipeDao;
	
	//임시 저장하는 요청 관련 메소드
	@Override
	public void tempSaveWrite(TempMyrecipeDto dto, HttpServletRequest request) {
		
		//tmp_my_recipe 테이블에 임시 저장된 값이 있는지 확인한다.
		boolean isSuccess = tempMyrecipeDao.temp_insert_Confirm(dto.getWriter());
		
		//만약 이미 임시저장된 값이 있을 경우 임시 저장된 내용을 수정한다.
		if(isSuccess){
			//MyrecipeDao에 dto 값을 수정
			tempMyrecipeDao.temp_update(dto);
		}
		//임시 저장된 값이 없을 경우 저장할 내용을 추가한다.
		else{
			//MyrecipeDao에 dto 값을 저장
			tempMyrecipeDao.temp_insert(dto);
		}
	}
	
}

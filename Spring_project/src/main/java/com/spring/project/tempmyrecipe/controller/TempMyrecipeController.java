package com.spring.project.tempmyrecipe.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.spring.project.tempmyrecipe.service.TempMyrecipeService;

@Controller
public class TempMyrecipeController {
	@Autowired
	private TempMyrecipeService myrecipeService;
	
}

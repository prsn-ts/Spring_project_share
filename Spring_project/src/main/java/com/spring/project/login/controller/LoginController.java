package com.spring.project.login.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.spring.project.login.service.LoginService;

@Controller
public class LoginController {
	@Autowired
	private LoginService loginService;
}

package com.care.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.care.member_service.*;

@Controller
public class LoginController {
	MemberService ms;
	private ApplicationContext applicationContext =
			ApplicationContextprovider.getApplicationContext();
	
	@RequestMapping(value = "/")
	public String index() {
		return "default/index";
	}
	
	@RequestMapping(value = "/login")
	public String login() {
		return "login/login";
	}
	
	@RequestMapping(value = "/loginChk")
	public String loginChk(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		ms = (MLoginChkImpl)applicationContext.getBean("mLoginChkImpl");
		ms.execute(model);
		return "login/login";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register() {
		return "login/register";
	}
	
}

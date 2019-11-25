package com.care.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.care.dto.MemberDTO;
import com.care.service.*;

@Controller
public class LoginController {
	
	@Autowired
	private MemberService ms;
	
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
	public String loginChk(Model model,MemberDTO dto,HttpServletRequest request) {
		model.addAttribute("dto", dto);
		model.addAttribute("request", request);
		ms.loginChk(model);
		return "login/login";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register(Model model,HttpServletRequest request) {
		return "login/register";
	}
	
	@RequestMapping(value = "/registerChk", method = RequestMethod.POST)
	public String registerChk(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		System.out.println(request.getParameter("id"));
		System.out.println(request.getParameter("pw"));
		System.out.println(request.getParameter("nickname"));
		System.out.println(request.getParameter("gender"));
		System.out.println(request.getParameter("mail"));
		System.out.println(request.getParameter("age"));
		
		System.out.println("컨트롤러 registerChk 실행");
		ms.register(model);
		return "redirect:login";
	}
}

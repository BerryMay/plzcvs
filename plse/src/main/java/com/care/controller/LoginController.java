package com.care.controller;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.care.dto.MemberDTO;
import com.care.service.*;

@Controller
public class LoginController {
	
	@Autowired
	private MemberService ms;
	
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
		return "login/loginChk";
	}
	@RequestMapping(value = "/logout")
	public String logout(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		ms.logout(model);
		return "login/login";
	}
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register(Model model,HttpServletRequest request) {
		return "login/register";
	}
	
	@RequestMapping(value = "/registerChk", method = RequestMethod.POST)
	public String registerChk(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		ms.register(model);
		return "login/registerChk";
	}
	
	@RequestMapping(value = "/user/idCheck", method = RequestMethod.GET)
	@ResponseBody
	public int idCheck(@RequestParam("id") String id) {
		return ms.userIdCheck(id);
	}
	
	//이메일 인증 코드
	@RequestMapping(value = "/emailConfirm", method = RequestMethod.GET)
	public String emailConfirm(MemberDTO dto,Model model) throws Exception {
		dto.setAuthstatus(1);
		ms.updateAuthstatus(dto);
		model.addAttribute("Authstatus", 1);
		model.addAttribute("dto", dto);
		return "login/emailChk";
	}
	//비밀번호 찾기 폼
	@RequestMapping(value = "/find_pw")
	public String find_pw() {
		return "login/find_pw";
	}
	//비밀번호 찾기 chk
	@RequestMapping(value = "/find_pw_Chk")
	public String find_pw_Chk(Model model,MemberDTO dto) throws MessagingException, UnsupportedEncodingException {
		ms.find_pw_Chk(model,dto);
		return "login/find_pw_Chk";
	}
}

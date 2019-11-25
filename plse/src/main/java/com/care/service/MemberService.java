package com.care.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.care.dao.MemberDAO;
import com.care.dto.MemberDTO;

import lombok.Getter;
import lombok.Setter;

@Service
public class MemberService{
	@Autowired
	MemberDAO dao;
	
	
	public int loginChk(Model model) {
		Map<String, Object> map = model.asMap();
		MemberDTO dto = new MemberDTO();
		dto = (MemberDTO)map.get("dto");
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		HttpSession session = null;
		MemberDTO loginchk = dao.loginChk(dto);
		if(loginchk != null) {
			session = request.getSession();
			session.setAttribute("userId", dto.getId());
			return 0;
		}else {
			return 0; 
		}
	}
	
	
	public int register(Model model) {
		System.out.println("register 서비스 실행");
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		MemberDTO dto = new MemberDTO();
		dto.setId(request.getParameter("id"));
		dto.setPw(request.getParameter("pw"));
		dto.setNickname(request.getParameter("nickname"));
		dto.setAge(request.getParameter("age"));
		dto.setGender(request.getParameter("gender"));
		dto.setMail(request.getParameter("mail"));
		int re = dao.register(dto);
		return re;
	}
}

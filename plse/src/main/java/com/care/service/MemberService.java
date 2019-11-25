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
	private MemberDAO dao;
	
	public void loginChk(Model model) {
		Map<String, Object> map = model.asMap();
		MemberDTO dto = new MemberDTO();
		dto = (MemberDTO)map.get("dto");
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		HttpSession session = request.getSession();
		MemberDTO loginchk = dao.loginChk(dto);
		try {
			if(loginchk != null) {
				// 성공시 세션 만들어줌
				session.setAttribute("userId", dto.getId());
			}else {
				// 실패시
			}			
		} catch (Exception e) { System.out.println("로그인 오류" + e); }
	}
	
	public void register(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		MemberDTO dto = new MemberDTO();
		dto.setId(request.getParameter("id"));
		dto.setPw(request.getParameter("pw"));
		dto.setNickname(request.getParameter("nickname"));
		dto.setAge(request.getParameter("age"));
		dto.setGender(request.getParameter("gender"));
		dto.setMail(request.getParameter("mail"));
		try {
			dao.register(dto);
		} catch (Exception e) { System.out.println("회원가입 오류" + e); }
	}
}

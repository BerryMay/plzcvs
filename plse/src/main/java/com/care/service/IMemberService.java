package com.care.service;

import org.springframework.ui.Model;

public interface IMemberService {

	// 로그인 체크 메서드
	public void loginChk(Model model);
	// 회원가입 메서드
	public void register(Model model);
	//로그아웃
	public void logout(Model model);
	
	public int userIdCheck(String id);
}

package com.care.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.care.dao.MemberDAO;
import com.care.dto.MemberDTO;
import com.care.mail.MailHandler;
import com.care.mail.TempKey;
import com.care.recaptcha.VerifyRecaptcha;

import lombok.Getter;
import lombok.Setter;


@Service
public class MemberService implements IMemberService{
	
	@Autowired
	private MemberDAO dao;
	@Autowired
	private JavaMailSender mailSender;
	
	public void loginChk(Model model) {
		Map<String, Object> map = model.asMap();
		MemberDTO dto = new MemberDTO();
		dto = (MemberDTO)map.get("dto");
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		HttpSession session = request.getSession();
		MemberDTO loginchk = dao.loginChk(dto);
		try {
			if(loginchk != null) {
				if(loginchk.getAuthstatus() == 1) {
					// 성공시 세션 만들어줌
					session.setAttribute("userId", loginchk.getNickname());
					session.setAttribute("verify", loginchk.getVerify());
					session.setAttribute("age", loginchk.getAge());
					model.addAttribute("result", "ok");
				}else {
					model.addAttribute("result", "no");
				}
			}else {
				// 실패시
				model.addAttribute("result", "fail");
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
		boolean result = false;
		
		VerifyRecaptcha.setSecretKey("6LcyXMcUAAAAAGlmmpaJIfO_rj2M26pnq07V_588");
		try {
		if(VerifyRecaptcha.verify(request.getParameter("g-recaptcha-response")))
		result =  true;
		}
		catch (IOException e) {
			e.printStackTrace();
			result =  false;
		}
		try {
			if ( result == true ) {
			String authkey = new TempKey().getKey(50, false);
			dto.setAuthkey(authkey);
			int re = dao.register(dto);
			MailHandler sendMail = new MailHandler(mailSender);
			
			sendMail.setSubject("편편백서 회원가입 이메일 인증");
			sendMail.setText(new StringBuffer().append("<h1>[이메일 인증]</h1>")
					.append("<p>아래 링크를 클릭하시면 이메일 인증이 완료됩니다.</p>")
					.append("<a href='http://localhost:8989/practice/emailConfirm?id=")
					.append(dto.getId())
					.append("&pw=")
					.append(dto.getPw())
					.append("&mail=")
					.append(dto.getMail())
					.append("&authkey=")
					.append(authkey)
					.append("' target='_blenk'>이메일 인증 확인</a>")
					.toString());
			sendMail.setFrom("plz@gmail.com", "편편백서");
			sendMail.setTo(dto.getMail());
			sendMail.send();
			model.addAttribute("result", re);
			}
	} 
		catch (Exception e) { System.out.println("회원가입오류" + e); }
	}
	
	public void logout(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		dao.logout(request);
	}
	public int userIdCheck(String id) {
		return dao.userIdCheck(id);
	}
	
	//회원정보보기
	public void member_view(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		MemberDTO dto = dao.member_view(request);
		
		model.addAttribute("dto", dto);
		
	}
	//회원정보 수정
	public void member_modify(Model model) {
		Map<String, Object> map = model.asMap();
		MemberDTO dto = (MemberDTO)map.get("dto");
		dao.member_modify(dto);		
	}
	//회원탈퇴
	public void member_withdrawal(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String nick= request.getParameter("nickname");
		dao.member_withdrawal(nick);
	}
	//이메일인증완료
	public void updateAuthstatus(MemberDTO dto) {
		dao.updateAuthstatus(dto);
	}
	//비번찾기 확인
	public void find_pw_Chk(Model model,MemberDTO dto) throws MessagingException, UnsupportedEncodingException {
		MemberDTO mdto = dao.find_pw_Chk(dto);
		if(mdto != null) {
			String authkey = new TempKey().getKey(8, false);
			MailHandler sendMail = new MailHandler(mailSender);
			sendMail.setSubject("편편백서 임시 비밀번호 발급");
			sendMail.setText(new StringBuffer().append("<h1>[임시 비밀번호 발급]</h1>")
					.append("<p>"+dto.getId())
					.append(" 님의 임시 비밀번호는 ")
					.append("<b>"+authkey+"</b>")
					.append(" 입니다</p>")
					.append("<a href='http://localhost:8989/practice/login")
					.append("' target='_blenk'>편편백서 바로가기</a>")
					.toString());
			sendMail.setFrom("plz@gmail.com", "편편백서");
			sendMail.setTo(dto.getMail());
			sendMail.send();
			dto.setPw(authkey);
			updatePw(dto);
			model.addAttribute("result", 1);
		}else {
			model.addAttribute("result", 0);
		}
	}
	public void updatePw(MemberDTO dto) {
		dao.updatePw(dto);
	}
}

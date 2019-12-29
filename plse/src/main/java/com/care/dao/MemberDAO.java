package com.care.dao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.care.dto.MemberDTO;

@Component
public class MemberDAO {
	private static final String namespace="com.care.mybatis.loginMapper";
	@Autowired 
	private SqlSession sqlSession;
	public MemberDTO loginChk(MemberDTO dto) {
		return sqlSession.selectOne(namespace+".login",dto);
	}
	public int register(MemberDTO dto) {
		return sqlSession.insert(namespace+".register",dto);
	}
	
	public void logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("userId");
	}
	public int userIdCheck(String id) {
		return sqlSession.selectOne(namespace+".userIdCheck",id);
		
	}
	//회원정보
	public MemberDTO member_view(HttpServletRequest request) {
		String nick = (String)request.getParameter("nickname");
		return sqlSession.selectOne(namespace+".view",nick);		
	}
	//회원수정
	public int member_modify(MemberDTO dto) {
		return sqlSession.update(namespace+".member_modify",dto);		
	}
	//회원탈퇴
	public int member_withdrawal(String nick) {
		return sqlSession.delete(namespace+".member_withdrawal",nick);			
	}
	//이메일 인증 완료
	public void updateAuthstatus(MemberDTO dto) {
		sqlSession.update(namespace+".updateAuthstatus",dto);
	}
}

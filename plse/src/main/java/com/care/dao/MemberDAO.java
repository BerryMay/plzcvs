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
}

package com.care.dao;

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
		System.out.println("dao 레지스터입니다");
		System.out.println(dto.getId());
		System.out.println(dto.getPw());
		System.out.println(dto.getNickname());
		System.out.println(dto.getGender());
		System.out.println(dto.getMail());
		System.out.println(dto.getAge());
		return sqlSession.insert(namespace+".register",dto);
	}
}

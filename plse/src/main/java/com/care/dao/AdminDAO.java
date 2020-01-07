package com.care.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.care.dto.CvsDTO;

@Component
public class AdminDAO {
	private static final String namespace="com.care.mybatis.adminMapper";
	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(method = RequestMethod.POST)
	public int adminPost(CvsDTO dto) {
		return sqlSession.insert(namespace+".adminPost",dto);
	}
}

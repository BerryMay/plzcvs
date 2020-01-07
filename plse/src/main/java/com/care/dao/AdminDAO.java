package com.care.dao;

import java.util.List;

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
	
	public List<CvsDTO> all_product(){
		return sqlSession.selectList(namespace+".all_product");
	}
	public CvsDTO select_product(CvsDTO dto) {
		return sqlSession.selectOne(namespace+".select_product",dto);
	}
	public void adminProduct_Modify(CvsDTO dto) {
		System.out.println(dto.getCvsnum());
		System.out.println(dto.getProductname());
		System.out.println(dto.getPrice());
		System.out.println(dto.getGdsimg());
		System.out.println(dto.getProductnum());
		sqlSession.update(namespace+".adminProduct_Modify",dto);
	}
}

package com.care.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.care.dto.BoardDTO;

@Component
public class BoardDAO {
	private static final String namespace="com.care.mybatis.boardMapper";
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<BoardDTO> board_list() {
		return sqlSession.selectList(namespace+".board_list");
	}
	public int board_reg(BoardDTO dto) {
		System.out.println(dto.getStars());
		return sqlSession.insert(namespace+".board_reg",dto);
	}
	public BoardDTO board_view(int num) {
		upHit(num);
		return sqlSession.selectOne(namespace+".board_view",num);
	}
	public int board_price(String productname) {
		return sqlSession.selectOne(namespace+".board_price",productname);
	}
	public int upHit(int num) {
		return sqlSession.update(namespace+".upHit",num);
	}
	public int board_modify(BoardDTO dto) {
		return sqlSession.update(namespace+".board_modify",dto);
	}
	public int board_delete(int num) {
		System.out.println("DAO delete num 값 " + num);
		return sqlSession.delete(namespace+".board_delete",num);
	}
	public List<BoardDTO> board_search(HashMap<String, Object> search) {
		return sqlSession.selectList(namespace+".board_search",search);
	}
}

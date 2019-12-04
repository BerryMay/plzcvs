package com.care.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.care.dto.BoardDTO;
import com.care.dto.CommentDTO;

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
	
	//좋아요
	
	public void board_heart(BoardDTO dto) {
		sqlSession.insert(namespace+".board_heart",dto);
	}
	public void board_unheart(BoardDTO dto) {
		sqlSession.delete(namespace+".board_unheart",dto);
	}
	public int board_heartCnt(int bnum) {
		return sqlSession.selectOne(namespace+".board_heartCnt",bnum);
	}
	public int board_heartChk(BoardDTO dto) {
		return sqlSession.selectOne(namespace+".board_heartChk",dto);
	}
	public void board_comment(CommentDTO dto) {
		sqlSession.insert(namespace+".board_comment",dto);
	}
	public List<CommentDTO> board_commentList(int bnum) {
		return sqlSession.selectList(namespace+".board_commentList",bnum);
	}
}

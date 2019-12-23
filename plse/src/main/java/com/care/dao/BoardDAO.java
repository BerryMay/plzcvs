package com.care.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.care.dto.BoardDTO;
import com.care.dto.CommentDTO;
import com.care.dto.CvsDTO;
import com.care.dto.PageCount;

@Component
public class BoardDAO {
	private static final String namespace="com.care.mybatis.boardMapper";
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<BoardDTO> board_list() {
		return sqlSession.selectList(namespace+".board_list");
	}
	@RequestMapping(method = RequestMethod.POST)
	public int board_reg(BoardDTO dto) {
		return sqlSession.insert(namespace+".board_reg",dto);
	}
	public BoardDTO board_view(int num) {
		upHit(num);
		return sqlSession.selectOne(namespace+".board_view",num);
	}
	public int board_price(BoardDTO dto) {
		return sqlSession.selectOne(namespace+".board_price", dto);
	}
	public int upHit(int num) {
		return sqlSession.update(namespace+".upHit",num);
	}
	public int board_modify(BoardDTO dto) {
		System.out.println("dao chk"+dto.getProductname());
		return sqlSession.update(namespace+".board_modify",dto);
	}
	public int board_delete(int num) {
		System.out.println("DAO delete num 값 " + num);
		return sqlSession.delete(namespace+".board_delete",num);
	}
	
	//게시판 서치
	public List<BoardDTO> board_search(BoardDTO dto) {
		return sqlSession.selectList(namespace+".board_search",dto);
	}
	//레시피 서치
	public List<BoardDTO> recipeBoard_search(BoardDTO dto) {
		return sqlSession.selectList(namespace+".recipeBoard_search",dto);
	}
	//게시판 검색
	public List<BoardDTO> cvs_search(BoardDTO dto) {
		System.out.println("cvs넘버dao실행");
		return sqlSession.selectList(namespace+".cvs_search",dto);
	}
	
	public String board_productimg(BoardDTO dto) {
		return sqlSession.selectOne(namespace+".board_productimg",dto);
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
	
	// 리뷰 토탈페이지
		public int getTotalPage() {
			return sqlSession.selectOne(namespace+".board_getTotalPage");
		}
		
	// 리세피 토탈페이지
		public int recipeGetTotalPage() {
			return sqlSession.selectOne(namespace+".recipeBoard_getTotalPage");
		}
		
		
		
	//리뷰페이지
		public List<BoardDTO> page_board_list(PageCount pc) {
			return sqlSession.selectList(namespace+".board_pagingList",pc);
		}
	//레시피페이지
		public List<BoardDTO> recipePage_board_list(PageCount pc) {
			return sqlSession.selectList(namespace+".recipeBoard_pagingList",pc);
		}
		
		
	//상품명 자동완성
	public List<String> productname_autocomplete(int cvsnum) {
		return sqlSession.selectList(namespace+".productname_autocomplete", cvsnum);
	}
	// 관리자
		@RequestMapping(method = RequestMethod.POST)
		public int adminPost(CvsDTO dto) {
			return sqlSession.insert(namespace+".adminPost",dto);
		}
	
}

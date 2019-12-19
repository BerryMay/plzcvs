package com.care.dao;

import java.io.PrintStream;
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
import com.care.dto.SearchCntDTO;

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
		return sqlSession.update(namespace+".board_modify",dto);
	}
	public int board_delete(int num) {
		return sqlSession.delete(namespace+".board_delete",num);
	}
	public List<BoardDTO> board_search(BoardDTO dto) {
		//검색할때 실시간검색어를 위한 검색기록 저장
		search_reg(dto);
		if(dto.getTitle() == null) {
			//실시간검색어 클릭시 검색
			return sqlSession.selectList(namespace+".searchSelect",dto);
		}else {
			//일반적인 검색 수행시
			return sqlSession.selectList(namespace+".board_search",dto);
		}
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
	
	// paging
		public int getTotalPage() {
			return sqlSession.selectOne(namespace+".board_getTotalPage");
		}
		
		public List<BoardDTO> page_board_list(PageCount pc) {
			return sqlSession.selectList(namespace+".board_pagingList",pc);
		}
		
		
	//상품명 자동완성
	public List<String> productname_autocomplete(int cvsnum) {
		return sqlSession.selectList(namespace+".productname_autocomplete", cvsnum);
	}
	//실시간검색어리스트
	public List<SearchCntDTO> searchCnt(){
		return sqlSession.selectList(namespace+".searchCnt");
	}
	//실시간검색어 여부확인
	public Object search_Chk(BoardDTO dto) {
		return sqlSession.selectOne(namespace+".search_chk",dto);
	}
	//실시간검색어 저장
	public void search_reg(BoardDTO dto){
		System.out.println("검색어 저장 실행, content 값 : " + dto.getContent());
		Object a = search_Chk(dto);
		if(a != null){
			sqlSession.update(namespace+".search_update",dto);
		}else {
			sqlSession.insert(namespace+".search_reg",dto);
		}
	}
	// 관리자
		@RequestMapping(method = RequestMethod.POST)
		public int adminPost(CvsDTO dto) {
			return sqlSession.insert(namespace+".adminPost",dto);
		}
	
}

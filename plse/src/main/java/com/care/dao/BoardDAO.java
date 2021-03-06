package com.care.dao;

import java.io.PrintStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
	
	public List<BoardDTO> board_list2() {
		return sqlSession.selectList(namespace+".board_list2");
	}
	public List<BoardDTO> board_list3() {
		return sqlSession.selectList(namespace+".board_list3");
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public int board_reg(BoardDTO dto) {
		int result = sqlSession.insert(namespace+".board_reg",dto);
		if(result==1) { 
			point_post(dto.getNickname());//포인트 주기
		}		
		return result;
	}

	public int recipeboard_reg(BoardDTO dto) {
		return sqlSession.insert(namespace+".recipeboard_reg",dto);
	}

	//게시글 등록시 포인트 주기
	public int point_post(String nick) {
		return sqlSession.update(namespace+".point_post",nick);

	}
	
	public BoardDTO board_view(BoardDTO dto) {
		upHit(dto.getNum());
		System.out.println("여기는 여기"+dto.getNum());
		System.out.println(dto.getNickname());
		return sqlSession.selectOne(namespace+".board_view",dto);
	}
	
	
	public String cvs_newproduct(BoardDTO dto) {
		return sqlSession.selectOne(namespace+".cvs_newproduct",dto);
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
	public int recipeBoard_modify(BoardDTO dto) {
		return sqlSession.update(namespace+".recipeBoard_modify",dto);
	}
	
	//게시글 삭제
	public int board_delete(int num) {
		sqlSession.delete(namespace+".content_commentlist_delete",num);
		sqlSession.delete(namespace+".content_heart_delete",num);
		return sqlSession.delete(namespace+".board_delete",num);
	}
	
	//게시판 서치
	public List<BoardDTO> board_search(BoardDTO dto) {
		//검색할때 실시간검색어를 위한 검색기록 저장
		search_reg(dto);
		if(dto.getTitle() == null) {
			//실시간검색어 클릭시 검색
			System.out.println("실검클릭");
			return sqlSession.selectList(namespace+".searchSelect",dto);
		}else {
			//일반적인 검색 수행시
			return sqlSession.selectList(namespace+".board_search",dto);
		}
	}

	//레시피 서치
	public List<BoardDTO> recipeBoard_search(BoardDTO dto) {
		search_reg(dto);
		if(dto.getTitle() == null) {
			//실시간검색어 클릭시 검색
			return sqlSession.selectList(namespace+".searchSelect",dto);
		}else {
			//일반적인 검색 수행시
		return sqlSession.selectList(namespace+".recipeBoard_search",dto);
		}
	}
	public List<BoardDTO> board_searchCnt(BoardDTO dto){
		return sqlSession.selectList(namespace+".searchSelect",dto);
	}
	//게시판 검색
	public List<BoardDTO> cvs_search(BoardDTO dto) {
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
		
	
	
		// 레시피 토탈페이지
		public int recipeGetTotalPage() {
			return sqlSession.selectOne(namespace+".recipeBoard_getTotalPage");
		}
		public int getSearchTotalPage(BoardDTO dto) {
			return sqlSession.selectOne(namespace+".getSearchTotalPage",dto);
		}
		public int getRecipeSearchTotalPage(BoardDTO dto) {
			return sqlSession.selectOne(namespace+".getRecipeSearchTotalPage",dto);
		}
		public int getSearchCntTotalPage(BoardDTO dto) {
			return sqlSession.selectOne(namespace+".getSearchCntTotalPage",dto);
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
		Object a = search_Chk(dto);
		if(a != null){
			sqlSession.update(namespace+".search_update",dto);
		}else {
			sqlSession.insert(namespace+".search_reg",dto);
		}
	}
	
	
	//내가 쓴 글
	public List<BoardDTO> myboard_list(String nickname) {
		return sqlSession.selectList(namespace+".myboard_list",nickname);
	}
	//좋아요 한 글
	public List<BoardDTO> myheart_list(String nickname) {
		return sqlSession.selectList(namespace+".myheart_list",nickname);
	}
	public void board_img(BoardDTO dto) {
		sqlSession.insert(namespace+".board_img",dto);
	}
	public void board_delImg(BoardDTO dto) {
		sqlSession.delete(namespace+".board_delImg",dto);
	}
	public int seqSelect() {
		return sqlSession.selectOne(namespace+".seqSelect");
	}
	public List<BoardDTO> imgList(String num) {
		System.out.println("imgList DAO 실행 ");
		return sqlSession.selectList(namespace+".imgList",num);
	}
	//베스트 게시글 top3
	public List<BoardDTO> board_best() {
		return sqlSession.selectList(namespace+".board_best");
	}
	//레시피 베스트 게시글 top3
	public List<BoardDTO> recipeBoard_best() {
		return sqlSession.selectList(namespace+".recipeBoard_best");
	}
	
	//페이징하기위해모두
	public int cvsGetTotalPage(int cvsnum) {
		return sqlSession.selectOne(namespace+".cvs_getTotalPage",cvsnum);
	}
	//페이징하는것과 동시에 모두가져오는거
	public List<BoardDTO> cvspaging(PageCount pc) {
		return sqlSession.selectList(namespace+".cvs_pagingList",pc);
	}
	
	
	
}

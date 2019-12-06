package com.care.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.care.dto.*;
import com.care.service.BoardService;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class BoardController {

	@Autowired
	private BoardService bs;
	
	//게시판보기
	@RequestMapping(value = "/board")
	public String board(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		// 페이징 처리하는 sql문 실행하기
		bs.page_board_list(model);
		bs.pagingNum(model);
		return "board/board";
	}

	//게시글 등록페이지
	@RequestMapping(value = "/post")
	public String post() {
		return "board/boardPost";
	}

	//상세보기
	@RequestMapping(value = "/detail")
	public String detail(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		bs.board_view(model);
		return "board/contentView";
	}
	//게시글 등록하기
	@RequestMapping(value = "/board_reg")
	public String board_reg(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);
		bs.board_reg(model);
		return "redirect:board";
	}
	//게시글 수정페이지
	@RequestMapping(value = "/board_modify")
	public String board_modify(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		bs.board_view(model);
		return "board/contentModify";
	}
	//게시글 수정하기
	@RequestMapping(value = "/board_modifyOk")
	public String board_modifyOk(Model model,BoardDTO dto) {
		model.addAttribute("dto", dto);
		bs.board_modify(model);
		return "redirect:detail?num="+dto.getNum();
	}
	//게시글 삭제
	@RequestMapping(value = "/board_delete")
	public String board_delete(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		bs.board_delete(model);
		return "redirect:board";
	}
	//게시글 검색
	@RequestMapping(value = "/board_search")
	public String board_search(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		bs.board_search(model);
		return "board/boardSearch";
	}
	//좋아요
	@RequestMapping(value = "/board_heart")
	@ResponseBody
	public void board_heart(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		bs.board_heart(model);
	}
	//좋아요취소
	@RequestMapping(value = "/board_unheart")
	@ResponseBody
	public void board_unheart(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		bs.board_unheart(model);
	}
	//좋아요 여부 체크
	@RequestMapping(value = "/board_heartChk")
	@ResponseBody
	public int board_heartChk(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		return bs.board_heartChk(model);
	}
	//좋아요 수
	@RequestMapping(value = "/board_heartCnt")
	@ResponseBody
	public int board_heartCnt(Model model,BoardDTO dto) {
		model.addAttribute("dto", dto);
		return bs.board_heartCnt(model);
	}
	//댓글 저장
	@RequestMapping(value = "/board_comment")
	@ResponseBody
	public void board_comment(Model model,CommentDTO dto) {
		model.addAttribute("dto", dto);
		bs.board_comment(model);
	}
	//댓글 리스트
	@RequestMapping(value = "/board_commentList")
	@ResponseBody
	public List<CommentDTO> board_commentList(Model model,CommentDTO dto) {
		model.addAttribute("dto", dto);
		System.out.println(bs.board_commentList(model));
		return bs.board_commentList(model);
	}
	
	//관리자 상품등록창
	//관리자 물품등록
	
	@RequestMapping(value = "/adminPost")
	public String adminPost() {
		return "admin/adminPost";
	}
}

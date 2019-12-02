package com.care.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.care.dto.BoardDTO;
import com.care.service.BoardService;

@Controller
public class BoardController {

	@Autowired
	private BoardService bs;
	
	//게시판보기
	@RequestMapping(value = "/board")
	public String board(Model model) {
		bs.board_list(model);
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
		System.out.println("modifyOk num = " +dto.getNum());
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
		System.out.println("검색완료");
		return "board/boardSearch";
	}
	//관리자 상품등록창
	//관리자 물품등록
	
	@RequestMapping(value = "/adminPost")
	public String adminPost() {
		return "admin/adminPost";
	}
}

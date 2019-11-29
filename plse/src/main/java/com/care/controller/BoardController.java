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
<<<<<<< HEAD
	//게시판보기
=======
	@Autowired
	private BoardService bs;
	
>>>>>>> branch 'master' of https://github.com/BerryMay/plzcvs.git
	@RequestMapping(value = "/board")
	public String board(Model model) {
		bs.board_list(model);
		return "board/board";
	}
	
	//게시글 수정
	@RequestMapping(value = "/contentmodify")
	public String contentmodify() {
		return "board/contentmodify";
	}
	//게시글 등록페이지
	@RequestMapping(value = "/post")
	public String post() {
		return "board/boardPost";
	}
<<<<<<< HEAD
	
	//상세보기
=======
	//게시글 1개 보기
>>>>>>> branch 'master' of https://github.com/BerryMay/plzcvs.git
	@RequestMapping(value = "/detail")
	public String detail(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		bs.board_view(model);
		return "board/contentView";
	}
<<<<<<< HEAD

	//관리자 상품등록창
=======
	//관리자 물품등록
>>>>>>> branch 'master' of https://github.com/BerryMay/plzcvs.git
	@RequestMapping(value = "/adminPost")
	public String adminPost() {
		return "admin/adminPost";
	}
	//게시글 등록하기
	@RequestMapping(value = "/board_reg")
	public String board_reg(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);
		bs.board_reg(model);
		return "redirect:board";
	}

}

package com.care.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BoardController {
	
	@RequestMapping(value = "/board")
	public String board() {
		return "board/board";
	}
	//게시글 수정
	@RequestMapping(value = "/contentmodify")
	public String contentmodify() {
		return "board/contentmodify";
	}
	//게시글 등록
	@RequestMapping(value = "/post")
	public String post() {
		return "board/boardPost";
	}
	
	@RequestMapping(value = "/detail")
	public String detail() {
		return "board/contentView";
	}

	@RequestMapping(value = "/adminPost")
	public String adminPost() {
		return "admin/adminPost";
	}

}

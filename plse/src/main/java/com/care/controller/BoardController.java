package com.care.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BoardController {
	//게시글 등록
	@RequestMapping(value = "/board")
	public String board() {
		return "board/boardPost";
	}
	//게시글 수정
	@RequestMapping(value = "/contentmodify")
	public String contentmodify() {
		return "board/contentmodify";
	}
	@RequestMapping(value = "/post")
	public String post() {
		return "board/contentView";
	}
	
}

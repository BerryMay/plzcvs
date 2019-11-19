package com.care.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BoardController {
	
	@RequestMapping(value = "/board")
	public String board() {
		return "board/board";
	}
	
	@RequestMapping(value = "/post")
	public String post() {
		return "board/boardPost";
	}
	
	@RequestMapping(value = "/detail")
	public String detail() {
		return "board/contentView";
	}
	

	
}

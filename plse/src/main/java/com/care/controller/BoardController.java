package com.care.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BoardController {
	
	@RequestMapping(value = "/board")
	public String board() {
		return "board/boardPost";
	}
	
	@RequestMapping(value = "/post")
	public String post() {
		return "board/contentView";
	}
	

	
}

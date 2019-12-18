package com.care.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.care.dto.CommentDTO;
import com.care.service.CommentService;

@Controller
public class CommentController {

	@Autowired
	private CommentService cs;	
	
	@RequestMapping(value = "comment_list")
	@ResponseBody	
	public List<CommentDTO> comment_list(Model model, CommentDTO dto) {
		
		model.addAttribute("dto", dto);
		return cs.comment_list(model);
	}
	
	//댓글 등록하기
	@RequestMapping(value = "reply_insert")
	@ResponseBody
	public void comment_create(Model model, CommentDTO dto) {
		model.addAttribute("dto", dto);
		cs.comment_create(model);		
	}


	//댓글수정
	@RequestMapping(value = "comment_modify")
	@ResponseBody
	public CommentDTO comment_update(Model model, CommentDTO dto) {
		model.addAttribute("dto", dto);
		cs.comment_modify(model);
		return dto;
	}

	
	//댓글 삭제
	@RequestMapping(value = "comment_delete")
	@ResponseBody
	public void comment_delete(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		cs.comment_delete(model);
	}
}

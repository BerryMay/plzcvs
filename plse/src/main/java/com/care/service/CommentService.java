package com.care.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.care.dao.CommentDAO;
import com.care.dto.CommentDTO;

@Service
public class CommentService implements ICommentService {
	@Autowired
	CommentDAO dao;

	//댓글 불러오기
	@Override
	public List<CommentDTO> comment_list(Model model) {
		Map<String, Object> map = model.asMap();
		CommentDTO dto = (CommentDTO)map.get("dto");	
		dto.setContent(dto.getContent().replace("\r\n", "<br>"));
		return dao.comment_list(dto.getBnum());
	}
	
	//댓글 생성
	@Override
	public void comment_create(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		CommentDTO dto = (CommentDTO)map.get("dto");
		dao.comment_create(dto);
		
	}

	//댓글 수정
	@Override
	public void comment_modify(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		CommentDTO dto = (CommentDTO)map.get("dto");
		dao.comment_modify(dto);
		
	}

	//댓글 삭제
	@Override
	public void comment_delete(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		dao.comment_delete(Integer.parseInt(request.getParameter("cnum")));
		
	}

	
}

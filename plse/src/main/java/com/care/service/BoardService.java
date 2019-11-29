package com.care.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.care.dao.BoardDAO;
import com.care.dto.BoardDTO;
@Service
public class BoardService implements IBoardService{
	@Autowired
	BoardDAO dao;
	
	@Override
	public void board_list(Model model) {
		model.addAttribute("list", dao.board_list());
	}
	@Override
	public void board_reg(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		BoardDTO dto = new BoardDTO();
		dto.setTitle(request.getParameter("title"));
		dto.setNickname(request.getParameter("nickname"));
		dto.setStars(Integer.parseInt(request.getParameter("stars")));
		dto.setProductname(request.getParameter("productname"));
		dto.setContent(request.getParameter("content"));
		dto.setCvsnum(Integer.parseInt(request.getParameter("cvsnum")));
		dao.board_reg(dto);
	}
	@Override
	public void board_view(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		model.addAttribute("dto", dao.board_view(Integer.parseInt(request.getParameter("num"))));
	}
}

package com.care.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
		dto.setStars(Double.parseDouble(request.getParameter("stars")));
		dto.setProductname(request.getParameter("productname"));
		dto.setContent(request.getParameter("content"));
		dto.setCvsnum(Integer.parseInt(request.getParameter("cvsnum")));
		dao.board_reg(dto);
	}
	@Override
	public void board_view(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		BoardDTO dto = dao.board_view(Integer.parseInt(request.getParameter("num")));
		model.addAttribute("dto", dto);
		HttpSession session = request.getSession();
		session.setAttribute("price", dao.board_price(dto.getProductname()));
	}
	@Override
	public void board_modify(Model model) {
		Map<String, Object> map = model.asMap();
		//HttpServletRequest request = (HttpServletRequest)map.get("request");
		BoardDTO dto = (BoardDTO)map.get("dto");
		dao.board_modify(dto);
	}
	@Override
	public void board_delete(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		dao.board_delete(Integer.parseInt(request.getParameter("num")));
	}
	@Override
	public void board_search(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		HashMap<String, Object> search = new HashMap<String, Object>();
		String s1 = request.getParameter("searchSelect");
		String s2 = request.getParameter("searchText");
		search.put("searchSelect", s1 );
		search.put("searchText", s2 );
		model.addAttribute("dto", dao.board_search(search));
	}
	@Override
	public int board_heart(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		BoardDTO dto = new BoardDTO();
		dto.setNum(Integer.parseInt(request.getParameter("num")));
		dto.setNickname(request.getParameter("nickname"));
		dao.board_heart(dto);
		return 0;
	}
	@Override
	public int board_unheart(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		BoardDTO dto = new BoardDTO();
		dto.setNum(Integer.parseInt(request.getParameter("num")));
		dto.setNickname(request.getParameter("nickname"));
		dao.board_unheart(dto);
		return 0;
	}
	@Override
	public int board_heartCnt(Model model) {
		Map<String, Object> map = model.asMap();
		BoardDTO dto = (BoardDTO)map.get("dto");
		return dao.board_heartCnt(dto.getNum());
	}
	@Override
	public int board_heartChk(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		BoardDTO dto = new BoardDTO();
		dto.setNum(Integer.parseInt(request.getParameter("num")));
		dto.setNickname(request.getParameter("nickname"));
		return dao.board_heartChk(dto);
	}
}

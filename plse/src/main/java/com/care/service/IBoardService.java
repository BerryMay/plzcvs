package com.care.service;

import java.util.List;

import org.springframework.ui.Model;

import com.care.dto.CommentDTO;

public interface IBoardService {
	public void board_list(Model model);
	public void board_reg(Model model);
	public void board_view(Model model);
	public void board_modify(Model model);
	public void board_delete(Model model);
	public void board_search(Model model);
	public int board_heart(Model model);
	public int board_unheart(Model model);
	public int board_heartCnt(Model model);
	public int board_heartChk(Model model);
	public void board_comment(Model model);
	public List<CommentDTO> board_commentList(Model model);
}

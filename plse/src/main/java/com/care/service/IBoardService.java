package com.care.service;

import org.springframework.ui.Model;

public interface IBoardService {
	public void board_list(Model model);
	public void board_reg(Model model);
	public void board_view(Model model);
}

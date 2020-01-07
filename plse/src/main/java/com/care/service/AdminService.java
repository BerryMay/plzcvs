package com.care.service;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.care.dao.AdminDAO;
import com.care.dao.BoardDAO;
import com.care.dto.CvsDTO;

@Service
public class AdminService {
	@Autowired
	AdminDAO dao;
	@Resource(name="uploadPath")
	private String uploadPath;
	//관리자 작성 
	
	@RequestMapping(method = RequestMethod.POST)
	public void adminPost(CvsDTO dto) throws Exception{
		dao.adminPost(dto);
	}

	public void all_product(Model model) {
		model.addAttribute("product", dao.all_product());
	}
	public CvsDTO select_product(CvsDTO dto) {
		return dao.select_product(dto);
	}
	public void adminProduct_Modify(CvsDTO dto) {
		dao.adminProduct_Modify(dto);
	}
}

package com.care.controller;

import java.io.File;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.care.dto.CvsDTO;
import com.care.file.UploadFileUtils;
import com.care.service.BoardService;

@Controller
public class AdminController {
	@Autowired
	private BoardService bs;
	@Resource(name="uploadPath")
	private String uploadPath;
	
	//관리자 물품등록
	@RequestMapping(value = "/adminPost")
	public String adminPost() {
		System.out.println("실행");
		return "admin/adminPost";
	}
	///물픔등록ok
	@RequestMapping(value = "/adminPostOk", method = RequestMethod.POST)
	public String adminPost(Model model,CvsDTO dto,MultipartFile file) throws Exception {
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath); 
			dto.setGdsimg("imgUpload" + ymdPath + File.separator + fileName);
		}else {
			dto.setGdsimg(null);
		}
		bs.adminPost(dto);
		return "admin/adminPost";
	}
	@RequestMapping(value = "/adminPage")
	public String adminPage() {
		return "admin/adminPage";
	}
	
	@RequestMapping(value = "/adminProduct")
	public String adminProduct() {
		return "admin/adminProduct";
	}

	@RequestMapping(value = "/adminMember")
	public String adminMember() {
		return "admin/adminMember";
	}
	
	
}

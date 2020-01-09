package com.care.controller;


import java.io.File;
import java.util.List;

import javax.annotation.Resource;

import javax.servlet.http.HttpServletRequest;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.care.dto.CvsDTO;
import com.care.dto.MemberDTO;
import com.care.file.UploadFileUtils;
import com.care.service.AdminService;
import com.care.service.BoardService;
import com.care.service.MemberService;

@Controller
public class AdminController {
	@Autowired
	private BoardService bs;
	@Autowired
	private AdminService adbs;
	@Autowired
	private MemberService ms;

	@Resource(name="uploadPath")
	private String uploadPath;
	
	//관리자 물품등록
	@RequestMapping(value = "/adminPost")
	public String adminPost(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		ms.member_view(model);
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
		adbs.adminPost(dto);
		return "admin/adminPost";
	}
	//전체상품
	@RequestMapping(value = "/adminProduct")
	public String adminProduct(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		ms.member_view(model);
		adbs.all_product(model);
		return "admin/adminProduct";
	}
	//상품 수정페이지
	@RequestMapping(value = "/adminProduct_modify")
	public String adminProduct_Modify(Model model,CvsDTO dto,HttpServletRequest request) {
		model.addAttribute("request", request);
		ms.member_view(model);
		model.addAttribute("product", adbs.select_product(dto));
		return "admin/adminProduct_Modify";
	}
	//상품 수정등록
	@RequestMapping(value = "/adminProduct_ModifyOk", method = RequestMethod.POST)
	public String adminProduct_ModifyOk(Model model,CvsDTO dto,MultipartFile file) throws Exception{
		System.out.println(dto.getGdsimg());
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			dto.setGdsimg("imgUpload" + ymdPath + File.separator + fileName);
		}
		adbs.adminProduct_Modify(dto);
		return "default/index";
	}

	@RequestMapping(value = "/adminMember")
	public String adminMember(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		ms.member_view(model);
		return "admin/adminMember";
	}

	
	/* 관리자멤버관리 */
	@RequestMapping(value = "/admin_member")
	@ResponseBody
	public List<MemberDTO> adim_member(Model model) {
		List<MemberDTO> list = adbs.admin_list(model);
		return adbs.admin_list(model);
	}
	
	@RequestMapping(value = "/member_delete")
	@ResponseBody
	public void member_delete(Model model,HttpServletRequest request) {	
		model.addAttribute("request", request);
		adbs.member_delete(model);
	}
	
	@RequestMapping(value = "/repoint")
	@ResponseBody
	public void repoint(Model model,HttpServletRequest request) {	
		model.addAttribute("request", request);
		adbs.repoint(model);
	}
	
	
}

package com.care.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.care.dto.BoardDTO;
import com.care.dto.CommentDTO;
import com.care.dto.MemberDTO;
import com.care.service.BoardService;
import com.care.service.CommentService;
import com.care.service.MemberService;

@Controller
public class MypageController {

	@Autowired
	private BoardService bs;
	@Autowired
	private CommentService cs;
	@Autowired
	private MemberService ms;
	


	//마이페이지
	@RequestMapping(value = "/mypage")
	public String mypage(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);
		ms.member_view(model);
		return "myPage/mypage";
	}
	
	//회원정보 수정
	@RequestMapping(value = "/member_modify")
	public String member_modify(Model model, MemberDTO dto) {
		model.addAttribute("dto", dto);
		System.out.println(dto.getNickname());
		ms.member_modify(model);
		return "redirect:/mypage?nickname="+dto.getNickname();
	}
	
	
	//회원탈퇴
	@RequestMapping(value = "/withdrawal")
	public String withdrawal(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);
		ms.member_withdrawal(model);	
		return "redirect:logout";
	}
	
	//메인화면
	@RequestMapping(value = "practice/")
	public String practice(Model model, MemberDTO dto) {
		return "default/index";
	}
	
	
	//내가 쓴 글 게시판보기
	@RequestMapping(value = "/myboard_list")
	@ResponseBody
	public List<BoardDTO> myboard_list(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);
		List<BoardDTO> lb =bs.myboard_list(model);

		return bs.myboard_list(model);
	}

	//내가 좋아요 한 글 게시판보기
	@RequestMapping(value = "/myheart_list")
	@ResponseBody
	public List<BoardDTO> myheart_list(Model model, HttpServletRequest request) {
		model.addAttribute("request", request);
		return bs.myheart_list(model);
	}
	
	
	
	
	
	
	
	
}

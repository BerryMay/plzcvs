package com.care.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.care.dto.*;
import com.care.file.UploadFileUtils;
import com.care.service.BoardService;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class BoardController {

	@Autowired
	private BoardService bs;
	@Resource(name="uploadPath")
	private String uploadPath;
	
	//게시판보기
	@RequestMapping(value = "/board")
	public String board(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		bs.board_best(model);//베스트 게시글 가져오기
		// 페이징 처리하는 sql문 실행하기
		bs.page_board_list(model);
		//bs.pagingNum(model);
		
		return "board/board";
	}
	//레시피게시판보기
	@RequestMapping(value = "/recipeBoard")
	public String recipeBoard(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		bs.recipeBoard_best(model);//레시피 베스트 게시글 가져오기
		bs.recipePage_board_list(model);
		
		return "board/recipeBoard";
	}
	
	//게시글에 값 넣어주기 
	
	
	//게시글 등록페이지
	@RequestMapping(value = "/post")
	public String post() {
		return "board/boardPost";
	}
	//레시피 게시글 등록페이지
	@RequestMapping(value = "/recipePost")
	public String recipePost() {
		return "board/recipePost";
	}
	//게시글 등록하기
	@RequestMapping(value = "/board_reg", method = RequestMethod.POST )
	public String board_reg(Model model,BoardDTO dto,List<MultipartFile> file) throws Exception {
		int num = bs.seqSelect();
		dto.setNum(num);
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		if(file.get(0).getOriginalFilename() != null && file.get(0).getOriginalFilename() != "") {
			dto.setGdsimg("1");
			bs.board_reg(dto);
			for (int i = 0; i < file.size(); i++) {
				fileName = UploadFileUtils.fileUpload(imgUploadPath, file.get(i).getOriginalFilename(), file.get(i).getBytes(), ymdPath); 
				dto.setGdsimg("imgUpload" + ymdPath + File.separator + fileName);
				bs.board_img(dto);
			}
		}else {
			dto.setGdsimg(null);
			bs.board_reg(dto);
		}
		return "redirect:board";
	}
	@RequestMapping(value = "/recipeBoard_reg", method = RequestMethod.POST )
	   public String recipeBoard_reg(Model model,BoardDTO dto,List<MultipartFile> file) throws Exception {
	      int num = bs.seqSelect();
	      dto.setNum(num);
	      String imgUploadPath = uploadPath + File.separator + "imgUpload";
	      String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
	      String fileName = null;
	         if(file.get(0).getOriginalFilename() != null && file.get(0).getOriginalFilename() != "") {
	            dto.setGdsimg("1");
	            bs.board_reg(dto);
	            for (int i = 0; i < file.size(); i++) {            
	            fileName = UploadFileUtils.fileUpload(imgUploadPath, file.get(i).getOriginalFilename(), file.get(i).getBytes(), ymdPath); 
	            dto.setGdsimg("imgUpload" + ymdPath + File.separator + fileName);
	            bs.board_img(dto);
	            }
	         }else {
	            dto.setGdsimg(null);
	            bs.board_reg(dto);
	         }      
	      return "redirect:recipeBoard";
	   }

		
	//리뷰상세보기
	@RequestMapping(value = "/detail")
	public String detail(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		bs.board_view(model);
		return "board/contentView";
	}
	//레시피상세보기
	@RequestMapping(value = "/recipeDetail")
	public String recipeDetail(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		bs.recipeboard_view(model);
		return "board/recipeView";
	}
	
	
	
	//게시글 수정페이지
	@RequestMapping(value = "/board_modify")
	public String board_modify(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		bs.board_view(model);
		return "board/contentModify";
	}
	//레시피 게시글 수정페이지
	@RequestMapping(value = "/recipeBoard_modify")
	public String recipeBoard_modify(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		bs.recipeboard_view(model);
		return "board/recipeContentModify";
	}
		
	
	//게시글 수정하기
	@RequestMapping(value = "/board_modifyOk", method = RequestMethod.POST)
	public String board_modifyOk(Model model,BoardDTO dto,List<MultipartFile> file) throws Exception {
		if(file.get(0).getOriginalFilename() != null && !file.get(0).getOriginalFilename().equals("")) {
			bs.board_delImg(dto);
			for(int i=0; i<file.size(); i++) {
				new File(uploadPath + dto.getGdsimg()).delete();
				String imgUploadPath = uploadPath + File.separator + "imgUpload";
				String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
				String fileName = UploadFileUtils.fileUpload(imgUploadPath, file.get(i).getOriginalFilename(), file.get(i).getBytes(), ymdPath); 
				dto.setGdsimg("imgUpload" + ymdPath + File.separator + fileName);
				bs.board_img(dto);
			}
		}
		model.addAttribute("dto", dto);
		bs.board_modify(model);
		return "redirect:detail?num="+dto.getNum();
	}
	//레시피 게시글 수정하기
	@RequestMapping(value = "/recipeBoard_modifyOk", method = RequestMethod.POST)
	public String recipeBoard_modifyOk(Model model,BoardDTO dto,List<MultipartFile> file) throws Exception {
		if(file.get(0).getOriginalFilename() != null && !file.get(0).getOriginalFilename().equals("")) {
			bs.board_delImg(dto);
			for(int i=0; i<file.size(); i++) {
				new File(uploadPath + dto.getGdsimg()).delete();
				String imgUploadPath = uploadPath + File.separator + "imgUpload";
				String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
				String fileName = UploadFileUtils.fileUpload(imgUploadPath, file.get(i).getOriginalFilename(), file.get(i).getBytes(), ymdPath); 
				dto.setGdsimg("imgUpload" + ymdPath + File.separator + fileName);
				bs.board_img(dto);
			}
		}
		model.addAttribute("dto", dto);
		bs.recipeBoard_modify(model);
		return "redirect:recipeDetail?num="+dto.getNum();
	}
	
	
	//게시글 삭제
	@RequestMapping(value = "/board_delete")
	public String board_delete(Model model,HttpServletRequest request,BoardDTO dto) {
		model.addAttribute("request", request);
		bs.board_delete(model);
		bs.board_delImg(dto);
		return "redirect:board";
	}
	//레시피게시글 삭제
	@RequestMapping(value = "/recipeBoard_delete")
	public String recipeBoard_delete(Model model,HttpServletRequest request,BoardDTO dto) {
		model.addAttribute("request", request);
		bs.board_delete(model);
		bs.board_delImg(dto);
		return "redirect:recipeBoard";
	}
	
	//게시글 검색
	@RequestMapping(value = "/board_search")
	public String board_search(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		bs.board_best(model);//베스트 게시글 가져오기
		bs.board_search(model);
		return "board/boardSearch";
	}
	//레시피 게시글 검색
	@RequestMapping(value = "/recipeBoard_search")
	public String recipeBoard_search(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		bs.recipeBoard_best(model);//레시피 베스트 게시글 가져오기
		bs.recipeBoard_search(model);
		return "board/recipeBoardSearch";
	}
	//실시간검색어 클릭시 검색
	@RequestMapping(value = "/board_SearchCntOk")
	public String board_SearchCntOk(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		bs.board_searchCnt(model);
		return "board/boardSearchCnt";
	}
	//편의점 검색
	@RequestMapping(value = "/cvs_search")
	public String cvs_search(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		bs.board_best(model);//베스트 게시글 가져오기
		bs.page_cvs_search(model);
		
	
		return "board/boardSearchCVS";
	}
	
	//좋아요
	@RequestMapping(value = "/board_heart")
	@ResponseBody
	public void board_heart(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		bs.board_heart(model);
	}
	//좋아요취소
	@RequestMapping(value = "/board_unheart")
	@ResponseBody
	public void board_unheart(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		bs.board_unheart(model);
	}
	//좋아요 여부 체크
	@RequestMapping(value = "/board_heartChk")
	@ResponseBody
	public int board_heartChk(Model model,HttpServletRequest request) {
		model.addAttribute("request", request);
		return bs.board_heartChk(model);
	}
	//좋아요 수
	@RequestMapping(value = "/board_heartCnt")
	@ResponseBody
	public int board_heartCnt(Model model,BoardDTO dto) {
		model.addAttribute("dto", dto);
		return bs.board_heartCnt(model);
	}
	//댓글 저장
	@RequestMapping(value = "/board_comment")
	@ResponseBody
	public void board_comment(Model model,CommentDTO dto) {
		model.addAttribute("dto", dto);
		bs.board_comment(model);
	}
	//댓글 리스트
	@RequestMapping(value = "/board_commentList")
	@ResponseBody
	public List<CommentDTO> board_commentList(Model model,CommentDTO dto) {
		model.addAttribute("dto", dto);
		return bs.board_commentList(model);
	}
	
	
	//상품명 자동완성
	@RequestMapping(value = "productname_autocomplete")
	@ResponseBody
	
	public List<String> productname_autocomplete(Model model, HttpServletRequest request) {
		
		model.addAttribute("request", request);
		return bs.productname_autocomplete(model);
	}
	//실시간검색어 리스트
	@RequestMapping(value = "board_searchCnt")
	@ResponseBody
	public List<SearchCntDTO> board_searchCnt(){
		return bs.searchCnt();
	}
}
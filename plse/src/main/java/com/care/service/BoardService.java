package com.care.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.care.dao.BoardDAO;
import com.care.dto.BoardDTO;
import com.care.dto.CommentDTO;
import com.care.dto.CvsDTO;
import com.care.dto.PageCount;
import com.care.dto.SearchCntDTO;
import com.care.file.UploadFileUtils;
import com.fasterxml.jackson.databind.BeanProperty.Bogus;

@Service
public class BoardService implements IBoardService{
	@Autowired
	BoardDAO dao;
	@Resource(name="uploadPath")
	private String uploadPath;
	
	
	/* 차트 1,2,3 */
	@Override
	public List<BoardDTO> board_list() {
		return  dao.board_list();
	}
	
	public List<BoardDTO> board_list2() {
		return  dao.board_list2();
	}
	
	public List<BoardDTO> board_list3() {
		return  dao.board_list3();
	}
	
	
	@Override
	@RequestMapping(method = RequestMethod.POST)
	public void board_reg(BoardDTO dto) throws Exception {
		dao.board_reg(dto);
	}
	
	@Override
	@RequestMapping(method = RequestMethod.POST)
	public void recipeboard_reg(BoardDTO dto) throws Exception {
		dao.recipeboard_reg(dto);
	}
	
	
	
	@Override
	public void board_view(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		BoardDTO dto = dao.board_view(Integer.parseInt(request.getParameter("num")));
		dto.setContent(dto.getContent().replace("\r\n", "<br>"));
		model.addAttribute("dto", dto);
		try {
			model.addAttribute("imgList", dao.imgList(request.getParameter("num")));		
		} catch (Exception e) { System.out.println("사진 없음");}
		HttpSession session = request.getSession();
		try {
		session.setAttribute("price", dao.board_price(dto));
		session.setAttribute("productimg", dao.board_productimg(dto));
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	@Override
	public void recipeboard_view(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		BoardDTO dto = dao.board_view(Integer.parseInt(request.getParameter("num")));
		dto.setContent(dto.getContent().replace("\r\n", "<br>"));
		model.addAttribute("dto", dto);
		try {
			model.addAttribute("imgList", dao.imgList(request.getParameter("num")));	
			HttpSession session = request.getSession();
			session.setAttribute("productimg", dao.board_productimg(dto));			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	//게시판 수정
	@Override
	public void board_modify(Model model) {
		Map<String, Object> map = model.asMap();
		//HttpServletRequest request = (HttpServletRequest)map.get("request");
		BoardDTO dto = (BoardDTO)map.get("dto");
		dao.board_modify(dto);
	}
	//레시피 게시판 수정
	@Override
	public void recipeBoard_modify(Model model) {
		Map<String, Object> map = model.asMap();
		//HttpServletRequest request = (HttpServletRequest)map.get("request");
		BoardDTO dto = (BoardDTO)map.get("dto");
		dao.recipeBoard_modify(dto);
	}
	
	
	
	@Override
	public void board_delete(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		dao.board_delete(Integer.parseInt(request.getParameter("num")));
	}
	
	//게시판서치
	@Override
	public void board_search(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		BoardDTO dto = new BoardDTO();
		dto.setTitle(request.getParameter("title"));
		dto.setContent(request.getParameter("content"));
		model.addAttribute("dto", dao.board_search(dto));
	}
	
	//레시피내부서치
		@Override
		public void recipeBoard_search(Model model) {
			Map<String, Object> map = model.asMap();
			HttpServletRequest request = (HttpServletRequest)map.get("request");
			BoardDTO dto = new BoardDTO();
			dto.setTitle(request.getParameter("title"));
			dto.setContent(request.getParameter("content"));
			model.addAttribute("dto", dao.recipeBoard_search(dto));
		}
	
		//편의점 검색
		@Override
		public void cvs_search(Model model) {
			Map<String, Object> map = model.asMap();
			HttpServletRequest request = (HttpServletRequest)map.get("request");
			BoardDTO dto = new BoardDTO();
			dto.setCvsnum(Integer.parseInt(request.getParameter("cvsnum")));
			model.addAttribute("dto", dao.cvs_search(dto));
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
	@Override
	public void board_comment(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		CommentDTO dto = (CommentDTO)map.get("dto");
		dao.board_comment(dto);
	}
	@Override
	public List<CommentDTO> board_commentList(Model model) {
		Map<String, Object> map = model.asMap();
		CommentDTO dto = (CommentDTO)map.get("dto");	
		return dao.board_commentList(dto.getBnum());
	}
	
	// 전체 게시글 갯수 가져오기
		public int getTotalPage() {
			return dao.getTotalPage();
		}
		
		public int getRecipeTotalPage() {
			return dao.recipeGetTotalPage();
		}
		
		
		
		// 가져온 게시글 갯수를 이용하여 페이징 계산하기
		public PageCount pagingNum(Model model) {
			int start = 0;
			Map<String, Object> map = model.asMap();
			HttpServletRequest request = (HttpServletRequest)map.get("request");
			// start 값 가져오기
			if(request.getParameter("start") == null ) start = 0;
			else start = Integer.parseInt(request.getParameter("start"));
			// 맨처음 리뷰게시판 들어올때 
			if(start == 0) start=1;
			PageCount pc = new PageCount();
			// 페이지에 보여줄 게시글 갯수
			int pageNum=10;
			// 전체 게시글 갯수 가져오기
			int totalPage = getTotalPage();
			// 전체 게시글 갯수 / 페이지 보여줄 게시글 갯수 + (나머지 값이 있으면 + 1) 마지막 페이지 번호를 정하는 식
			int totEndPage = totalPage/pageNum + (totalPage%pageNum == 0 ?0 :1);
			// 페이지 넘버를 눌렀을때 첫번째 상단에 보여줄 게시글 번호 
			int startPage = (start - 1) * pageNum + 1;
			// 페이지 넘버를 눌렀을 때 마지막에 보여줄 게시글 번호
			int endPage = pageNum * start;
			
			pc.setTotEndPage(totEndPage);
			pc.setStartPage(startPage);
			pc.setEndPage(endPage);
			model.addAttribute("pc", pc);
			return pc;
		}
		
		
		
		public PageCount recipePagingNum(Model model) {
			int start = 0;
			Map<String, Object> map = model.asMap();
			HttpServletRequest request = (HttpServletRequest)map.get("request");
			// start 값 가져오기
			if(request.getParameter("start") == null ) start = 0;
			else start = Integer.parseInt(request.getParameter("start"));
			// 맨처음 리뷰게시판 들어올때 
			if(start == 0) start=1;
			PageCount pc = new PageCount();
			// 페이지에 보여줄 게시글 갯수
			int pageNum=10;
			// 전체 게시글 갯수 가져오기
			int totalPage = getRecipeTotalPage();
			// 전체 게시글 갯수 / 페이지 보여줄 게시글 갯수 + (나머지 값이 있으면 + 1) 마지막 페이지 번호를 정하는 식
			int totEndPage = totalPage/pageNum + (totalPage%pageNum == 0 ?0 :1);
			// 페이지 넘버를 눌렀을때 첫번째 상단에 보여줄 게시글 번호 
			int startPage = (start - 1) * pageNum + 1;
			// 페이지 넘버를 눌렀을 때 마지막에 보여줄 게시글 번호
			int endPage = pageNum * start;
			
			pc.setTotEndPage(totEndPage);
			pc.setStartPage(startPage);
			pc.setEndPage(endPage);
			model.addAttribute("pc", pc);
			return pc;
		}
		
		
		
		// 페이징된 리스트 가져오기
		public void page_board_list(Model model) {
			model.addAttribute("list", dao.page_board_list(pagingNum(model)));
		}
		
		public void recipePage_board_list(Model model) {
			// 페이징된 리스트 가져오기
			model.addAttribute("list", dao.recipePage_board_list(recipePagingNum(model)));
		}
		
		
	//관리자 작성 
	@RequestMapping(method = RequestMethod.POST)
	public void adminPost(CvsDTO dto) throws Exception{
			dao.adminPost(dto);
			
		}
	//자동완성	
	@Override
	public List<String> productname_autocomplete(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");

		return dao.productname_autocomplete(Integer.parseInt(request.getParameter("cvsnum")));
	}
	//실시간검색어 리스트
	public List<SearchCntDTO> searchCnt(){
		return dao.searchCnt();
	}
	
	//내가 쓴 글 가져오기
	public List<BoardDTO> myboard_list(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		String nick= request.getParameter("nickname");
		
		return  dao.myboard_list(nick);	
	}
	
	//내가 좋아요 한 글 가져오기
	public List<BoardDTO> myheart_list(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		String nickname= request.getParameter("nickname");
		return  dao.myheart_list(nickname);	
	}
	//게시글작성시 이미지 저장
	public void board_img(BoardDTO dto) {
		dao.board_img(dto);
	}
	//게시글 수정시 사진 변경되면 기존 이미지 삭제
	public void board_delImg(BoardDTO dto) {
		dao.board_delImg(dto);
	}
	//시퀀스 조회
	public int seqSelect() {
		return dao.seqSelect();
	}
	

	//베스트 게시글 top3
	@Override
	public void board_best(Model model) {
		model.addAttribute("best_list", dao.board_best());
	}
	
	//레시피 베스트 게시글 top3
	@Override
	public void recipeBoard_best(Model model) {
		model.addAttribute("best_list", dao.recipeBoard_best());
	}
	
	//레시피 페이징
	public void page_cvs_search(Model model) {
		model.addAttribute("list", dao.cvspaging(cvs_PagingNum(model)));
		
	}

	public PageCount cvs_PagingNum(Model model) {
		System.out.println("페이징은 하셔야죠");
		int start = 0;
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		// start 값 가져오기
	//	BoardDTO dto = new BoardDTO();
	//	dto.setCvsnum(Integer.parseInt(request.getParameter("cvsnum")));
		
		int cvsnum = Integer.parseInt(request.getParameter("cvsnum"));
		System.out.println(cvsnum);
		model.addAttribute("cvsnum",cvsnum);
		if(request.getParameter("start") == null ) start = 0;
		else start = Integer.parseInt(request.getParameter("start"));
		
		
		
		// 맨처음 리뷰게시판 들어올때 
		if(start == 0) start=1;
	
		PageCount pc = new PageCount();
		// 페이지에 보여줄 게시글 갯수
		int pageNum=10;
		// 전체 게시글 갯수 가져오기
		int totalPage = dao.cvsGetTotalPage(cvsnum);
	
		// 전체 게시글 갯수 / 페이지 보여줄 게시글 갯수 + (나머지 값이 있으면 + 1) 마지막 페이지 번호를 정하는 식
		int totEndPage = totalPage/pageNum + (totalPage%pageNum == 0 ?0 :1);
		// 페이지 넘버를 눌렀을때 첫번째 상단에 보여줄 게시글 번호 
		int startPage = (start - 1) * pageNum + 1;
		// 페이지 넘버를 눌렀을 때 마지막에 보여줄 게시글 번호
		int endPage = pageNum * start;
		
		
		pc.setCvsnum(cvsnum);
		pc.setTotEndPage(totEndPage);
		pc.setStartPage(startPage);
		pc.setEndPage(endPage);
		model.addAttribute("pc", pc);
		return pc;
	}






	
	
	
	
	
}

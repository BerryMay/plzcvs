package com.care.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.care.dao.AdminDAO;
import com.care.dto.CvsDTO;
import com.care.dto.MemberDTO;

@Service
public class AdminService {
	@Autowired
	AdminDAO dao;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	//관리자 작성 
<<<<<<< HEAD
		@RequestMapping(method = RequestMethod.POST)
		public void adminPost(CvsDTO dto) throws Exception{
				dao.adminPost(dto);
				
			}
		
		public List<MemberDTO> admin_list(Model model) {
			
			return dao.admin_list(model);
		}


		public int member_delete(Model model) {
			Map<String, Object> map = model.asMap();
			System.out.println("멤버삭제");
			HttpServletRequest request = (HttpServletRequest)map.get("request");
			return dao.member_delete(request.getParameter("nickname"));
			
		}

		public int repoint(Model model) {
			Map<String, Object> map = model.asMap();
			System.out.println("포인트수정");
			HttpServletRequest request = (HttpServletRequest)map.get("request");
			MemberDTO dto = new MemberDTO();
			dto.setNickname(request.getParameter("nickname"));
			dto.setPoint(Integer.parseInt(request.getParameter("point")));
			System.out.println(dto.getPoint());
			return dao.repoint(dto);
			
		}
=======
	
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
	@RequestMapping(method = RequestMethod.POST)
	public void adminProduct_Modify(CvsDTO dto) {
		dao.adminProduct_Modify(dto);
	}
>>>>>>> branch 'master' of https://github.com/BerryMay/plzcvs.git
}

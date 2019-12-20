package com.care.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import com.care.dto.BoardDTO;
import com.care.dto.CommentDTO;

@Component
public class CommentDAO {
	private static final String namespace="com.care.mybatis.commentMapper";
	
	@Autowired
	private SqlSession sqlSession;
	
	//댓글리스트 불러오기
	public List<CommentDTO> comment_list(int num) {
		//System.out.println("comment_list num 값 " + num);
		return sqlSession.selectList(namespace+".comment_list", num);
	}
	
	//등록하기
	public int comment_create(CommentDTO dto) {
		return sqlSession.insert(namespace+".comment_create",dto);
	}
	//수정하기
	public int comment_modify(CommentDTO dto) {
		return sqlSession.update(namespace+".comment_modify", dto);
	}
	
	//삭제하기
	public int comment_delete(int num) {
		System.out.println("DAO delete num 값 " + num);
		return sqlSession.delete(namespace+".comment_delete",num);
	}
	
	
	
}

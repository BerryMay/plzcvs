package com.care.service;

import java.util.List;

import org.springframework.ui.Model;

import com.care.dto.CommentDTO;

public interface ICommentService {

	public List<CommentDTO> comment_list(Model model);
	public void comment_create(Model model);
	public void comment_modify(Model model);
	public void comment_delete(Model model);
}

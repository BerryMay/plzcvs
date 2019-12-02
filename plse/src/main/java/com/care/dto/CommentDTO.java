package com.care.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommentDTO {
	private int bnum;
	private int cnum;
	private Date savedate;
	private String nickname;
	private String content;
	
}

package com.care.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class BoardDTO {
	private int num;
	private String title;
	private String nickname;
	private int hit;
	private int recommend;
	private Date savedate;
	private double stars;
	private String productname;
	private String content;
	private int cvsnum;
}

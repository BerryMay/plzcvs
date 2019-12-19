package com.care.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Setter @Getter
public class SearchCntDTO {
	private String title;
	private Date dates;
	private int cnt;
}

package com.care.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Setter @Getter
public class CvsDTO {
	private int cvsnum;
	private int productnum;
	private String productname;
	private int price;
	private Date newproduct;
	private String gdsimg;
}

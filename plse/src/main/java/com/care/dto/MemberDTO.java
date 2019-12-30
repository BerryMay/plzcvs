package com.care.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberDTO {
	private String id;
	private String pw;
	private String nickname;
	private String age;
	private String gender;
	private String mail;
	private int point;
	private String authkey;
	private int authstatus;
}

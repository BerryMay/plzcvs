package com.care.controller;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class EventController {
	String url ;
	Document doc = null;

	@RequestMapping("event") // GS25
	public String gsevent(Model model) {
		url = "http://storeboss.co.kr/products?convenience_id=2";
		try {
			doc = Jsoup.connect(url).get();
		}catch (Exception e) {
			e.printStackTrace();
		}
		Elements element = doc.select("div.border-gray");
		model.addAttribute("list", element);
		return "event/event";
	}
	
	
	@RequestMapping("slevent")
	public String slevent(Model model) {
		url = "http://storeboss.co.kr/products?convenience_id=1";
		try {
			doc = Jsoup.connect(url).get();
		}catch (Exception e) {
			e.printStackTrace();
		}
		Elements element = doc.select("div.border-gray");
		model.addAttribute("list", element);
		return "event/event";
	}
	
	
	@RequestMapping("cuevent")
	public String cuevent(Model model) {
		url = "http://storeboss.co.kr/products?convenience_id=3";
		try {
			doc = Jsoup.connect(url).get();
		}catch (Exception e) {
			e.printStackTrace();
		}
		Elements element = doc.select("div.border-gray");
		model.addAttribute("list", element);
		return "event/event";
	}
}

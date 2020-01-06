package com.care.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.care.service.GoogleChartService;

import net.sf.json.JSONObject;

@RestController 


public class GoogleChartController {
    
	@Autowired
	GoogleChartService gservice;
  
    
    @RequestMapping("chart")
    public ModelAndView chart2() {
        return new ModelAndView("chart/chart"); 
    }
    @RequestMapping("chart_list")
    public JSONObject chart_list() {
    	return gservice.getChartData();
    }
 
    @RequestMapping("chart_w")
    public JSONObject chart_w() {
    	return gservice.getChartData2();
    }
    @RequestMapping("chart_m")
    public JSONObject chart_m() {
    	return gservice.getChartData3();
    }
    

 
}

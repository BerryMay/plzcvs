package com.care.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.care.service.GoogleChartService;

import net.sf.json.JSONObject;

@RestController //json을 리턴하는 method가 있는 경우

//일반적인 controller어노테이션을 jsp <=> controller을 연동할때 사용하지만
//RestController은 그 데이터 자체를 받아서 제이슨 형식으로 바꿔서 출력하고 싶을때 사용
//(지금은 json 형식으로 차트를 그릴것이기 때문에 Rest를 붙여서 컨트롤러를 선언한 것이다)
public class GoogleChartController {
    
	@Autowired
	GoogleChartService gservice;
  
    
    @RequestMapping("chart")
    public ModelAndView chart2() {
        return new ModelAndView("chart/chart"); //json데이터를 호출한 곳으로 되돌려준다.
    }
 
    //@ResponseBody //화면으로 넘어가는 것이 아닌 데이터를 리턴하는 경우 사용
    
    @RequestMapping("chart_list")
    public JSONObject chart_list() {
        return gservice.getChartData();
    }

 
}

package com.care.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.care.dto.BoardDTO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
 


@Service
public class GoogleChartService implements IGoogleChartService {

	@Inject
	BoardService bser;
    
	public  JSONObject getChartData() {
		
        List<BoardDTO> items = bser.board_list();
        items.add(new BoardDTO());
        List<String> productName = new ArrayList<String>();
        List<Integer> hitList = new ArrayList<Integer>();
        int hitt = 0;
        for(int i =0; i<items.size()-1; i++) {
        	if(items.get(i).getProductname().equals(items.get(i+1).getProductname())) {
        		hitt += items.get(i).getHit();
        	} else {
        		if(hitt!=0) {
        			hitt += items.get(i).getHit();
        			hitList.add(hitt); 
        			hitt = 0;
        		}
        		else {
        			hitt += items.get(i).getHit();
        			hitList.add(hitt);
        		}
        		productName.add(items.get(i).getProductname());
        		hitt = 0;
        	}
        }
        
        for (int i = 0; i < productName.size(); i++) {
        	System.out.println(productName.get(i));
        	System.out.println(hitList.get(i));
		}
        
      
        JSONObject data = new JSONObject();
        
        
        JSONObject col1 = new JSONObject();
        JSONObject col2 = new JSONObject();
        
        
        
        JSONArray title = new JSONArray();
        col1.put("label","상품명"); 
        col1.put("type", "string");
        col2.put("hit", "조회수");
        col2.put("type", "number");
       
        
     
        title.add(col1);
        title.add(col2);
        

        data.put("cols", title);
    
        
        JSONArray body = new JSONArray(); 
        for (int i = 0; i < productName.size(); i++) {
        	JSONObject name = new JSONObject();
            name.put("v", productName.get(i)); 
            
            JSONObject hit = new JSONObject(); 
            hit.put("v", hitList.get(i)); 
            
            JSONArray row = new JSONArray(); 
            row.add(name); 
            row.add(hit); 
            
            JSONObject cell = new JSONObject(); 
            cell.put("c", row); 
            body.add(cell); 
		}  
        


        data.put("rows", body); 
        
        return data; 
    }
	
	
	public JSONObject getChartData2() {
	
	
       List<BoardDTO> items = bser.board_list2();
       
       items.add(new BoardDTO());
       List<String> productName = new ArrayList<String>();
       List<Integer> genderList = new ArrayList<Integer>();
       int hit = 0;
       for(int i =0; i<items.size()-1; i++) {
       	if(items.get(i).getProductname().equals(items.get(i+1).getProductname())) {
       		hit ++;
       	} else {
       		if(hit !=0) {
       			hit ++;
       			genderList.add(hit); 
       			hit = 0;
       		}
       		else {
       			hit ++;
       			genderList.add(hit);
       		}
       		productName.add(items.get(i).getProductname());
       		hit = 0;
       	}
       }
   
       
   for (int i = 0; i < productName.size(); i++) {
  	System.out.println(productName.get(i));
   	System.out.println(genderList.get(i));
	}
       
       
       
       JSONObject data = new JSONObject(); 
       
      
       JSONObject col1 = new JSONObject();
       JSONObject col2 = new JSONObject();
       
       
       
       JSONArray title = new JSONArray();
       col1.put("label","상품명"); 
       col1.put("type", "string");
       col2.put("gender", "성별");
       col2.put("type", "number");
      
       
       //테이블행에 컬럼 추가
       title.add(col1);
       title.add(col2);
       
       //json 객체에 타이틀행 추가
       data.put("cols", title);//제이슨을 넘김
      
       
       JSONArray body = new JSONArray(); //json 배열을 사용하기 위해 객체를 생성
       for (int i = 0; i < productName.size(); i++) { 
           JSONObject name2 = new JSONObject(); 
           name2.put("v", productName.get(i)); 
           
           JSONObject gender = new JSONObject(); 
          
           gender.put("v", genderList.get(i)); 
           
           JSONArray row = new JSONArray(); 
           row.add(name2); 
           row.add(gender); 
           
           JSONObject cell = new JSONObject(); 
           cell.put("c", row); 
           body.add(cell); 
               
       }
       data.put("rows", body); 
       
       return data; 
   }
	
	
	public JSONObject getChartData3() {
		
		
		List<BoardDTO> items = bser.board_list3();
		
		items.add(new BoardDTO());
		List<String> productName = new ArrayList<String>();
		List<Integer> genderList = new ArrayList<Integer>();
		int hit = 0;
		for(int i =0; i<items.size()-1; i++) {
			if(items.get(i).getProductname().equals(items.get(i+1).getProductname())) {
				hit ++;
			} else {
				if(hit !=0) {
					hit ++;
					genderList.add(hit); 
					hit = 0;
				}
				else {
					hit ++;
					genderList.add(hit);
				}
				productName.add(items.get(i).getProductname());
				hit = 0;
			}
		}
		
		
		for (int i = 0; i < productName.size(); i++) {
			System.out.println(productName.get(i));
			System.out.println(genderList.get(i));
		}
		
		
		//리턴할 json 객체
		JSONObject data = new JSONObject(); 
		
		//json의 칼럼 객체
		JSONObject col1 = new JSONObject();
		JSONObject col2 = new JSONObject();
		
		
		
		JSONArray title = new JSONArray();
		col1.put("id", "");
		col1.put("label","상품명"); 
		col1.put("pattern", "");
		col1.put("type", "string");
		
		col2.put("id", "");
		col2.put("gender", "성별");
		col2.put("pattern", "");
		col2.put("type", "number");
		
		
		//테이블행에 컬럼 추가
		title.add(col1);
		title.add(col2);
		
		//json 객체에 타이틀행 추가
		data.put("cols", title);//제이슨을 넘김
		
		JSONArray body = new JSONArray(); 
		for (int i = 0; i < productName.size(); i++) { 
			
			JSONObject name2 = new JSONObject(); 
			name2.put("v", productName.get(i)); 
			
			JSONObject gender = new JSONObject(); 
			
			gender.put("v", genderList.get(i)); 
			
			JSONArray row = new JSONArray(); 
			row.add(name2); 
			row.add(gender);
			
			JSONObject cell = new JSONObject(); 
			cell.put("c", row); 
			body.add(cell); 
			
		}
		data.put("rows", body); 
		
		return data; 
	}
	
	
}

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
}

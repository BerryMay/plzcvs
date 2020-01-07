package com.care.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(path = "/error")
public class ErrorController {
   
   //[그외 에러페이지]
   @GetMapping
   public String defaultError() {
      return "error/default";
   }

   //[404 에러페이지]
   @GetMapping("/no-resource")
   public String noResource() {
      return "error/noResource";
   }

   //[500 에러페이지]
   @GetMapping("/server-error")
   public String serverError() {
      return "error/serverError";
   }
   
}	
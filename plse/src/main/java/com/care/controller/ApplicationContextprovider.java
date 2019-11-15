package com.care.controller;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

@Component
public class ApplicationContextprovider implements ApplicationContextAware {
	private static ApplicationContext applicationContext;

	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		System.out.println("Application 실행됨");
		this.applicationContext= applicationContext;
		
	}
	public static ApplicationContext getApplicationContext() {
		return applicationContext;
	}
	
}

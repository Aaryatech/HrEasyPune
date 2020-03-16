package com.ats.hreasy.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.ui.Model;

@Controller
@Scope("session")
public class ProfileController {

	
	@RequestMapping(value = "/getProfile", method = RequestMethod.GET)
	public String dashboard(HttpServletRequest request, HttpServletResponse response,
	  Model model) {
	  
	  String mav = "profile";
	 
	  return mav; 
	  
	}
}

package com.ats.hreasy.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@Scope("session")
public class GenerateLetters {

	@RequestMapping(value = "/generateLetters", method = RequestMethod.GET)
	public String showEmpListForFullnfinal(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = new String();

		try {
			mav = "letter/generateLetters";

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

}

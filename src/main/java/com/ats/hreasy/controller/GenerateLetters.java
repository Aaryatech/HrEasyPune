package com.ats.hreasy.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ats.hreasy.common.Constants;
import com.ats.hreasy.common.FormValidation;
import com.ats.hreasy.model.EmpDetailForLetters;
import com.ats.hreasy.model.GetEmployeeDetails;

@Controller
@Scope("session")
public class GenerateLetters {

	@RequestMapping(value = "/generateLetters", method = RequestMethod.GET)
	public String showEmpListForFullnfinal(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = new String();

		try {
			mav = "letter/generateLetters";
			String base64encodedString = request.getParameter("empId");
			String empId = FormValidation.DecodeKey(base64encodedString);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("empId", empId);
			EmpDetailForLetters empDetail = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getEmpDetailForGenrateLetters", map, EmpDetailForLetters.class);

			System.out.println(empDetail);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

}

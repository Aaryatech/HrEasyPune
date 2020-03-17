package com.ats.hreasy.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

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
import com.ats.hreasy.model.GetEmployeeDetails;

@Controller
@Scope("session")
public class FullAndFinalController {

	@RequestMapping(value = "/showEmpListForFullnfinal", method = RequestMethod.GET)
	public String showEmpListForFullnfinal(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = new String();

		try {

			mav = "FullAndFinal/showEmpListForFullnfinal";
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("companyId", 1);

			/*
			 * EmployeeMaster[] empArr =
			 * Constants.getRestTemplate().postForObject(Constants.url + "/getAllEmployee",
			 * map, EmployeeMaster[].class); List<EmployeeMaster> empList = new
			 * ArrayList<EmployeeMaster>(Arrays.asList(empArr));
			 */

			GetEmployeeDetails[] empdetList1 = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getAllEmployeeDetail", GetEmployeeDetails[].class);

			List<GetEmployeeDetails> empList = new ArrayList<GetEmployeeDetails>(Arrays.asList(empdetList1));
			for (int i = 0; i < empList.size(); i++) {

				empList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(empList.get(i).getEmpId())));
			}

			model.addAttribute("empList", empList);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/showfullnfinal", method = RequestMethod.GET)
	public String showEmpGraphs(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = new String();

		try {

			mav = "FullAndFinal/fullnfinal";

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

}

package com.ats.hreasy.controller;

import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ats.hreasy.common.Constants;
import com.ats.hreasy.common.FormValidation;
import com.ats.hreasy.model.AuthorityInformation;
import com.ats.hreasy.model.CalenderYear;
import com.ats.hreasy.model.EmployeeMaster;
import com.ats.hreasy.model.LeaveHistory;
import com.ats.hreasy.model.LoginResponse;
import com.ats.hreasy.model.MstEmpType;
import com.ats.hreasy.model.Setting;

@Controller
@Scope("session")
public class OptionalHolidayController {

	@RequestMapping(value = "/applyHoliday", method = RequestMethod.GET)
	public ModelAndView showApplyLeave(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("optionalholiday/applyHoliday");

		try {
			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("empId", 1);

			EmployeeMaster editEmp = Constants.getRestTemplate().postForObject(Constants.url + "/getEmpInfoByEmpId",
					map, EmployeeMaster.class);

			model.addObject("editEmp", editEmp);

		} catch (Exception e) {

			e.printStackTrace();
		}
		return model;
	}

}

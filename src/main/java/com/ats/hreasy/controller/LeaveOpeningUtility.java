package com.ats.hreasy.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod; 

import com.ats.hreasy.common.Constants; 
import com.ats.hreasy.model.OpeningPendingLeaveEmployeeList;

@Controller
@Scope("session")
public class LeaveOpeningUtility {

	@RequestMapping(value = "/applyPreviousLeave", method = RequestMethod.GET)
	public String applyPreviousLeave(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "leave/previousLeaveUtility";
		try {
			HttpSession session = request.getSession();
			int locId = (int) session.getAttribute("liveLocationId");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("locId", locId);
			OpeningPendingLeaveEmployeeList[] employeeDoc = Constants.getRestTemplate().postForObject(
					Constants.url + "/getEmplistForOpeningLeave", map, OpeningPendingLeaveEmployeeList[].class);

			List<OpeningPendingLeaveEmployeeList> list = new ArrayList<OpeningPendingLeaveEmployeeList>(
					Arrays.asList(employeeDoc));

			model.addAttribute("list", list); 
			
		} catch (Exception e) {

			e.printStackTrace();
		}

		return mav;

	}

}

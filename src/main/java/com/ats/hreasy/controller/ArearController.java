package com.ats.hreasy.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

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

import com.ats.hreasy.common.AcessController;
import com.ats.hreasy.common.Constants;
import com.ats.hreasy.model.AccessRightModule;
import com.ats.hreasy.model.AssetVendor;
import com.ats.hreasy.model.EmpSalaryInfoForPayroll;
import com.ats.hreasy.model.GetEmployeeDetails;
import com.ats.hreasy.model.GetSalDynamicTempRecord;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.Location;
import com.ats.hreasy.model.LoginResponse;
import com.ats.hreasy.model.PayRollDataForProcessing;
import com.ats.hreasy.model.Setting;
import com.ats.hrmgt.model.assets.AMCExpirationDetail;
import com.ats.hrmgt.model.assets.AssetNotificatn;
import com.ats.hrmgt.model.assets.ServicingDashDetails;

@Controller
@Scope("session")
public class ArearController {

	@RequestMapping(value = "/empListForArear", method = RequestMethod.GET)
	public String assetsDashboard(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "arear/empListForArear";
		HttpSession session = request.getSession();

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

		LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");
		try {

			int locId = (int) session.getAttribute("liveLocationId");

			map.add("locId", locId);
			PayRollDataForProcessing payRollDataForProcessing = Constants.getRestTemplate().postForObject(
					Constants.url + "/getEmployeeListWithEmpSalEnfoForArrear", map, PayRollDataForProcessing.class);
			List<EmpSalaryInfoForPayroll> list = payRollDataForProcessing.getList();

			model.addAttribute("empList", list);
			model.addAttribute("editAccess", 0);
			model.addAttribute("allownceList", payRollDataForProcessing.getAllowancelist());
			/*
			 * empdetList.stream().forEach(games -> {
			 * 
			 * });
			 */

		} catch (Exception e) {

		}
		return mav;
	}

	@RequestMapping(value = "/calculationArears", method = RequestMethod.POST)
	public String calculationArears(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "redirect:/accessDenied";

		try {
			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			String[] selectEmp = request.getParameterValues("selectEmp");
			String empIds = "0";

			for (int i = 0; i < selectEmp.length; i++) {
				empIds = empIds + "," + selectEmp[i];
			}
			empIds = empIds.substring(2, empIds.length());

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("empIds", empIds);
			map.add("userId", userObj.getUserId());

			GetSalDynamicTempRecord[] getSalDynamicTempRecord = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getSalDynamicTempRecord", map, GetSalDynamicTempRecord[].class);
			List<GetSalDynamicTempRecord> list = new ArrayList<>(Arrays.asList(getSalDynamicTempRecord));
			model.addAttribute("empList", list);

			model.addAttribute("empIds", empIds);

			// model.addAttribute("empList", list);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

}

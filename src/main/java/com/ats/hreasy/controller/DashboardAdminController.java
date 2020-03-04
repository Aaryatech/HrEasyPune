package com.ats.hreasy.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
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

import com.ats.hreasy.model.dashboard.BirthHoliDash;
import com.ats.hreasy.model.dashboard.DeptWiseWeekoffDash;
import com.ats.hreasy.model.dashboard.GetAllPendingMasterDet;
import com.ats.hreasy.model.dashboard.GetNewHiresDash;
import com.ats.hreasy.model.dashboard.LeavePenDash;
import com.ats.hreasy.model.dashboard.LoanAdvDashDet;
import com.ats.hreasy.model.dashboard.PayRewardDedDash;
import com.ats.hreasy.model.dashboard.PreDayAttnDash;

@Controller
@Scope("session")
public class DashboardAdminController {

	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String dashboard(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "welcome";
		Date date = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

		try {

			String fiterdate = sf.format(date);

			try {
				fiterdate = request.getParameter("fiterdate");

			} catch (Exception e) {
				fiterdate = sf.format(date);

			}

			if (fiterdate == null) {
				fiterdate = sf.format(date);
			}

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("fiterdate", fiterdate);

			BirthHoliDash birth = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getBirthDayAndHolidayDash", map, BirthHoliDash.class);
			model.addAttribute("birth", birth);

			GetNewHiresDash newHire = Constants.getRestTemplate().postForObject(Constants.url + "/getNewHireDash", map,
					GetNewHiresDash.class);
			model.addAttribute("newHire", newHire);

			LeavePenDash lvDet = Constants.getRestTemplate().getForObject(Constants.url + "/getLeaveCountDash",
					LeavePenDash.class);
			model.addAttribute("lvDet", lvDet);

			PreDayAttnDash attnDet = Constants.getRestTemplate().postForObject(Constants.url + "/getAttnDash", map,
					PreDayAttnDash.class);
			model.addAttribute("attnDet", attnDet);

			GetAllPendingMasterDet masterDet = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getAllPendingMasterDet", GetAllPendingMasterDet.class);
			model.addAttribute("masterDet", masterDet);

			DeptWiseWeekoffDash[] company = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getDashDeptWiseWeekoff", map, DeptWiseWeekoffDash[].class);

			List<DeptWiseWeekoffDash> deptwiseWkoff = new ArrayList<DeptWiseWeekoffDash>(Arrays.asList(company));

			model.addAttribute("deptwiseWkoff", deptwiseWkoff);

			map = new LinkedMultiValueMap<>();
			map.add("type", 1);
			map.add("fiterdate", fiterdate);
			PayRewardDedDash dedDet = Constants.getRestTemplate().postForObject(Constants.url + "/getRewardedDet", map,
					PayRewardDedDash.class);
			model.addAttribute("dedDet", dedDet);

			map = new LinkedMultiValueMap<>();
			map.add("type", 2);
			map.add("fiterdate", fiterdate);
			PayRewardDedDash rewardDet = Constants.getRestTemplate().postForObject(Constants.url + "/getRewardedDet",
					map, PayRewardDedDash.class);
			model.addAttribute("rewardDet", rewardDet);

			map = new LinkedMultiValueMap<>();
			map.add("type", 1);
			map.add("fiterdate", fiterdate);
			LoanAdvDashDet advDet = Constants.getRestTemplate().postForObject(Constants.url + "/getAdvLoanDash", map,
					LoanAdvDashDet.class);
			model.addAttribute("advDet", advDet);

			map = new LinkedMultiValueMap<>();
			map.add("type", 2);
			map.add("fiterdate", fiterdate);
			LoanAdvDashDet loanDet = Constants.getRestTemplate().postForObject(Constants.url + "/getAdvLoanDash", map,
					LoanAdvDashDet.class);
			model.addAttribute("loanDet", loanDet);
			
			
			System.err.println("--"+masterDet.toString());

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

}

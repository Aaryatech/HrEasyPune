package com.ats.hreasy.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.GregorianCalendar;
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
import org.springframework.web.servlet.ModelAndView;

import com.ats.hreasy.common.AcessController;
import com.ats.hreasy.common.Constants;
import com.ats.hreasy.common.DateConvertor;
import com.ats.hreasy.model.AccessRightModule;
import com.ats.hreasy.model.EmpListForHolidayApprove;
import com.ats.hreasy.model.GetDailyDailyRecord;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.Location;
import com.ats.hreasy.model.LoginResponse;

@Controller
@Scope("session")
public class OtModuleController {

	List<GetDailyDailyRecord> dailyrecordList = new ArrayList<GetDailyDailyRecord>();
	String date;

	@RequestMapping(value = "/otApprovalList", method = RequestMethod.GET)
	public String otApprovalList(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "attendence/otApprovalList";

		try {
			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");
			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("otApprovalList", "otApprovalList", 1, 0, 0, 0, newModuleList);

			if (view.isError() == true) {

				mav = "accessDenied";

			} else {

				mav = "attendence/otApprovalList";
				date = request.getParameter("date");

				if (date != null) {
					
					int locId = (int) session.getAttribute("liveLocationId");
					
					MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
					map.add("date", DateConvertor.convertToYMD(date));
					map.add("empId", userObj.getEmpId());
					map.add("locId", locId);
					GetDailyDailyRecord[] getDailyDailyRecord = Constants.getRestTemplate().postForObject(
							Constants.url + "/getDailyDailyRecordForOtApproval", map, GetDailyDailyRecord[].class);
					dailyrecordList = new ArrayList<GetDailyDailyRecord>(Arrays.asList(getDailyDailyRecord));
					model.addAttribute("dailyrecordList", dailyrecordList);
					model.addAttribute("date", date);
				}
			}
		} catch (Exception e) {

			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/submitApproveProductionIncentive", method = RequestMethod.POST)
	public String submitApproveProductionIncentive(HttpServletRequest request, HttpServletResponse response) {
		String redirect = new String();

		HttpSession session = request.getSession();
		try {
			redirect = "redirect:/otApprovalList?date=" + date;

			String[] ids = request.getParameterValues("selectEmp");

			String id = "0";
			for (int i = 0; i < ids.length; i++) {

				for (int j = 0; j < dailyrecordList.size(); j++) {

					if (dailyrecordList.get(j).getId() == Integer.parseInt(ids[i])) {
						id = id + "," + ids[i];
						break;
					}
				}

			}

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("ids", id);
			map.add("status", 1);
			System.out.println(map);
			Info info = Constants.getRestTemplate().postForObject(Constants.url + "/updateOtApproveStatus", map,
					Info.class);

			if (info.isError() == false) {
				session.setAttribute("successMsg", "Production Incentive Approved Successfully");
			} else {
				session.setAttribute("errorMsg", "Failed to Approved Production Incentive");
			}

		} catch (Exception e) {

			session.setAttribute("errorMsg", "Failed to Approved Production Incentive");
			e.printStackTrace();
		}

		return redirect;
	}

	@RequestMapping(value = "/otFinalApprovalList", method = RequestMethod.GET)
	public String otFinalApprovalList(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "attendence/otFinalApprovalList";

		try {
			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("otFinalApprovalList", "otFinalApprovalList", 1, 0, 0, 0, newModuleList);

			if (view.isError() == true) {

				mav = "accessDenied";

			} else {

				date = request.getParameter("date");

				if (date != null) {
					
					int locId = (int) session.getAttribute("liveLocationId");
					
					MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
					map.add("date", DateConvertor.convertToYMD(date));
					map.add("empId", userObj.getEmpId());
					map.add("locId", locId);
					GetDailyDailyRecord[] getDailyDailyRecord = Constants.getRestTemplate().postForObject(
							Constants.url + "/getDailyDailyRecordForFinalOtApproval", map, GetDailyDailyRecord[].class);
					dailyrecordList = new ArrayList<GetDailyDailyRecord>(Arrays.asList(getDailyDailyRecord));
					model.addAttribute("dailyrecordList", dailyrecordList);
					model.addAttribute("date", date);
				}
			}
		} catch (Exception e) {

			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/submitFinalApproveProductionIncentive", method = RequestMethod.POST)
	public String submitFinalApproveProductionIncentive(HttpServletRequest request, HttpServletResponse response) {
		String redirect = new String();

		HttpSession session = request.getSession();
		try {
			redirect = "redirect:/otFinalApprovalList?date=" + date;

			String[] ids = request.getParameterValues("selectEmp");

			String id = "0";
			String empId = "0";
			for (int i = 0; i < ids.length; i++) {

				for (int j = 0; j < dailyrecordList.size(); j++) {

					if (dailyrecordList.get(j).getId() == Integer.parseInt(ids[i])) {
						id = id + "," + ids[i];
						empId = empId + "," + dailyrecordList.get(j).getEmpId();
						break;
					}
				}

			}

			String[] dtsplt = date.split("-");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("ids", id);
			map.add("status", 2);
			System.out.println(map);
			Info info = Constants.getRestTemplate().postForObject(Constants.url + "/updateOtApproveStatus", map,
					Info.class);

			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			Date firstDay = new GregorianCalendar(Integer.parseInt(dtsplt[2]), Integer.parseInt(dtsplt[1]) - 1, 1)
					.getTime();
			Date lastDay = new GregorianCalendar(Integer.parseInt(dtsplt[2]), Integer.parseInt(dtsplt[1]), 0).getTime();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			map = new LinkedMultiValueMap<String, Object>();
			map.add("fromDate", sf.format(firstDay));
			map.add("toDate", sf.format(lastDay));
			map.add("userId", userObj.getUserId());
			map.add("year", Integer.parseInt(dtsplt[2]));
			map.add("month", Integer.parseInt(dtsplt[1]));
			map.add("empIds", empId);

			info = Constants.getRestTemplate().postForObject(Constants.url + "/updateAttendaceFinalRecordByempId", map,
					Info.class);

			if (info.isError() == false) {
				session.setAttribute("successMsg", "Production Incentive Approved Successfully");
			} else {
				session.setAttribute("errorMsg", "Failed to Approved Production Incentive");
			}

		} catch (Exception e) {

			session.setAttribute("errorMsg", "Failed to Approved Production Incentive");
			e.printStackTrace();
		}

		return redirect;
	}

}

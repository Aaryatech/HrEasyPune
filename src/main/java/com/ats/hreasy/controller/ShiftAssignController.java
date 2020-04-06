package com.ats.hreasy.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.ats.hreasy.common.AcessController;
import com.ats.hreasy.common.Constants;
import com.ats.hreasy.model.AccessRightModule;
import com.ats.hreasy.model.CountOfAssignPending;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.InfoForUploadAttendance;
import com.ats.hreasy.model.LoginResponse;

@Controller
@Scope("session")
public class ShiftAssignController {

	@RequestMapping(value = "/shiftUploadSelectMonth", method = RequestMethod.GET)
	public String attendanceSelectMonth(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = null;
		HttpSession session = request.getSession();

		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("attendanceSelectMonth", "attendanceSelectMonth", 1, 0, 0, 0,
				newModuleList);

		if (view.isError() == true) {

			mav = "accessDenied";

		} else {
			mav = "shiftassign/shiftUploadSelectMonth";

		}
		return mav;

	}

	@RequestMapping(value = "/shiftbulkuploadImportExel", method = RequestMethod.GET)
	public String shiftbulkuploadImportExel(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "shiftassign/shiftassignImportExel";

		try {

			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar temp = Calendar.getInstance();
			String month = request.getParameter("selectMonth");

			String[] monthsplt = month.split("-");

			Date firstDay = new GregorianCalendar(Integer.parseInt(monthsplt[1]), Integer.parseInt(monthsplt[0]) - 1, 1)
					.getTime();
			Date lastDay = new GregorianCalendar(Integer.parseInt(monthsplt[1]), Integer.parseInt(monthsplt[0]), 0)
					.getTime();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("fromDate", sf.format(firstDay));
			map.add("toDate", sf.format(lastDay));
			InfoForUploadAttendance infoForUploadAttendance = Constants.getRestTemplate().postForObject(
					Constants.url + "/getInformationOfUploadedShift", map, InfoForUploadAttendance.class);

			temp = Calendar.getInstance();
			temp.setTime(firstDay);
			int year = temp.get(Calendar.YEAR);
			int month1 = temp.get(Calendar.MONTH);

			String[] monthNames = { "January", "February", "March", "April", "May", "June", "July", "August",
					"September", "October", "November", "December" };
			String monthName = monthNames[month1];

			model.addAttribute("monthName", monthName);
			model.addAttribute("year", year);
			model.addAttribute("month", month1 + 1);
			model.addAttribute("infoForUploadAttendance", infoForUploadAttendance);

			// System.out.println(month);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;

	}
	
	@RequestMapping(value = "/addDefaultRecordinShiftAssign", method = RequestMethod.POST)
	@ResponseBody
	public Info addDefaultRecordinShiftAssign(HttpServletRequest request, HttpServletResponse response, Model model) {

		Info info = new Info();

		try {

			int month = Integer.parseInt(request.getParameter("month"));
			int year = Integer.parseInt(request.getParameter("year"));
			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			Date firstDay = new GregorianCalendar(year, month - 1, 1).getTime();
			Date lastDay = new GregorianCalendar(year, month, 0).getTime();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("fromDate", sf.format(firstDay));
			map.add("toDate", sf.format(lastDay));
			map.add("userId", userObj.getUserId());
			info = Constants.getRestTemplate().postForObject(Constants.url + "/initiallyInsertDailyShiftAssignRecord", map,
					Info.class);
			if (info.isError() == false) {
				session.setAttribute("successMsg", "Step 1 Completed Successfully");
			} else {
				session.setAttribute("errorMsg", "Error in Step 1");
			}
		} catch (Exception e) {
			e.printStackTrace();
			info = new Info();
			info.setError(true);
			info.setMsg("failed");
		}
		return info;

	}

}

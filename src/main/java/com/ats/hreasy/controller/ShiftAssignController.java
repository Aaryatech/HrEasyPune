package com.ats.hreasy.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
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
import com.ats.hreasy.common.DateConvertor;
import com.ats.hreasy.model.AccessRightModule;
import com.ats.hreasy.model.CountOfAssignPending;
import com.ats.hreasy.model.DateAndDay;
import com.ats.hreasy.model.EmpWithShiftDetail;
import com.ats.hreasy.model.GetEmployeeDetails;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.InfoForUploadAttendance;
import com.ats.hreasy.model.Location;
import com.ats.hreasy.model.LoginResponse;
import com.ats.hreasy.model.ShiftMaster;

@Controller
@Scope("session")
public class ShiftAssignController {

	@RequestMapping(value = "/shiftUploadSelectMonth", method = RequestMethod.GET)
	public String attendanceSelectMonth(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = null;
		HttpSession session = request.getSession();

		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("shiftUploadSelectMonth", "shiftUploadSelectMonth", 1, 0, 0, 0,
				newModuleList);

		if (view.isError() == true) {

			mav = "accessDenied";

		} else {
			mav = "shiftassign/shiftUploadSelectMonth";

		}
		return mav;

	}

	int locId = 0;

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

			ShiftMaster[] shiftMaster = Constants.getRestTemplate().postForObject(Constants.url + "/getShiftListByLpad",
					map, ShiftMaster[].class);
			model.addAttribute("shiftMaster", shiftMaster);

			map = new LinkedMultiValueMap<>();
			map.add("companyId", 1);
			Location[] location = Constants.getRestTemplate().postForObject(Constants.url + "/getLocationList", map,
					Location[].class);

			List<Location> locationList = new ArrayList<Location>(Arrays.asList(location));
			model.addAttribute("locationList", locationList);

			Date fmdt = sf.parse(sf.format(firstDay));
			Date todt = sf.parse(sf.format(lastDay));

			SimpleDateFormat dd = new SimpleDateFormat("dd-MM-yyyy");
			/*
			 * List<String> dates = new ArrayList<>();
			 * 
			 * for (Date j = fmdt; j.compareTo(todt) <= 0;) {
			 * 
			 * temp = Calendar.getInstance(); temp.setTime(j); String attdate =
			 * dd.format(j); dates.add(attdate); j.setTime(j.getTime() + 1000 * 60 * 60 *
			 * 24);
			 * 
			 * } model.addAttribute("dates", dates);
			 * 
			 * assignDate = new String(); assignDate = request.getParameter("assignDate");
			 */

			try {

				/*
				 * map = new LinkedMultiValueMap<String, Object>(); map.add("date",
				 * DateConvertor.convertToYMD(assignDate)); GetEmployeeDetails[] empList =
				 * Constants.getRestTemplate().postForObject( Constants.url +
				 * "/getEmpDetailListforassignshiftbulk", map, GetEmployeeDetails[].class);
				 * model.addAttribute("empdetList", empList); model.addAttribute("assignDate",
				 * assignDate);
				 */

				locId = Integer.parseInt(request.getParameter("locId"));

				SimpleDateFormat sdf = new SimpleDateFormat("EEE");

				List<DateAndDay> dateAndDayList = new ArrayList<>();

				for (Date j = fmdt; j.compareTo(todt) <= 0;) {

					DateAndDay dateAndDay = new DateAndDay();
					String stringDate = sdf.format(j);
					dateAndDay.setDate(dd.format(j));
					dateAndDay.setDay(stringDate);
					dateAndDayList.add(dateAndDay);

					/* System.out.println(sf.parse(sf.format(j))); */
					j.setTime(j.getTime() + 1000 * 60 * 60 * 24);
				}

				model.addAttribute("dateAndDayList", dateAndDayList);

				map = new LinkedMultiValueMap<String, Object>();
				map.add("fromDate", sf.format(firstDay));
				map.add("toDate", sf.format(lastDay));
				map.add("locId", locId);

				EmpWithShiftDetail[] empList = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getEmpProjectionMatrix", map, EmpWithShiftDetail[].class);
				model.addAttribute("empList", empList);
				
				model.addAttribute("locId", locId);

			} catch (Exception e) {

			}
			// System.out.println(dates);

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
			info = Constants.getRestTemplate().postForObject(Constants.url + "/initiallyInsertDailyShiftAssignRecord",
					map, Info.class);
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

	@RequestMapping(value = "/submitEmpShiftList", method = RequestMethod.POST)
	public String addCustLoginDetail(HttpServletRequest request, HttpServletResponse response) {
		String redirect = new String();

		try {

			int sm = Integer.parseInt(request.getParameter("sm"));
			int sy = Integer.parseInt(request.getParameter("sy"));
			int shiftId = Integer.parseInt(request.getParameter("shiftId"));
			String daterange = request.getParameter("daterange");
			String[] empId = request.getParameterValues("empId");

			StringBuilder sb = new StringBuilder();

			List<Integer> empIdList = new ArrayList<>();

			for (int i = 0; i < empId.length; i++) {
				sb = sb.append(empId[i] + ",");
				empIdList.add(Integer.parseInt(empId[i]));

			}

			String items = sb.toString();
			items = items.substring(0, items.length() - 1);

			String[] daterangear = daterange.split("to");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("empIdList", items);
			map.add("shiftId", shiftId);
			map.add("fromDate", DateConvertor.convertToYMD(daterangear[0]));
			map.add("toDate", DateConvertor.convertToYMD(daterangear[1]));
			Info info = Constants.getRestTemplate().postForObject(Constants.url + "/updateAssignShiftByDate", map,
					Info.class);

			redirect = "redirect:/shiftbulkuploadImportExel?selectMonth=" + sm + "-" + sy;

		} catch (Exception e) {

			e.printStackTrace();
		}

		return redirect;
	}

}

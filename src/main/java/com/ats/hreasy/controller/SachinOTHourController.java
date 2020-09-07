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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.zefer.html.doc.n;

import com.ats.hreasy.common.AcessController;
import com.ats.hreasy.common.Constants;
import com.ats.hreasy.common.FormValidation;
import com.ats.hreasy.model.AccessRightModule;
import com.ats.hreasy.model.DailyDaily;
import com.ats.hreasy.model.GetEmployeeDetails;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.LoginResponse;

//Sachin 05-09-2020
@Controller
@Scope("session")
public class SachinOTHourController {

	// Sachin 05-09-2020
	@RequestMapping(value = "/showUpdateOTHours", method = RequestMethod.GET)
	public String showUpdateOTHours(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = null;
		HttpSession session = request.getSession();

		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("showUpdateOTHours", "showUpdateOTHours", 1, 0, 0, 0, newModuleList);

		if (view.isError() == true) {

			mav = "accessDenied";

		} else {
			mav = "update_ot/update_ot_hour";

			Info editAcc = AcessController.checkAccess("showUpdateOTHours", "showUpdateOTHours", 0, 0, 1, 0,
					newModuleList);
			if (editAcc.isError() == true) {
				model.addAttribute("isAdd", 0);
			} else {
				model.addAttribute("isAdd", 1);
			}
			try {

				int locId = (int) session.getAttribute("liveLocationId");

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("locId", locId);

				GetEmployeeDetails[] empdetList1 = Constants.getRestTemplate().postForObject(
						Constants.url + "/getAllEmployeeDetailBylocationId", map, GetEmployeeDetails[].class);

				List<GetEmployeeDetails> empdetList = new ArrayList<GetEmployeeDetails>(Arrays.asList(empdetList1));

				for (int i = 0; i < empdetList.size(); i++) {

					empdetList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(empdetList.get(i).getEmpId())));
				}

				model.addAttribute("empList", empdetList);

				// On Submit check

				/*
				 * SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd"); Calendar temp =
				 * Calendar.getInstance(); String month = request.getParameter("selectMonth");
				 * 
				 * String[] monthsplt = month.split("-");
				 * 
				 * Date firstDay = new GregorianCalendar(Integer.parseInt(monthsplt[1]),
				 * Integer.parseInt(monthsplt[0]) - 1, 1) .getTime(); Date lastDay = new
				 * GregorianCalendar(Integer.parseInt(monthsplt[1]),
				 * Integer.parseInt(monthsplt[0]), 0) .getTime();
				 * 
				 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
				 * Object>(); map.add("fromDate", sf.format(firstDay)); map.add("toDate",
				 * sf.format(lastDay));
				 */

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return mav;
	}

	// Sachin 05-09-2020

	List<DailyDaily> dailyList = null;
	String month = new String();
	String empId = new String();
	@RequestMapping(value = "/searchEmpOTDataForm", method = RequestMethod.GET)
	public String searchEmpOTDataForm(HttpServletRequest request, HttpServletResponse response, Model model) {
		String mav = null;
		mav = "update_ot/update_ot_hour";
		System.err.println("in searchEmpOTDataForm ");

		try {
			HttpSession session = request.getSession();

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("showUpdateOTHours", "showUpdateOTHours", 1, 0, 0, 0,
					newModuleList);

			if (view.isError() == true) {

				mav = "accessDenied";

			} else {

				Info editAcc = AcessController.checkAccess("showUpdateOTHours", "showUpdateOTHours", 0, 0, 1, 0,
						newModuleList);
				if (editAcc.isError() == true) {
					model.addAttribute("isAdd", 0);
				} else {
					model.addAttribute("isAdd", 1);
				}

				String x = request.getParameter("selectMonth");
				// String empId=request.getParameter("empId");
				String base64encodedString = request.getParameter("empId");
				empId = FormValidation.DecodeKey(base64encodedString);

				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
				Calendar temp = Calendar.getInstance();
				month = request.getParameter("selectMonth");

				String[] monthsplt = month.split("-");

				Date firstDay = new GregorianCalendar(Integer.parseInt(monthsplt[1]),
						Integer.parseInt(monthsplt[0]) - 1, 1).getTime();
				Date lastDay = new GregorianCalendar(Integer.parseInt(monthsplt[1]), Integer.parseInt(monthsplt[0]), 0)
						.getTime();

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("fromDate", sf.format(firstDay));
				map.add("toDate", sf.format(lastDay));
				map.add("empId", empId);

				DailyDaily[] dailyArray = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getDailyDailyBetFdTdAndEmpId", map, DailyDaily[].class);

				dailyList = new ArrayList<DailyDaily>(Arrays.asList(dailyArray));
				System.err.println("Input dailyList " + dailyList.toString());

				model.addAttribute("dailyList", dailyList);
				model.addAttribute("empId", empId);

				int locId = (int) session.getAttribute("liveLocationId");
				map = new LinkedMultiValueMap<>();
				map.add("locId", locId);

				GetEmployeeDetails[] empdetList1 = Constants.getRestTemplate().postForObject(
						Constants.url + "/getAllEmployeeDetailBylocationId", map, GetEmployeeDetails[].class);

				List<GetEmployeeDetails> empdetList = new ArrayList<GetEmployeeDetails>(Arrays.asList(empdetList1));

				for (int i = 0; i < empdetList.size(); i++) {

					empdetList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(empdetList.get(i).getEmpId())));
				}

				model.addAttribute("empList", empdetList);
				model.addAttribute("month", month);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	// Sachin 05-09-2020

	@RequestMapping(value = "/submitEmpOtUpdt", method = RequestMethod.POST)
	public String submitEmpOtUpdt(HttpServletRequest request, HttpServletResponse response, Model model) {
		String mav = null;
		mav = "update_ot/update_ot_hour";

		try {
			HttpSession session = request.getSession();

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info edit = AcessController.checkAccess("showUpdateOTHours", "showUpdateOTHours", 0, 0, 1, 0,
					newModuleList);

			if (edit.isError() == true) {
				mav = "accessDenied";
			} else {
				 
				LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");
				
				List<DailyDaily> outList = new ArrayList<DailyDaily>();

				for (int i = 0; i < dailyList.size(); i++) {

					System.err.println("OT Data  " + request.getParameter("ot_hr" + dailyList.get(i).getId()));
					DailyDaily daily = new DailyDaily();
					daily.setId(dailyList.get(i).getId());

					String hr = convertHoursToMin(request.getParameter("ot_hr" + dailyList.get(i).getId()));

					daily.setOtHr(hr);

					outList.add(daily);
				}
				DailyDaily[] dailyArray = Constants.getRestTemplate()
						.postForObject(Constants.url + "/saveDailyOTUpdate", outList, DailyDaily[].class);
				
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
				String[] monthsplt = month.split("-");
				Date firstDay = new GregorianCalendar(Integer.parseInt(monthsplt[1]),
						Integer.parseInt(monthsplt[0]) - 1, 1).getTime();
				Date lastDay = new GregorianCalendar(Integer.parseInt(monthsplt[1]), Integer.parseInt(monthsplt[0]), 0)
						.getTime(); 
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map = new LinkedMultiValueMap<String, Object>();
				map.add("fromDate", sf.format(firstDay));
				map.add("toDate", sf.format(lastDay));
				map.add("userId", userObj.getUserId());
				map.add("month", monthsplt[0]);
				map.add("year", monthsplt[1]);
				map.add("empId", empId);
				System.out.println(map);

				Info sumryinfo = Constants.getRestTemplate()
						.postForObject(Constants.url + "/finalUpdateDailySumaryRecord", map, Info.class);

				session.setAttribute("successMsg", "OT Updated Successfully");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/showUpdateOTHours";
	}

	public String convertHoursToMin(String str) {
		String min = new String();

		try {
			int minutes = 0;
			String[] result = str.split(":");
			int hours = 0;
			try {
				hours = Integer.parseInt(result[0]);
			} catch (Exception e) {
				hours = 0;
			}
			try {
				minutes = Integer.parseInt(result[1]);
			} catch (Exception e) {
				minutes = 0;
			}
			min = String.valueOf((hours * 60) + minutes);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return min;

	}

	public String convertMinToHours(String minutes1) {
		String min = new String();
		int minutes = Integer.parseInt(minutes1);

		try {
			String hrs = String.valueOf(minutes / 60);
			String rem = String.valueOf(minutes % 60);
			System.out.println("prev hrs **" + hrs);
			System.out.println("prev rem  **" + rem);
			if (String.valueOf(hrs).length() == 1) {
				hrs = "0".concat(hrs);
				System.out.println("hrs after **" + hrs);

			}
			if (String.valueOf(rem).length() == 1) {
				rem = "0".concat(rem);
				System.out.println("rem after **" + rem);
			}
			min = hrs.concat(":").concat(rem);

			/// System.out.println("final hrs**" + min);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return min;

	}

}

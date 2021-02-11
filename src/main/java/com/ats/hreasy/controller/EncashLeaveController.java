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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ats.hreasy.common.AcessController;
import com.ats.hreasy.common.Constants;
import com.ats.hreasy.model.AccessRightModule;
import com.ats.hreasy.model.CalenderYear;
import com.ats.hreasy.model.EmployeeMaster;
import com.ats.hreasy.model.GetEmployeeDetails;
import com.ats.hreasy.model.GetEmployeeDetailsForCarryFrwdLeave;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.LeaveHistory;
import com.ats.hreasy.model.LeaveSummary;
import com.ats.hreasy.model.LeaveType;
import com.ats.hreasy.model.Setting;

@Controller
@Scope("session")
public class EncashLeaveController {

	@RequestMapping(value = "/empListForLeaveIncash", method = RequestMethod.GET)
	public String empListForLeaveIncash(HttpServletRequest request, HttpServletResponse response, Model model) {

		HttpSession session = request.getSession();
		// LoginResponse userObj = (LoginResponse) session.getAttribute("UserDetail");
		String returnLink = "accessDenied";

		try {

			/*
			 * List<AccessRightModule> newModuleList = (List<AccessRightModule>)
			 * session.getAttribute("moduleJsonList"); Info view =
			 * AcessController.checkAccess("leaveTypeAdd", "showLeaveTypeList", 0, 1, 0, 0,
			 * newModuleList);
			 * 
			 * if (view.isError() == false) {
			 */

			returnLink = "leave/empListForLeaveIncash";
			int locId = (int) session.getAttribute("liveLocationId");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("locId", locId);
			GetEmployeeDetails[] empdetList1 = Constants.getRestTemplate().postForObject(
					Constants.url + "/getAllEmployeeDetailBylocationId", map, GetEmployeeDetails[].class);

			List<GetEmployeeDetails> empdetList = new ArrayList<GetEmployeeDetails>(Arrays.asList(empdetList1));
			model.addAttribute("empdetList", empdetList);
			// }
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnLink;
	}

	EmployeeMaster editEmp = new EmployeeMaster();
	List<LeaveHistory> leaveHistoryList = new ArrayList<LeaveHistory>();

	@RequestMapping(value = "/encashLeaveProcess", method = RequestMethod.GET)
	public String encashLeaveProcess(HttpServletRequest request, HttpServletResponse response, Model model) {

		HttpSession session = request.getSession();
		// LoginResponse userObj = (LoginResponse) session.getAttribute("UserDetail");
		String returnLink = "accessDenied";

		try {
			returnLink = "leave/encashLeaveProcess";
			int empId = Integer.parseInt(request.getParameter("empId"));

			CalenderYear calculateYear = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getCalculateYearListIsCurrent", CalenderYear.class);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			model.addAttribute("empId", empId);

			map = new LinkedMultiValueMap<>();
			map.add("empId", empId);
			map.add("currYrId", calculateYear.getCalYrId());

			LeaveHistory[] leaveHistory = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getLeaveHistoryList", map, LeaveHistory[].class);
			leaveHistoryList = new ArrayList<LeaveHistory>(Arrays.asList(leaveHistory));
			model.addAttribute("leaveHistoryList", leaveHistoryList);

			editEmp = Constants.getRestTemplate().postForObject(Constants.url + "/getEmpInfoByEmpId", map,
					EmployeeMaster.class);

			model.addAttribute("editEmp", editEmp);

			map = new LinkedMultiValueMap<>();
			map.add("limitKey", "monthday");
			Setting dayInMonth = Constants.getRestTemplate().postForObject(Constants.url + "/getSettingByKey", map,
					Setting.class);
			model.addAttribute("day", dayInMonth.getValue());

			map = new LinkedMultiValueMap<>();
			map.add("empId", empId);
			map.add("currYrId", calculateYear.getCalYrId());
			GetEmployeeDetailsForCarryFrwdLeave employeeInfo = Constants.getRestTemplate().postForObject(
					Constants.url + "/getDetailForCarryForwordLeaveByEmpId", map,
					GetEmployeeDetailsForCarryFrwdLeave.class);
			model.addAttribute("employeeInfo", employeeInfo);
			// }
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnLink;
	}

	@RequestMapping(value = "/submitLeaveEncash", method = RequestMethod.GET)
	public @ResponseBody Info submitLeaveEncash(HttpServletRequest request, HttpServletResponse response) {

		Info info = new Info();

		try {

			int leaveTypeId = Integer.parseInt(request.getParameter("leaveTypeId"));
			float noOfDays = Float.parseFloat(request.getParameter("noOfDays"));
			String datepicker = request.getParameter("datepicker");
			String leaveRemark = request.getParameter("leaveRemark");
			CalenderYear calculateYear = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getCalculateYearListIsCurrent", CalenderYear.class);

		} catch (Exception e) {
			e.printStackTrace();
			info.setError(true);
			info.setMsg("Error while encash leave.");
		}

		return info;
	}

}

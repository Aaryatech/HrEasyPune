package com.ats.hreasy.controller;

import java.text.DecimalFormat;
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
import com.ats.hreasy.common.FormValidation;
import com.ats.hreasy.model.AccessRightModule;
import com.ats.hreasy.model.CalenderYear;
import com.ats.hreasy.model.EmployeeMaster;
import com.ats.hreasy.model.GetEmployeeDetails;
import com.ats.hreasy.model.GetEmployeeDetailsForCarryFrwdLeave;
import com.ats.hreasy.model.GetLeaveEncashDetail;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.LeaveEncash;
import com.ats.hreasy.model.LeaveHistory;
import com.ats.hreasy.model.LeaveSummary;
import com.ats.hreasy.model.LeaveType;
import com.ats.hreasy.model.LoginResponse;
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
	GetEmployeeDetailsForCarryFrwdLeave employeeInfo = new GetEmployeeDetailsForCarryFrwdLeave();

	int day = 1;

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
			day = Integer.parseInt(dayInMonth.getValue());

			map = new LinkedMultiValueMap<>();
			map.add("empId", empId);
			map.add("currYrId", calculateYear.getCalYrId());
			employeeInfo = Constants.getRestTemplate().postForObject(
					Constants.url + "/getDetailForCarryForwordLeaveByEmpId", map,
					GetEmployeeDetailsForCarryFrwdLeave.class);
			model.addAttribute("employeeInfo", employeeInfo);
			// }
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnLink;
	}

	@RequestMapping(value = "/submitLeaveEncash", method = RequestMethod.POST)
	public @ResponseBody Info submitLeaveEncash(HttpServletRequest request, HttpServletResponse response) {

		Info info = new Info();
		HttpSession session = request.getSession();
		try {
			float bal = 0;
			int leaveTypeId = Integer.parseInt(request.getParameter("leaveTypeId"));
			float noOfDays = Float.parseFloat(request.getParameter("noOfDays"));
			String datepicker = request.getParameter("datepicker");
			String leaveRemark = request.getParameter("leaveRemark");

			for (int i = 0; i < leaveHistoryList.size(); i++) {

				if (leaveHistoryList.get(i).getLvTypeId() == leaveTypeId) {
					bal = leaveHistoryList.get(i).getBalLeave() + leaveHistoryList.get(i).getLvsAllotedLeaves()
							- leaveHistoryList.get(i).getSactionLeave() - leaveHistoryList.get(i).getAplliedLeaeve()
							- leaveHistoryList.get(i).getLeaveEncashCount();
					break;
				}
			}

			if (noOfDays <= bal) {

				LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");
				CalenderYear calculateYear = Constants.getRestTemplate()
						.getForObject(Constants.url + "/getCalculateYearListIsCurrent", CalenderYear.class);

				float perday = (float) (employeeInfo.getBasic() + employeeInfo.getAllowSum()) / day;
				DecimalFormat df = new DecimalFormat("#.00");

				String[] st = datepicker.split("-");
				LeaveEncash leaveEncash = new LeaveEncash();
				leaveEncash.setDelStatus(1);
				leaveEncash.setEmpId(editEmp.getEmpId());
				leaveEncash.setLeaveCount(noOfDays);
				leaveEncash.setLvTypeId(leaveTypeId);
				leaveEncash.setMonth(Integer.parseInt(st[0]));
				leaveEncash.setYear(Integer.parseInt(st[1]));
				leaveEncash.setPerDayAmt(Float.parseFloat(df.format(perday)));
				leaveEncash.setTotalAmt(Math.round(perday * noOfDays));
				leaveEncash.setRemark(leaveRemark);
				leaveEncash.setYearId(calculateYear.getCalYrId());
				leaveEncash.setAddedBy(userObj.getEmpId());

				info = Constants.getRestTemplate().postForObject(Constants.url + "/newLeaveEncash", leaveEncash,
						Info.class);
			} else {
				info.setError(true);
				info.setMsg("Insufienct leave bal.");
			}

			if (info.isError() == false) {
				// retString = info.getMsg();
				session.setAttribute("successMsg", "Leave encash successfully submitted.");

			} else {
				session.setAttribute("errorMsg", "Error while encash leave.");

			}
		} catch (Exception e) {
			e.printStackTrace();
			info.setError(true);
			info.setMsg("Error while encash leave.");
		}

		return info;
	}

	@RequestMapping(value = "/leaveEncashHistory", method = RequestMethod.GET)
	public String leaveEncashHistory(HttpServletRequest request, HttpServletResponse response, Model model) {

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
			returnLink = "leave/leaveEncashHistory";
			int empId = Integer.parseInt(request.getParameter("empId"));

			CalenderYear calculateYear = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getCalculateYearListIsCurrent", CalenderYear.class);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			model.addAttribute("empId", empId);

			map = new LinkedMultiValueMap<>();
			map.add("empId", empId);
			map.add("currYrId", calculateYear.getCalYrId());

			GetLeaveEncashDetail[] encashHistory = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getLeaveEncashDetailByEmpId", map, GetLeaveEncashDetail[].class);

			List<GetLeaveEncashDetail> encashHistoryList = new ArrayList<GetLeaveEncashDetail>(
					Arrays.asList(encashHistory));

			editEmp = Constants.getRestTemplate().postForObject(Constants.url + "/getEmpInfoByEmpId", map,
					EmployeeMaster.class);

			model.addAttribute("editEmp", editEmp);
			model.addAttribute("encashHistoryList", encashHistoryList);
			// }
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnLink;
	}

	@RequestMapping(value = "/deleteEncashLeave", method = RequestMethod.GET)
	public String deleteEncashLeave(HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		String returnLink = "accessDenied";

		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");

		Info view = AcessController.checkAccess("deleteContractor", "showContractorsList", 0, 0, 0, 1, newModuleList);
		if (view.isError() == false) {

			try {
				int empId = Integer.parseInt(request.getParameter("empId"));
				int id = Integer.parseInt(request.getParameter("id"));
				returnLink = "redirect:/leaveEncashHistory?empId=" + empId;
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("id", id);

				Info res = Constants.getRestTemplate().postForObject(Constants.url + "/deleteEncashLeave", map,
						Info.class);

				if (res.isError()) {
					session.setAttribute("errorMsg", "Failed to Delete Leave Encash Record");
				} else {
					session.setAttribute("successMsg", "Leave Encash Record Deleted Successfully");

				}

			} catch (Exception e) {
				e.printStackTrace();
				session.setAttribute("errorMsg", "Failed to Delete");
			}

		}
		return returnLink;
	}

}

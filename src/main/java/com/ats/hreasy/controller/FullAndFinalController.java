package com.ats.hreasy.controller;

import java.util.ArrayList;
import java.util.Arrays;
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
import com.ats.hreasy.common.FormValidation;
import com.ats.hreasy.model.AdvanceAndLoanInfo;
import com.ats.hreasy.model.CalenderYear;
import com.ats.hreasy.model.EmpBasicAllownceForLeaveInCash;
import com.ats.hreasy.model.EmpSalaryInfo;
import com.ats.hreasy.model.EmployeeMaster;
import com.ats.hreasy.model.GetDetailForGraduaty;
import com.ats.hreasy.model.GetEmployeeDetails;
import com.ats.hreasy.model.LeaveHistory;
import com.ats.hreasy.model.LeaveStructureHeader;
import com.ats.hreasy.model.Setting;

@Controller
@Scope("session")
public class FullAndFinalController {

	
	
	@RequestMapping(value = "/showEmpListForFullnfinal", method = RequestMethod.GET)
	public String showEmpListForFullnfinal(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = new String();

		try {

			mav = "FullAndFinal/showEmpListForFullnfinal";
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("companyId", 1);

			/*
			 * EmployeeMaster[] empArr =
			 * Constants.getRestTemplate().postForObject(Constants.url + "/getAllEmployee",
			 * map, EmployeeMaster[].class); List<EmployeeMaster> empList = new
			 * ArrayList<EmployeeMaster>(Arrays.asList(empArr));
			 */

			GetEmployeeDetails[] empdetList1 = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getAllEmployeeDetail", GetEmployeeDetails[].class); 
			List<GetEmployeeDetails> empList = new ArrayList<GetEmployeeDetails>(Arrays.asList(empdetList1));
			
			for (int i = 0; i < empList.size(); i++) {

				empList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(empList.get(i).getEmpId())));
			}

			model.addAttribute("empList", empList);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	EmployeeMaster empInfoshow = new EmployeeMaster();
	EmpSalaryInfo empSalInfo = new EmpSalaryInfo();

	@RequestMapping(value = "/showfullnfinal", method = RequestMethod.GET)
	public String showEmpGraphs(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = new String();

		try {

			mav = "FullAndFinal/fullnfinal";

			/*String base64encodedString = request.getParameter("empId");
			int empId = Integer.parseInt(FormValidation.DecodeKey(base64encodedString));
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("empId", empId);
			empInfoshow = Constants.getRestTemplate().postForObject(Constants.url + "/getEmployeeById", map,
					EmployeeMaster.class);
			empSalInfo = Constants.getRestTemplate().postForObject(Constants.url + "/getEmployeeSalInfo", map,
					EmpSalaryInfo.class);
			model.addAttribute("empinfo", empInfoshow);
			model.addAttribute("empSalInfo", empSalInfo);*/
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/fullnfinalprocess", method = RequestMethod.GET)
	public String fullnfinalprocess(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = new String();

		try {

			mav = "FullAndFinal/fullnfinalprocess";

			/*String leavingDate = request.getParameter("leaveDate");
			String leaveReason = request.getParameter("leaveReason");
			int lrEsic = Integer.parseInt(request.getParameter("lrEsic"));
			int lrForPF = Integer.parseInt(request.getParameter("lrForPF"));*/

			String base64encodedString = request.getParameter("empId");
			int empId = Integer.parseInt(FormValidation.DecodeKey(base64encodedString));
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("empId", empId);
			empInfoshow = Constants.getRestTemplate().postForObject(Constants.url + "/getEmployeeById", map,
					EmployeeMaster.class);
			empSalInfo = Constants.getRestTemplate().postForObject(Constants.url + "/getEmployeeSalInfo", map,
					EmpSalaryInfo.class);
			model.addAttribute("empinfo", empInfoshow);
			model.addAttribute("empSalInfo", empSalInfo);
			model.addAttribute("empinfo", empInfoshow);
			model.addAttribute("empSalInfo", empSalInfo);

			CalenderYear calculateYear = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getCalculateYearListIsCurrent", CalenderYear.class);

			map = new LinkedMultiValueMap<>();

			map = new LinkedMultiValueMap<>();
			map.add("empId", empInfoshow.getEmpId());
			map.add("currYrId", calculateYear.getCalYrId());

			LeaveHistory[] leaveHistory = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getLeaveHistoryList", map, LeaveHistory[].class);
			List<LeaveHistory> previousleavehistorylist = new ArrayList<>(Arrays.asList(leaveHistory));
			model.addAttribute("previousleavehistorylist", previousleavehistorylist);
			
			map = new LinkedMultiValueMap<>();
			map.add("lvsId", previousleavehistorylist.get(0).getLvsId());
			map.add("empId", empInfoshow.getEmpId());
			EmpBasicAllownceForLeaveInCash empBasicAllownceForLeaveInCash = Constants.getRestTemplate().postForObject(
					Constants.url + "/getEmployeeBasicAndAllownceValueByEmpIdAndStructId", map,
					EmpBasicAllownceForLeaveInCash.class);
			model.addAttribute("empBasicAllownceForLeaveInCash", empBasicAllownceForLeaveInCash);

			map = new LinkedMultiValueMap<>();
			map.add("limitKey", "monthday");
			Setting dayInMonth = Constants.getRestTemplate().postForObject(Constants.url + "/getSettingByKey", map,
					Setting.class);
			model.addAttribute("day", dayInMonth.getValue());
			
			map = new LinkedMultiValueMap<>();
			map.add("empId", empInfoshow.getEmpId());
			AdvanceAndLoanInfo advanceAndLoanInfo = Constants.getRestTemplate().postForObject(Constants.url + "/getAllAmountDeductionSectionListForFullnFinal", map,
					AdvanceAndLoanInfo.class);
			model.addAttribute("advanceAndLoanInfo", advanceAndLoanInfo);
			
			GetDetailForGraduaty getDetailForGraduaty = Constants.getRestTemplate().postForObject(Constants.url + "/getdetailforgraduaty", map,
					GetDetailForGraduaty.class);
			model.addAttribute("getDetailForGraduaty", getDetailForGraduaty);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

}

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.ats.hreasy.common.Constants;
import com.ats.hreasy.common.DateConvertor;
import com.ats.hreasy.common.FormValidation;
import com.ats.hreasy.model.AdvanceAndLoanInfo;
import com.ats.hreasy.model.CalenderYear;
import com.ats.hreasy.model.EmpBasicAllownceForLeaveInCash;
import com.ats.hreasy.model.EmpSalaryInfo;
import com.ats.hreasy.model.EmployeeMaster;
import com.ats.hreasy.model.FullAndFinal;
import com.ats.hreasy.model.GetDetailForBonus;
import com.ats.hreasy.model.GetDetailForGraduaty;
import com.ats.hreasy.model.GetEmployeeDetails;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.LeaveHistory;
import com.ats.hreasy.model.LeaveStructureHeader;
import com.ats.hreasy.model.LoginResponse;
import com.ats.hreasy.model.Setting;
import com.ats.hreasy.model.ViewEmployee;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;

@Controller
@Scope("session")
public class FullAndFinalController {

	@RequestMapping(value = "/showEmpListForFullnfinal", method = RequestMethod.GET)
	public String showEmpListForFullnfinal(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = new String();

		try {

			mav = "FullAndFinal/showEmpListForFullnfinal";
			HttpSession session = request.getSession();
			int locId = (int) session.getAttribute("liveLocationId");
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("locId", locId);
			/*
			 * EmployeeMaster[] empArr =
			 * Constants.getRestTemplate().postForObject(Constants.url + "/getAllEmployee",
			 * map, EmployeeMaster[].class); List<EmployeeMaster> empList = new
			 * ArrayList<EmployeeMaster>(Arrays.asList(empArr));
			 */

			GetEmployeeDetails[] empdetList1 = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getAllEmployeeDetailForFullnFinalLocId",map, GetEmployeeDetails[].class);
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

			/*
			 * String base64encodedString = request.getParameter("empId"); int empId =
			 * Integer.parseInt(FormValidation.DecodeKey(base64encodedString));
			 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			 * map.add("empId", empId); empInfoshow =
			 * Constants.getRestTemplate().postForObject(Constants.url + "/getEmployeeById",
			 * map, EmployeeMaster.class); empSalInfo =
			 * Constants.getRestTemplate().postForObject(Constants.url +
			 * "/getEmployeeSalInfo", map, EmpSalaryInfo.class);
			 * model.addAttribute("empinfo", empInfoshow); model.addAttribute("empSalInfo",
			 * empSalInfo);
			 */
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

			/*
			 * String leavingDate = request.getParameter("leaveDate"); String leaveReason =
			 * request.getParameter("leaveReason"); int lrEsic =
			 * Integer.parseInt(request.getParameter("lrEsic")); int lrForPF =
			 * Integer.parseInt(request.getParameter("lrForPF"));
			 */

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
			AdvanceAndLoanInfo advanceAndLoanInfo = Constants.getRestTemplate().postForObject(
					Constants.url + "/getAllAmountDeductionSectionListForFullnFinal", map, AdvanceAndLoanInfo.class);
			model.addAttribute("advanceAndLoanInfo", advanceAndLoanInfo);

			GetDetailForGraduaty getDetailForGraduaty = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getdetailforgraduaty", map, GetDetailForGraduaty.class);
			model.addAttribute("getDetailForGraduaty", getDetailForGraduaty);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/calculateBonusAmt", method = RequestMethod.POST)
	@ResponseBody
	public GetDetailForBonus calculateBonusAmt(HttpServletRequest request, HttpServletResponse response, Model model) {

		GetDetailForBonus getDetailForBonus = new GetDetailForBonus();

		try {

			String fromMonth = request.getParameter("fromMonth");
			String toMonth = request.getParameter("toMonth");

			String[] fmonthyear = fromMonth.split("-");
			String[] tomonthyear = toMonth.split("-");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("empId", empInfoshow.getEmpId());
			map.add("fromMonth", fmonthyear[0]);
			map.add("toMonth", tomonthyear[0]);
			map.add("fromYear", fmonthyear[1]);
			map.add("toYear", tomonthyear[1]);
			getDetailForBonus = Constants.getRestTemplate().postForObject(Constants.url + "/getbonuscalDetails", map,
					GetDetailForBonus.class);

		} catch (Exception e) {
			e.printStackTrace();

		}
		return getDetailForBonus;

	}

	@RequestMapping(value = "/submitFullandFinal", method = RequestMethod.POST)
	public String submitFullandFinal(HttpServletRequest request, HttpServletResponse response, Model model) {

		try {

			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("empId", empInfoshow.getEmpId());

			ViewEmployee empInfo = Constants.getRestTemplate().postForObject(Constants.url + "/getEmployeeAllInfo", map,
					ViewEmployee.class);

			String leaveDate = request.getParameter("leaveDate");
			String leaveReason = request.getParameter("leaveReason");
			String lrEsic = request.getParameter("lrEsic");
			String lrForPF = request.getParameter("lrForPF");
			float advanceamt = Float.parseFloat(request.getParameter("advanceamt"));
			float loanamt = Float.parseFloat(request.getParameter("loanamt"));
			int leaveincash = Integer.parseInt(request.getParameter("leaveincash"));
			float leavecashamt = Float.parseFloat(request.getParameter("leavecashamt"));
			float gratuityamt = Float.parseFloat(request.getParameter("gratuityamt"));
			float bonusAmt = Float.parseFloat(request.getParameter("bonusAmt"));
			String fromMonth = request.getParameter("fromMonth");
			String toMonth = request.getParameter("toMonth");
			float plusamt = Float.parseFloat(request.getParameter("plusamt"));
			float minusamt = Float.parseFloat(request.getParameter("minusamt"));
			String remark = request.getParameter("remark");

			String[] leaveDatesplt = leaveDate.split("-");
			/*
			 * System.out.println(leaveDate); System.out.println(leaveReason);
			 * System.out.println(lrEsic); System.out.println(lrForPF);
			 * System.out.println(advanceamt); System.out.println(loanamt);
			 * System.out.println(leaveincash); System.out.println(leavecashamt);
			 * System.out.println(gratuityamt); System.out.println(bonusAmt);
			 * System.out.println(fromMonth); System.out.println(toMonth);
			 * System.out.println(plusamt); System.out.println(minusamt);
			 */
			Date date = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
			String json = ow.writeValueAsString(empInfo);

			FullAndFinal save = new FullAndFinal();
			save.setLeavingDate(DateConvertor.convertToYMD(leaveDate));
			save.setEmpId(empInfoshow.getEmpId());
			save.setAdvanceBalAmt(advanceamt);
			save.setLoanBalAmt(loanamt);
			save.setLeaveCountCash(leaveincash);
			save.setLeaveInCashAmt(leavecashamt);
			save.setGratuityAmt(gratuityamt);
			save.setBonusExgratiaAmt(bonusAmt);
			save.setBonusFromMonth(fromMonth);
			save.setBonusToMonth(toMonth);
			save.setAdjstPlus(plusamt);
			save.setAdjstMinus(minusamt);
			save.setNetAmt(advanceamt + loanamt + leavecashamt + gratuityamt + bonusAmt + plusamt - minusamt);
			save.setComment(remark);
			save.setLoginId(userObj.getUserId());
			save.setLoginDate(sf.format(date));
			save.setEmpDataJson(json);
			save.setEmpCode(empInfo.getEmpCode());

			FullAndFinal res = Constants.getRestTemplate().postForObject(Constants.url + "/insertfullandfinalrecord",
					save, FullAndFinal.class);

			if (res != null) {

				map = new LinkedMultiValueMap<>();
				map.add("empIds", empInfoshow.getEmpId());
				map.add("userId", userObj.getUserId());
				map.add("month", leaveDatesplt[1]);
				map.add("year", leaveDatesplt[2]);
				Info advupdateres = Constants.getRestTemplate()
						.postForObject(Constants.url + "/updateIsPaidInPaydeClaimAdvLoanInFullFinal", map, Info.class);

				map = new LinkedMultiValueMap<>();
				map.add("empId", empInfoshow.getEmpId());
				map.add("leaveDate", DateConvertor.convertToYMD(leaveDate));
				map.add("leaveReason", leaveReason);
				map.add("lrEsic", lrEsic);
				map.add("lrForPF", lrForPF);
				Info leavingDatainfo = Constants.getRestTemplate()
						.postForObject(Constants.url + "/updateLeaveDatainemployee", map, Info.class);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/showEmpListForFullnfinal";
	}

}

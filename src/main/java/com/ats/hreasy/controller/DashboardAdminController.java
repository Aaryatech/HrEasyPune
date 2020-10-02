package com.ats.hreasy.controller;

import java.text.SimpleDateFormat;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ats.hreasy.common.Constants;
import com.ats.hreasy.common.DateConvertor;
import com.ats.hreasy.model.AssetCategory;
import com.ats.hreasy.model.CalenderYear;
import com.ats.hreasy.model.DailyDaily;
import com.ats.hreasy.model.DashboardLeavePending;
import com.ats.hreasy.model.Department;
import com.ats.hreasy.model.EmpDeptWise;
import com.ats.hreasy.model.EmpGraphDetail;
import com.ats.hreasy.model.EmpInfoForDashBoard;
import com.ats.hreasy.model.GetEmployeeDetails;
import com.ats.hreasy.model.GetLeaveApplyAuthwise;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.LeaveHistory;
import com.ats.hreasy.model.LineGraphData;
import com.ats.hreasy.model.LoginResponse;
import com.ats.hreasy.model.MonthWiseDisbusedAmt;
import com.ats.hreasy.model.MonthWithOT;
import com.ats.hreasy.model.MstEmpType;
import com.ats.hreasy.model.SelfAttendanceDetail;
import com.ats.hreasy.model.Setting;
import com.ats.hreasy.model.SummaryAttendance;
import com.ats.hreasy.model.SummaryDailyAttendance;
import com.ats.hreasy.model.TotalOT;
import com.ats.hreasy.model.Advance.GetAdvance;
import com.ats.hreasy.model.claim.GetClaimApplyAuthwise;
import com.ats.hreasy.model.dashboard.AgeDiversityDash;
import com.ats.hreasy.model.dashboard.BirthHoliDash;
import com.ats.hreasy.model.dashboard.CommonDash;
import com.ats.hreasy.model.dashboard.DeptWiseWeekoffDash;
import com.ats.hreasy.model.dashboard.GetAllPendingMasterDet;
import com.ats.hreasy.model.dashboard.GetLeaveHistForDash;
import com.ats.hreasy.model.dashboard.GetNewHiresDash;
import com.ats.hreasy.model.dashboard.IncentivesAmtDash;
import com.ats.hreasy.model.dashboard.LeavePenDash;
import com.ats.hreasy.model.dashboard.LoanAdvDashDet;
import com.ats.hreasy.model.dashboard.PayRewardDedDash;
import com.ats.hreasy.model.dashboard.PerformanceProdDash;
import com.ats.hreasy.model.dashboard.PreDayAttnDash;
import com.ats.hreasy.model.report.DashTempBean;
import com.ats.hreasy.model.report.HodDashboard;
import com.ats.hreasy.model.report.HodDeptDashb;
import com.ats.hrmgt.model.AttendaceLiveData;
import com.ats.hrmgt.model.assets.AMCExpirationDetail;
import com.ats.hrmgt.model.assets.AssetNotificatn;
import com.ats.hrmgt.model.assets.CatWiseAssetCount;
import com.ats.hrmgt.model.assets.ServicingDashDetails;
import com.itextpdf.text.pdf.PdfStructTreeController.returnType;

@Controller
@Scope("session")
public class DashboardAdminController {

	@RequestMapping(value = "/assetsDashboard", method = RequestMethod.GET)
	public String assetsDashboard(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "assetsDashbPage";
		Date date = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat sf1 = new SimpleDateFormat("yyyy-MM-dd");
		HttpSession session = request.getSession();
		LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");
		try {

			AssetNotificatn[] assetArr = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getAllAssetsForNotifiction", AssetNotificatn[].class);
			List<AssetNotificatn> assetRtnPndngList = new ArrayList<AssetNotificatn>(Arrays.asList(assetArr));
			model.addAttribute("assetRtnPndngList", assetRtnPndngList);

			AMCExpirationDetail[] assetAMCExpiryArr = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getAllAssetsAMCForNotifiction", AMCExpirationDetail[].class);
			List<AMCExpirationDetail> assetAMCExpiryList = new ArrayList<AMCExpirationDetail>(
					Arrays.asList(assetAMCExpiryArr));
			model.addAttribute("assetAMCExpiryList", assetAMCExpiryList);

			ServicingDashDetails[] assetServiceArr = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getServicingDetails", ServicingDashDetails[].class);
			List<ServicingDashDetails> assetServiceList = new ArrayList<ServicingDashDetails>(
					Arrays.asList(assetServiceArr));
			model.addAttribute("assetServiceList", assetServiceList);

			CatWiseAssetCount[] catAssetArray = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getCateWiseAssetCnt", CatWiseAssetCount[].class);
			List<CatWiseAssetCount> catAssetList = new ArrayList<CatWiseAssetCount>(Arrays.asList(catAssetArray));
			model.addAttribute("catAssetList", catAssetList);

		} catch (Exception e) {

		}
		return mav;
	}

	@RequestMapping(value = "/getCateAssetCount", method = RequestMethod.GET)
	public @ResponseBody List<CatWiseAssetCount> cateAssetCount(HttpServletRequest request,
			HttpServletResponse response, Model model) {

		CatWiseAssetCount[] catAssetArray = Constants.getRestTemplate()
				.getForObject(Constants.url + "/getCateWiseAssetCnt", CatWiseAssetCount[].class);
		List<CatWiseAssetCount> catAssetList = new ArrayList<CatWiseAssetCount>(Arrays.asList(catAssetArray));

		return catAssetList;
	}

	/*
	 * @RequestMapping(value = "/dashboard", method = RequestMethod.GET) public
	 * String dashboard1(HttpServletRequest request, HttpServletResponse response,
	 * Model model) {
	 * 
	 * String mav = "welcome"; Date date = new Date(); SimpleDateFormat sf = new
	 * SimpleDateFormat("dd-MM-yyyy"); SimpleDateFormat sf1 = new
	 * SimpleDateFormat("yyyy-MM-dd"); HttpSession session = request.getSession();
	 * LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo"); try
	 * {
	 * 
	 * String fiterdate = sf1.format(date);
	 * 
	 * try { fiterdate =
	 * DateConvertor.convertToYMD(request.getParameter("fiterdate"));
	 * 
	 * model.addAttribute("fiterdate", request.getParameter("fiterdate"));
	 * 
	 * } catch (Exception e) { fiterdate = sf1.format(date);
	 * model.addAttribute("fiterdate", sf.format(date));
	 * 
	 * } if (fiterdate == null) { fiterdate = sf1.format(date);
	 * model.addAttribute("fiterdate", sf.format(date));
	 * 
	 * }
	 * 
	 * model.addAttribute("userType", userObj.getDesignType());
	 * 
	 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
	 * 
	 * map.add("empId", userObj.getEmpId());
	 * 
	 * Integer n = Constants.getRestTemplate().postForObject(Constants.url +
	 * "/chkIsAuth", map, Integer.class); model.addAttribute("isAuth", n);
	 * 
	 * // start map = new LinkedMultiValueMap<>(); map.add("fiterdate", fiterdate);
	 * 
	 * BirthHoliDash birth = Constants.getRestTemplate()
	 * .postForObject(Constants.url + "/getBirthDayAndHolidayDash", map,
	 * BirthHoliDash.class); model.addAttribute("birth", birth);
	 * 
	 * GetNewHiresDash newHire =
	 * Constants.getRestTemplate().postForObject(Constants.url + "/getNewHireDash",
	 * map, GetNewHiresDash.class); model.addAttribute("newHire", newHire);
	 * 
	 * LeavePenDash lvDet = Constants.getRestTemplate().getForObject(Constants.url +
	 * "/getLeaveCountDash", LeavePenDash.class); model.addAttribute("lvDet",
	 * lvDet);
	 * 
	 * PreDayAttnDash attnDet =
	 * Constants.getRestTemplate().postForObject(Constants.url + "/getAttnDash",
	 * map, PreDayAttnDash.class); model.addAttribute("attnDet", attnDet);
	 * 
	 * GetAllPendingMasterDet masterDet = Constants.getRestTemplate()
	 * .getForObject(Constants.url + "/getAllPendingMasterDet",
	 * GetAllPendingMasterDet.class); model.addAttribute("masterDet", masterDet);
	 * 
	 * DeptWiseWeekoffDash[] company = Constants.getRestTemplate()
	 * .postForObject(Constants.url + "/getDashDeptWiseWeekoff", map,
	 * DeptWiseWeekoffDash[].class);
	 * 
	 * List<DeptWiseWeekoffDash> deptwiseWkoff = new
	 * ArrayList<DeptWiseWeekoffDash>(Arrays.asList(company));
	 * 
	 * model.addAttribute("deptwiseWkoff", deptwiseWkoff);
	 * 
	 * DeptWiseWeekoffDash[] perf = Constants.getRestTemplate()
	 * .postForObject(Constants.url + "/getDeptWisePerformanceBonus", map,
	 * DeptWiseWeekoffDash[].class);
	 * 
	 * List<DeptWiseWeekoffDash> perfListDept = new
	 * ArrayList<DeptWiseWeekoffDash>(Arrays.asList(perf));
	 * 
	 * model.addAttribute("perfListDept", perfListDept);
	 * 
	 * System.err.println("perfListDept" + perfListDept.toString());
	 * 
	 * DeptWiseWeekoffDash[] deptWiseLvAb = Constants.getRestTemplate()
	 * .postForObject(Constants.url + "/getEmpAbsentLv", map,
	 * DeptWiseWeekoffDash[].class);
	 * 
	 * List<DeptWiseWeekoffDash> deptWiseLvAbLList = new
	 * ArrayList<DeptWiseWeekoffDash>( Arrays.asList(deptWiseLvAb));
	 * 
	 * model.addAttribute("deptWiseLvAbLList", deptWiseLvAbLList);
	 * 
	 * // Diversity rep
	 * 
	 * DeptWiseWeekoffDash[] deptWiseEmpCnt = Constants.getRestTemplate()
	 * .getForObject(Constants.url + "/getDashDeptWiseEmpCount",
	 * DeptWiseWeekoffDash[].class);
	 * 
	 * List<DeptWiseWeekoffDash> deptWiseEmpCntList = new
	 * ArrayList<DeptWiseWeekoffDash>( Arrays.asList(deptWiseEmpCnt));
	 * 
	 * model.addAttribute("deptWiseEmpCntList", deptWiseEmpCntList);
	 * 
	 * GetNewHiresDash ageDiv =
	 * Constants.getRestTemplate().getForObject(Constants.url + "/getAgeDiversity",
	 * GetNewHiresDash.class); model.addAttribute("ageDiv", ageDiv);
	 * 
	 * AgeDiversityDash[] diverse = Constants.getRestTemplate()
	 * .postForObject(Constants.url + "/getAgeDiversityDetail", map,
	 * AgeDiversityDash[].class); List<AgeDiversityDash> diverseList = new
	 * ArrayList<AgeDiversityDash>(Arrays.asList(diverse));
	 * 
	 * model.addAttribute("ageDiversity", diverseList.get(0));
	 * model.addAttribute("expDiversity", diverseList.get(1));
	 * model.addAttribute("salDiversity", diverseList.get(2)); // end Diversity rep
	 * 
	 * map = new LinkedMultiValueMap<>(); map.add("type", 1); map.add("fiterdate",
	 * fiterdate); PayRewardDedDash dedDet =
	 * Constants.getRestTemplate().postForObject(Constants.url + "/getRewardedDet",
	 * map, PayRewardDedDash.class); model.addAttribute("dedDet", dedDet);
	 * 
	 * map = new LinkedMultiValueMap<>(); map.add("type", 2); map.add("fiterdate",
	 * fiterdate); PayRewardDedDash rewardDet =
	 * Constants.getRestTemplate().postForObject(Constants.url + "/getRewardedDet",
	 * map, PayRewardDedDash.class); model.addAttribute("rewardDet", rewardDet);
	 * 
	 * map = new LinkedMultiValueMap<>(); map.add("type", 1); map.add("fiterdate",
	 * fiterdate); LoanAdvDashDet advDet =
	 * Constants.getRestTemplate().postForObject(Constants.url + "/getAdvLoanDash",
	 * map, LoanAdvDashDet.class); model.addAttribute("advDet", advDet);
	 * 
	 * map = new LinkedMultiValueMap<>(); map.add("type", 2); map.add("fiterdate",
	 * fiterdate); LoanAdvDashDet loanDet =
	 * Constants.getRestTemplate().postForObject(Constants.url + "/getAdvLoanDash",
	 * map, LoanAdvDashDet.class); model.addAttribute("loanDet", loanDet);
	 * 
	 * CalenderYear calculateYear = Constants.getRestTemplate()
	 * .getForObject(Constants.url + "/getCalculateYearListIsCurrent",
	 * CalenderYear.class); map = new LinkedMultiValueMap<>(); map.add("empId",
	 * userObj.getEmpId()); map.add("currYrId", calculateYear.getCalYrId());
	 * 
	 * GetLeaveApplyAuthwise[] employeeDoc = Constants.getRestTemplate()
	 * .postForObject(Constants.url + "/getLeaveApplyListForPending", map,
	 * GetLeaveApplyAuthwise[].class); List<GetLeaveApplyAuthwise> leaveList = new
	 * ArrayList<GetLeaveApplyAuthwise>(Arrays.asList(employeeDoc));
	 * 
	 * model.addAttribute("list1Count", leaveList.size());
	 * 
	 * map = new LinkedMultiValueMap<>(); map.add("empId", userObj.getEmpId());
	 * map.add("currYrId", calculateYear.getCalYrId());
	 * 
	 * LeaveHistory[] leaveHistory = Constants.getRestTemplate()
	 * .postForObject(Constants.url + "/getLeaveHistoryList", map,
	 * LeaveHistory[].class);
	 * 
	 * List<LeaveHistory> leaveHistoryList = new
	 * ArrayList<LeaveHistory>(Arrays.asList(leaveHistory));
	 * model.addAttribute("leaveHistoryList", leaveHistoryList);
	 * 
	 * map = new LinkedMultiValueMap<>(); map.add("empId", userObj.getEmpId());
	 * MstEmpType mstEmpType =
	 * Constants.getRestTemplate().postForObject(Constants.url +
	 * "/getEmpTypeByempId", map, MstEmpType.class);
	 * model.addAttribute("mstEmpType", mstEmpType); // leave end
	 * 
	 * map = new LinkedMultiValueMap<>(); map.add("empId", userObj.getEmpId());
	 * 
	 * GetLeaveHistForDash[] lvAppl = Constants.getRestTemplate()
	 * .postForObject(Constants.url + "/getLeaveHistForDash", map,
	 * GetLeaveHistForDash[].class);
	 * 
	 * List<GetLeaveHistForDash> lvApplList = new
	 * ArrayList<GetLeaveHistForDash>(Arrays.asList(lvAppl));
	 * 
	 * model.addAttribute("lvApplList", lvApplList);
	 * 
	 * map = new LinkedMultiValueMap<>();
	 * 
	 * map.add("fiterdate", fiterdate); map.add("empId", userObj.getEmpId());
	 * SummaryDailyAttendance attnLastMon = Constants.getRestTemplate()
	 * .postForObject(Constants.url + "/getEmpLastMonthAttn", map,
	 * SummaryDailyAttendance.class); model.addAttribute("attnLastMon",
	 * attnLastMon);
	 * 
	 * map = new LinkedMultiValueMap<>();
	 * 
	 * map.add("empId", userObj.getEmpId());
	 * 
	 * DeptWiseWeekoffDash[] dedWiseDed = Constants.getRestTemplate()
	 * .postForObject(Constants.url + "/getDedTypewiseDeduction", map,
	 * DeptWiseWeekoffDash[].class);
	 * 
	 * List<DeptWiseWeekoffDash> dedWiseDedList = new
	 * ArrayList<DeptWiseWeekoffDash>(Arrays.asList(dedWiseDed));
	 * 
	 * model.addAttribute("dedWiseDedList", dedWiseDedList);
	 * 
	 * System.err.println("dedWiseDedList---" + dedWiseDedList.toString());
	 * 
	 * DeptWiseWeekoffDash[] rewardWiseDed = Constants.getRestTemplate()
	 * .postForObject(Constants.url + "/getRewardWisewiseDeduction", map,
	 * DeptWiseWeekoffDash[].class);
	 * 
	 * List<DeptWiseWeekoffDash> rewardWiseDedList = new
	 * ArrayList<DeptWiseWeekoffDash>( Arrays.asList(rewardWiseDed));
	 * 
	 * model.addAttribute("rewardWiseDedList", rewardWiseDedList);
	 * 
	 * System.err.println("rewardWiseDedList---" + rewardWiseDedList.toString());
	 * 
	 * map = new LinkedMultiValueMap<>(); map.add("fiterdate", fiterdate);
	 * map.add("empId", userObj.getEmpId());
	 * 
	 * PerformanceProdDash[] perfProd =
	 * Constants.getRestTemplate().postForObject(Constants.url + "/getPerfProd",
	 * map, PerformanceProdDash[].class);
	 * 
	 * List<PerformanceProdDash> perfProdList = new
	 * ArrayList<PerformanceProdDash>(Arrays.asList(perfProd));
	 * 
	 * model.addAttribute("perfList", perfProdList.get(0));
	 * model.addAttribute("prodList", perfProdList.get(1));
	 * 
	 * map = new LinkedMultiValueMap<>(); map.add("empId", userObj.getEmpId());
	 * IncentivesAmtDash icent =
	 * Constants.getRestTemplate().postForObject(Constants.url +
	 * "/getEmpTotAmtsDash", map, IncentivesAmtDash.class);
	 * model.addAttribute("icent", icent);
	 * 
	 * } catch (Exception e) { e.printStackTrace(); }
	 * 
	 * return mav;
	 * 
	 * }
	 */

	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String dashboard(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "welcome1";

		try {
			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			model.addAttribute("designType", userObj.getDesignType());

			if (userObj.getDesignType() == 1) {
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

				/*
				 * Akshay Code Prev. Date dt = new Date();
				 * 
				 * SimpleDateFormat mm = new SimpleDateFormat("MM"); SimpleDateFormat yy = new
				 * SimpleDateFormat("yyyy");
				 * 
				 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				 * 
				 * map.add("deptId", userObj.getHodDeptIds()); map.add("month", mm.format(dt));
				 * map.add("year", yy.format(dt));
				 * 
				 * SummaryAttendance[] summaryAttendance = Constants.getRestTemplate()
				 * .postForObject(Constants.url + "/getCountofWeeklyOff", map,
				 * SummaryAttendance[].class); List<SummaryAttendance> weeklyofcountList = new
				 * ArrayList<>(Arrays.asList(summaryAttendance));
				 * model.addAttribute("weeklyofcountList", weeklyofcountList);
				 */
				map = new LinkedMultiValueMap<>();
				map.add("limitKey", "is_hod_dashb_show");
				Setting getHodKeyVakue = Constants.getRestTemplate().postForObject(Constants.url + "/getSettingByKey",
						map, Setting.class);
				model.addAttribute("is_hod_dashb_show", getHodKeyVakue.getValue());

				if (getHodKeyVakue.getValue().equalsIgnoreCase("1")) {

					map = new LinkedMultiValueMap<>();
					map.add("deptIdString", userObj.getHodDeptIds());
					Department[] department = Constants.getRestTemplate()
							.postForObject(Constants.url + "/getDeptByDeptIds", map, Department[].class);

					List<Department> departmentList = new ArrayList<Department>(Arrays.asList(department));

					model.addAttribute("deptList", departmentList);

					map = new LinkedMultiValueMap<>();
					map.add("limitKey", "no_of_woffs");
					Setting noOfWoffs = Constants.getRestTemplate().postForObject(Constants.url + "/getSettingByKey",
							map, Setting.class);
					model.addAttribute("noOfWoffs", noOfWoffs.getValue());

					// Calendar cal = Calendar.getInstance();
					// int numDays = cal.getActualMaximum(Calendar.DATE);
					// System.out.println("************" + numDays);
					// int currWeekNo = cal.get(Calendar.WEEK_OF_MONTH);
					Date dt = new Date();
					SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
					String date = sf.format(dt);
					String[] arr = date.split("-");
					String firstDate = arr[0] + "-" + arr[1] + "-01";

					int diff = difffun(firstDate, date);

					System.out.println(diff + " " + firstDate + " " + date);
					int currWeekNo = diff / 7;
					model.addAttribute("currWeekNo", currWeekNo);
					model.addAttribute("diff", diff);

					/*
					 * String prevMonthStartEnd = getPrevMonthStartEndDate();
					 * 
					 * String runningMonthStartToCurDate = getFromToDate();
					 * 
					 * String cmFromDate, cmToDate, pmFromDate, pmToDate; String
					 * runningMonthStartToCurDateArr[] = runningMonthStartToCurDate.split(" to ");
					 * String prevMonthStartEndArr[] = prevMonthStartEnd.split(" to ");
					 * 
					 * cmFromDate = runningMonthStartToCurDateArr[0].trim(); cmToDate =
					 * runningMonthStartToCurDateArr[1].trim();
					 * 
					 * pmFromDate = prevMonthStartEndArr[0].trim(); pmToDate =
					 * prevMonthStartEndArr[1].trim();
					 * 
					 * map = new LinkedMultiValueMap<>();
					 * 
					 * map.add("deptIdList", userObj.getHodDeptIds()); map.add("locIdList",
					 * session.getAttribute("liveLocationId"));
					 * 
					 * map.add("cmFromDate", cmFromDate); map.add("cmToDate", cmToDate);
					 * map.add("pmFromDate", pmFromDate); map.add("pmToDate", pmToDate);
					 * 
					 * System.err.println("Map  " + map);
					 * 
					 * HodDashboard[] hodRepArray = Constants.getRestTemplate()
					 * .postForObject(Constants.url + "/getHodDashboard", map,
					 * HodDashboard[].class); List<HodDashboard> dashBList = new
					 * ArrayList<>(Arrays.asList(hodRepArray));
					 * 
					 * 
					 * model.addAttribute("dashBList", dashBList);
					 * 
					 * 
					 * map = new LinkedMultiValueMap<>();
					 * 
					 * map.add("deptIdList", "5,13"); // get from user Ajax map.add("locIdList",
					 * session.getAttribute("liveLocationId"));
					 * 
					 * map.add("pmFromDate", pmFromDate); map.add("pmToDate", pmToDate);
					 * 
					 * System.err.println("Map  " + map); HodDeptDashb[] hodDeptArray =
					 * Constants.getRestTemplate() .postForObject(Constants.url +
					 * "/getHodDeptDashb", map, HodDeptDashb[].class); List<HodDeptDashb>
					 * hodDeptDashBList = new ArrayList<HodDeptDashb>(Arrays.asList(hodDeptArray));
					 * System.err.println(" hodDeptDashBList " + hodDeptDashBList.toString());
					 * model.addAttribute("hodDeptDashBList", hodDeptDashBList);
					 */

				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	// Sachin 05-09-2020
	List<HodDeptDashb> hodDeptDashBList = new ArrayList<HodDeptDashb>();

	@RequestMapping(value = "/getHodDashboard", method = RequestMethod.POST)
	public @ResponseBody Object getHodDashboard(HttpServletRequest request, HttpServletResponse response) {
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
		List<HodDashboard> dashBList = new ArrayList<>();

		HttpSession session = request.getSession();
		DashTempBean responseBean = new DashTempBean();
		try {
			String prevMonthStartEnd = getPrevMonthStartEndDate();

			String runningMonthStartToCurDate = getFromToDate();

			String cmFromDate, cmToDate, pmFromDate, pmToDate;
			String runningMonthStartToCurDateArr[] = runningMonthStartToCurDate.split(" to ");
			String prevMonthStartEndArr[] = prevMonthStartEnd.split(" to ");

			cmFromDate = runningMonthStartToCurDateArr[0].trim();
			cmToDate = runningMonthStartToCurDateArr[1].trim();

			pmFromDate = prevMonthStartEndArr[0].trim();
			pmToDate = prevMonthStartEndArr[1].trim();

			map = new LinkedMultiValueMap<>();

			map.add("deptIdList", Integer.parseInt(request.getParameter("deptId")));
			map.add("locIdList", session.getAttribute("liveLocationId"));

			map.add("cmFromDate", cmFromDate);
			map.add("cmToDate", cmToDate);
			map.add("pmFromDate", pmFromDate);
			map.add("pmToDate", pmToDate);

			HodDashboard[] hodRepArray = Constants.getRestTemplate().postForObject(Constants.url + "/getHodDashboard",
					map, HodDashboard[].class);
			dashBList = new ArrayList<>(Arrays.asList(hodRepArray));
			// System.err.println("dashBList " +dashBList);
			responseBean.setHodDashList(dashBList);
			// NEW DEPT wise

			map = new LinkedMultiValueMap<>();

			map.add("deptIdList", Integer.parseInt(request.getParameter("deptId"))); // get from user Ajax
			map.add("locIdList", session.getAttribute("liveLocationId"));

			map.add("pmFromDate", pmFromDate);
			map.add("pmToDate", pmToDate);

			HodDeptDashb[] hodDeptArray = Constants.getRestTemplate().postForObject(Constants.url + "/getHodDeptDashb",
					map, HodDeptDashb[].class);
			hodDeptDashBList = new ArrayList<HodDeptDashb>(Arrays.asList(hodDeptArray));
			responseBean.setHodDeptList(hodDeptDashBList);
			// end NEW DEPT wise

		} catch (Exception e) {
			e.printStackTrace();
		}
		return responseBean;
	}

	@RequestMapping(value = "/getHodDeptSummaryDashb", method = RequestMethod.POST)
	public @ResponseBody List<HodDeptDashb> getHodDeptSummaryDashb(HttpServletRequest request,
			HttpServletResponse response) {

		return hodDeptDashBList;

	}

	// Sachin 04-09-2020
	public static String getFromToDate() {
		String leaveDateRange = null;
		String fromDate = null;
		String toDate = null;
		Calendar c = Calendar.getInstance(); // this takes current date

		// System.out.println(c.getTime());
		// c.set(Calendar.DAY_OF_MONTH, 1);
		Date toDate1 = c.getTime();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		toDate = sdf.format(toDate1);

		c.set(Calendar.DAY_OF_MONTH, 1);
		Date fromDate1 = c.getTime();

		fromDate = sdf.format(fromDate1);

		leaveDateRange = fromDate.concat(" to ").concat(toDate);
		return leaveDateRange;
	}

	public static String getMonthsStartEnd() {
		String leaveDateRange = null;
		String fromDate = null;
		String toDate = null;
		Calendar c = Calendar.getInstance(); // this takes current date

		// System.out.println(c.getTime());

		c.add(Calendar.MONTH, 1);
		c.set(Calendar.DAY_OF_MONTH, 1);
		c.add(Calendar.DATE, -1);
		Date toDate1 = c.getTime();
//System.err.println("to date "+toDate1);
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

		toDate = sdf.format(toDate1);
		c = Calendar.getInstance();
		c.set(Calendar.DAY_OF_MONTH, 1);
		Date fromDate1 = c.getTime();

		fromDate = sdf.format(fromDate1);

		leaveDateRange = fromDate.concat(" to ").concat(toDate);
		return leaveDateRange;
	}

	// get PrevMonthStartEndDate 04-09-2020

	public String getPrevMonthStartEndDate() {

		String leaveDateRange = null;
		String fromDate = null;
		String toDate = null;

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Calendar aCalendar = Calendar.getInstance();
		// add -1 month to current month
		aCalendar.add(Calendar.MONTH, -1);
		// set DATE to 1, so first date of previous month
		aCalendar.set(Calendar.DATE, 1);

		Date firstDateOfPreviousMonth = aCalendar.getTime();

		fromDate = sdf.format(firstDateOfPreviousMonth);

		// set actual maximum date of previous month
		aCalendar.set(Calendar.DATE, aCalendar.getActualMaximum(Calendar.DAY_OF_MONTH));
		// read it
		Date lastDateOfPreviousMonth = aCalendar.getTime();
		toDate = sdf.format(lastDateOfPreviousMonth);

		leaveDateRange = fromDate.concat(" to ").concat(toDate);
		return leaveDateRange;
	}

	@RequestMapping(value = "/dashboardModified", method = RequestMethod.GET)
	public String dashboardNew(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "welcome";
		Date date = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat sf1 = new SimpleDateFormat("yyyy-MM-dd");
		HttpSession session = request.getSession();
		LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

		String fiterdate = sf1.format(date);

		try {
			fiterdate = DateConvertor.convertToYMD(request.getParameter("fiterdate"));

			model.addAttribute("fiterdate", request.getParameter("fiterdate"));

		} catch (Exception e) {
			fiterdate = sf1.format(date);
			model.addAttribute("fiterdate", sf.format(date));

		}
		if (fiterdate == null) {
			fiterdate = sf1.format(date);
			model.addAttribute("fiterdate", sf.format(date));

		}

		model.addAttribute("userType", userObj.getDesignType());

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

		map.add("empId", userObj.getEmpId());

		/*
		 * Integer n = Constants.getRestTemplate().postForObject(Constants.url +
		 * "/chkIsAuth", map, Integer.class); model.addAttribute("isAuth", n);
		 */

		// Commondash

		int locId = (int) session.getAttribute("liveLocationId");
		map = new LinkedMultiValueMap<>();
		map.add("fiterdate", fiterdate);
		map.add("empId", userObj.getEmpId());
		map.add("userType", userObj.getDesignType());
		map.add("isAuth", 0);
		map.add("locId", locId);
		CommonDash dash = Constants.getRestTemplate().postForObject(Constants.url + "/getCommonDash", map,
				CommonDash.class);

		System.err.println("-------------" + dash.getBirth());
		model.addAttribute("toDayIsBirthday", dash.getBirth().getLoginUserBirthDay());
		model.addAttribute("birth", dash.getBirth()); // alll
		model.addAttribute("newHire", dash.getNewHire()); // hr
		model.addAttribute("lvDet", dash.getLvDet()); // hr
		model.addAttribute("attnDet", dash.getAttnDet());// hr empType= 2
		model.addAttribute("masterDet", dash.getMasterDet());// userType == 2
		model.addAttribute("deptwiseWkoff", dash.getDeptwiseWkoff()); // hr empType= 2 isAuth >0
		model.addAttribute("perfListDept", dash.getPerfListDept()); // userType ==2
		model.addAttribute("deptWiseEmpCntList", dash.getDeptWiseEmpCntList());
		model.addAttribute("ageDiv", dash.getAgeDiv()); // userType ==2
		model.addAttribute("ageDiversity", dash.getAgeDiversity()); // userType ==2
		model.addAttribute("expDiversity", dash.getExpDiversity()); // userType ==2
		model.addAttribute("salDiversity", dash.getSalDiversity()); // userType ==2
		model.addAttribute("rewardDet", dash.getRewardDet()); // userType ==2
		model.addAttribute("advDet", dash.getAdvDet()); // userType == 2
		model.addAttribute("loanDet", dash.getLoanDet()); // userType == 2
		model.addAttribute("lvApplList", dash.getLvApplList());
		model.addAttribute("attnLastMon", dash.getAttnLastMon()); // hr empType= 2 isAuth >0
		model.addAttribute("dedWiseDedList", dash.getDedWiseDedList());
		model.addAttribute("rewardWiseDedList", dash.getRewardWiseDedList());
		model.addAttribute("perfList", dash.getPerfList());
		model.addAttribute("prodList", dash.getProdList());
		model.addAttribute("icent", dash.getIcent());
		model.addAttribute("deptWiseLvAbLList", dash.getDeptWiseLvAbLList());// hr empType= 2 isAuth >0
		model.addAttribute("dedDet", dash.getDedDet()); // hr empType= 2 isAuth >0

		// ends commondash

		CalenderYear calculateYear = Constants.getRestTemplate()
				.getForObject(Constants.url + "/getCalculateYearListIsCurrent", CalenderYear.class);

		// userType == 2

		/* if (n > 0) { */
		map = new LinkedMultiValueMap<>();
		map.add("empId", userObj.getEmpId());
		map.add("currYrId", calculateYear.getCalYrId());

		GetLeaveApplyAuthwise[] employeeDoc = Constants.getRestTemplate()
				.postForObject(Constants.url + "/getLeaveApplyListForPending", map, GetLeaveApplyAuthwise[].class);
		List<GetLeaveApplyAuthwise> leaveList = new ArrayList<GetLeaveApplyAuthwise>(Arrays.asList(employeeDoc));

		model.addAttribute("list1Count", leaveList.size());

		map = new LinkedMultiValueMap<>();
		map.add("empId", userObj.getEmpId());
		GetClaimApplyAuthwise[] employeeDocClaim = Constants.getRestTemplate()
				.postForObject(Constants.url + "/getClaimApplyListForPending", map, GetClaimApplyAuthwise[].class);
		model.addAttribute("list2Count", employeeDocClaim.length);
		/*
		 * } else { model.addAttribute("list1Count", 0);
		 * 
		 * }
		 */

		map = new LinkedMultiValueMap<>();
		map.add("empId", userObj.getEmpId());
		map.add("currYrId", calculateYear.getCalYrId());

		LeaveHistory[] leaveHistory = Constants.getRestTemplate().postForObject(Constants.url + "/getLeaveHistoryList",
				map, LeaveHistory[].class);

		List<LeaveHistory> leaveHistoryList = new ArrayList<LeaveHistory>(Arrays.asList(leaveHistory));
		model.addAttribute("leaveHistoryList", leaveHistoryList);

		map = new LinkedMultiValueMap<>();
		map.add("empId", userObj.getEmpId());
		MstEmpType mstEmpType = Constants.getRestTemplate().postForObject(Constants.url + "/getEmpTypeByempId", map,
				MstEmpType.class);
		model.addAttribute("mstEmpType", mstEmpType);

		Calendar cal2 = Calendar.getInstance();
		int month = cal2.get(Calendar.MONTH) + 1;
		int year = cal2.get(Calendar.YEAR);

		model.addAttribute("month", month);
		model.addAttribute("year", year);

		return mav;
	}

	@RequestMapping(value = "/lateMarkDetailAndGraph", method = RequestMethod.GET)
	public String lateMarkDetailAndGraph(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "Graph/lateMarkDetailAndGraph";

		/*
		 * Calendar cal = Calendar.getInstance(); cal.add(Calendar.MONTH, -6); Date
		 * result = cal.getTime(); System.out.println(cal.MONTH);
		 */

		try {

			int empId = Integer.parseInt(request.getParameter("empId"));
			int graphType = Integer.parseInt(request.getParameter("graphType"));
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("empId", empId);

			EmpInfoForDashBoard empInfoForDashBoard = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getEmpInfoForModelGraph", map, EmpInfoForDashBoard.class);

			model.addAttribute("empInfoForDashBoard", empInfoForDashBoard);
			model.addAttribute("graphType", graphType);
		} catch (Exception e) {

		}
		return mav;
	}

	@RequestMapping(value = "/getTransactionDetails", method = RequestMethod.GET)
	public String getTransactionDetails(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "Advance/getTransactionDetails";

		try {

			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			int type = Integer.parseInt(request.getParameter("type"));
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("empId", userObj.getEmpId());

			GetAdvance[] getAdvance = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getAdvanceHistoryByEmpId", map, GetAdvance[].class);

			model.addAttribute("getAdvance", getAdvance);
			// model.addAttribute("graphType", graphType);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/leavePendingListForDashboard", method = RequestMethod.GET)
	public String leavePendingListForDashboard(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "Graph/leavePendingListForDashboard";

		try {
			HttpSession session = request.getSession();
			int locId = (int) session.getAttribute("liveLocationId");
			int type = Integer.parseInt(request.getParameter("type"));
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("type", type);
			map.add("locId", locId);
			DashboardLeavePending[] dashboardLeavePending = Constants.getRestTemplate().postForObject(
					Constants.url + "/getLeaveApprovalListForDashBoard", map, DashboardLeavePending[].class);

			List<DashboardLeavePending> list = new ArrayList<>(Arrays.asList(dashboardLeavePending));
			model.addAttribute("list", list);
			model.addAttribute("type", type);
		} catch (Exception e) {

		}
		return mav;
	}

	@RequestMapping(value = "/getSelfAttendace", method = RequestMethod.GET)
	public String getSelfAttendace(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "dashboard/getSelfAttendace";

		try {

			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

			String monthYearLineGraph = request.getParameter("monthYear");
			String[] split = monthYearLineGraph.split("-");
			Date firstDay = new GregorianCalendar(Integer.parseInt(split[1]), Integer.parseInt(split[0]) - 1, 1)
					.getTime();
			Date lastDay = new GregorianCalendar(Integer.parseInt(split[1]), Integer.parseInt(split[0]), 0).getTime();
			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("fromDate", sf.format(firstDay));
			map.add("toDate", sf.format(lastDay));
			map.add("empId", userObj.getEmpId());
			SelfAttendanceDetail[] selfAttendanceDetail = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getSelfAttendaceForDashboard", map, SelfAttendanceDetail[].class);
			List<SelfAttendanceDetail> list = new ArrayList<>(Arrays.asList(selfAttendanceDetail));
			model.addAttribute("list", list);

		} catch (Exception e) {

		}
		return mav;
	}

	@RequestMapping(value = "/getLateMarkGraph", method = RequestMethod.GET)
	public @ResponseBody List<EmpGraphDetail> getLateMarkGraph(HttpServletRequest request,
			HttpServletResponse response) {

		List<EmpGraphDetail> list = new ArrayList<>();
		try {

			int empId = Integer.parseInt(request.getParameter("empId"));

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("empId", empId);
			EmpGraphDetail[] empGraphDetail = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getLateMarkGraph", map, EmpGraphDetail[].class);
			list = new ArrayList<>(Arrays.asList(empGraphDetail));

		} catch (Exception e) {

		}
		return list;
	}

	@RequestMapping(value = "/getdeptwiseEmp", method = RequestMethod.GET)
	public @ResponseBody List<EmpDeptWise> getdeptwiseEmp(HttpServletRequest request, HttpServletResponse response) {

		List<EmpDeptWise> list = new ArrayList<>();
		try {

			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			if (userObj.getDesignType() == 2) {
				int locId = (int) session.getAttribute("liveLocationId");
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("locId", locId);
				EmpDeptWise[] empGraphDetail = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getDeparmentWiseEmpCount", map, EmpDeptWise[].class);
				list = new ArrayList<>(Arrays.asList(empGraphDetail));
			}

		} catch (Exception e) {

		}
		return list;
	}

	@RequestMapping(value = "/totalOtPrevioussixMonth", method = RequestMethod.GET)
	public @ResponseBody LineGraphData totalOtPrevioussixMonth(HttpServletRequest request,
			HttpServletResponse response) {

		LineGraphData lineGraphData = new LineGraphData();
		try {
			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			if (userObj.getDesignType() == 2) {

				String monthYearLineGraph = request.getParameter("monthYearLineGraph");
				String[] split = monthYearLineGraph.split("-");

				/*
				 * int month = Integer.parseInt(request.getParameter("month")); int year =
				 * Integer.parseInt(request.getParameter("year"));
				 */

				int locId = (int) session.getAttribute("liveLocationId");
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("locId", locId);
				map.add("month", split[0]);
				map.add("year", split[1]);
				lineGraphData = Constants.getRestTemplate().postForObject(Constants.url + "/totalOtPrevioussixMonth",
						map, LineGraphData.class);
			}
		} catch (Exception e) {

		}
		return lineGraphData;
	}

	@RequestMapping(value = "/getAmtBarGraph", method = RequestMethod.GET)
	public @ResponseBody List<MonthWiseDisbusedAmt> getAmtBarGraph(HttpServletRequest request,
			HttpServletResponse response) {

		List<MonthWiseDisbusedAmt> list = new ArrayList<>();
		try {
			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			if (userObj.getDesignType() == 2) {
				String monthYearBarGraph = request.getParameter("monthYearBarGraph");
				String[] split = monthYearBarGraph.split("-");

				int locId = (int) session.getAttribute("liveLocationId");
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("locId", locId);
				map.add("month", split[0]);
				map.add("year", split[1]);
				MonthWiseDisbusedAmt[] monthWiseDisbusedAmt = Constants.getRestTemplate()
						.postForObject(Constants.url + "/disbusedAmtMonthWise", map, MonthWiseDisbusedAmt[].class);
				list = new ArrayList<>(Arrays.asList(monthWiseDisbusedAmt));
			}
		} catch (Exception e) {

		}
		return list;
	}

	@RequestMapping(value = "/getClaimRewardAmtBarGraph", method = RequestMethod.GET)
	public @ResponseBody List<MonthWiseDisbusedAmt> getClaimRewardAmtBarGraph(HttpServletRequest request,
			HttpServletResponse response) {

		List<MonthWiseDisbusedAmt> list = new ArrayList<>();
		try {
			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			if (userObj.getDesignType() == 2) {
				String monthYearBarGraph = request.getParameter("monthYearBarGraph");
				String[] split = monthYearBarGraph.split("-");

				int locId = (int) session.getAttribute("liveLocationId");
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("locId", locId);
				map.add("month", split[0]);
				map.add("year", split[1]);
				MonthWiseDisbusedAmt[] monthWiseDisbusedAmt = Constants.getRestTemplate().postForObject(
						Constants.url + "/rewardAndClaimAmtMonthWise", map, MonthWiseDisbusedAmt[].class);
				list = new ArrayList<>(Arrays.asList(monthWiseDisbusedAmt));
			}
		} catch (Exception e) {

		}
		return list;
	}

	@RequestMapping(value = "/getAttendaceByMonth", method = RequestMethod.GET)
	public @ResponseBody SummaryDailyAttendance getAttendaceByMonth(HttpServletRequest request,
			HttpServletResponse response) {

		SummaryDailyAttendance list = new SummaryDailyAttendance();
		try {
			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			String monthYearBarGraph = request.getParameter("monthYearBarGraph");
			String[] split = monthYearBarGraph.split("-");

			int locId = (int) session.getAttribute("liveLocationId");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("empId", userObj.getEmpId());
			map.add("month", split[0]);
			map.add("year", split[1]);
			list = Constants.getRestTemplate().postForObject(Constants.url + "/getAttendaceByMonth", map,
					SummaryDailyAttendance.class);

		} catch (Exception e) {

		}
		return list;
	}

	@RequestMapping(value = "/getPresentData", method = RequestMethod.GET)
	public @ResponseBody AttendaceLiveData getPresentData(HttpServletRequest request, HttpServletResponse response) {

		AttendaceLiveData attendaceLiveData = new AttendaceLiveData();
		try {

			String attendaceDate = request.getParameter("attendaceDate");

			HttpSession session = request.getSession();
			int locId = (int) session.getAttribute("liveLocationId");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("locId", locId);
			map.add("date", DateConvertor.convertToYMD(attendaceDate));
			attendaceLiveData = Constants.getRestTemplate().postForObject(Constants.url + "/liveAttendaceDashboardData",
					map, AttendaceLiveData.class);

		} catch (Exception e) {

		}
		return attendaceLiveData;
	}

	public int difffun(String date1, String date2) {

		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");

		int result = 0;

		try {
			Date date3 = myFormat.parse(date1);
			Date date4 = myFormat.parse(date2);
			long diff = date4.getTime() - date3.getTime();
			result = (int) TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);
		} catch (Exception e) {

		}

		return result + 1;
	}

	List<GetEmployeeDetails> empdetList = new ArrayList<GetEmployeeDetails>();

	@RequestMapping(value = "/employeeChangeEmpCode", method = RequestMethod.GET)
	public String employeeChangeEmpCode(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "employeeChangeEmpCode";

		try {

			HttpSession session = request.getSession();

			int locId = (int) session.getAttribute("liveLocationId");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("locId", locId);

			GetEmployeeDetails[] empdetList1 = Constants.getRestTemplate().postForObject(
					Constants.url + "/getAllEmployeeDetailBylocationId", map, GetEmployeeDetails[].class);

			empdetList = new ArrayList<GetEmployeeDetails>(Arrays.asList(empdetList1));
			model.addAttribute("empList", empdetList);
		} catch (Exception e) {

		}
		return mav;
	}

	@RequestMapping(value = "/submitupdateempcode", method = RequestMethod.POST)
	public String submitupdateempcode(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "redirect:/employeeChangeEmpCode";

		try {

			List<DailyDaily> outList = new ArrayList<DailyDaily>();

			for (int i = 0; i < empdetList.size(); i++) {
				DailyDaily daily = new DailyDaily();
				daily.setId(empdetList.get(i).getEmpId());
				daily.setOtHr(request.getParameter("code" + empdetList.get(i).getEmpId()));
				outList.add(daily);
			}

			DailyDaily[] info = Constants.getRestTemplate().postForObject(Constants.url + "/updateEmpCode", outList,
					DailyDaily[].class);

			System.out.println(outList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

}

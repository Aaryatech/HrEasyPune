package com.ats.hreasy.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
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

import com.ats.hreasy.common.Constants;
import com.ats.hreasy.common.DateConvertor;
import com.ats.hreasy.common.FormValidation;
import com.ats.hreasy.model.AuthorityInformation;
import com.ats.hreasy.model.CalenderYear;
import com.ats.hreasy.model.EmpDetailForOptionalHoliday;
import com.ats.hreasy.model.EmpListForHolidayApprove;
import com.ats.hreasy.model.EmployeeMaster;
import com.ats.hreasy.model.GetEmployeeDetails;
import com.ats.hreasy.model.Holiday;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.LeaveHistory;
import com.ats.hreasy.model.Location;
import com.ats.hreasy.model.LoginResponse;
import com.ats.hreasy.model.MstEmpType;
import com.ats.hreasy.model.OptionalHoliday;
import com.ats.hreasy.model.Setting;

@Controller
@Scope("session")
public class OptionalHolidayController {

	EmpDetailForOptionalHoliday empDetail = new EmpDetailForOptionalHoliday();
	List<Holiday> holidayList = new ArrayList<>();

	@RequestMapping(value = "/applyHoliday", method = RequestMethod.GET)
	public ModelAndView showApplyLeave(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("optionalholiday/applyHoliday");

		try {
			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			CalenderYear calculateYear = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getCalculateYearListIsCurrent", CalenderYear.class);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("empId", userObj.getEmpId());
			map.add("yearId", calculateYear.getCalYrId());
			empDetail = Constants.getRestTemplate().postForObject(Constants.url + "/getEmpInfoForOptionalHoliday", map,
					EmpDetailForOptionalHoliday.class);
			model.addObject("empDetail", empDetail);

			Date dt = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

			map = new LinkedMultiValueMap<>();
			map.add("date", sf.format(dt));
			map.add("yearId", calculateYear.getCalYrId());
			map.add("catId", empDetail.getHolidayCategory());
			map.add("empId", userObj.getEmpId());
			Holiday[] holiday = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getHolidayListforoptionalHoliday", map, Holiday[].class);

			holidayList = new ArrayList<>(Arrays.asList(holiday));

			for (int i = 0; i < holidayList.size(); i++) {
				holidayList.get(i).setHolidayFromdt(DateConvertor.convertToDMY(holidayList.get(i).getHolidayFromdt()));
			}

			model.addObject("holidayList", holidayList);

		} catch (Exception e) {

			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/submitApplyHoliday", method = RequestMethod.POST)
	public String submitApplyHoliday(HttpServletRequest request, HttpServletResponse response) {

		String ret = "redirect:/applyHoliday";

		try {

			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			Date dt = new Date();

			CalenderYear calculateYear = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getCalculateYearListIsCurrent", CalenderYear.class);

			int holidayId = Integer.parseInt(request.getParameter("holidayId"));
			String remark = request.getParameter("remark");

			OptionalHoliday save = new OptionalHoliday();

			for (int i = 0; i < holidayList.size(); i++) {
				if (holidayId == holidayList.get(i).getHolidayId()) {
					save.setHolidate(DateConvertor.convertToYMD(holidayList.get(i).getHolidayFromdt()));
					break;
				}
			}

			save.setRemark(remark);
			save.setRequestBy(userObj.getUserId());
			save.setRequestDatetime(sf.format(dt));
			save.setApprovedDaetime(sf.format(dt));
			save.setYearId(calculateYear.getCalYrId());
			save.setEmpId(empDetail.getEmpId());
			save.setHolidayId(holidayId);

			OptionalHoliday res = Constants.getRestTemplate().postForObject(Constants.url + "/saveApplyHoliday", save,
					OptionalHoliday.class);

			if (res != null) {
				session.setAttribute("successMsg", "Optional Holiday Apply Successfully");
			} else {
				session.setAttribute("errorMsg", "Failed to Apply Optional Holiday");
			}

		} catch (Exception e) {

			e.printStackTrace();
		}
		return ret;
	}

	int locId = 0;

	@RequestMapping(value = "/optinalholidayapprovallist", method = RequestMethod.GET)
	public String optinalholidayapprovallist(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "optionalholiday/optinalholidayapprovallist";

		try {
			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			/*
			 * CalenderYear calculateYear = Constants.getRestTemplate()
			 * .getForObject(Constants.url + "/getCalculateYearListIsCurrent",
			 * CalenderYear.class);
			 */

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("companyId", 1);
			Location[] location = Constants.getRestTemplate().postForObject(Constants.url + "/getLocationList", map,
					Location[].class);

			List<Location> locationList = new ArrayList<Location>(Arrays.asList(location));
			model.addAttribute("locationList", locationList);

			try {
				locId = Integer.parseInt(request.getParameter("locId"));
				model.addAttribute("locId", locId);

				map = new LinkedMultiValueMap<>();
				map.add("locId", locId);
				map.add("sts", "0");
				EmpListForHolidayApprove[] empListForHolidayApprove = Constants.getRestTemplate().postForObject(
						Constants.url + "/getOptionalHolidayApprovalList", map, EmpListForHolidayApprove[].class);

				List<EmpListForHolidayApprove> apprvlList = new ArrayList<EmpListForHolidayApprove>(
						Arrays.asList(empListForHolidayApprove));
				model.addAttribute("apprvlList", apprvlList);

			} catch (Exception e) {

			}

		} catch (Exception e) {

			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/approverejectoptionalholiday", method = RequestMethod.POST)
	public String approverejectoptionalholiday(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "redirect:/optinalholidayapprovallist?locId=" + locId;

		try {

			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			int sts = Integer.parseInt(request.getParameter("stsaprv"));

			String[] ids = request.getParameterValues("ids");
			StringBuilder sb = new StringBuilder();

			List<Integer> empIdList = new ArrayList<>();

			for (int i = 0; i < ids.length; i++) {
				sb = sb.append(ids[i] + ",");
				empIdList.add(Integer.parseInt(ids[i]));

			}

			String items = sb.toString();
			items = items.substring(0, items.length() - 1);

			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			Date dt = new Date();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("date", sf.format(dt));
			map.add("userId", userObj.getUserId());
			map.add("sts", sts);
			map.add("ids", items);
			Info info = Constants.getRestTemplate().postForObject(Constants.url + "/updateStsOfOptionalHoliday", map,
					Info.class);

			if (info.isError() == false) {

				if (sts == 2) {
					session.setAttribute("successMsg", "Optional Holiday Rejected Successfully");
				} else {
					session.setAttribute("successMsg", "Optional Holiday Approved Successfully");
				}

			} else {
				session.setAttribute("errorMsg", "Failed to Approve Optional Holiday");
			}

		} catch (Exception e) {

			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/empListForApplyOptionalHoliday", method = RequestMethod.GET)
	public String empListForApplyOptionalHoliday(HttpServletRequest request, HttpServletResponse response,
			Model model) {

		String mav = "optionalholiday/empListForApplyOptionalHoliday";

		try {
			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			/*
			 * CalenderYear calculateYear = Constants.getRestTemplate()
			 * .getForObject(Constants.url + "/getCalculateYearListIsCurrent",
			 * CalenderYear.class);
			 */

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("companyId", 1);
			Location[] location = Constants.getRestTemplate().postForObject(Constants.url + "/getLocationList", map,
					Location[].class);

			List<Location> locationList = new ArrayList<Location>(Arrays.asList(location));
			model.addAttribute("locationList", locationList);

			try {
				locId = Integer.parseInt(request.getParameter("locId"));
				model.addAttribute("locId", locId);

				map = new LinkedMultiValueMap<>();
				map.add("locationIds", locId);
				GetEmployeeDetails[] getEmployeeDetails = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getEmpDetailListByLocId", map, GetEmployeeDetails[].class);

				List<GetEmployeeDetails> empList = new ArrayList<GetEmployeeDetails>(Arrays.asList(getEmployeeDetails));
				model.addAttribute("empList", empList);

			} catch (Exception e) {
				e.printStackTrace();
			}

		} catch (Exception e) {

			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/applyHolidayByHr", method = RequestMethod.GET)
	public ModelAndView applyHolidayByHr(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("optionalholiday/applyHolidayByHr");

		try {
			HttpSession session = request.getSession();
			// LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			CalenderYear calculateYear = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getCalculateYearListIsCurrent", CalenderYear.class);

			int empId = Integer.parseInt(request.getParameter("empId"));
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("empId", empId);
			map.add("yearId", calculateYear.getCalYrId());
			empDetail = Constants.getRestTemplate().postForObject(Constants.url + "/getEmpInfoForOptionalHoliday", map,
					EmpDetailForOptionalHoliday.class);
			model.addObject("empDetail", empDetail);

			Date dt = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

			map = new LinkedMultiValueMap<>();
			map.add("date", sf.format(dt));
			map.add("yearId", calculateYear.getCalYrId());
			map.add("catId", empDetail.getHolidayCategory());
			map.add("empId", empId);
			Holiday[] holiday = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getHolidayListforoptionalHoliday", map, Holiday[].class);

			holidayList = new ArrayList<>(Arrays.asList(holiday));

			for (int i = 0; i < holidayList.size(); i++) {
				holidayList.get(i).setHolidayFromdt(DateConvertor.convertToDMY(holidayList.get(i).getHolidayFromdt()));
			}

			model.addObject("holidayList", holidayList);

		} catch (Exception e) {

			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/submitApplyHolidayByHr", method = RequestMethod.POST)
	public String submitApplyHolidayByHr(HttpServletRequest request, HttpServletResponse response) {

		String ret = "redirect:/empListForApplyOptionalHoliday";

		try {

			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			Date dt = new Date();

			CalenderYear calculateYear = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getCalculateYearListIsCurrent", CalenderYear.class);

			int holidayId = Integer.parseInt(request.getParameter("holidayId"));
			String remark = request.getParameter("remark");

			OptionalHoliday save = new OptionalHoliday();

			for (int i = 0; i < holidayList.size(); i++) {
				if (holidayId == holidayList.get(i).getHolidayId()) {
					save.setHolidate(DateConvertor.convertToYMD(holidayList.get(i).getHolidayFromdt()));
					break;
				}
			}

			save.setRemark(remark);
			save.setRequestBy(userObj.getUserId());
			save.setRequestDatetime(sf.format(dt));
			save.setApprovedDaetime(sf.format(dt));
			save.setYearId(calculateYear.getCalYrId());
			save.setEmpId(empDetail.getEmpId());
			save.setHolidayId(holidayId);
			save.setStatus(1);
			save.setApprovedBy(userObj.getUserId());
			OptionalHoliday res = Constants.getRestTemplate().postForObject(Constants.url + "/saveApplyHoliday", save,
					OptionalHoliday.class);

			if (res != null) {
				session.setAttribute("successMsg", "Optional Holiday Apply Successfully");
			} else {
				session.setAttribute("errorMsg", "Failed to Apply Optional Holiday");
			}

		} catch (Exception e) {

			e.printStackTrace();
		}
		return ret;
	}

	@RequestMapping(value = "/getOptionalHolidayHistory", method = RequestMethod.GET)
	public String getOptionalHolidayHistory(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "optionalholiday/optionalHolidayHistory";

		try {
			// HttpSession session = request.getSession();
			// LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			int empId = Integer.parseInt(request.getParameter("empId"));

			CalenderYear calculateYear = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getCalculateYearListIsCurrent", CalenderYear.class);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("empId", empId);
			map.add("yearId", calculateYear.getCalYrId());
			map.add("sts", "0,1,2,3");
			EmpListForHolidayApprove[] empListForHolidayApprove = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getHistoryOptionalHoliday", map, EmpListForHolidayApprove[].class);
			List<EmpListForHolidayApprove> historyList = new ArrayList<EmpListForHolidayApprove>(
					Arrays.asList(empListForHolidayApprove));
			model.addAttribute("historyList", historyList);

			/*
			 * Date dt = new Date(); SimpleDateFormat sf = new
			 * SimpleDateFormat("yyyy-MM-dd");
			 * 
			 * map = new LinkedMultiValueMap<>(); map.add("date", sf.format(dt));
			 * map.add("yearId", calculateYear.getCalYrId()); map.add("catId",
			 * empDetail.getHolidayCategory()); map.add("empId", userObj.getEmpId());
			 * Holiday[] holiday = Constants.getRestTemplate() .postForObject(Constants.url
			 * + "/getHolidayListforoptionalHoliday", map, Holiday[].class);
			 * 
			 * holidayList = new ArrayList<>(Arrays.asList(holiday));
			 * 
			 * for (int i = 0; i < holidayList.size(); i++) {
			 * holidayList.get(i).setHolidayFromdt(DateConvertor.convertToDMY(holidayList.
			 * get(i).getHolidayFromdt())); }
			 * 
			 * model.addAttribute("holidayList", holidayList);
			 */

		} catch (Exception e) {

			e.printStackTrace();
		}
		return mav;
	}

}

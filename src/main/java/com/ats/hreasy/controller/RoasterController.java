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

import com.ats.hreasy.common.AcessController;
import com.ats.hreasy.common.Constants;
import com.ats.hreasy.model.AccessRightModule;
import com.ats.hreasy.model.GetDailyDailyRecord;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.LvType;
import com.ats.hreasy.model.MstEmpType;
import com.ats.hreasy.model.ShiftMaster;
import com.ats.hreasy.model.SummaryAttendance;

@Controller
@Scope("session")
public class RoasterController {

	@RequestMapping(value = "/assignRootToDriver", method = RequestMethod.GET)
	public String attendanceEditEmpMonth(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();

		String mav = null;
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("attendanceEditEmpMonth", "attendaceSheet", 0, 0, 1, 0, newModuleList);

		/*
		 * if (view.isError() == true) {
		 * 
		 * mav = "accessDenied";
		 * 
		 * } else {
		 */
		mav = "roaster/assignRootToDriver";

		try {

			/*
			 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
			 * Object>(); map.add("fromDate", sf.format(firstDay)); map.add("toDate",
			 * sf.format(lastDay)); map.add("year", year); map.add("month", month);
			 * map.add("empId", empId);
			 * 
			 * GetDailyDailyRecord[] getDailyDailyRecord = Constants.getRestTemplate()
			 * .postForObject(Constants.url + "/getDailyDailyRecord", map,
			 * GetDailyDailyRecord[].class); List<GetDailyDailyRecord> dailyrecordList = new
			 * ArrayList<GetDailyDailyRecord>( Arrays.asList(getDailyDailyRecord));
			 * model.addAttribute("dailyrecordList", dailyrecordList);
			 */

		} catch (Exception e) {
			e.printStackTrace();
		}
		// }
		return mav;

	}

	@RequestMapping(value = "/rouetMasterList", method = RequestMethod.GET)
	public String rouetMasterList(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();

		String mav = null;
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("attendanceEditEmpMonth", "attendaceSheet", 0, 0, 1, 0, newModuleList);

		/*
		 * if (view.isError() == true) {
		 * 
		 * mav = "accessDenied";
		 * 
		 * } else {
		 */
		mav = "roaster/rouetMasterList";

		try {

			/*
			 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
			 * Object>(); map.add("fromDate", sf.format(firstDay)); map.add("toDate",
			 * sf.format(lastDay)); map.add("year", year); map.add("month", month);
			 * map.add("empId", empId);
			 * 
			 * GetDailyDailyRecord[] getDailyDailyRecord = Constants.getRestTemplate()
			 * .postForObject(Constants.url + "/getDailyDailyRecord", map,
			 * GetDailyDailyRecord[].class); List<GetDailyDailyRecord> dailyrecordList = new
			 * ArrayList<GetDailyDailyRecord>( Arrays.asList(getDailyDailyRecord));
			 * model.addAttribute("dailyrecordList", dailyrecordList);
			 */

		} catch (Exception e) {
			e.printStackTrace();
		}
		// }
		return mav;

	}

	@RequestMapping(value = "/editRoute", method = RequestMethod.GET)
	public String editRoute(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();

		String mav = null;
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("attendanceEditEmpMonth", "attendaceSheet", 0, 0, 1, 0, newModuleList);

		/*
		 * if (view.isError() == true) {
		 * 
		 * mav = "accessDenied";
		 * 
		 * } else {
		 */
		mav = "roaster/editRoute";

		try {

			/*
			 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
			 * Object>(); map.add("fromDate", sf.format(firstDay)); map.add("toDate",
			 * sf.format(lastDay)); map.add("year", year); map.add("month", month);
			 * map.add("empId", empId);
			 * 
			 * GetDailyDailyRecord[] getDailyDailyRecord = Constants.getRestTemplate()
			 * .postForObject(Constants.url + "/getDailyDailyRecord", map,
			 * GetDailyDailyRecord[].class); List<GetDailyDailyRecord> dailyrecordList = new
			 * ArrayList<GetDailyDailyRecord>( Arrays.asList(getDailyDailyRecord));
			 * model.addAttribute("dailyrecordList", dailyrecordList);
			 */

		} catch (Exception e) {
			e.printStackTrace();
		}
		// }
		return mav;

	}

	@RequestMapping(value = "/editAssignRoot", method = RequestMethod.GET)
	public String editAssignRoot(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();

		String mav = null;
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("attendanceEditEmpMonth", "attendaceSheet", 0, 0, 1, 0, newModuleList);

		/*
		 * if (view.isError() == true) {
		 * 
		 * mav = "accessDenied";
		 * 
		 * } else {
		 */
		mav = "roaster/editAssignRoot";

		try {

			/*
			 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
			 * Object>(); map.add("fromDate", sf.format(firstDay)); map.add("toDate",
			 * sf.format(lastDay)); map.add("year", year); map.add("month", month);
			 * map.add("empId", empId);
			 * 
			 * GetDailyDailyRecord[] getDailyDailyRecord = Constants.getRestTemplate()
			 * .postForObject(Constants.url + "/getDailyDailyRecord", map,
			 * GetDailyDailyRecord[].class); List<GetDailyDailyRecord> dailyrecordList = new
			 * ArrayList<GetDailyDailyRecord>( Arrays.asList(getDailyDailyRecord));
			 * model.addAttribute("dailyrecordList", dailyrecordList);
			 */

		} catch (Exception e) {
			e.printStackTrace();
		}
		// }
		return mav;

	}

	@RequestMapping(value = "/confirmationRouteByDate", method = RequestMethod.GET)
	public String confirmationRouteByDate(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();

		String mav = null;
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("attendanceEditEmpMonth", "attendaceSheet", 0, 0, 1, 0, newModuleList);

		/*
		 * if (view.isError() == true) {
		 * 
		 * mav = "accessDenied";
		 * 
		 * } else {
		 */
		mav = "roaster/confirmationRouteByDate";

		try {

			/*
			 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
			 * Object>(); map.add("fromDate", sf.format(firstDay)); map.add("toDate",
			 * sf.format(lastDay)); map.add("year", year); map.add("month", month);
			 * map.add("empId", empId);
			 * 
			 * GetDailyDailyRecord[] getDailyDailyRecord = Constants.getRestTemplate()
			 * .postForObject(Constants.url + "/getDailyDailyRecord", map,
			 * GetDailyDailyRecord[].class); List<GetDailyDailyRecord> dailyrecordList = new
			 * ArrayList<GetDailyDailyRecord>( Arrays.asList(getDailyDailyRecord));
			 * model.addAttribute("dailyrecordList", dailyrecordList);
			 */

		} catch (Exception e) {
			e.printStackTrace();
		}
		// }
		return mav;

	}
	
	
	@RequestMapping(value = "/routeassignmonthlysheet", method = RequestMethod.GET)
	public String routeassignmonthlysheet(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();

		String mav = null;
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("attendanceEditEmpMonth", "attendaceSheet", 0, 0, 1, 0, newModuleList);
 
		mav = "roaster/routeassignmonthlysheet";

		try {
 

		} catch (Exception e) {
			e.printStackTrace();
		}
		// }
		return mav;

	}

}

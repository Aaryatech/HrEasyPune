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

import com.ats.hreasy.common.AcessController;
import com.ats.hreasy.common.Constants;
import com.ats.hreasy.common.DateConvertor;
import com.ats.hreasy.model.AccessRightModule;
import com.ats.hreasy.model.GetDailyDailyRecord;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.Location;
import com.ats.hreasy.model.LvType;
import com.ats.hreasy.model.MstEmpType;
import com.ats.hreasy.model.RouteList;
import com.ats.hreasy.model.RouteListFromOps;
import com.ats.hreasy.model.RoutePlanDetailWithName;
import com.ats.hreasy.model.RouteType;
import com.ats.hreasy.model.ShiftMaster;
import com.ats.hreasy.model.SummaryAttendance;
import com.ats.hrmgt.model.PlanHistoryDetail;

@Controller
@Scope("session")
public class RoasterController {

	List<RouteList> routeList = new ArrayList<>();

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
			model.addAttribute("flag", 0);

			String date = request.getParameter("date");

			if (date != null) {

				model.addAttribute("date", date);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map = new LinkedMultiValueMap<>();
				map.add("date", DateConvertor.convertToYMD(date));

				Info info = Constants.getRestTemplate()
						.postForObject(Constants.url + "/insertInitiallydriverInPlanRoute", map, Info.class);

				model.addAttribute("info", info);

				if (info.isError() == false) {
					RoutePlanDetailWithName[] routePlanDetailWithName = Constants.getRestTemplate()
							.postForObject(Constants.url + "/getDriverPlanList", map, RoutePlanDetailWithName[].class);

					List<RoutePlanDetailWithName> list = new ArrayList<>(Arrays.asList(routePlanDetailWithName));
					model.addAttribute("list", list);

					RouteList[] route = Constants.getRestTemplate().getForObject(Constants.url + "/getRouteList",
							RouteList[].class);
					routeList = new ArrayList<>(Arrays.asList(route));
					model.addAttribute("routeList", routeList);
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		// }
		return mav;

	}

	@RequestMapping(value = "/updateRouteId", method = RequestMethod.POST)
	@ResponseBody
	public Info updateRouteId(HttpServletRequest request, HttpServletResponse response) {

		Info info = new Info();

		try {
			HttpSession session = request.getSession();
			int planDetailId = Integer.parseInt(request.getParameter("planDetailId"));
			int isFF = Integer.parseInt(request.getParameter("isFF"));
			int routeId = Integer.parseInt(request.getParameter("routeId"));

			String rountName = "NA";
			String frName = "NA";
			String frId = "0";
			int typeId = 0;
			int km = 0;
			float incentive = 0;

			for (int i = 0; i < routeList.size(); i++) {

				if (routeList.get(i).getRouteId() == routeId) {

					rountName = routeList.get(i).getRouteName();
					frName = routeList.get(i).getFrName();
					frId = routeList.get(i).getFrIds();
					typeId = routeList.get(i).getTypeId();
					km = routeList.get(i).getKm();
					incentive = routeList.get(i).getIncentive();
					break;
				}

			}

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("planDetailId", planDetailId);
			map.add("isFF", isFF);
			map.add("routeId", routeId);
			map.add("rountName", rountName);
			map.add("frName", frName);
			map.add("frId", frId);
			map.add("typeId", typeId);
			map.add("km", km);
			map.add("incentive", incentive);
			info = Constants.getRestTemplate().postForObject(Constants.url + "/updateRouteId", map, Info.class);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return info;

	}

	@RequestMapping(value = "/getPlanHistoryDetailByEmpId", method = RequestMethod.POST)
	@ResponseBody
	public PlanHistoryDetail getPlanHistoryDetailByEmpId(HttpServletRequest request, HttpServletResponse response) {

		PlanHistoryDetail info = new PlanHistoryDetail();

		try {
			HttpSession session = request.getSession();
			int empId = Integer.parseInt(request.getParameter("empId"));
			String dt = request.getParameter("date");

			String[] date = dt.split("to");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("empId", empId);
			map.add("fromDate", DateConvertor.convertToYMD(date[0]));
			map.add("toDate", DateConvertor.convertToYMD(date[1]));

			info = Constants.getRestTemplate().postForObject(Constants.url + "/getPlanHistoryByEmpId", map,
					PlanHistoryDetail.class);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return info;

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

			RouteListFromOps[] routeListFromOps = Constants.getRestTemplate()
					.getForObject(Constants.opsWebApiUrl + "/getAllRoutesFrDetails", RouteListFromOps[].class);

			List<RouteListFromOps> routeListFromOpsList = new ArrayList<>(Arrays.asList(routeListFromOps));

			System.out.println(routeListFromOpsList);

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
		mav = "roaster/assignRootToDriver";

		try {

			model.addAttribute("flag", 1);

			String date = request.getParameter("date");

			if (date != null) {

				model.addAttribute("date", date);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map = new LinkedMultiValueMap<>();
				map.add("date", DateConvertor.convertToYMD(date));

				Info info = Constants.getRestTemplate()
						.postForObject(Constants.url + "/insertInitiallydriverInPlanRoute", map, Info.class);

				model.addAttribute("info", info);

				if (info.isError() == false) {
					RoutePlanDetailWithName[] routePlanDetailWithName = Constants.getRestTemplate()
							.postForObject(Constants.url + "/getDriverPlanList", map, RoutePlanDetailWithName[].class);

					List<RoutePlanDetailWithName> list = new ArrayList<>(Arrays.asList(routePlanDetailWithName));
					model.addAttribute("list", list);

					RouteList[] route = Constants.getRestTemplate().getForObject(Constants.url + "/getRouteList",
							RouteList[].class);
					routeList = new ArrayList<>(Arrays.asList(route));
					model.addAttribute("routeList", routeList);
				}

			}

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

	@RequestMapping(value = "/showRosterdatewise", method = RequestMethod.GET)
	public String showRosterdatewise(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();

		String mav = null;
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("attendanceEditEmpMonth", "attendaceSheet", 0, 0, 1, 0, newModuleList);

		mav = "roaster/showRosterdatewise";

		try {

		} catch (Exception e) {
			e.printStackTrace();
		}
		// }
		return mav;

	}

	@RequestMapping(value = "/routeTypeList", method = RequestMethod.GET)
	public String routeTypeList(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();

		String mav = null;
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("routeTypeList", "routeTypeList", 0, 0, 1, 0, newModuleList);

		/*
		 * if (view.isError() == true) {
		 * 
		 * mav = "accessDenied";
		 * 
		 * } else {
		 */
		mav = "roaster/routeTypeList";

		try {

			RouteType[] routeType = Constants.getRestTemplate().getForObject(Constants.url + "/getRouteTypeList",
					RouteType[].class);
			List<RouteType> routeTypeList = new ArrayList<RouteType>(Arrays.asList(routeType));
			model.addAttribute("routeTypeList", routeTypeList);

		} catch (Exception e) {
			e.printStackTrace();
		}
		// }
		return mav;

	}

	@RequestMapping(value = "/addRouteType", method = RequestMethod.GET)
	public String addRouteType(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();

		String mav = null;
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("addRouteType", "routeTypeList", 0, 0, 1, 0, newModuleList);

		mav = "roaster/addRouteType";

		try {

		} catch (Exception e) {
			e.printStackTrace();
		}
		// }
		return mav;

	}

	@RequestMapping(value = "/submitAddRouteType", method = RequestMethod.POST)
	public String submitAddRouteType(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();

		String mav = null;
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("addRouteType", "routeTypeList", 0, 0, 1, 0, newModuleList);

		mav = "redirect:/routeTypeList";

		try {

			String typeId = request.getParameter("typeId");
			String typeName = request.getParameter("typeName");

			RouteType routeType = new RouteType();

			if (typeId == null || typeId == "") {
				routeType.setTypeId(0);

			} else {
				routeType.setTypeId(Integer.parseInt(typeId));

			}

			routeType.setTypeName(typeName);
			routeType.setDelStatus(1);

			RouteType res = Constants.getRestTemplate().postForObject(Constants.url + "/saveRouteType", routeType,
					RouteType.class);

		} catch (Exception e) {
			e.printStackTrace();
		}
		// }
		return mav;

	}

	@RequestMapping(value = "/editRouteType", method = RequestMethod.GET)
	public String editRouteType(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();

		String mav = null;
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("addRouteType", "routeTypeList", 0, 0, 1, 0, newModuleList);

		mav = "roaster/addRouteType";

		try {

			int typeId = Integer.parseInt(request.getParameter("typeId"));

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("typeId", typeId);
			RouteType res = Constants.getRestTemplate().postForObject(Constants.url + "/getRouteTypeById", map,
					RouteType.class);
			model.addAttribute("res", res);

		} catch (Exception e) {
			e.printStackTrace();
		}
		// }
		return mav;

	}

	@RequestMapping(value = "/deleteRouteType", method = RequestMethod.GET)
	public String deleteRouteType(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();

		String mav = null;
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("addRouteType", "routeTypeList", 0, 0, 1, 0, newModuleList);

		mav = "redirect:/routeTypeList";

		try {

			int typeId = Integer.parseInt(request.getParameter("typeId"));

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("typeId", typeId);
			Info res = Constants.getRestTemplate().postForObject(Constants.url + "/deleteRouteType", map, Info.class);

			if (res.isError()) {
				session.setAttribute("errorMsg", "Failed to Delete Type");
			} else {
				session.setAttribute("successMsg", "Type Deleted Successfully");

			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		// }
		return mav;

	}

}

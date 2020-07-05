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
import com.ats.hreasy.common.FormValidation;
import com.ats.hreasy.model.AccessRightModule;
import com.ats.hreasy.model.GetDailyDailyRecord;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.Location;
import com.ats.hreasy.model.LoginResponse;
import com.ats.hreasy.model.LvType;
import com.ats.hreasy.model.MstEmpType;
import com.ats.hreasy.model.RoasterSheetData;
import com.ats.hreasy.model.RouteList;
import com.ats.hreasy.model.RouteListFromOps;
import com.ats.hreasy.model.RoutePlanDetailListWithRouteList;
import com.ats.hreasy.model.RoutePlanDetailWithName;
import com.ats.hreasy.model.RouteType;
import com.ats.hreasy.model.ShiftMaster;
import com.ats.hreasy.model.SummaryAttendance;
import com.ats.hrmgt.model.PlanHistoryDetail;

@Controller
@Scope("session")
public class RoasterController {

	List<RouteList> routeList = new ArrayList<>();
	List<RoutePlanDetailWithName> driverPlanList = new ArrayList<>();

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

					driverPlanList = new ArrayList<>(Arrays.asList(routePlanDetailWithName));
					model.addAttribute("list", driverPlanList);

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

	@RequestMapping(value = "/getDriverPlanList", method = RequestMethod.POST)
	@ResponseBody
	public RoutePlanDetailListWithRouteList getDriverPlanList(HttpServletRequest request,
			HttpServletResponse response) {

		RoutePlanDetailListWithRouteList routePlanDetailListWithRouteList = new RoutePlanDetailListWithRouteList();

		routePlanDetailListWithRouteList.setDriverPlanList(driverPlanList);
		routePlanDetailListWithRouteList.setRouteList(routeList);

		return routePlanDetailListWithRouteList;

	}

	@RequestMapping(value = "/rouetMasterList", method = RequestMethod.GET)
	public String rouetMasterList(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();

		String mav = null;
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("rouetMasterList", "rouetMasterList", 1, 0, 0, 0, newModuleList);

		if (view.isError() == true) {

			mav = "accessDenied";

		} else {

			mav = "roaster/rouetMasterList";

			try {

				RouteList[] route = Constants.getRestTemplate().getForObject(Constants.url + "/getRouteList",
						RouteList[].class);
				List<RouteList> routeList = new ArrayList<>(Arrays.asList(route));
				model.addAttribute("routeList", routeList);

				Info add = AcessController.checkAccess("rouetMasterList", "rouetMasterList", 0, 1, 0, 0, newModuleList);
				Info edit = AcessController.checkAccess("rouetMasterList", "rouetMasterList", 0, 0, 1, 0,
						newModuleList);
				Info delete = AcessController.checkAccess("rouetMasterList", "rouetMasterList", 0, 0, 0, 1,
						newModuleList);

				if (add.isError() == false) {
					model.addAttribute("addAccess", 0);

				}
				if (edit.isError() == false) {

					model.addAttribute("editAccess", 0);
				}
				if (delete.isError() == false) {

					model.addAttribute("deleteAccess", 0);

				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return mav;

	}

	RouteList route = new RouteList();

	@RequestMapping(value = "/editRoute", method = RequestMethod.GET)
	public String editRoute(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();

		String mav = null;
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("rouetMasterList", "rouetMasterList", 0, 0, 1, 0, newModuleList);

		if (view.isError() == true) {

			mav = "accessDenied";

		} else {

			mav = "roaster/editRoute";

			try {

				int routeId = Integer.parseInt(request.getParameter("routeId"));

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("id", routeId);

				route = Constants.getRestTemplate().postForObject(Constants.url + "/getRouteById", map,
						RouteList.class);

				model.addAttribute("route", route);

				RouteType[] routeType = Constants.getRestTemplate().getForObject(Constants.url + "/getRouteTypeList",
						RouteType[].class);
				List<RouteType> routeTypeList = new ArrayList<RouteType>(Arrays.asList(routeType));
				model.addAttribute("routeTypeList", routeTypeList);

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return mav;

	}

	@RequestMapping(value = "/submitEditRoute", method = RequestMethod.POST)
	public String submitEditLocation(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		// LoginResponse userObj = (LoginResponse) session.getAttribute("UserDetail");
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("rouetMasterList", "rouetMasterList", 0, 0, 1, 0, newModuleList);
		String a = new String();
		if (view.isError() == true) {

			a = "redirect:/accessDenied";

		} else {

			a = "redirect:/rouetMasterList";
			try {

				String starttime = request.getParameter("starttime");
				int km = Integer.parseInt(request.getParameter("km"));
				int typeId = Integer.parseInt(request.getParameter("typeId"));
				float incetive = Float.parseFloat(request.getParameter("incetive"));

				route.setStartTime(starttime);
				route.setKm(km);
				route.setTypeId(typeId);
				route.setIncentive(incetive);

				List<RouteList> routeList = new ArrayList<>();
				routeList.add(route);
				RouteList[] res = Constants.getRestTemplate().postForObject(Constants.url + "/saveRouteList", routeList,
						RouteList[].class);

				session.setAttribute("successMsg", "Route Updated Successfully");

			} catch (Exception e) {
				e.printStackTrace();
				session.setAttribute("errorMsg", "Failed to Update Route");
			}
		}

		return a;
	}

	@RequestMapping(value = "/synchronizeRoute", method = RequestMethod.GET)
	public String synchronizeRoute(HttpServletRequest request, HttpServletResponse response, Model model) {
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
		mav = "redirect:/rouetMasterList";

		try {

			RouteList[] route = Constants.getRestTemplate().getForObject(Constants.url + "/getRouteList",
					RouteList[].class);
			List<RouteList> routeList = new ArrayList<>(Arrays.asList(route));

			RouteListFromOps[] routeListFromOps = Constants.getRestTemplate()
					.getForObject(Constants.opsWebApiUrl + "/getAllRoutesFrDetails", RouteListFromOps[].class);

			List<RouteListFromOps> routeListFromOpsList = new ArrayList<>(Arrays.asList(routeListFromOps));

			for (int i = 0; i < routeListFromOpsList.size(); i++) {

				int flag = 0;

				for (int j = 0; j < routeList.size(); j++) {

					if (routeListFromOpsList.get(i).getRouteId() == routeList.get(j).getRouteId()) {
						routeList.get(j).setFrIds(routeListFromOpsList.get(i).getFr_ids());
						routeList.get(j).setFrName(routeListFromOpsList.get(i).getFr_names());
						routeList.get(j).setRouteName(routeListFromOpsList.get(i).getRoute_name());
						flag = 1;

						break;
					}

				}

				if (flag == 0) {
					RouteList routenew = new RouteList();
					routenew.setRouteId(routeListFromOpsList.get(i).getRouteId());
					routenew.setFrIds(routeListFromOpsList.get(i).getFr_ids());
					routenew.setFrName(routeListFromOpsList.get(i).getFr_names());
					routenew.setRouteName(routeListFromOpsList.get(i).getRoute_name());
					routenew.setDelStatus(1);
					routeList.add(routenew);
				}

			}

			System.out.println(routeList);

			RouteList[] info = Constants.getRestTemplate().postForObject(Constants.url + "/saveRouteList", routeList,
					RouteList[].class);

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

	String date;

	@RequestMapping(value = "/confirmationRouteByDate", method = RequestMethod.GET)
	public String confirmationRouteByDate(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();

		String mav = null;
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("confirmationRouteByDate", "confirmationRouteByDate", 1, 0, 0, 0,
				newModuleList);

		if (view.isError() == true) {

			mav = "accessDenied";

		} else {

			mav = "roaster/assignRootToDriver";

			try {

				model.addAttribute("flag", 1);

				date = request.getParameter("date");

				if (date != null) {

					model.addAttribute("date", date);

					MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
					map = new LinkedMultiValueMap<>();
					map.add("date", DateConvertor.convertToYMD(date));

					Info info = Constants.getRestTemplate()
							.postForObject(Constants.url + "/insertInitiallydriverInPlanRoute", map, Info.class);

					model.addAttribute("info", info);

					if (info.isError() == false) {
						RoutePlanDetailWithName[] routePlanDetailWithName = Constants.getRestTemplate().postForObject(
								Constants.url + "/getDriverPlanList", map, RoutePlanDetailWithName[].class);

						driverPlanList = new ArrayList<>(Arrays.asList(routePlanDetailWithName));
						model.addAttribute("list", driverPlanList);

						RouteList[] route = Constants.getRestTemplate().getForObject(Constants.url + "/getRouteList",
								RouteList[].class);
						routeList = new ArrayList<>(Arrays.asList(route));
						model.addAttribute("routeList", routeList);
					}

				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return mav;

	}

	@RequestMapping(value = "/changeLateMarkInRoaster", method = RequestMethod.POST)
	@ResponseBody
	public Info changeLateMarkInRoaster(HttpServletRequest request, HttpServletResponse response) {

		Info info = new Info();

		try {
			HttpSession session = request.getSession();
			int planDetailId = Integer.parseInt(request.getParameter("planDetailId"));
			int lateMark = Integer.parseInt(request.getParameter("lateMark"));
			int lateMin = Integer.parseInt(request.getParameter("lateMin"));
			int routeId = Integer.parseInt(request.getParameter("routeId"));

			String startTime = "00:00";

			for (int i = 0; i < routeList.size(); i++) {

				if (routeList.get(i).getRouteId() == routeId) {

					startTime = routeList.get(i).getStartTime();

					if (startTime == null) {
						startTime = "00:00";
					}
					break;
				}

			}

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("planDetailId", planDetailId);
			map.add("lateMark", lateMark);
			map.add("lateMin", lateMin);
			map.add("startTime", startTime);
			System.out.println(map);
			info = Constants.getRestTemplate().postForObject(Constants.url + "/changeLateMarkInRoaster", map,
					Info.class);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return info;

	}

	@RequestMapping(value = "/submitConfirmationRoaster", method = RequestMethod.POST)
	public String submitConfirmationRoaster(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();
		LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

		String mav = null;
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("confirmationRouteByDate", "confirmationRouteByDate", 1, 0, 0, 0,
				newModuleList);

		if (view.isError() == true) {

			mav = "accessDenied";

		} else {

			mav = "redirect:/confirmationRouteByDate";

			try {

				LvType[] lvType = Constants.getRestTemplate().getForObject(Constants.url + "/getLvTypeListAll",
						LvType[].class);
				List<LvType> lvTypeList = new ArrayList<LvType>(Arrays.asList(lvType));

				int wo = 12;
				String wosts = "WO";
				String woText = "WO";

				int p = 5;
				String psts = "P";
				String pText = "P";

				for (int k = 0; k < lvTypeList.size(); k++) {

					if (lvTypeList.get(k).getNameSd().equalsIgnoreCase("P")) {
						pText = lvTypeList.get(k).getNameSdShow();
					} else if (lvTypeList.get(k).getNameSd().equalsIgnoreCase("WO")) {
						woText = lvTypeList.get(k).getNameSdShow();
					}

				}

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map = new LinkedMultiValueMap<>();
				map.add("date", DateConvertor.convertToYMD(date));
				Info info = Constants.getRestTemplate()
						.postForObject(Constants.url + "/updateAndSubmitConfirmDateRoster", map, Info.class);

				if (info.isError()) {
					session.setAttribute("errorMsg", "Failed to Confirmation");
				} else {

					RoutePlanDetailWithName[] routePlanDetailWithName = Constants.getRestTemplate()
							.postForObject(Constants.url + "/getDriverPlanList", map, RoutePlanDetailWithName[].class);

					List<RoutePlanDetailWithName> driverPlanList = new ArrayList<>(
							Arrays.asList(routePlanDetailWithName));

					String empIds = "0";

					for (int i = 0; i < driverPlanList.size(); i++) {

						empIds = empIds + "," + driverPlanList.get(i).getDriverId();

					}

					map = new LinkedMultiValueMap<>();
					map = new LinkedMultiValueMap<>();
					map.add("date", DateConvertor.convertToYMD(date));
					map.add("empIds", empIds);
					GetDailyDailyRecord[] getDailyDailyRecord = Constants.getRestTemplate().postForObject(
							Constants.url + "/getDailyDailyRecordForRoaster", map, GetDailyDailyRecord[].class);

					/*
					 * List<Integer> dailyIds = new ArrayList<>();
					 * 
					 * for (int i = 0; i < getDailyDailyRecord.length; i++) {
					 * 
					 * dailyIds.add(getDailyDailyRecord[i].getId());
					 * 
					 * }
					 */

					for (int j = 0; j < driverPlanList.size(); j++) {

						for (int i = 0; i < getDailyDailyRecord.length; i++) {

							if (driverPlanList.get(j).getDriverId() == getDailyDailyRecord[i].getEmpId()) {
								map = new LinkedMultiValueMap<String, Object>();
								map.add("dailyId", getDailyDailyRecord[i].getId());

								if (driverPlanList.get(j).getRouteId() != 0) {

									map.add("selectStatus", p);
									map.add("selectStatusText", psts);
									map.add("nameSd", pText);
								} else {

									if (driverPlanList.get(j).getIsoffdayIsff() == 2) {
										map.add("selectStatus", p);
										map.add("selectStatusText", psts);
										map.add("nameSd", pText);
									} else {
										map.add("selectStatus", wo);
										map.add("selectStatusText", wosts);
										map.add("nameSd", woText);
									}
								}

								map.add("lateMark", driverPlanList.get(j).getLateMark());
								map.add("userId", userObj.getUserId());
								map.add("flag", 1);
								map.add("otHours", "00:00");
								map.add("lateMin", driverPlanList.get(j).getLateMin());

								Info infores = Constants.getRestTemplate().postForObject(
										Constants.url + "/updateAttendaceRecordSingleByHod", map, Info.class);
								break;
							}

						}

					}

					session.setAttribute("successMsg", "Confirmation Successfully");
				}

			} catch (Exception e) {
				e.printStackTrace();
				session.setAttribute("errorMsg", "Failed to Confirmation");
			}
		}
		return mav;

	}

	@RequestMapping(value = "/routeassignmonthlysheet", method = RequestMethod.GET)
	public String routeassignmonthlysheet(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();

		String mav = null;
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("routeassignmonthlysheet", "routeassignmonthlysheet", 1, 0, 0, 0,
				newModuleList);

		mav = "roaster/routeassignmonthlysheet";

		try {

			String date = request.getParameter("date");

			if (date != null) {
				SimpleDateFormat dd = new SimpleDateFormat("dd-MM-yyyy");
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

				Date dt = dd.parse("01-" + date);
				Calendar temp = Calendar.getInstance();
				temp.setTime(dt);
				int year = temp.get(Calendar.YEAR);
				int month = temp.get(Calendar.MONTH) + 1;

				Date firstDay = new GregorianCalendar(year, month - 1, 1).getTime();
				Date lastDay = new GregorianCalendar(year, month, 0).getTime();

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("fromDate", sf.format(firstDay));
				map.add("toDate", sf.format(lastDay));
				RoasterSheetData roasterSheetData = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getMonthlyRoasterSheet", map, RoasterSheetData.class);

				model.addAttribute("roasterSheetData", roasterSheetData);
				model.addAttribute("date", date);
				model.addAttribute("year", year);
				model.addAttribute("month", month);

				System.out.println(roasterSheetData.getInfomationList());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

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

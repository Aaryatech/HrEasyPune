package com.ats.hreasy.controller;

import java.io.BufferedReader;
import java.io.FileReader;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ats.hreasy.common.AcessController;
import com.ats.hreasy.common.Constants;
import com.ats.hreasy.common.DateConvertor;
import com.ats.hreasy.common.VpsImageUpload;
import com.ats.hreasy.model.AccessRightModule;
import com.ats.hreasy.model.AttendaceLiveCount;
import com.ats.hreasy.model.DataForUpdateAttendance;
import com.ats.hreasy.model.EmpListForHolidayApprove;
import com.ats.hreasy.model.FileUploadedData;
import com.ats.hreasy.model.GetDailyDailyRecord;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.Location;
import com.ats.hreasy.model.LoginResponse;

@Controller
@Scope("session")
public class OtModuleController {

	List<GetDailyDailyRecord> dailyrecordList = new ArrayList<GetDailyDailyRecord>();
	String date;

	@RequestMapping(value = "/otApprovalList", method = RequestMethod.GET)
	public String otApprovalList(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "attendence/otApprovalList";

		try {
			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");
			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("otApprovalList", "otApprovalList", 1, 0, 0, 0, newModuleList);

			if (view.isError() == true) {

				mav = "accessDenied";

			} else {

				mav = "attendence/otApprovalList";
				date = request.getParameter("date");

				if (date != null) {

					int locId = (int) session.getAttribute("liveLocationId");

					MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
					map.add("date", DateConvertor.convertToYMD(date));
					map.add("empId", userObj.getEmpId());
					map.add("locId", locId);
					GetDailyDailyRecord[] getDailyDailyRecord = Constants.getRestTemplate().postForObject(
							Constants.url + "/getDailyDailyRecordForOtApproval", map, GetDailyDailyRecord[].class);
					dailyrecordList = new ArrayList<GetDailyDailyRecord>(Arrays.asList(getDailyDailyRecord));
					model.addAttribute("dailyrecordList", dailyrecordList);
					model.addAttribute("date", date);
				}
			}
		} catch (Exception e) {

			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/submitApproveProductionIncentive", method = RequestMethod.POST)
	public String submitApproveProductionIncentive(HttpServletRequest request, HttpServletResponse response) {
		String redirect = new String();

		HttpSession session = request.getSession();
		try {
			redirect = "redirect:/otApprovalList?date=" + date;

			String[] ids = request.getParameterValues("selectEmp");

			String id = "0";
			for (int i = 0; i < ids.length; i++) {

				for (int j = 0; j < dailyrecordList.size(); j++) {

					if (dailyrecordList.get(j).getId() == Integer.parseInt(ids[i])) {
						id = id + "," + ids[i];
						break;
					}
				}

			}

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("ids", id);
			map.add("status", 1);
			System.out.println(map);
			Info info = Constants.getRestTemplate().postForObject(Constants.url + "/updateOtApproveStatus", map,
					Info.class);

			if (info.isError() == false) {
				session.setAttribute("successMsg", "Production Incentive Approved Successfully");
			} else {
				session.setAttribute("errorMsg", "Failed to Approved Production Incentive");
			}

		} catch (Exception e) {

			session.setAttribute("errorMsg", "Failed to Approved Production Incentive");
			e.printStackTrace();
		}

		return redirect;
	}

	@RequestMapping(value = "/otFinalApprovalList", method = RequestMethod.GET)
	public String otFinalApprovalList(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "attendence/otFinalApprovalList";

		try {
			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("otFinalApprovalList", "otFinalApprovalList", 1, 0, 0, 0,
					newModuleList);

			if (view.isError() == true) {

				mav = "accessDenied";

			} else {

				date = request.getParameter("date");

				if (date != null) {

					int locId = (int) session.getAttribute("liveLocationId");

					MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
					map.add("date", DateConvertor.convertToYMD(date));
					map.add("empId", userObj.getEmpId());
					map.add("locId", locId);
					GetDailyDailyRecord[] getDailyDailyRecord = Constants.getRestTemplate().postForObject(
							Constants.url + "/getDailyDailyRecordForFinalOtApproval", map, GetDailyDailyRecord[].class);
					dailyrecordList = new ArrayList<GetDailyDailyRecord>(Arrays.asList(getDailyDailyRecord));
					model.addAttribute("dailyrecordList", dailyrecordList);
					model.addAttribute("date", date);
				}
			}
		} catch (Exception e) {

			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/submitFinalApproveProductionIncentive", method = RequestMethod.POST)
	public String submitFinalApproveProductionIncentive(HttpServletRequest request, HttpServletResponse response) {
		String redirect = new String();

		HttpSession session = request.getSession();
		try {
			redirect = "redirect:/otFinalApprovalList?date=" + date;

			String[] ids = request.getParameterValues("selectEmp");

			String id = "0";
			String empId = "0";
			for (int i = 0; i < ids.length; i++) {

				for (int j = 0; j < dailyrecordList.size(); j++) {

					if (dailyrecordList.get(j).getId() == Integer.parseInt(ids[i])) {
						id = id + "," + ids[i];
						empId = empId + "," + dailyrecordList.get(j).getEmpId();
						break;
					}
				}

			}

			String[] dtsplt = date.split("-");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("ids", id);
			map.add("status", 2);
			System.out.println(map);
			Info info = Constants.getRestTemplate().postForObject(Constants.url + "/updateOtApproveStatus", map,
					Info.class);

			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			Date firstDay = new GregorianCalendar(Integer.parseInt(dtsplt[2]), Integer.parseInt(dtsplt[1]) - 1, 1)
					.getTime();
			Date lastDay = new GregorianCalendar(Integer.parseInt(dtsplt[2]), Integer.parseInt(dtsplt[1]), 0).getTime();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			map = new LinkedMultiValueMap<String, Object>();
			map.add("fromDate", sf.format(firstDay));
			map.add("toDate", sf.format(lastDay));
			map.add("userId", userObj.getUserId());
			map.add("year", Integer.parseInt(dtsplt[2]));
			map.add("month", Integer.parseInt(dtsplt[1]));
			map.add("empIds", empId);

			info = Constants.getRestTemplate().postForObject(Constants.url + "/updateAttendaceFinalRecordByempId", map,
					Info.class);

			if (info.isError() == false) {
				session.setAttribute("successMsg", "Production Incentive Approved Successfully");
			} else {
				session.setAttribute("errorMsg", "Failed to Approved Production Incentive");
			}

		} catch (Exception e) {

			session.setAttribute("errorMsg", "Failed to Approved Production Incentive");
			e.printStackTrace();
		}

		return redirect;
	}

	@RequestMapping(value = "/importCsvFileForPresent", method = RequestMethod.GET)
	public String importCsvFileForPresent(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "attendence/importCsvFileForPresent";

		try {

			String date = request.getParameter("date");

			if (date != null) {
				HttpSession session = request.getSession();
				int locId = (int) session.getAttribute("liveLocationId");

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("fromDate", DateConvertor.convertToYMD(date));
				map.add("locId", locId);
				AttendaceLiveCount[] attendaceLiveCount = Constants.getRestTemplate()
						.postForObject(Constants.url + "/presentAttendaceLiveCount", map, AttendaceLiveCount[].class);
				List<AttendaceLiveCount> list = new ArrayList<AttendaceLiveCount>(Arrays.asList(attendaceLiveCount));
				model.addAttribute("list", list);
				model.addAttribute("date", date);
			}
		} catch (Exception e) {

			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/attUploadCSVForPresentStatus", method = RequestMethod.POST)
	@ResponseBody
	public Info attUploadCSV(@RequestParam("file") List<MultipartFile> file, HttpServletRequest request,
			HttpServletResponse response) {

		Info info = new Info();
		HttpSession session = request.getSession();
		try {

			SimpleDateFormat dateTimeInGMT = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");

			Date dt = new Date();

			VpsImageUpload upload = new VpsImageUpload();

			String date = request.getParameter("date");

			String imageName = new String();
			imageName = dateTimeInGMT.format(dt) + "_" + file.get(0).getOriginalFilename();

			try {

				SimpleDateFormat sf = new SimpleDateFormat("dd-MM-yyyy");

				upload.saveUploadedFiles(file.get(0), Constants.attsDocSaveUrl, imageName);
				String fileIn = Constants.attsDocSaveUrl + imageName;

				// String fileIn = "/home/lenovo/Documents/attendance/" + imageName;

				String line = null;

				FileReader fileReader = new FileReader(fileIn);
				BufferedReader bufferedReader = new BufferedReader(fileReader);

				List<FileUploadedData> fileUploadedDataList = new ArrayList<>();

				FileUploadedData fileUploadedData = new FileUploadedData();

				while ((line = bufferedReader.readLine()) != null) {

					// System.out.println(bufferedReader.readLine());
					try {
						fileUploadedData = new FileUploadedData();
						String[] temp = line.split(",");
						String empCode = temp[0];
						String ename = temp[1];
						String logDate = temp[2];
						String inTime = temp[3];

						if (sf.parse(logDate).compareTo(sf.parse(date)) == 0) {
							fileUploadedData.setEmpCode(empCode);
							fileUploadedData.setEmpName(ename);
							fileUploadedData.setLogDate(logDate);
							fileUploadedData.setInTime(inTime);
							fileUploadedDataList.add(fileUploadedData);
						}

					} catch (Exception e) {
						// TODO: handle exception
						e.printStackTrace();
					}

				}
				bufferedReader.close();

				// System.out.println(fileUploadedDataList);

				LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

				DataForUpdateAttendance dataForUpdateAttendance = new DataForUpdateAttendance();
				dataForUpdateAttendance.setFromDate(DateConvertor.convertToYMD(date));
				dataForUpdateAttendance.setToDate(DateConvertor.convertToYMD(date));
				dataForUpdateAttendance.setUserId(userObj.getUserId());
				dataForUpdateAttendance.setFileUploadedDataList(fileUploadedDataList);
				dataForUpdateAttendance.setEmpId(0);

				info = Constants.getRestTemplate().postForObject(Constants.url + "/importAttendanceByFileAndUpdateForPresentStatus",
						dataForUpdateAttendance, Info.class);

				System.out.println(dataForUpdateAttendance);

				//

				if (info.isError() == false) {
					session.setAttribute("successMsg", "Attendance Updated Successfully");
				} else {
					session.setAttribute("errorMsg", "Failed to Update Attendance");
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}

		} catch (Exception e) {
			session.setAttribute("errorMsg", "Failed to Update Attendance");
			e.printStackTrace();

		}
		return info;

	}

}

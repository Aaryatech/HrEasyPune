package com.ats.hreasy.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
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
import com.ats.hreasy.common.FormValidation;
import com.ats.hreasy.common.VpsImageUpload;
import com.ats.hreasy.model.AccessRightModule;
import com.ats.hreasy.model.AttendanceSheetData;
import com.ats.hreasy.model.AuthorityInformation;
import com.ats.hreasy.model.CalenderYear;
import com.ats.hreasy.model.CountOfAssignPending;
import com.ats.hreasy.model.DailyAttendance;
import com.ats.hreasy.model.DataForUpdateAttendance;
import com.ats.hreasy.model.Designation;
import com.ats.hreasy.model.EmpInfo;
import com.ats.hreasy.model.EmpSalAllowance;
import com.ats.hreasy.model.EmpSalaryInfoForPayroll;
import com.ats.hreasy.model.EmployeeAllDetails;
import com.ats.hreasy.model.EmployeeMaster;
import com.ats.hreasy.model.FileUploadedData;
import com.ats.hreasy.model.FreezeLogs;
import com.ats.hreasy.model.GetDailyDailyRecord;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.InfoForUploadAttendance;
import com.ats.hreasy.model.LeaveHistory;
import com.ats.hreasy.model.LoginResponse;
import com.ats.hreasy.model.LvType;
import com.ats.hreasy.model.MstEmpType;
import com.ats.hreasy.model.Setting;
import com.ats.hreasy.model.ShiftMaster;
import com.ats.hreasy.model.SummaryAttendance;
import com.ats.hreasy.model.SummaryDailyAttendance;
import com.ats.hreasy.model.VariousList;
import com.ats.hreasy.model.ViewEmployee;

@Controller
@Scope("session")
public class AttendenceController {

	@RequestMapping(value = "/attendenceImportExel", method = RequestMethod.GET)
	public String attendenceImportExel(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "attendence/attendenceImportExel";

		try {

			/*
			 * int month = Integer.parseInt(request.getParameter("selectMonth"));
			 * 
			 * Date dt = new Date(); Calendar temp = Calendar.getInstance();
			 * temp.setTime(dt); int year = temp.get(Calendar.YEAR);
			 * 
			 * Date firstDay = new GregorianCalendar(year, month - 1, 1).getTime(); Date
			 * lastDay = new GregorianCalendar(year, month, 0).getTime();
			 * 
			 * SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			 */
			HttpSession session = request.getSession();
			int locId = (int) session.getAttribute("liveLocationId");

			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar temp = Calendar.getInstance();
			String month = request.getParameter("selectMonth");

			String[] monthsplt = month.split("-");

			Date firstDay = new GregorianCalendar(Integer.parseInt(monthsplt[1]), Integer.parseInt(monthsplt[0]) - 1, 1)
					.getTime();
			Date lastDay = new GregorianCalendar(Integer.parseInt(monthsplt[1]), Integer.parseInt(monthsplt[0]), 0)
					.getTime();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("fromDate", sf.format(firstDay));
			map.add("toDate", sf.format(lastDay));
			map.add("locId", locId);
			InfoForUploadAttendance infoForUploadAttendance = Constants.getRestTemplate().postForObject(
					Constants.url + "/getInformationOfUploadedAttendance", map, InfoForUploadAttendance.class);

			temp = Calendar.getInstance();
			temp.setTime(firstDay);
			int year = temp.get(Calendar.YEAR);
			int month1 = temp.get(Calendar.MONTH);

			String[] monthNames = { "January", "February", "March", "April", "May", "June", "July", "August",
					"September", "October", "November", "December" };
			String monthName = monthNames[month1];

			model.addAttribute("monthName", monthName);
			model.addAttribute("year", year);
			model.addAttribute("month", month1 + 1);
			model.addAttribute("infoForUploadAttendance", infoForUploadAttendance);

			model.addAttribute("showLoc", 0);
			// System.out.println(month);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;

	}

	@RequestMapping(value = "/submitImportExel", method = RequestMethod.POST)
	public String submitInsertEmpDoc(@RequestParam("doc") List<MultipartFile> doc, HttpServletRequest request,
			HttpServletResponse response) {

		try {

			/*
			 * FileInputStream fis = new FileInputStream(new
			 * File("/home/lenovo/Downloads/Employee Type Wise Claim Report-2019-11-14.xlsx"
			 * ));
			 * 
			 * XSSFWorkbook workbook = new XSSFWorkbook(fis); XSSFSheet spreadsheet =
			 * workbook.getSheetAt(0); Iterator < Row > rowIterator =
			 * spreadsheet.iterator();
			 * 
			 * while (rowIterator.hasNext()) { XSSFRow row = (XSSFRow) rowIterator.next();
			 * Iterator < Cell > cellIterator = row.cellIterator();
			 * 
			 * while ( cellIterator.hasNext()) { Cell cell = cellIterator.next();
			 * 
			 * switch (cell.getCellType()) { case Cell.CELL_TYPE_NUMERIC:
			 * System.out.print(cell.getNumericCellValue() + " \t\t "); break;
			 * 
			 * case Cell.CELL_TYPE_STRING: System.out.print( cell.getStringCellValue() +
			 * " \t\t "); break; } } System.out.println(); } fis.close();
			 */

			String fileIn = "/home/lenovo/Downloads/Attendance Logs final NOV 19.csv";
			String line = null;

			FileReader fileReader = new FileReader(fileIn);
			BufferedReader bufferedReader = new BufferedReader(fileReader);

			while ((line = bufferedReader.readLine()) != null) {

				// System.out.println(bufferedReader.readLine());
				try {
					String[] temp = line.split(",");
					String studentID = temp[0];
					String firstName = temp[1];
					String lastName = temp[2];
					String finalMark = temp[3];
					String finalGrade = temp[4];

					System.out
							.println(studentID + " " + firstName + " " + lastName + " " + finalMark + " " + finalGrade);

				} catch (Exception e) {

				}

			}
			bufferedReader.close();

		} catch (Exception e) {
			e.printStackTrace();

		}
		return "redirect:/attendenceImportExel";
	}

	@RequestMapping(value = "/attendanceSelectMonth", method = RequestMethod.GET)
	public String attendanceSelectMonth(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = null;
		HttpSession session = request.getSession();

		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("attendanceSelectMonth", "attendanceSelectMonth", 1, 0, 0, 0,
				newModuleList);

		if (view.isError() == true) {

			mav = "accessDenied";

		} else {
			mav = "attendence/attendanceSelectMonth";

			try {

				/*
				 * Integer countSal = Constants.getRestTemplate().postForObject(Constants.url +
				 * "/getSalStructCountEmp", map, Integer.class);
				 * 
				 * model.addAttribute("countSal", countSal);
				 */

				int locId = (int) session.getAttribute("liveLocationId");
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("locId", locId);
				CountOfAssignPending countSal = Constants.getRestTemplate().postForObject(
						Constants.url + "/getCountOfAssignForAttendance", map, CountOfAssignPending.class);
				model.addAttribute("countSal", countSal);

				map = new LinkedMultiValueMap<String, Object>();

				Date dt = new Date();
				Calendar temp = Calendar.getInstance();
				temp.setTime(dt);
				int year = temp.get(Calendar.YEAR);
				int month = temp.get(Calendar.MONTH);

				/*
				 * Date firstDay = new Date(year, month, 1); Date lastDay = new Date(year, month
				 * + 1, 0);
				 */

				Date firstDay = new GregorianCalendar(year, month - 1, 1).getTime();
				Date lastDay = new GregorianCalendar(year, month, 0).getTime();

				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

				map = new LinkedMultiValueMap<String, Object>();
				map.add("fromDate", sf.format(firstDay));
				map.add("toDate", sf.format(lastDay));
				map.add("locId", locId);
				InfoForUploadAttendance infoForUploadAttendance = Constants.getRestTemplate().postForObject(
						Constants.url + "/getInformationOfUploadedAttendance", map, InfoForUploadAttendance.class);

				temp = Calendar.getInstance();
				temp.setTime(firstDay);
				year = temp.get(Calendar.YEAR);
				month = temp.get(Calendar.MONTH);

				String[] monthNames = { "January", "February", "March", "April", "May", "June", "July", "August",
						"September", "October", "November", "December" };
				String monthName = monthNames[month];

				model.addAttribute("monthName", monthName);
				model.addAttribute("year", year);
				model.addAttribute("infoForUploadAttendance", infoForUploadAttendance);

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return mav;

	}

	@RequestMapping(value = "/addDefaultAttendance", method = RequestMethod.POST)
	@ResponseBody
	public Info addDefaultAttendance(HttpServletRequest request, HttpServletResponse response, Model model) {

		Info info = new Info();

		try {

			int month = Integer.parseInt(request.getParameter("month"));
			int year = Integer.parseInt(request.getParameter("year"));
			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");
			int locId = (int) session.getAttribute("liveLocationId");

			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			Date firstDay = new GregorianCalendar(year, month - 1, 1).getTime();
			Date lastDay = new GregorianCalendar(year, month, 0).getTime();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("fromDate", sf.format(firstDay));
			map.add("toDate", sf.format(lastDay));
			map.add("userId", userObj.getUserId());
			map.add("locId", locId);
			info = Constants.getRestTemplate().postForObject(Constants.url + "/initiallyInsertDailyRecord", map,
					Info.class);
			if (info.isError() == false) {
				session.setAttribute("successMsg", "Step 1 Completed Successfully");
			} else {
				session.setAttribute("errorMsg", "Error in Step 1");
			}
		} catch (Exception e) {
			e.printStackTrace();
			info = new Info();
			info.setError(true);
			info.setMsg("failed");
		}
		return info;

	}

	@RequestMapping(value = "/attUploadCSV", method = RequestMethod.POST)
	@ResponseBody
	public Info attUploadCSV(@RequestParam("file") List<MultipartFile> file, HttpServletRequest request,
			HttpServletResponse response) {

		Info info = new Info();

		try {

			SimpleDateFormat dateTimeInGMT = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");
			Date date = new Date();
			VpsImageUpload upload = new VpsImageUpload();

			int month = Integer.parseInt(request.getParameter("month"));
			int year = Integer.parseInt(request.getParameter("year"));

			System.out.println("month " + month + "year " + year);

			String imageName = new String();
			imageName = dateTimeInGMT.format(date) + "_" + file.get(0).getOriginalFilename();

			try {

				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
				Date firstDay = new GregorianCalendar(year, month - 1, 1).getTime();
				Date lastDay = new GregorianCalendar(year, month, 0).getTime();

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
						String outTime = temp[4];

						fileUploadedData.setEmpCode(empCode);
						fileUploadedData.setEmpName(ename);
						fileUploadedData.setLogDate(logDate);
						fileUploadedData.setInTime(inTime);
						fileUploadedData.setOutTime(outTime);

						fileUploadedDataList.add(fileUploadedData);
					} catch (Exception e) {
						// TODO: handle exception
						e.printStackTrace();
					}

				}
				bufferedReader.close();

				// System.out.println(fileUploadedDataList);
				HttpSession session = request.getSession();
				LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

				DataForUpdateAttendance dataForUpdateAttendance = new DataForUpdateAttendance();
				dataForUpdateAttendance.setFromDate(sf.format(firstDay));
				dataForUpdateAttendance.setToDate(sf.format(lastDay));
				dataForUpdateAttendance.setMonth(month);
				dataForUpdateAttendance.setYear(year);
				dataForUpdateAttendance.setUserId(userObj.getUserId());
				dataForUpdateAttendance.setFileUploadedDataList(fileUploadedDataList);
				dataForUpdateAttendance.setEmpId(0);
				info = Constants.getRestTemplate().postForObject(Constants.url + "/importAttendanceByFileAndUpdate",
						dataForUpdateAttendance, Info.class);
				// System.out.println(variousList);

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
			e.printStackTrace();

		}
		return info;

	}

	@RequestMapping(value = "/finalizeAttendaceProcess", method = RequestMethod.POST)
	@ResponseBody
	public Info finalizeAttendaceProcess(HttpServletRequest request, HttpServletResponse response, Model model) {

		Info info = new Info();

		try {

			int month = Integer.parseInt(request.getParameter("month"));
			int year = Integer.parseInt(request.getParameter("year"));
			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			Date firstDay = new GregorianCalendar(year, month - 1, 1).getTime();
			Date lastDay = new GregorianCalendar(year, month, 0).getTime();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("fromDate", sf.format(firstDay));
			map.add("toDate", sf.format(lastDay));
			map.add("userId", userObj.getUserId());
			map.add("month", month);
			map.add("year", year);
			map.add("empId", 0);
			info = Constants.getRestTemplate().postForObject(Constants.url + "/finalUpdateDailySumaryRecord", map,
					Info.class);
			// System.out.println(info);
			if (info.isError() == false) {
				session.setAttribute("successMsg", "Step 3 Completed Successfully");
			} else {
				session.setAttribute("errorMsg", "Error in Step 3");
			}
		} catch (Exception e) {
			e.printStackTrace();
			info = new Info();
			info.setError(true);
			info.setMsg("failed");
		}
		return info;

	}

	@RequestMapping(value = "/attendaceSheet", method = RequestMethod.GET)
	public String attendaceSheet(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = null;

		HttpSession session = request.getSession();

		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("attendaceSheet", "attendaceSheet", 1, 0, 0, 0, newModuleList);

		if (view.isError() == true) {

			mav = "accessDenied";

		} else {
			mav = "attendence/attendaceSheet";

			try {

				Info edit = AcessController.checkAccess("attendaceSheet", "attendaceSheet", 0, 0, 1, 0, newModuleList);

				if (edit.isError() == false) {
					model.addAttribute("editAccess", 0);
				}

				SimpleDateFormat dd = new SimpleDateFormat("dd-MM-yyyy");
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

				String date = request.getParameter("date");

				if (date != null) {

					LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");
					int locId = (int) session.getAttribute("liveLocationId");
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
					map.add("userType", userObj.getDesignType());
					map.add("userId", userObj.getEmpId());
					map.add("locId", locId);
					AttendanceSheetData attendanceSheetData = Constants.getRestTemplate()
							.postForObject(Constants.url + "/getAttendanceSheet", map, AttendanceSheetData.class);

					model.addAttribute("attendanceSheetData", attendanceSheetData);
					model.addAttribute("date", date);
					model.addAttribute("year", year);
					model.addAttribute("month", month);

					map = new LinkedMultiValueMap<String, Object>();
					map.add("year", year);
					map.add("month", month);
					map.add("userType", userObj.getDesignType());
					map.add("userId", userObj.getEmpId());
					map.add("locId", locId);
					SummaryAttendance[] summaryDailyAttendance = Constants.getRestTemplate().postForObject(
							Constants.url + "/getMonthlySummryAttendace", map, SummaryAttendance[].class);
					List<SummaryAttendance> summrylist = new ArrayList<SummaryAttendance>(
							Arrays.asList(summaryDailyAttendance));
					model.addAttribute("summrylist", summrylist);

				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return mav;

	}

	@RequestMapping(value = "/attendanceEditEmpMonth", method = RequestMethod.GET)
	public String attendanceEditEmpMonth(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();

		String mav = null;
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("attendanceEditEmpMonth", "attendaceSheet", 0, 0, 1, 0, newModuleList);

		if (view.isError() == true) {

			mav = "accessDenied";

		} else {
			mav = "attendence/attendanceEditEmpMonth";

			try {

				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

				int year = Integer.parseInt(request.getParameter("year"));
				int month = Integer.parseInt(request.getParameter("month"));
				int empId = Integer.parseInt(request.getParameter("empId"));

				Date firstDay = new GregorianCalendar(year, month - 1, 1).getTime();
				Date lastDay = new GregorianCalendar(year, month, 0).getTime();

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("fromDate", sf.format(firstDay));
				map.add("toDate", sf.format(lastDay));
				map.add("year", year);
				map.add("month", month);
				map.add("empId", empId);

				GetDailyDailyRecord[] getDailyDailyRecord = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getDailyDailyRecord", map, GetDailyDailyRecord[].class);
				List<GetDailyDailyRecord> dailyrecordList = new ArrayList<GetDailyDailyRecord>(
						Arrays.asList(getDailyDailyRecord));
				model.addAttribute("dailyrecordList", dailyrecordList);

				SummaryAttendance summaryAttendance = Constants.getRestTemplate().postForObject(
						Constants.url + "/getMonthlySummryAttendaceByEmpId", map, SummaryAttendance.class);
				model.addAttribute("summaryAttendance", summaryAttendance);
				model.addAttribute("year", year);
				model.addAttribute("month", month);

				LvType[] lvType = Constants.getRestTemplate().getForObject(Constants.url + "/getLvTypeList",
						LvType[].class);
				List<LvType> lvTypeList = new ArrayList<LvType>(Arrays.asList(lvType));
				model.addAttribute("lvTypeList", lvTypeList);

				map = new LinkedMultiValueMap<>();
				map.add("empId", empId);
				MstEmpType mstEmpType = Constants.getRestTemplate().postForObject(Constants.url + "/getEmpTypeByempId",
						map, MstEmpType.class);
				model.addAttribute("mstEmpType", mstEmpType);
				model.addAttribute("empId", empId);

				ShiftMaster[] shiftMaster = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getShiftListByLpad", map, ShiftMaster[].class);
				model.addAttribute("shiftMaster", shiftMaster);

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return mav;

	}

	@RequestMapping(value = "/editDailyRecord", method = RequestMethod.POST)
	@ResponseBody
	public GetDailyDailyRecord editDailyRecord(HttpServletRequest request, HttpServletResponse response, Model model) {

		GetDailyDailyRecord info = new GetDailyDailyRecord();

		try {

			int dailyId = Integer.parseInt(request.getParameter("dailyId"));

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("dailyId", dailyId);
			info = Constants.getRestTemplate().postForObject(Constants.url + "/getDailyDailyRecordByDailyId", map,
					GetDailyDailyRecord.class);
			// System.out.println(info);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return info;

	}

	@RequestMapping(value = "/markAsCompOff", method = RequestMethod.POST)
	@ResponseBody
	public Info markAsCompOff(HttpServletRequest request, HttpServletResponse response) {

		Info info = new Info();

		try {
			HttpSession session = request.getSession();
			int dailyId = Integer.parseInt(request.getParameter("dailyId"));
			String sts = request.getParameter("sts");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("dailyId", dailyId);
			map.add("sts", sts);
			info = Constants.getRestTemplate().postForObject(Constants.url + "/updateMarkAsCompOff", map, Info.class);
			// System.out.println(info);
			if (info.isError() == false) {
				session.setAttribute("successMsg", "Attendance Updated Successfully.");
			} else {
				session.setAttribute("errorMsg", "Failed to update Attendance.");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return info;

	}

	@RequestMapping(value = "/changeEmpStatus", method = RequestMethod.POST)
	@ResponseBody
	public Info changeEmpStatus(HttpServletRequest request, HttpServletResponse response) {

		Info info = new Info();

		try {
			HttpSession session = request.getSession();
			int empId = Integer.parseInt(request.getParameter("empId"));
			int isActive = Integer.parseInt(request.getParameter("isActive"));

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("empId", empId);
			map.add("isActive", isActive);
			info = Constants.getRestTemplate().postForObject(Constants.url + "/deleteEmployeeStatus", map, Info.class);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return info;

	}

	@RequestMapping(value = "/submitAttendanceDetail", method = RequestMethod.POST)
	@ResponseBody
	public Info submitAttendanceDetail(HttpServletRequest request, HttpServletResponse response, Model model) {

		Info info = new Info();

		try {
			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			int dailyId = Integer.parseInt(request.getParameter("dailyId"));
			int selectStatus = Integer.parseInt(request.getParameter("selectStatus"));
			int byStatus = Integer.parseInt(request.getParameter("byStatus"));
			int lateMark = Integer.parseInt(request.getParameter("lateMark"));
			String otHours = request.getParameter("otHours");
			String inTime = request.getParameter("inTime");
			String outTime = request.getParameter("outTime");
			String selectStatusText = request.getParameter("selectStatusText");
			String namesd = request.getParameter("namesd");
			int year = Integer.parseInt(request.getParameter("year"));
			int month = Integer.parseInt(request.getParameter("month"));
			int selectShift = Integer.parseInt(request.getParameter("selectShift"));
			int otApproval = Integer.parseInt(request.getParameter("otApproval"));
			int lateMin = Integer.parseInt(request.getParameter("lateMin"));

			Date firstDay = new GregorianCalendar(year, month - 1, 1).getTime();
			Date lastDay = new GregorianCalendar(year, month, 0).getTime();

			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("dailyId", dailyId);
			map.add("selectStatus", selectStatus);
			map.add("byStatus", byStatus);
			map.add("lateMark", lateMark);
			map.add("otHours", otHours);
			map.add("inTime", inTime + ":00");
			map.add("outTime", outTime + ":00");
			map.add("selectStatusText", selectStatusText);
			map.add("fromDate", sf.format(firstDay));
			map.add("toDate", sf.format(lastDay));
			map.add("userId", userObj.getUserId());
			map.add("year", year);
			map.add("month", month);
			map.add("selectShift", selectShift);
			map.add("otApproval", otApproval);
			map.add("namesd", namesd);
			map.add("lateMin", lateMin);
			System.out.println(map);
			info = Constants.getRestTemplate().postForObject(Constants.url + "/updateAttendaceRecordSingle", map,
					Info.class);

			if (info.isError() == false) {
				session.setAttribute("successMsg", "Attendance Updated Successfully.");
			} else {
				session.setAttribute("errorMsg", "Failed to update Attendance.");
			}
			// System.out.println(info);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return info;

	}

	int month = 0;
	int year = 0;

	@RequestMapping(value = "/fixAttendaceByDateAndEmp", method = RequestMethod.GET)
	public String fixAttendaceByDateAndEmp(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();

		String mav = null;
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("fixAttendaceByDateAndEmp", "fixAttendaceByDateAndEmp", 1, 0, 0, 0,
				newModuleList);
		month = 0;
		year = 0;
		if (view.isError() == true) {

			mav = "accessDenied";

		} else {
			mav = "attendence/fixAttendace";

			try {

				String selectMonth = request.getParameter("selectMonth");
				String[] mnth = selectMonth.split("-");
				month = Integer.parseInt(mnth[0]);
				year = Integer.parseInt(mnth[1]);
				int locId = (int) session.getAttribute("liveLocationId");

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("month", month);
				map.add("year", year);
				map.add("isFixed", 0);
				map.add("sts", "O");
				map.add("locId", locId);
				EmpSalaryInfoForPayroll[] empInfo = Constants.getRestTemplate().postForObject(
						Constants.url + "/getListForfixunfixAttendance", map, EmpSalaryInfoForPayroll[].class);
				List<EmpSalaryInfoForPayroll> empList = new ArrayList<EmpSalaryInfoForPayroll>(Arrays.asList(empInfo));
				model.addAttribute("empList", empList);
				model.addAttribute("selectMonth", selectMonth);

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return mav;

	}

	@RequestMapping(value = "/submitFixAttendaceByDateAndEmp", method = RequestMethod.POST)
	public String submitFixAttendaceByDateAndEmp(HttpServletRequest request, HttpServletResponse response) {

		try {

			String[] empIds = request.getParameterValues("selectEmp");
			Date firstDay = new GregorianCalendar(year, month - 1, 1).getTime();
			Date lastDay = new GregorianCalendar(year, month, 0).getTime();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

			String empId = new String();

			for (int i = 0; i < empIds.length; i++) {
				empId = empId + "," + empIds[i];
			}
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("fromDate", sf.format(firstDay));
			map.add("toDate", sf.format(lastDay));
			map.add("empIds", empId.substring(1, empId.length()));
			map.add("isFixed", 1);
			map.add("sts", "F");
			// System.out.println(map);
			Info info = Constants.getRestTemplate().postForObject(Constants.url + "/fixAttendanceByDateOfEmpLoyee", map,
					Info.class);

			String userAgent = request.getHeader("User-Agent");
			InetAddress addr = InetAddress.getByName(request.getRemoteAddr());
			String hostName = addr.getHostName();

			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			Date date = new Date();
			SimpleDateFormat dt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			FreezeLogs savefreezeLogs = new FreezeLogs();
			savefreezeLogs.setIpAddress(hostName);
			savefreezeLogs.setUserAgent(userAgent);
			savefreezeLogs.setUserId(userObj.getUserId());
			savefreezeLogs.setMakerEnterDatetime(dt.format(date));
			savefreezeLogs.setEmployeeIds(empId.substring(1, empId.length()));
			savefreezeLogs.setFreezeMonth(month + "-" + year);
			savefreezeLogs.setFreezeType("F");
			savefreezeLogs.setComments("");

			FreezeLogs save = Constants.getRestTemplate().postForObject(Constants.url + "/freezeUnfreezeLogs",
					savefreezeLogs, FreezeLogs.class);
			if (info.isError() == false) {
				session.setAttribute("successMsg", "Freeze Attendance Successfully.");
			} else {
				session.setAttribute("errorMsg", "Failed to Freeze Attendance.");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/fixAttendaceByDateAndEmp?selectMonth=" + month + "-" + year;

	}

	@RequestMapping(value = "/unfixAttendaceByDateAndEmp", method = RequestMethod.GET)
	public String unfixAttendaceByDateAndEmp(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();

		String mav = null;
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("unfixAttendaceByDateAndEmp", "unfixAttendaceByDateAndEmp", 1, 0, 0, 0,
				newModuleList);
		month = 0;
		year = 0;
		if (view.isError() == true) {

			mav = "accessDenied";

		} else {
			mav = "attendence/unfixAttendace";

			try {
				int locId = (int) session.getAttribute("liveLocationId");
				String selectMonth = request.getParameter("selectMonth");
				String[] mnth = selectMonth.split("-");
				month = Integer.parseInt(mnth[0]);
				year = Integer.parseInt(mnth[1]);
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("month", month);
				map.add("year", year);
				map.add("isFixed", 1);
				map.add("sts", "F");
				map.add("locId", locId);
				EmpSalaryInfoForPayroll[] empInfo = Constants.getRestTemplate().postForObject(
						Constants.url + "/getListForfixunfixAttendance", map, EmpSalaryInfoForPayroll[].class);
				List<EmpSalaryInfoForPayroll> empList = new ArrayList<EmpSalaryInfoForPayroll>(Arrays.asList(empInfo));
				model.addAttribute("empList", empList);
				model.addAttribute("selectMonth", selectMonth);

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return mav;

	}

	@RequestMapping(value = "/submitunFixAttendaceByDateAndEmp", method = RequestMethod.POST)
	public String submitunFixAttendaceByDateAndEmp(HttpServletRequest request, HttpServletResponse response) {

		try {

			String[] empIds = request.getParameterValues("selectEmp");
			String comnt = request.getParameter("cmnt");

			Date firstDay = new GregorianCalendar(year, month - 1, 1).getTime();
			Date lastDay = new GregorianCalendar(year, month, 0).getTime();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

			String empId = new String();

			for (int i = 0; i < empIds.length; i++) {
				empId = empId + "," + empIds[i];
			}
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("fromDate", sf.format(firstDay));
			map.add("toDate", sf.format(lastDay));
			map.add("empIds", empId.substring(1, empId.length()));
			map.add("isFixed", 0);
			map.add("sts", "O");
			// System.out.println(map);
			Info info = Constants.getRestTemplate().postForObject(Constants.url + "/fixAttendanceByDateOfEmpLoyee", map,
					Info.class);

			String userAgent = request.getHeader("User-Agent");
			InetAddress addr = InetAddress.getByName(request.getRemoteAddr());
			String hostName = addr.getHostName();

			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			Date date = new Date();
			SimpleDateFormat dt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			FreezeLogs savefreezeLogs = new FreezeLogs();
			savefreezeLogs.setIpAddress(hostName);
			savefreezeLogs.setUserAgent(userAgent);
			savefreezeLogs.setUserId(userObj.getUserId());
			savefreezeLogs.setMakerEnterDatetime(dt.format(date));
			savefreezeLogs.setEmployeeIds(empId.substring(1, empId.length()));
			savefreezeLogs.setFreezeMonth(month + "-" + year);
			savefreezeLogs.setFreezeType("O");
			savefreezeLogs.setComments(comnt);

			FreezeLogs save = Constants.getRestTemplate().postForObject(Constants.url + "/freezeUnfreezeLogs",
					savefreezeLogs, FreezeLogs.class);
			if (info.isError() == false) {
				session.setAttribute("successMsg", "Unfreeze Attendance Successfully.");
			} else {
				session.setAttribute("errorMsg", "Failed to Unfreeze Attendance.");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/unfixAttendaceByDateAndEmp?selectMonth=" + month + "-" + year;

	}

	String date;
	List<DailyAttendance> dailyDailyList = new ArrayList<DailyAttendance>();

	@RequestMapping(value = "/attendaceSheetByHod", method = RequestMethod.GET)
	public String attendaceSheetByHod(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = null;

		HttpSession session = request.getSession();

		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("attendaceSheetByHod", "attendaceSheetByHod", 1, 0, 0, 0,
				newModuleList);

		if (view.isError() == true) {

			mav = "accessDenied";

		} else {

			mav = "attendence/attendaceSheetByHod";

			try {

				Info edit = AcessController.checkAccess("attendaceSheetByHod", "attendaceSheetByHod", 0, 0, 1, 0,
						newModuleList);

				if (edit.isError() == false) {
					model.addAttribute("editAccess", 0);
				}

				date = request.getParameter("date");

				if (date != null) {
					LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");
					MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
					int locId = (int) session.getAttribute("liveLocationId");
					map = new LinkedMultiValueMap<String, Object>();
					map.add("date", DateConvertor.convertToYMD(date));
					map.add("desgType", 2);
					map.add("locId", locId);
					DailyAttendance[] dailyAttendance = Constants.getRestTemplate().postForObject(
							Constants.url + "/getEmployyeDailyDailyListforHrLocId", map, DailyAttendance[].class);
					dailyDailyList = new ArrayList<DailyAttendance>(Arrays.asList(dailyAttendance));
					model.addAttribute("dailyDailyList", dailyDailyList);
					model.addAttribute("date", date);
					LvType[] lvType = Constants.getRestTemplate().getForObject(Constants.url + "/getLvTypeList",
							LvType[].class);
					List<LvType> lvTypeList = new ArrayList<LvType>(Arrays.asList(lvType));
					model.addAttribute("lvTypeList", lvTypeList);

				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return mav;

	}

	@RequestMapping(value = "/attendaceSheetByHr", method = RequestMethod.GET)
	public String attendaceSheetByHr(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = null;

		HttpSession session = request.getSession();

		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("attendaceSheetByHr", "attendaceSheetByHr", 1, 0, 0, 0, newModuleList);

		if (view.isError() == true) {

			mav = "accessDenied";

		} else {

			mav = "attendence/attendaceSheetByHr";

			try {

				Info edit = AcessController.checkAccess("attendaceSheetByHr", "attendaceSheetByHr", 0, 0, 1, 0,
						newModuleList);

				if (edit.isError() == false) {
					model.addAttribute("editAccess", 0);
				}

				date = request.getParameter("date");

				if (date != null) {
					LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");
					MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

					/*
					 * map = new LinkedMultiValueMap<String, Object>(); map.add("date",
					 * DateConvertor.convertToYMD(date)); map.add("desgType", 1);
					 * map.add("departIds", userObj.getHodDeptIds());
					 */
					int locId = (int) session.getAttribute("liveLocationId");
					map = new LinkedMultiValueMap<String, Object>();
					map.add("date", DateConvertor.convertToYMD(date));
					map.add("empId", userObj.getEmpId());
					map.add("locId", locId);
					DailyAttendance[] dailyAttendance = Constants.getRestTemplate().postForObject(
							Constants.url + "/getEmployyeDailyDailyListByAuthorityLocId", map, DailyAttendance[].class);
					dailyDailyList = new ArrayList<DailyAttendance>(Arrays.asList(dailyAttendance));
					model.addAttribute("dailyDailyList", dailyDailyList);
					model.addAttribute("date", date);
					LvType[] lvType = Constants.getRestTemplate().getForObject(Constants.url + "/getLvTypeList",
							LvType[].class);
					List<LvType> lvTypeList = new ArrayList<LvType>(Arrays.asList(lvType));
					model.addAttribute("lvTypeList", lvTypeList);

				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return mav;

	}

	@RequestMapping(value = "/submitAttendanceDetailByHod", method = RequestMethod.POST)
	@ResponseBody
	public Info submitAttendanceDetailByHod(HttpServletRequest request, HttpServletResponse response, Model model) {

		Info info = new Info();

		try {
			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			int dailyId = Integer.parseInt(request.getParameter("dailyId"));
			int selectStatus = Integer.parseInt(request.getParameter("selectStatus"));
			int lateMark = Integer.parseInt(request.getParameter("lateMark"));
			String selectStatusText = request.getParameter("selectStatusText");
			String nameSd = request.getParameter("namesd");
			int flag = Integer.parseInt(request.getParameter("flag"));
			int lateMin = Integer.parseInt(request.getParameter("lateMin"));
			String otHours = request.getParameter("otHours");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("dailyId", dailyId);
			map.add("selectStatus", selectStatus);
			map.add("lateMark", lateMark);
			map.add("selectStatusText", selectStatusText);
			map.add("userId", userObj.getUserId());
			map.add("flag", flag);
			map.add("otHours", otHours);
			map.add("lateMin", lateMin);
			map.add("nameSd", nameSd);
			// System.out.println(map);
			info = Constants.getRestTemplate().postForObject(Constants.url + "/updateAttendaceRecordSingleByHod", map,
					Info.class);
			// System.out.println(info);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return info;

	}

	@RequestMapping(value = "/approveAttendaceBysecurity", method = RequestMethod.POST)
	public String approveAttendaceBysecurity(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "redirect:/attendaceSheetByHod?date=" + date;

		HttpSession session = request.getSession();

		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("attendaceSheetByHod", "attendaceSheetByHod", 1, 0, 0, 0,
				newModuleList);

		if (view.isError() == true) {

			mav = "accessDenied";

		} else {

			try {

				LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

				String[] ids = request.getParameterValues("ids");

				/*
				 * StringBuilder sb = new StringBuilder();
				 * 
				 * for (int i = 0; i < ids.length; i++) { sb = sb.append(ids[i] + ",");
				 * 
				 * } String items = sb.toString(); items = items.substring(0, items.length() -
				 * 1);
				 * 
				 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
				 * Object>(); map.add("ids", items); map.add("status", 8); Info info =
				 * Constants.getRestTemplate().postForObject(Constants.url +
				 * "/approveAttendanceStatusById", map, Info.class);
				 */

				for (int i = 0; i < ids.length; i++) {

					int id = Integer.parseInt(ids[i]);
					int ontime = 0;
					int lateMark = 0;
					int lateMin = 0;

					try {
						ontime = Integer.parseInt(request.getParameter("ontime" + id));
					} catch (Exception e) {
						ontime = 0;
					}
					try {
						lateMark = Integer.parseInt(request.getParameter("lateMark" + id));
					} catch (Exception e) {
						lateMark = 0;
					}
					try {
						lateMin = Integer.parseInt(request.getParameter("lateMin" + id));
					} catch (Exception e) {
						lateMin = 0;
					}

					int selectStatus = 5;
					String selectStatusText = "P";
					String nameSd = "P";

					if (ontime == 0 && lateMark == 0) {

						for (int k = 0; k < dailyDailyList.size(); k++) {

							if (id == dailyDailyList.get(k).getId()) {

								selectStatus = dailyDailyList.get(k).getLvSumupId();
								selectStatusText = dailyDailyList.get(k).getAttStatus();
								nameSd = dailyDailyList.get(k).getAttsSdShow();
								break;
							}
						}

						// keep status;
					}

					MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
					map.add("dailyId", id);
					map.add("selectStatus", selectStatus);
					map.add("lateMark", lateMark);
					map.add("selectStatusText", selectStatusText);
					map.add("userId", userObj.getUserId());
					map.add("flag", 0);
					map.add("otHours", 0);
					map.add("lateMin", lateMin);
					map.add("nameSd", nameSd);
					// System.out.println(map);
					Info info = Constants.getRestTemplate()
							.postForObject(Constants.url + "/updateAttendaceRecordSingleByHod", map, Info.class);
				}

				/*
				 * if (info.isError() == false) { session.setAttribute("successMsg",
				 * "Attendance Approved Successfully"); } else {
				 * session.setAttribute("errorMsg", "Failed to Approve Attendance"); }
				 */
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return mav;

	}

	@RequestMapping(value = "/approveAttendaceByHod", method = RequestMethod.POST)
	public String approveAttendaceByHod(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "redirect:/attendaceSheetByHr?date=" + date;

		HttpSession session = request.getSession();

		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("attendaceSheetByHr", "attendaceSheetByHr", 1, 0, 0, 0, newModuleList);

		if (view.isError() == true) {

			mav = "accessDenied";

		} else {

			try {
				String[] ids = request.getParameterValues("ids");

				StringBuilder sb = new StringBuilder();

				for (int i = 0; i < ids.length; i++) {
					sb = sb.append(ids[i] + ",");

				}
				String items = sb.toString();
				items = items.substring(0, items.length() - 1);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("ids", items);
				map.add("status", 9);
				Info info = Constants.getRestTemplate().postForObject(Constants.url + "/approveAttendanceStatusById",
						map, Info.class);
				if (info.isError() == false) {
					session.setAttribute("successMsg", "Attendance Approved Successfully");
				} else {
					session.setAttribute("errorMsg", "Failed to Approve Attendance");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return mav;

	}

	@RequestMapping(value = "/attendaceSheetForHrDateWise", method = RequestMethod.GET)
	public String attendaceSheetForHrDateWise(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = null;

		HttpSession session = request.getSession();

		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("attendaceSheetForHrDateWise", "attendaceSheetForHrDateWise", 1, 0, 0,
				0, newModuleList);

		if (view.isError() == true) {

			mav = "accessDenied";

		} else {

			mav = "attendence/attendaceSheetForHrDateWise";

			try {

				Info edit = AcessController.checkAccess("attendaceSheetForHrDateWise", "attendaceSheetForHrDateWise", 0,
						0, 1, 0, newModuleList);

				if (edit.isError() == false) {
					model.addAttribute("editAccess", 0);
				}

				date = request.getParameter("date");

				if (date != null) {

					int locId = (int) session.getAttribute("liveLocationId");
					LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");
					MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
					map.add("date", DateConvertor.convertToYMD(date));
					map.add("locId", locId);
					GetDailyDailyRecord[] getDailyDailyRecord = Constants.getRestTemplate().postForObject(
							Constants.url + "/getDailyDailyRecordForHrByDateLocId", map, GetDailyDailyRecord[].class);
					List<GetDailyDailyRecord> dailyrecordList = new ArrayList<GetDailyDailyRecord>(
							Arrays.asList(getDailyDailyRecord));
					model.addAttribute("dailyrecordList", dailyrecordList);
					model.addAttribute("date", date);
					LvType[] lvType = Constants.getRestTemplate().getForObject(Constants.url + "/getLvTypeList",
							LvType[].class);
					List<LvType> lvTypeList = new ArrayList<LvType>(Arrays.asList(lvType));
					model.addAttribute("lvTypeList", lvTypeList);

					ShiftMaster[] shiftMaster = Constants.getRestTemplate()
							.postForObject(Constants.url + "/getShiftListByLpad", map, ShiftMaster[].class);
					model.addAttribute("shiftMaster", shiftMaster);

					String[] datearr = date.split("-");
					model.addAttribute("year", datearr[2]);
					model.addAttribute("month", datearr[1]);
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return mav;

	}

}

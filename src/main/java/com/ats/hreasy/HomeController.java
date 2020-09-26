package com.ats.hreasy;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.net.URL;
import java.net.URLConnection;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;
import java.util.Properties;
import java.util.Random;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.ats.hreasy.common.Constants;
import com.ats.hreasy.common.RandomString;
import com.ats.hreasy.model.AccessRightModule;
import com.ats.hreasy.model.EmpType;
import com.ats.hreasy.model.GetAccessibleLocation;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.Location;
import com.ats.hreasy.model.LoginResponse;
import com.ats.hreasy.model.Setting;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Handles requests for the application home page.
 */
@Controller
@Scope("session")
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	/*
	 * @RequestMapping(value = "/", method = RequestMethod.GET) public String
	 * home(Locale locale, Model model) {
	 * logger.info("Welcome home! The client locale is {}.", locale);
	 * 
	 * Date date = new Date(); DateFormat dateFormat =
	 * DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
	 * 
	 * String formattedDate = dateFormat.format(date);
	 * 
	 * model.addAttribute("serverTime", formattedDate );
	 * 
	 * return "home"; }
	 */

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model,HttpServletRequest request) {
		HttpSession session = request.getSession();
		String mav = "login";

		return mav;
	}

	@RequestMapping(value = "/loginProcess", method = RequestMethod.POST)
	public String loginProcess(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = new String();
		HttpSession session = request.getSession();
		try {

			String name = request.getParameter("username");
			String password = request.getParameter("password");

			if (name.equalsIgnoreCase("") || password.equalsIgnoreCase("") || name == null || password == null) {

				mav = "redirect:/";
				session.setAttribute("errorMsg", "Login Failed");
			} else {

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

				MessageDigest md = MessageDigest.getInstance("MD5");
				byte[] messageDigest = md.digest(password.getBytes());
				BigInteger number = new BigInteger(1, messageDigest);
				String hashtext = number.toString(16);

				map.add("username", name);
				map.add("password", hashtext);

				LoginResponse userObj = Constants.getRestTemplate().postForObject(Constants.url + "loginProcess", map,
						LoginResponse.class);

				if (userObj.getIsError() == false) {
//System.err.println("userObj.getIsVisit() "+userObj.getIsVisit());
					if(userObj.getIsVisit()==1) {
						session.setAttribute("userId", userObj.getEmpId());
						mav = "redirect:/changePassPage";
					}else {
					
					request.getSession().setMaxInactiveInterval(14400);
					map = new LinkedMultiValueMap<String, Object>();
					map.add("limitKey", "header_color");
					Setting getSettingByKey = Constants.getRestTemplate()
							.postForObject(Constants.url + "/getSettingByKey", map, Setting.class);

					mav = "redirect:/dashboard";
					session.setAttribute("userInfo", userObj);
					session.setAttribute("headerColor", getSettingByKey.getValue());
					session.setAttribute("imgViewUrl", Constants.empDocShowUrl);

					map = new LinkedMultiValueMap<>();
					map.add("empTypeId", userObj.getAccessRoleId());
					EmpType editEmpType = Constants.getRestTemplate().postForObject(Constants.url + "/getEmpTypeById",
							map, EmpType.class);
					List<AccessRightModule> moduleJsonList = new ArrayList<AccessRightModule>();

					
					try {
						map = new LinkedMultiValueMap<>();
						map.add("empId", userObj.getEmpId());
						GetAccessibleLocation eetAccessibleLocation = Constants.getRestTemplate().postForObject(Constants.url + "/getAccessibleLocationAndPresentLocation",
								map, GetAccessibleLocation.class); 
						 
						String[] array = eetAccessibleLocation.getAccessibleLoc().split(",");
						List<String> list = new ArrayList<String>(Arrays.asList(array));
						session.setAttribute("liveAccesibleLoc", list);
						
						session.setAttribute("liveLocationId", Integer.parseInt(array[0]));
						
						map = new LinkedMultiValueMap<>();
						map.add("companyId", 1);
						Location[] location = Constants.getRestTemplate().postForObject(Constants.url + "/getLocationList", map,
								Location[].class); 
						List<Location> locationList = new ArrayList<Location>(Arrays.asList(location));
						session.setAttribute("globalLocationList", locationList);
						
					}catch(Exception e) {
						e.printStackTrace();
					}
					 
					try {

						AccessRightModule[] moduleJson = null;
						ObjectMapper mapper = new ObjectMapper();
						
						//System.out.println(editEmpType.getEmpTypeAccess());
						moduleJson = mapper.readValue(editEmpType.getEmpTypeAccess(), AccessRightModule[].class);
						/*moduleJson = mapper.readValue("[{\"moduleId\":12,\"moduleName\":\"Access Rights\",\"moduleDesc\":\"Access Rights\",\"delStatus\":0,\"orderBy\":0,\"iconDiv\":\"<i class=\\\"icon-list-unordered\\\"></i>\",\"accessRightSubModuleList\":[{\"subModuleId\":54,\"moduleId\":12,\"subModulName\":\"Access Role List\",\"subModuleMapping\":\"showAccessRoleList\",\"subModuleDesc\":\"showAccessRoleList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":0}]},{\"moduleId\":1,\"moduleName\":\"Master\",\"moduleDesc\":\"Master\",\"delStatus\":0,\"orderBy\":1,\"iconDiv\":\"<i class=\\\"icon-list-unordered\\\"></i>\",\"accessRightSubModuleList\":[{\"subModuleId\":55,\"moduleId\":1,\"subModulName\":\"Company Details\",\"subModuleMapping\":\"showSubCompanyList\",\"subModuleDesc\":\"showSubCompanyList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":-1},{\"subModuleId\":8,\"moduleId\":1,\"subModulName\":\"Location List\",\"subModuleMapping\":\"showLocationList\",\"subModuleDesc\":\"showLocationList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":1},{\"subModuleId\":4,\"moduleId\":1,\"subModulName\":\"Department List\",\"subModuleMapping\":\"showDepartmentList\",\"subModuleDesc\":\"showDepartmentList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":4},{\"subModuleId\":5,\"moduleId\":1,\"subModulName\":\"Designation List\",\"subModuleMapping\":\"showDesignationList\",\"subModuleDesc\":\"showDesignationList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":5},{\"subModuleId\":7,\"moduleId\":1,\"subModulName\":\"Bank List\",\"subModuleMapping\":\"showBankList\",\"subModuleDesc\":\"showBankList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":6},{\"subModuleId\":6,\"moduleId\":1,\"subModulName\":\"Contractor List\",\"subModuleMapping\":\"showContractorsList\",\"subModuleDesc\":\"showContractorsList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":7},{\"subModuleId\":61,\"moduleId\":1,\"subModulName\":\"Holiday Master\",\"subModuleMapping\":\"showHolidayMasterList\",\"subModuleDesc\":\"showHolidayMasterList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":8},{\"subModuleId\":56,\"moduleId\":1,\"subModulName\":\"Holiday Category\",\"subModuleMapping\":\"showHolidayCatList\",\"subModuleDesc\":\"showHolidayCatList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":9},{\"subModuleId\":11,\"moduleId\":1,\"subModulName\":\"Holiday List\",\"subModuleMapping\":\"showHolidayList\",\"subModuleDesc\":\"showHolidayList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":10},{\"subModuleId\":57,\"moduleId\":1,\"subModulName\":\"Week off Category\",\"subModuleMapping\":\"showWeekoffCatList\",\"subModuleDesc\":\"showWeekoffCatList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":11},{\"subModuleId\":12,\"moduleId\":1,\"subModulName\":\"Weekly Off List\",\"subModuleMapping\":\"showWeeklyOffList\",\"subModuleDesc\":\"showWeeklyOffList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":12},{\"subModuleId\":10,\"moduleId\":1,\"subModulName\":\"Leave Structure List\",\"subModuleMapping\":\"showLeaveStructureList\",\"subModuleDesc\":\"showLeaveStructureList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":14},{\"subModuleId\":44,\"moduleId\":1,\"subModulName\":\"Shift Group List\",\"subModuleMapping\":\"showSelfGrpList\",\"subModuleDesc\":\"showSelfGrpList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":15},{\"subModuleId\":41,\"moduleId\":1,\"subModulName\":\"Shift Timing List\",\"subModuleMapping\":\"getshiftList\",\"subModuleDesc\":\"getshiftList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":16},{\"subModuleId\":75,\"moduleId\":1,\"subModulName\":\"Skill Rate\",\"subModuleMapping\":\"showSkillList\",\"subModuleDesc\":\"showSkillList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":17},{\"subModuleId\":39,\"moduleId\":1,\"subModulName\":\"Employee Type List\",\"subModuleMapping\":\"showMstEmpTypeList\",\"subModuleDesc\":\"showMstEmpTypeList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":19},{\"subModuleId\":3,\"moduleId\":1,\"subModulName\":\"Payment Deduction List\",\"subModuleMapping\":\"showPayDeductionList\",\"subModuleDesc\":\"showPayDeductionList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":21}]},{\"moduleId\":16,\"moduleName\":\"Employee Management\",\"moduleDesc\":\"Employee Management\",\"delStatus\":0,\"orderBy\":1,\"iconDiv\":\"<i class=\\\"icon-list-unordered\\\"></i>\",\"accessRightSubModuleList\":[{\"subModuleId\":2,\"moduleId\":16,\"subModulName\":\"Employee List\",\"subModuleMapping\":\"showEmployeeList\",\"subModuleDesc\":\"showEmployeeList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":1},{\"subModuleId\":62,\"moduleId\":16,\"subModulName\":\"Assign Company\",\"subModuleMapping\":\"assignSubCompany\",\"subModuleDesc\":\"assignSubCompany\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":2},{\"subModuleId\":66,\"moduleId\":16,\"subModulName\":\"Assign Employee Type\",\"subModuleMapping\":\"showAssignEmpType\",\"subModuleDesc\":\"showAssignEmpType\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":2},{\"subModuleId\":65,\"moduleId\":16,\"subModulName\":\"Assign Designation\",\"subModuleMapping\":\"showAssignDesignation\",\"subModuleDesc\":\"showAssignDesignation\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":3},{\"subModuleId\":64,\"moduleId\":16,\"subModulName\":\"Assign Department\",\"subModuleMapping\":\"assignDept\",\"subModuleDesc\":\"assignDept\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":4},{\"subModuleId\":63,\"moduleId\":16,\"subModulName\":\"Assign Location\",\"subModuleMapping\":\"showAssignLocation\",\"subModuleDesc\":\"showAssignLocation\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":5},{\"subModuleId\":74,\"moduleId\":16,\"subModulName\":\"Accessible Location Assignment\",\"subModuleMapping\":\"showAssignAccesibleLocation\",\"subModuleDesc\":\"showAssignAccesibleLocation\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":5},{\"subModuleId\":76,\"moduleId\":16,\"subModulName\":\"Skill Rate Assign\",\"subModuleMapping\":\"showAssignSkillRate\",\"subModuleDesc\":\"showAssignSkillRate\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":7},{\"subModuleId\":78,\"moduleId\":16,\"subModulName\":\"Assign Acceess Role\",\"subModuleMapping\":\"showAssignAccessRole\",\"subModuleDesc\":\"showAssignAccessRole\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":7},{\"subModuleId\":58,\"moduleId\":16,\"subModulName\":\"Holiday Assignment\",\"subModuleMapping\":\"assignHolidayCategory\",\"subModuleDesc\":\"assignHolidayCategory\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":8},{\"subModuleId\":59,\"moduleId\":16,\"subModulName\":\"Weeklyoff Assignment\",\"subModuleMapping\":\"assignWeekoffCategory\",\"subModuleDesc\":\"assignWeekoffCategory\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":9},{\"subModuleId\":18,\"moduleId\":16,\"subModulName\":\"Salary Structure Assignment\",\"subModuleMapping\":\"showEmpListToAssignSalStruct\",\"subModuleDesc\":\"showEmpListToAssignSalStruct\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":10},{\"subModuleId\":20,\"moduleId\":16,\"subModulName\":\"Shifted Weekly Off List\",\"subModuleMapping\":\"showWeekOffShift\",\"subModuleDesc\":\"showWeekOffShift\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":11},{\"subModuleId\":81,\"moduleId\":16,\"subModulName\":\"Assign Login Types\",\"subModuleMapping\":\"showAssignLogin\",\"subModuleDesc\":\"Assign Login Types- ie web app.mobile app or both\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":22}]},{\"moduleId\":17,\"moduleName\":\"Shift Management\",\"moduleDesc\":\"Shift Management\",\"delStatus\":0,\"orderBy\":1,\"iconDiv\":\"<i class=\\\"icon-list-unordered\\\"></i>\",\"accessRightSubModuleList\":[{\"subModuleId\":82,\"moduleId\":17,\"subModulName\":\"Set First Day Allocation\",\"subModuleMapping\":\"assignFistDayShift\",\"subModuleDesc\":\"assignFistDayShift\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":-2},{\"subModuleId\":79,\"moduleId\":17,\"subModulName\":\"Monthly Shift Allocation\",\"subModuleMapping\":\"showShiftProjectionAllocation\",\"subModuleDesc\":\"showShiftProjectionAllocation\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":-1}]},{\"moduleId\":19,\"moduleName\":\"Optional Holiday\",\"moduleDesc\":\"Optional Holiday\",\"delStatus\":0,\"orderBy\":1,\"iconDiv\":\"<i class=\\\"icon-list-unordered\\\"></i>\",\"accessRightSubModuleList\":[{\"subModuleId\":86,\"moduleId\":19,\"subModulName\":\"Apply Optional Holiday\",\"subModuleMapping\":\"applyHoliday\",\"subModuleDesc\":\"applyHoliday\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":1},{\"subModuleId\":87,\"moduleId\":19,\"subModulName\":\"Optional Holiday Pending List\",\"subModuleMapping\":\"optinalholidayapprovallist\",\"subModuleDesc\":\"optinalholidayapprovallist\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":2},{\"subModuleId\":88,\"moduleId\":19,\"subModulName\":\"Optional Holiday Apply By HR\",\"subModuleMapping\":\"empListForApplyOptionalHoliday\",\"subModuleDesc\":\"empListForApplyOptionalHoliday\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":3}]},{\"moduleId\":2,\"moduleName\":\"Leave Management\",\"moduleDesc\":\"Leave Management\",\"delStatus\":0,\"orderBy\":2,\"iconDiv\":\"<i class=\\\"icon-list-unordered\\\"></i>\",\"accessRightSubModuleList\":[{\"subModuleId\":13,\"moduleId\":2,\"subModulName\":\"Assign Leave Authority\",\"subModuleMapping\":\"leaveAuthorityList\",\"subModuleDesc\":\"leaveAuthorityList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":0},{\"subModuleId\":14,\"moduleId\":2,\"subModulName\":\"Leave Structure Allotment\",\"subModuleMapping\":\"leaveStructureAllotment\",\"subModuleDesc\":\"leaveStructureAllotment\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":1},{\"subModuleId\":15,\"moduleId\":2,\"subModulName\":\"Apply Leave\",\"subModuleMapping\":\"showApplyForLeave\",\"subModuleDesc\":\"showApplyForLeave\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":2},{\"subModuleId\":40,\"moduleId\":2,\"subModulName\":\"Leave Approval By Authority\",\"subModuleMapping\":\"showLeaveApprovalByAuthority\",\"subModuleDesc\":\"showLeaveApprovalByAuthority\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":3},{\"subModuleId\":16,\"moduleId\":2,\"subModulName\":\"Leave Pending Report\",\"subModuleMapping\":\"empInfoHistoryReport\",\"subModuleDesc\":\"empInfoHistoryReport\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":4},{\"subModuleId\":17,\"moduleId\":2,\"subModulName\":\"Carry forward Leave\",\"subModuleMapping\":\"carryForwordLeave\",\"subModuleDesc\":\"carryForwordLeave\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":5},{\"subModuleId\":71,\"moduleId\":2,\"subModulName\":\"Leave Cash Pending List\",\"subModuleMapping\":\"getPendingListOfleaveCash\",\"subModuleDesc\":\"getPendingListOfleaveCash\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":5},{\"subModuleId\":72,\"moduleId\":2,\"subModulName\":\"Leave Cash Paid List\",\"subModuleMapping\":\"getPaidListOfleaveCash\",\"subModuleDesc\":\"getPaidListOfleaveCash\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":5}]},{\"moduleId\":3,\"moduleName\":\"Claim Management\",\"moduleDesc\":\"Claim Management\",\"delStatus\":0,\"orderBy\":2,\"iconDiv\":\"<i class=\\\"icon-list-unordered\\\"></i>\",\"accessRightSubModuleList\":[{\"subModuleId\":24,\"moduleId\":3,\"subModulName\":\"Claim Type List\",\"subModuleMapping\":\"showClaimTypeList\",\"subModuleDesc\":\"showClaimTypeList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":0},{\"subModuleId\":25,\"moduleId\":3,\"subModulName\":\" Claim Authority List\",\"subModuleMapping\":\"claimAuthorityList\",\"subModuleDesc\":\"claimAuthorityList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":1},{\"subModuleId\":29,\"moduleId\":3,\"subModulName\":\"Claim Structure List\",\"subModuleMapping\":\"showClaimStructureList\",\"subModuleDesc\":\"showClaimStructureList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":2},{\"subModuleId\":28,\"moduleId\":3,\"subModulName\":\"Claim Structure Allotment\",\"subModuleMapping\":\"claimStructureAllotment\",\"subModuleDesc\":\"claimStructureAllotment\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":3},{\"subModuleId\":26,\"moduleId\":3,\"subModulName\":\"Apply Claim\",\"subModuleMapping\":\"showApplyForClaim\",\"subModuleDesc\":\"showApplyForClaim\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":4},{\"subModuleId\":27,\"moduleId\":3,\"subModulName\":\"Claim Approval By Authority\",\"subModuleMapping\":\"showClaimApprovalByAuthority\",\"subModuleDesc\":\"showClaimApprovalByAuthority\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":5},{\"subModuleId\":48,\"moduleId\":3,\"subModulName\":\"Change Claim Paid Date\",\"subModuleMapping\":\"showClaimListToChangeDate\",\"subModuleDesc\":\"showClaimListToChangeDate\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":6}]},{\"moduleId\":4,\"moduleName\":\"Attendance\",\"moduleDesc\":\"Attendance\",\"delStatus\":0,\"orderBy\":2,\"iconDiv\":\"<i class=\\\"icon-list-unordered\\\"></i>\",\"accessRightSubModuleList\":[{\"subModuleId\":21,\"moduleId\":4,\"subModulName\":\"Upload Attendance CSV File\",\"subModuleMapping\":\"attendanceSelectMonth\",\"subModuleDesc\":\"attendanceSelectMonth\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":0},{\"subModuleId\":22,\"moduleId\":4,\"subModulName\":\"Attendance Sheet\",\"subModuleMapping\":\"attendaceSheet\",\"subModuleDesc\":\"attendaceSheet\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":1},{\"subModuleId\":52,\"moduleId\":4,\"subModulName\":\"Production Incentive Initial Approval List (OT)\",\"subModuleMapping\":\"otApprovalList\",\"subModuleDesc\":\"otApprovalList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":2},{\"subModuleId\":53,\"moduleId\":4,\"subModulName\":\"Production Incentive Final Approval List (OT)\",\"subModuleMapping\":\"otFinalApprovalList\",\"subModuleDesc\":\"otFinalApprovalList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":3},{\"subModuleId\":23,\"moduleId\":4,\"subModulName\":\"Freeze Attendance\",\"subModuleMapping\":\"fixAttendaceByDateAndEmp\",\"subModuleDesc\":\"fixAttendaceByDateAndEmp\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":4},{\"subModuleId\":77,\"moduleId\":4,\"subModulName\":\"Unfreeze Attendance\",\"subModuleMapping\":\"unfixAttendaceByDateAndEmp\",\"subModuleDesc\":\"unfixAttendaceByDateAndEmp\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":5}]},{\"moduleId\":7,\"moduleName\":\"Loan\",\"moduleDesc\":\"Loan\",\"delStatus\":0,\"orderBy\":2,\"iconDiv\":\"<i class=\\\"icon-list-unordered\\\"></i>\",\"accessRightSubModuleList\":[{\"subModuleId\":32,\"moduleId\":7,\"subModulName\":\"Add Loan\",\"subModuleMapping\":\"showEmpListToAddLoan\",\"subModuleDesc\":\"showEmpListToAddLoan\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":0},{\"subModuleId\":33,\"moduleId\":7,\"subModulName\":\"Pending Loan List\",\"subModuleMapping\":\"showCompLoanList\",\"subModuleDesc\":\"showCompLoanList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":0},{\"subModuleId\":34,\"moduleId\":7,\"subModulName\":\"Loan History\",\"subModuleMapping\":\"showLoanHistory\",\"subModuleDesc\":\"showLoanHistory\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":0}]},{\"moduleId\":8,\"moduleName\":\"Advanced\",\"moduleDesc\":\"Advanced\",\"delStatus\":0,\"orderBy\":2,\"iconDiv\":\"<i class=\\\"icon-list-unordered\\\"></i>\",\"accessRightSubModuleList\":[{\"subModuleId\":35,\"moduleId\":8,\"subModulName\":\"Add Advance\",\"subModuleMapping\":\"showEmpListToAddAdvance\",\"subModuleDesc\":\"showEmpListToAddAdvance\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":0},{\"subModuleId\":36,\"moduleId\":8,\"subModulName\":\"Advance List\",\"subModuleMapping\":\"showEmpAdvancePendingList\",\"subModuleDesc\":\"showEmpAdvancePendingList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":0},{\"subModuleId\":37,\"moduleId\":8,\"subModulName\":\"Advance History\",\"subModuleMapping\":\"showAdvanceHistory\",\"subModuleDesc\":\"showAdvanceHistory\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":0}]},{\"moduleId\":14,\"moduleName\":\"Pay Deduction\",\"moduleDesc\":\"Pay Deduction\",\"delStatus\":0,\"orderBy\":2,\"iconDiv\":\"<i class=\\\"icon-list-unordered\\\"></i>\",\"accessRightSubModuleList\":[{\"subModuleId\":30,\"moduleId\":14,\"subModulName\":\"Payment Deduction\",\"subModuleMapping\":\"viewPayDeduction\",\"subModuleDesc\":\"viewPayDeduction\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":0},{\"subModuleId\":31,\"moduleId\":14,\"subModulName\":\"Payment Deduction Details\",\"subModuleMapping\":\"payDeductionDetails\",\"subModuleDesc\":\"payDeductionDetails\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":0},{\"subModuleId\":67,\"moduleId\":14,\"subModulName\":\"Pay Deduction Type\",\"subModuleMapping\":\"showPayDeductionList\",\"subModuleDesc\":\"showPayDeductionList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":0}]},{\"moduleId\":13,\"moduleName\":\"Reward\",\"moduleDesc\":\"Reward\",\"delStatus\":0,\"orderBy\":3,\"iconDiv\":\"<i class=\\\"icon-list-unordered\\\"></i>\",\"accessRightSubModuleList\":[{\"subModuleId\":68,\"moduleId\":13,\"subModulName\":\"Reward Type \",\"subModuleMapping\":\"showPayBonusTypeList\",\"subModuleDesc\":\"showPayBonusTypeList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":0},{\"subModuleId\":69,\"moduleId\":13,\"subModulName\":\"Add Reward\",\"subModuleMapping\":\"viewEmpRewarAddList\",\"subModuleDesc\":\"viewEmpRewarAddList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":0},{\"subModuleId\":70,\"moduleId\":13,\"subModulName\":\"Reward List\",\"subModuleMapping\":\"payRewardDetails\",\"subModuleDesc\":\"payRewardDetails\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":0}]},{\"moduleId\":9,\"moduleName\":\"Pay Roll\",\"moduleDesc\":\"Pay Roll\",\"delStatus\":0,\"orderBy\":4,\"iconDiv\":\"<i class=\\\"icon-list-unordered\\\"></i>\",\"accessRightSubModuleList\":[{\"subModuleId\":46,\"moduleId\":9,\"subModulName\":\"Payroll process\",\"subModuleMapping\":\"selectMonthForPayRoll\",\"subModuleDesc\":\"selectMonthForPayRoll\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":1},{\"subModuleId\":47,\"moduleId\":9,\"subModulName\":\"List Of Generated Payroll\",\"subModuleMapping\":\"listOfGeneratedPayroll\",\"subModuleDesc\":\"listOfGeneratedPayroll\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":2},{\"subModuleId\":90,\"moduleId\":9,\"subModulName\":\"List Of Generated Payroll For Authority\",\"subModuleMapping\":\"listOfGeneratedPayrollByAuthrity\",\"subModuleDesc\":\"listOfGeneratedPayrollByAuthrity\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":3},{\"subModuleId\":91,\"moduleId\":9,\"subModulName\":\"Full And Final Process\",\"subModuleMapping\":\"showEmpListForFullnfinal\",\"subModuleDesc\":\"showEmpListForFullnfinal\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":4}]},{\"moduleId\":10,\"moduleName\":\"Bonus & Exgratia\",\"moduleDesc\":\"Bonus & Exgratia\",\"delStatus\":0,\"orderBy\":5,\"iconDiv\":\"<i class=\\\"icon-list-unordered\\\"></i>\",\"accessRightSubModuleList\":[{\"subModuleId\":43,\"moduleId\":10,\"subModulName\":\"Bonus List\",\"subModuleMapping\":\"showBonusList\",\"subModuleDesc\":\"showBonusList\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":12}]},{\"moduleId\":11,\"moduleName\":\"Reports\",\"moduleDesc\":\"Reports\",\"delStatus\":0,\"orderBy\":6,\"iconDiv\":\"<i class=\\\"icon-list-unordered\\\"></i>\",\"accessRightSubModuleList\":[{\"subModuleId\":51,\"moduleId\":11,\"subModulName\":\"Report Dash\",\"subModuleMapping\":\"showReportsDashbord\",\"subModuleDesc\":\"showReportsDashbord\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":-1}]},{\"moduleId\":6,\"moduleName\":\"User Profile\",\"moduleDesc\":\"User Profile\",\"delStatus\":0,\"orderBy\":8,\"iconDiv\":\"<i class=\\\"icon-list-unordered\\\"></i>\",\"accessRightSubModuleList\":[{\"subModuleId\":42,\"moduleId\":6,\"subModulName\":\"Change Password\",\"subModuleMapping\":\"changePass\",\"subModuleDesc\":\"changePass\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":0},{\"subModuleId\":38,\"moduleId\":6,\"subModulName\":\"Logout\",\"subModuleMapping\":\"logout\",\"subModuleDesc\":\"logout\",\"type\":0,\"view\":1,\"addApproveConfig\":1,\"editReject\":1,\"deleteRejectApprove\":1,\"isDelete\":0,\"orderBy\":1}]}]\n" + 
								"", AccessRightModule[].class);*/
						moduleJsonList = new ArrayList<AccessRightModule>(Arrays.asList(moduleJson));

					} catch (Exception e) {

						e.printStackTrace();
					}
					session.setAttribute("moduleJsonList", moduleJsonList);
					// System.err.println("Hoem**"+userObj.toString());
					}
				} else {
					mav = "redirect:/";
					session.setAttribute("errorMsg", "Login Failed");
				}

			}

		} catch (Exception e) {
			mav = "redirect:/";
			session.setAttribute("errorMsg", "Login Failed");
			e.printStackTrace();
		}

		return mav;
	}

	/*
	 * @RequestMapping(value = "/dashboard", method = RequestMethod.GET) public
	 * String dashboard(HttpServletRequest request, HttpServletResponse response,
	 * Model model) {
	 * 
	 * String mav = "welcome";
	 * 
	 * try {
	 * 
	 * 
	 * String testString = request.getParameter("pass"); MessageDigest md =
	 * MessageDigest.getInstance("MD5"); byte[] messageDigest =
	 * md.digest(testString.getBytes()); BigInteger number = new BigInteger(1,
	 * messageDigest); String hashtext = number.toString(16);
	 * 
	 * System.out.println(hashtext);
	 * 
	 * RandomString randomString = new RandomString(); String password =
	 * randomString.nextString(); System.out.println(password);
	 * 
	 * } catch (Exception e) { e.printStackTrace(); }
	 * 
	 * return mav; }
	 */

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {

		session.invalidate();
		return "redirect:/";
	}

	@RequestMapping(value = "/sessionTimeOut", method = RequestMethod.GET)
	public String sessionTimeOut(HttpSession session) {
		System.out.println("User Logout");

		session.invalidate();
		return "redirect:/";
	}

	@RequestMapping(value = "/setLocation", method = RequestMethod.POST)
	@ResponseBody
	public  Info setLocation(HttpServletRequest request, HttpServletResponse response) {
		
		Info info = new Info();
		 
		try {
			int locationId = Integer.parseInt(request.getParameter("locationId"));
			 
			HttpSession session = request.getSession();
			session.setAttribute("liveLocationId", locationId);
			info.setError(false);
		}catch(Exception e) {
			e.printStackTrace();
			info.setError(true);
		}
		
		
		return info;
	}
	
	
	@RequestMapping(value = "/setSubModId", method = RequestMethod.GET)
	public @ResponseBody void setSubModId(HttpServletRequest request, HttpServletResponse response) {
		int subModId = Integer.parseInt(request.getParameter("subModId"));
		int modId = Integer.parseInt(request.getParameter("modId"));
		/*
		 * System.out.println("subModId " + subModId); System.out.println("modId " +
		 * modId);
		 */
		HttpSession session = request.getSession();
		session.setAttribute("sessionModuleId", modId);
		session.setAttribute("sessionSubModuleId", subModId);
		session.removeAttribute("exportExcelList");
	}

	@RequestMapping(value = "/accessDenied", method = RequestMethod.GET)
	public String accessDenied(HttpServletRequest request, HttpServletResponse response) {
		String mav = "accessDenied";
		return mav;
	}

	@RequestMapping(value = "/sendMail", method = RequestMethod.GET)
	public @ResponseBody String sendMail(HttpServletRequest request, HttpServletResponse response) {
		final String emailSMTPserver = "smtp.gmail.com";
		final String emailSMTPPort = "587";
		final String mailStoreType = "imaps";

		final String username = "purchase.monginis1@gmail.com";
		final String password = "purchase1234#";

		/*
		 * final String username = "akshaykasar72@gmail.com"; final String password =
		 * "Mh151772";
		 */

		System.out.println("username** " + username);
		System.out.println("password** " + password);

		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.starttls.enable", "true");

		/*
		 * Session session = Session.getDefaultInstance(props, new
		 * javax.mail.Authenticator() { protected PasswordAuthentication
		 * getPasswordAuthentication() { return new PasswordAuthentication(username,
		 * password); } });
		 * 
		 * try { Store mailStore = session.getStore(mailStoreType);
		 * mailStore.connect(emailSMTPserver, username, password);
		 * 
		 * String subject = " Order For ";
		 * 
		 * Message mimeMessage = new MimeMessage(session); mimeMessage.setFrom(new
		 * InternetAddress(username)); //
		 * mimeMessage.setRecipients(Message.RecipientType.TO, //
		 * InternetAddress.parse(vendorList.getVendorEmail()));
		 * mimeMessage.setRecipients(Message.RecipientType.TO,
		 * InternetAddress.parse("akshaykasar72@gmail.com"));
		 * mimeMessage.setSubject(subject); mimeMessage.setFileName("PO Print");
		 * Multipart multipart = new MimeMultipart();
		 * 
		 * MimeBodyPart messageBodyPart = new MimeBodyPart(); messageBodyPart = new
		 * MimeBodyPart(); StringBuilder sb = new StringBuilder();
		 * sb.append("<html><body style='color : blue;'>"); sb.append("Dear Sir, <br>" +
		 * "	Kindly dispatch the goods as per attached PO. We have changed our system as per FSSAI gudlines. Kindly follow following instructions while dispatching the material.<br>"
		 * +
		 * "	1. COA-Chemical Analysis Report is compulsory with all the raw materials. Kindly note that if COA is not sent, payment will be delayed.<br>"
		 * +
		 * "	2. New Software has been installed at our end, so send material as per PO quantity only. If excess material is sent we will not be able to accept it, as there is no facility in new software to inward excess material.<br>"
		 * + "	3. All bills shall compulsory carry our PO number. <br>" +
		 * "	4. All bills shall compulsory carry your FDA/ FSSAI license no. (This is important if your are supplying edible raw material which is used as raw material in our manufacturing process). Note that if your bill is without FSSAI no your payment will be put on hold.<br>\r\n"
		 * + "	<br>" + "	<br>" + "	डिअर सर, <br>" +
		 * "	माल पाठविताना खालील पॉईंट्स वर कृपया लक्ष द्यावे-- <br>" +
		 * "	1. मटेरियल सोबात COA (केमिकल अनेलीसिस ) रिपोर्ट पाठवणे. COA मटेरियल सोबत नाही आला तर, पेमेंट मध्ये दिरंगाई होईल याची नोंद घ्यावी.<br>"
		 * +
		 * "	2. परचेस ऑर्डर मध्ये जि Quantity आहे त्यानुसार बिल बनवणे, Quantity जर परचेस ऑर्डर नुसार जास्त आली तर माल परत केला जाईल ,कारण लक्षात घ्या आमच्या कडे नवीन सॉफ्टवेअर इन्स्टॉल केला आहे व त्या मध्ये परचेस ऑर्डर च्या जास्त माल इनवॉर्ड करता येत नाही.<br>"
		 * +
		 * "	३. आमच्या कडे नवीन सॉफ्टवेअर इन्स्टॉल झाल्या कारणाने, बिल बनवतानी परचेसे ऑर्डर नंबर टाकणे आवश्यक आहे  <br>"
		 * +
		 * "	4. तुम्ही जर आम्हाला खाद्य पदार्थ पाठवत/ सप्लाय  असाल तर तुमचा FSSAI license no तुमच्या बिलावर येणे अनिवार्य आहे.बिना FSSAI license नो च्या बिल आल्यास पेमेंट होल्ड वर जाईल."
		 * );
		 * 
		 * sb.append("</body></html>"); messageBodyPart.setContent("" + sb,
		 * "text/html; charset=utf-8"); multipart.addBodyPart(messageBodyPart);
		 * mimeMessage.setContent(multipart);
		 * 
		 * Transport.send(mimeMessage); } catch (Exception e) {
		 * 
		 * e.printStackTrace(); }
		 */
		return "success";
	}

	@RequestMapping(value = "/downloadFile", method = RequestMethod.GET)
	public @ResponseBody String downloadFile(HttpServletRequest request, HttpServletResponse response) {

		try {
			/*
			 * URL url = new
			 * URL("http://97.74.228.55:8080/uploads/ITEM/15:03:14-download.jpg");
			 * URLConnection connection = url.openConnection(); InputStream is =
			 * connection.getInputStream();
			 */

			String dataDirectory = "/home/lenovo/Downloads/";
			/* request.getServletContext().getRealPath("/WEB-INF/downloads/pdf/"); */
			String fileName = "8_StandardReport.xls";
			Path file = Paths.get(dataDirectory, fileName);
			if (Files.exists(file)) {
				response.setContentType("application/pdf");
				response.addHeader("Content-Disposition", "attachment; filename=" + fileName);
				try {
					Files.copy(file, response.getOutputStream());
					response.getOutputStream().flush();
				} catch (IOException ex) {
					ex.printStackTrace();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

}

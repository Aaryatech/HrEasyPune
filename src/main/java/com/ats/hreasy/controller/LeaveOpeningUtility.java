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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ats.hreasy.common.Constants;
import com.ats.hreasy.common.DateConvertor;
import com.ats.hreasy.common.FormValidation;
import com.ats.hreasy.common.UpateAttendaceCommon;
import com.ats.hreasy.common.VpsImageUpload;
import com.ats.hreasy.model.CalenderYear;
import com.ats.hreasy.model.GetAuthorityIds;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.LeaveApply;
import com.ats.hreasy.model.LeaveTrail;
import com.ats.hreasy.model.LoginResponse;
import com.ats.hreasy.model.OpeningPendingLeaveEmployeeList;
import com.ats.hreasy.model.Setting;

@Controller
@Scope("session")
public class LeaveOpeningUtility {

	List<OpeningPendingLeaveEmployeeList> list = new ArrayList<OpeningPendingLeaveEmployeeList>();

	@RequestMapping(value = "/applyPreviousLeave", method = RequestMethod.GET)
	public String applyPreviousLeave(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "leave/previousLeaveUtility";
		try {
			HttpSession session = request.getSession();
			int locId = (int) session.getAttribute("liveLocationId");

			CalenderYear calculateYear = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getCalculateYearListIsCurrent", CalenderYear.class);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("locId", locId);
			map.add("yearId", calculateYear.getCalYrId());
			OpeningPendingLeaveEmployeeList[] employeeDoc = Constants.getRestTemplate().postForObject(
					Constants.url + "/getEmplistForOpeningLeave", map, OpeningPendingLeaveEmployeeList[].class);

			list = new ArrayList<OpeningPendingLeaveEmployeeList>(Arrays.asList(employeeDoc));

			model.addAttribute("list", list);

		} catch (Exception e) {

			e.printStackTrace();
		}

		return mav;

	}

	@RequestMapping(value = "/submitPriviousLeave", method = RequestMethod.POST)
	public String insertOpningLeave(HttpServletRequest request, HttpServletResponse response) {
		String empId1 = request.getParameter("empId");
		HttpSession session = request.getSession();
		
		try {

			CalenderYear calculateYear = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getCalculateYearListIsCurrent", CalenderYear.class);

			
			Date date = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");

			/*
			 * float noOfDays = Float.parseFloat(request.getParameter("noOfDays")); int
			 * empId = Integer.parseInt(request.getParameter("empId"));
			 */
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map = new LinkedMultiValueMap<>();
			map.add("limitKey", "OPENING_LEAVE_DATE");
			Setting OPENING_LEAVE_DATE = Constants.getRestTemplate().postForObject(Constants.url + "/getSettingByKey",
					map, Setting.class);

			String[] dt = OPENING_LEAVE_DATE.getValue().split("to");

			List<LeaveApply>  save = new ArrayList<>();
			
			for (int i = 0; i < list.size(); i++) {
				LeaveApply leaveSummary = new LeaveApply();
				leaveSummary.setLeaveId(list.get(i).getLeaveId());
				leaveSummary.setCalYrId(calculateYear.getCalYrId());
				leaveSummary.setEmpId(list.get(i).getEmpId());
				leaveSummary.setLvTypeId(list.get(i).getLvTypeId());
				leaveSummary.setFinalStatus(1);
				leaveSummary.setLeaveNumDays(Float.parseFloat(
						request.getParameter("noOfDay" + list.get(i).getEmpId() + "" + list.get(i).getLvTypeId())));
				leaveSummary.setCirculatedTo("1");
				leaveSummary.setLeaveDuration("1");
				leaveSummary.setLeaveEmpReason("FOR OPENING");

				leaveSummary.setLeaveFromdt(DateConvertor.convertToYMD(dt[0]));
				leaveSummary.setLeaveTodt(DateConvertor.convertToYMD(dt[1]));

				leaveSummary.setExInt1(3);
				leaveSummary.setExInt2(1);
				leaveSummary.setExInt3(1);
				leaveSummary.setExVar1("NA");
				leaveSummary.setExVar3("");
				leaveSummary.setIsActive(1);
				leaveSummary.setDelStatus(1);
				leaveSummary.setMakerUserId(userObj.getUserId());
				leaveSummary.setMakerEnterDatetime(sf.format(date));
				save.add(leaveSummary);
				 
				/*
				 * if (res != null) { LeaveTrail lt = new LeaveTrail();
				 * lt.setEmpRemarks("FOR OPENING"); lt.setLeaveId(res.getLeaveId());
				 * lt.setLeaveStatus(3); lt.setEmpId(list.get(i).getEmpId()); lt.setExInt1(1);
				 * lt.setExInt2(1); lt.setExInt3(1); lt.setExVar1("NA"); lt.setExVar2("NA");
				 * lt.setExVar3("NA");
				 * 
				 * lt.setMakerUserId(userObj.getUserId());
				 * lt.setMakerEnterDatetime(sf.format(date)); LeaveTrail res1 =
				 * Constants.getRestTemplate().postForObject(Constants.url + "/saveLeaveTrail",
				 * lt, LeaveTrail.class); map = new LinkedMultiValueMap<>(); map.add("leaveId",
				 * res.getLeaveId()); map.add("trailId", res1.getTrailPkey()); Info info =
				 * Constants.getRestTemplate().postForObject(Constants.url + "/updateTrailId",
				 * map, Info.class); }
				 */
			}
			LeaveApply[] res = Constants.getRestTemplate().postForObject(Constants.url + "/saveLeaveApplyList",
					save, LeaveApply[].class);
			
			if (res != null) {
				session.setAttribute("successMsg", "Update leave opening Successfully.");
			} else {
				session.setAttribute("errorMsg", "Failed to update leave opening");
			}
		} catch (Exception e) {
			session.setAttribute("errorMsg", "Failed to update leave opening");
			e.printStackTrace();
		}

		// return "redirect:/showApplyForLeave";
		return "redirect:/applyPreviousLeave";

	}

}

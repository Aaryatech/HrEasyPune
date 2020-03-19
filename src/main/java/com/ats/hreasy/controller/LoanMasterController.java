package com.ats.hreasy.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ats.hreasy.common.AcessController;
import com.ats.hreasy.common.Constants;
import com.ats.hreasy.common.FormValidation;
import com.ats.hreasy.model.AccessRightModule;
import com.ats.hreasy.model.GetEmployeeDetails;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.Setting;
import com.ats.hreasy.model.Loan.LoanMain;

@Controller
@Scope("session")
public class LoanMasterController {

	@RequestMapping(value = "/showCalLoan", method = RequestMethod.GET)
	public ModelAndView showAddAdvance(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		ModelAndView model = null;

		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("showCalLoan", "showEmpListToAddLoan", 0, 0, 1, 0, newModuleList);

		if (view.isError() == true) {

			model = new ModelAndView("accessDenied");

		} else {
			model = new ModelAndView("Loan/calLoan");
			Date date = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("dd-MM-yyyy");
			try {

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("limitKey", "loan_number");
				Setting getSettingByKey = Constants.getRestTemplate().postForObject(Constants.url + "/getSettingByKey",
						map, Setting.class);

				model.addObject("appNo", getSettingByKey.getValue());

				String base64encodedString = request.getParameter("empId");
				String empTypeId = FormValidation.DecodeKey(base64encodedString);

				map = new LinkedMultiValueMap<>();
				map.add("empId", empTypeId);
				GetEmployeeDetails empPersInfo = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getAllEmployeeDetailByEmpId", map, GetEmployeeDetails.class);
				// System.out.println("Edit EmpPersonal Info-------"+ empPersInfo.toString());

				String empPersInfoString = empPersInfo.getEmpCode().concat(" ").concat(empPersInfo.getFirstName())
						.concat(" ").concat(empPersInfo.getSurname()).concat(" [").concat(empPersInfo.getEmpDesgn())
						.concat("]");
				model.addObject("empPersInfo", empPersInfo);
				model.addObject("empPersInfoString", empPersInfoString);
				model.addObject("todaysDate", sf.format(date));

				map = new LinkedMultiValueMap<>();
				map.add("empId", empTypeId);
				LoanMain empPersInfo1 = Constants.getRestTemplate().postForObject(Constants.url + "/getEmpLoanHistory",
						map, LoanMain.class);

				model.addObject("prevLoan", empPersInfo1);

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return model;
	}
}

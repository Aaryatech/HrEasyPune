package com.ats.hreasy.controller;

import java.awt.Dimension;
import java.awt.Insets;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.zefer.pd4ml.PD4Constants;
import org.zefer.pd4ml.PD4ML;
import org.zefer.pd4ml.PD4PageMark;

import com.ats.hreasy.common.Constants;
import com.ats.hreasy.common.FormValidation;
import com.ats.hreasy.model.EmpDetailForLetters;
import com.ats.hreasy.model.GetEmployeeDetails;
import com.ats.hreasy.model.GetPayrollGeneratedList;
import com.ats.hreasy.model.MstCompanySub;
import com.ats.hreasy.model.PayRollDataForProcessing;
import com.ats.hreasy.model.Setting;

@Controller
@Scope("session")
public class GenerateLetters {

	@RequestMapping(value = "/generateLetters", method = RequestMethod.GET)
	public String showEmpListForFullnfinal(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = new String();

		try {
			mav = "letter/generateLetters";
			String base64encodedString = request.getParameter("empId");
			String empId = FormValidation.DecodeKey(base64encodedString);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("empId", empId);
			EmpDetailForLetters empDetail = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getEmpDetailForGenrateLetters", map, EmpDetailForLetters.class);
			model.addAttribute("empDetail", empDetail);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/pdf/gernerateApologyletterAbsent/{empId}/{date}/{fromdate}/{toDate}/{noOfDays}", method = RequestMethod.GET)
	public ModelAndView gernerateApologyletterAbsent(@PathVariable int empId, @PathVariable String date,
			@PathVariable String fromdate, @PathVariable String toDate, @PathVariable int noOfDays,
			HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("letter/gernerateApologyletterAbsent");
		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("empId", empId);
			EmpDetailForLetters empDetail = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getEmpDetailForGenrateLetters", map, EmpDetailForLetters.class);
			model.addObject("empDetail", empDetail);
			model.addObject("noOfDays", noOfDays);

			SimpleDateFormat name_date = new SimpleDateFormat("dd-MMM-yyyy", Locale.ENGLISH);
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
			Date fmdt = sdf.parse(fromdate);
			model.addObject("fromdate", name_date.format(fmdt));

			Date todt = sdf.parse(toDate);
			model.addObject("toDate", name_date.format(todt));

			Date dt = sdf.parse(date);
			model.addObject("date", name_date.format(dt));

			// System.out.println(list);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping(value = "/pdf/gernerateApologyletterMisbehaviour/{empId}/{date}/{fromdate}/{reason}", method = RequestMethod.GET)
	public ModelAndView gernerateApologyletterMisbehaviour(@PathVariable int empId, @PathVariable String date,
			@PathVariable String fromdate, @PathVariable String reason, HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView model = new ModelAndView("letter/gernerateApologyletterMisbehaviour");
		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("empId", empId);
			EmpDetailForLetters empDetail = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getEmpDetailForGenrateLetters", map, EmpDetailForLetters.class);
			model.addObject("empDetail", empDetail);
			model.addObject("reason", reason);

			SimpleDateFormat name_date = new SimpleDateFormat("dd-MMM-yyyy", Locale.ENGLISH);
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
			Date fmdt = sdf.parse(fromdate);
			model.addObject("fromdate", name_date.format(fmdt));
  
			Date dt = sdf.parse(date);
			model.addObject("date", name_date.format(dt));

			// System.out.println(list);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

}

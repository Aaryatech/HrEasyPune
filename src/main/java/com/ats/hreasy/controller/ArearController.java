package com.ats.hreasy.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ats.hreasy.common.AcessController;
import com.ats.hreasy.common.Constants;
import com.ats.hreasy.common.DateConvertor;
import com.ats.hreasy.common.ExceUtil;
import com.ats.hreasy.common.ExportToExcel;
import com.ats.hreasy.common.ReportCostants;
import com.ats.hreasy.model.AccessRightModule;
import com.ats.hreasy.model.Allowances;
import com.ats.hreasy.model.AssetVendor;
import com.ats.hreasy.model.EmpInfoForArear;
import com.ats.hreasy.model.EmpSalInfoDaiyInfoTempInfo;
import com.ats.hreasy.model.EmpSalaryInfoForPayroll;
import com.ats.hreasy.model.GetEmpDetail;
import com.ats.hreasy.model.GetEmployeeDetails;
import com.ats.hreasy.model.GetSalDynamicTempRecord;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.Location;
import com.ats.hreasy.model.LoginResponse;
import com.ats.hreasy.model.PayRollDataForProcessing;
import com.ats.hreasy.model.Setting;
import com.ats.hrmgt.model.assets.AMCExpirationDetail;
import com.ats.hrmgt.model.assets.AssetNotificatn;
import com.ats.hrmgt.model.assets.ServicingDashDetails;

@Controller
@Scope("session")
public class ArearController {

	List<EmpInfoForArear> empInfoForArearlist = new ArrayList<>();
	String fromMonth;
	String toMonth;
	List<Allowances> allowanceList = new ArrayList<Allowances>();

	@RequestMapping(value = "/empListForArear", method = RequestMethod.GET)
	public String assetsDashboard(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "arear/empListForArear";
		HttpSession session = request.getSession();

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

		LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");
		try {

			int locId = (int) session.getAttribute("liveLocationId");

			map.add("locId", locId);
			PayRollDataForProcessing payRollDataForProcessing = Constants.getRestTemplate().postForObject(
					Constants.url + "/getEmployeeListWithEmpSalEnfoForArrear", map, PayRollDataForProcessing.class);
			List<EmpSalaryInfoForPayroll> list = payRollDataForProcessing.getList();

			model.addAttribute("empList", list);
			model.addAttribute("editAccess", 0);
			model.addAttribute("allownceList", payRollDataForProcessing.getAllowancelist());
			/*
			 * empdetList.stream().forEach(games -> {
			 * 
			 * });
			 */

		} catch (Exception e) {

		}
		return mav;
	}

	@RequestMapping(value = "/calculationArears", method = RequestMethod.POST)
	public String calculationArears(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "arear/calculationArears";

		try {
			HttpSession session = request.getSession();
			LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");
			String fromMonth = request.getParameter("fromMonth");
			String toMonth = request.getParameter("toMonth");
			String[] selectEmp = request.getParameterValues("selectEmp");
			String empIds = "0";

			for (int i = 0; i < selectEmp.length; i++) {
				empIds = empIds + "," + selectEmp[i];
			}
			empIds = empIds.substring(2, empIds.length());

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("fromDate", DateConvertor.convertToYMD("01-" + fromMonth));
			map.add("toDate", DateConvertor.convertToYMD("01-" + toMonth));
			map.add("empIds", empIds);

			EmpInfoForArear[] getSalDynamicTempRecord = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getPayrollGenratedListforarear", map, EmpInfoForArear[].class);
			empInfoForArearlist = new ArrayList<>(Arrays.asList(getSalDynamicTempRecord));
			model.addAttribute("empList", empInfoForArearlist);

			model.addAttribute("fromMonth", fromMonth);
			model.addAttribute("toMonth", toMonth);

			Allowances[] allowanceArr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllAllowances",
					Allowances[].class);
			allowanceList = new ArrayList<Allowances>(Arrays.asList(allowanceArr));

			model.addAttribute("allowanceList", allowanceList);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/excelForArears", method = RequestMethod.GET)
	public void excelForArears(HttpServletRequest request, HttpServletResponse response) {

		try {

			String reportName = "Arrears Calculation for " + fromMonth + " To " + toMonth;

			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();

			rowData.add("EMP Name");
			rowData.add("Department");
			rowData.add("Designation");
			rowData.add("Month");
			rowData.add("Payable Days");
			rowData.add("Total DIFF");
			rowData.add("Net AMT");
			rowData.add("Basic Old");
			rowData.add("Basic Current");
			rowData.add("Basic Diff");
			rowData.add("Basic CAL");
			// rowData.add("Allowance");
			for (int i = 0; i < allowanceList.size(); i++) {
				rowData.add(allowanceList.get(i).getName() + " Old");
				rowData.add(allowanceList.get(i).getName() + " Current");
				rowData.add(allowanceList.get(i).getName() + " Diff");
				rowData.add(allowanceList.get(i).getName() + " CAL");
			}

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

			for (int i = 0; i < empInfoForArearlist.size(); i++) {

				if (empInfoForArearlist.get(i).getGeneratedPayrollList().size() > 0) {

					double basicOldTotal = 0;
					double basicCurrentTotal = 0;
					double basicDiffTotal = 0;
					double basicCalTotal = 0;

					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();

					rowData.add("" + empInfoForArearlist.get(i).getEmpName() + " ("
							+ empInfoForArearlist.get(i).getEmpCode() + ")");
					rowData.add("" + empInfoForArearlist.get(i).getDeptName());
					rowData.add("" + empInfoForArearlist.get(i).getDesignation());
					rowData.add("");
					rowData.add("");
					rowData.add("");
					rowData.add("");
					rowData.add("");
					rowData.add("");
					rowData.add("");
					rowData.add("");
					for (int j = 0; j < allowanceList.size(); j++) {
						rowData.add("");
						rowData.add("");
						rowData.add("");
						rowData.add("");
					}

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

					for (int j = 0; j < empInfoForArearlist.get(i).getGeneratedPayrollList().size(); j++) {
						expoExcel = new ExportToExcel();
						rowData = new ArrayList<String>();

						rowData.add("");
						rowData.add("");
						rowData.add("");
						rowData.add("" + empInfoForArearlist.get(i).getGeneratedPayrollList().get(j).getEmail());
						rowData.add("" + empInfoForArearlist.get(i).getGeneratedPayrollList().get(j).getPayableDays());
						rowData.add("" + empInfoForArearlist.get(i).getGeneratedPayrollList().get(j).getSalTotalDiff());
						rowData.add("" + empInfoForArearlist.get(i).getGeneratedPayrollList().get(j).getNetCalArear());
						rowData.add("" + empInfoForArearlist.get(i).getGeneratedPayrollList().get(j).getBasicCal());
						rowData.add("" + empInfoForArearlist.get(i).getGeneratedPayrollList().get(j).getBasicDefault());
						rowData.add("" + empInfoForArearlist.get(i).getGeneratedPayrollList().get(j).getSalBasicDiff());
						rowData.add(
								"" + empInfoForArearlist.get(i).getGeneratedPayrollList().get(j).getBasicCalArear());

						basicOldTotal = basicOldTotal
								+ empInfoForArearlist.get(i).getGeneratedPayrollList().get(j).getBasicCal();
						basicCurrentTotal = basicCurrentTotal
								+ empInfoForArearlist.get(i).getGeneratedPayrollList().get(j).getBasicDefault();
						basicDiffTotal = basicDiffTotal
								+ empInfoForArearlist.get(i).getGeneratedPayrollList().get(j).getSalBasicDiff();
						basicCalTotal = basicCalTotal
								+ empInfoForArearlist.get(i).getGeneratedPayrollList().get(j).getBasicCalArear();

						for (int m = 0; m < allowanceList.size(); m++) {
							for (int k = 0; k < empInfoForArearlist.get(i).getGeneratedPayrollList().get(j)
									.getDifAlloList().size(); k++) {

								if (empInfoForArearlist.get(i).getGeneratedPayrollList().get(j).getDifAlloList().get(k)
										.getAllowanceId() == allowanceList.get(m).getAllowanceId()) {
									rowData.add("" + empInfoForArearlist.get(i).getGeneratedPayrollList().get(j)
											.getDifAlloList().get(k).getAllowanceValueCal());
									rowData.add("" + empInfoForArearlist.get(i).getGeneratedPayrollList().get(j)
											.getDifAlloList().get(k).getAllowanceValue());
									rowData.add("" + empInfoForArearlist.get(i).getGeneratedPayrollList().get(j)
											.getDifAlloList().get(k).getAllowanceDifference());
									rowData.add("" + empInfoForArearlist.get(i).getGeneratedPayrollList().get(j)
											.getDifAlloList().get(k).getArearCal());
									break;
								}

							}
						}
						expoExcel.setRowData(rowData);
						exportToExcelList.add(expoExcel);

					}
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();

					rowData.add("");
					rowData.add("");
					rowData.add("");
					rowData.add("Total");
					rowData.add("");
					rowData.add("");
					rowData.add("");
					rowData.add("" + basicOldTotal);
					rowData.add("" + basicCurrentTotal);
					rowData.add("" + basicDiffTotal);
					rowData.add("" + basicCalTotal); 
					for (int m = 0; m < allowanceList.size(); m++) {
						rowData.add("");
						rowData.add("");
						rowData.add("");
						rowData.add("");
					}

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);
				}
			}

			XSSFWorkbook wb = null;
			try {
				// System.out.println("exportToExcelList" + exportToExcelList.toString());

				wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName, " ", "", 'Z');

				ExceUtil.autoSizeColumns(wb, 3);
				response.setContentType("application/vnd.ms-excel");
				String date = new SimpleDateFormat("yyyy_MM_dd_hh:mm:ss").format(new Date());
				response.setHeader("Content-disposition", "attachment; filename=" + reportName + "-" + date + ".xlsx");
				wb.write(response.getOutputStream());

			} catch (IOException ioe) {
				throw new RuntimeException("Error writing spreadsheet to output stream");
			} finally {
				if (wb != null) {
					wb.close();
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}

	}

}

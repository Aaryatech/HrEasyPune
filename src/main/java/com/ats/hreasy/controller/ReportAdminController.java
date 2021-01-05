package com.ats.hreasy.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ats.hreasy.common.AcessController;
import com.ats.hreasy.common.Constants;
import com.ats.hreasy.common.DateConvertor;
import com.ats.hreasy.common.EnglishNumberToWords;
import com.ats.hreasy.common.ExceUtil;
import com.ats.hreasy.common.ExportToExcel;
import com.ats.hreasy.common.ItextPageEvent;
import com.ats.hreasy.common.ReportCostants;
import com.ats.hreasy.model.AccessRightModule;
import com.ats.hreasy.model.Bank;
import com.ats.hreasy.model.BankTrasferReport;
import com.ats.hreasy.model.CalenderYear;
import com.ats.hreasy.model.DailyAttendance;
import com.ats.hreasy.model.DateAndDay;
import com.ats.hreasy.model.EcrFileData;
import com.ats.hreasy.model.EmpLeaveHistoryRep;
import com.ats.hreasy.model.EmpSalAllowance;
import com.ats.hreasy.model.EmployeeMaster;
import com.ats.hreasy.model.GetDailyDailyRecord;
import com.ats.hreasy.model.GetDeptPayReport;
import com.ats.hreasy.model.GetEmployeeDetails;
import com.ats.hreasy.model.GetOnelineReport;
import com.ats.hreasy.model.GetPayrollGeneratedList;
import com.ats.hreasy.model.GetPfStatementSummary;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.LeaveApply;
import com.ats.hreasy.model.LeaveHistTemp;
import com.ats.hreasy.model.LoginResponse;
import com.ats.hreasy.model.LwfChallanData;
import com.ats.hreasy.model.MstCompanySub;
import com.ats.hreasy.model.PayDeductionDetails;
import com.ats.hreasy.model.PayRollDataForProcessing;
import com.ats.hreasy.model.SalaryRateData;
import com.ats.hreasy.model.Setting;
import com.ats.hreasy.model.Advance.AdvanceDetails;
import com.ats.hreasy.model.Advance.GetAdvance;
import com.ats.hreasy.model.Bonus.BonusCalc;
import com.ats.hreasy.model.Bonus.BonusMaster;
import com.ats.hreasy.model.report.EmpAttendeanceRep;
import com.ats.hreasy.model.report.EsiSumaryRep;
import com.ats.hreasy.model.report.GetLoanReport;
import com.ats.hreasy.model.report.GetPtChallan;
import com.ats.hreasy.model.report.GetSalaryCalcReport;
import com.ats.hreasy.model.report.GetYearlyAdvance;
import com.ats.hreasy.model.report.GetYearlyAdvanceNew;
import com.ats.hreasy.model.report.GetYearlyLoan;
import com.ats.hreasy.model.report.LoanDedReport;
import com.ats.hreasy.model.report.StatutoryEsicRep;
import com.ats.hrmgt.model.EmpOpningLoanList;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Font.FontFamily;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

@Controller
@Scope("session")
public class ReportAdminController {

	@RequestMapping(value = "/showReportsDashbord", method = RequestMethod.GET)
	public ModelAndView showQueryBasedReports(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = null;
		try {
			model = new ModelAndView("Report/repDash");
			HttpSession session = request.getSession();

			MstCompanySub[] company = Constants.getRestTemplate().getForObject(Constants.url + "/getAllSubCompanies",
					MstCompanySub[].class);

			List<MstCompanySub> companyList = new ArrayList<MstCompanySub>(Arrays.asList(company));
			model.addObject("companySubList", companyList);

			BonusMaster[] location = Constants.getRestTemplate().getForObject(Constants.url + "/getAllBonusList",
					BonusMaster[].class);
			List<BonusMaster> bonusList = new ArrayList<BonusMaster>(Arrays.asList(location));

			CalenderYear[] calenderYear = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getCalculateYearList", CalenderYear[].class);
			List<CalenderYear> calYearList = new ArrayList<CalenderYear>(Arrays.asList(calenderYear));

			model.addObject("calYearList", calYearList);

			model.addObject("bonusList", bonusList);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("companyId", 1);
			Bank[] bank = Constants.getRestTemplate().postForObject(Constants.url + "/getAllBanks", map, Bank[].class);
			List<Bank> bankList = new ArrayList<Bank>(Arrays.asList(bank));
			model.addObject("bankList", bankList);

		} catch (Exception e) {

			System.err.println("Exce in showReports " + e.getMessage());
			e.printStackTrace();

		}

		return model;
	}

	@RequestMapping(value = "/showAdvancePaymentRep", method = RequestMethod.GET)
	public void showStudentParticipatedNssNccReport(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Employee Advance Payment";

		HttpSession session = request.getSession();

		String month = request.getParameter("date");

		String temp[] = month.split("-");

		try {

			int locId = (int) session.getAttribute("liveLocationId");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("companyId", 1);
			map.add("month", temp[0]);
			map.add("year", temp[1]);
			map.add("locId", locId);
			GetAdvance[] resArray = Constants.getRestTemplate().postForObject(Constants.url + "getAdvanceReport", map,
					GetAdvance[].class);
			List<GetAdvance> progList = new ArrayList<>(Arrays.asList(resArray));

			String header = "";
			String title = "                 ";

			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			Document document = new Document(PageSize.A4);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(6);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 2.0f, 3.0f, 5.5f, 3.0f, 3.0f, 3.0f });
			Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
			// BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																	// BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Code", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Advance Date", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Advance Amt", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Is Ded", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			int index = 0;
			for (int i = 0; i < progList.size(); i++) {
				// System.err.println("I " + i);
				GetAdvance prog = progList.get(i);

				index++;
				PdfPCell cell;
				cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpCode(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(
						new Phrase("" + prog.getFirstName().concat(" ").concat(prog.getSurname()), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getAdvDate(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getAdvAmount(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getExVar1(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

			}

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));
			document.add(new Paragraph("Month-Year: " + month));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p"));
			// System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Sr. No");
				rowData.add("Emp Code");
				rowData.add("Emp Name");
				rowData.add("Adv Date");
				rowData.add("Adv Amount");
				rowData.add("Is Ded");

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;
				for (int i = 0; i < progList.size(); i++) {
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					cnt = cnt + i;

					rowData.add("" + (i + 1));
					rowData.add("" + progList.get(i).getEmpCode());
					rowData.add("" + progList.get(i).getFirstName().concat(" ").concat(progList.get(i).getSurname()));
					rowData.add("" + progList.get(i).getAdvDate());
					rowData.add("" + progList.get(i).getAdvAmount());
					rowData.add("" + progList.get(i).getExVar1());

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

				}

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName, "Month-Year:" + month, "", 'F');

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/payOneLineReportExcel", method = RequestMethod.GET)
	public void payOneLineReportExcel(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		String month = request.getParameter("date");

		String temp[] = month.split("-");
		String reportName = "Pay Register For the Month of" + month;
		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("limitKey", "ab_deduction");
			Setting abDeduction = Constants.getRestTemplate().postForObject(Constants.url + "/getSettingByKey", map,
					Setting.class);
			int ab_deduction = Integer.parseInt(abDeduction.getValue());

			map = new LinkedMultiValueMap<String, Object>();
			map.add("limitKey", "ammount_format_show");
			Setting getSettingByKey = Constants.getRestTemplate().postForObject(Constants.url + "/getSettingByKey", map,
					Setting.class);
			int amount_round = Integer.parseInt(getSettingByKey.getValue());

			map = new LinkedMultiValueMap<String, Object>();
			map.add("group", "PAYROLLHIDESHOW");
			Setting[] setting = Constants.getRestTemplate().postForObject(Constants.url + "/getSettingListByGroup", map,
					Setting[].class);
			List<Setting> settingList = new ArrayList<>(Arrays.asList(setting));

			int payroll_claim_show = 0;
			int payroll_advance_show = 0;
			int payroll_loan_show = 0;
			int payroll_payded_show = 0;
			int payroll_reward_show = 0;
			int payroll_bhatta_show = 0;

			for (int k = 0; k < settingList.size(); k++) {
				if (settingList.get(k).getKey().equalsIgnoreCase("payroll_claim_show")) {
					payroll_claim_show = Integer.parseInt(settingList.get(k).getValue());
				} else if (settingList.get(k).getKey().equalsIgnoreCase("payroll_advance_show")) {
					payroll_advance_show = Integer.parseInt(settingList.get(k).getValue());
				} else if (settingList.get(k).getKey().equalsIgnoreCase("payroll_loan_show")) {
					payroll_loan_show = Integer.parseInt(settingList.get(k).getValue());
				} else if (settingList.get(k).getKey().equalsIgnoreCase("payroll_payded_show")) {
					payroll_payded_show = Integer.parseInt(settingList.get(k).getValue());
				} else if (settingList.get(k).getKey().equalsIgnoreCase("payroll_reward_show")) {
					payroll_reward_show = Integer.parseInt(settingList.get(k).getValue());
				} else if (settingList.get(k).getKey().equalsIgnoreCase("payroll_bhatta_show")) {
					payroll_bhatta_show = Integer.parseInt(settingList.get(k).getValue());
				}
			}

			int locId = (int) session.getAttribute("liveLocationId");
			map = new LinkedMultiValueMap<String, Object>();

			map.add("month", temp[0]);
			map.add("year", temp[1]);
			map.add("locId", locId);
			PayRollDataForProcessing payRollDataForProcessing = Constants.getRestTemplate()
					.postForObject(Constants.url + "getPayOneLineReport", map, PayRollDataForProcessing.class);
			List<GetOnelineReport> list = payRollDataForProcessing.getOnelinereportlist();

			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();

			// rowData.add("Sr. No");
			rowData.add("EMP Code");
			rowData.add("EMP Name");
			rowData.add("Date of Joining");
			rowData.add("Gender");
			rowData.add("Department");
			rowData.add("Designation");
			rowData.add("EMP Type");

			rowData.add("Payable Days");
			rowData.add("Present Days");
			rowData.add("W/O");
			// rowData.add("Gross Salary");
			rowData.add("Basic");
			for (int i = 0; i < payRollDataForProcessing.getAllowancelist().size(); i++) {
				rowData.add("" + payRollDataForProcessing.getAllowancelist().get(i).getName() + " Rate");
				rowData.add("" + payRollDataForProcessing.getAllowancelist().get(i).getName() + " Value");
				payRollDataForProcessing.getAllowancelist().get(i).setGrossSalPer(0);
				payRollDataForProcessing.getAllowancelist().get(i).setTaxPer(0);
			}

			if (ab_deduction == 1) {
				rowData.add("Absent Deduction");
			}
			rowData.add("Total Earning Rate");
			rowData.add("Total Earning Value");

			if (payroll_claim_show == 1) {
				rowData.add("Claim ADD");
			}

			rowData.add("Production Incentive");
			rowData.add("Performance Incentive");
			rowData.add("Night Allowance");
			rowData.add("Performance Bonus");

			if (payroll_bhatta_show == 1) {
				rowData.add("Bhatta");
			}
			rowData.add("Other1");
			if (payroll_reward_show == 1) {
				rowData.add("Reward");
			}
			if (payroll_advance_show == 1) {
				rowData.add("Adv");
			}
			if (payroll_loan_show == 1) {
				rowData.add("Loan");
			}

			rowData.add("TDS");
			if (payroll_payded_show == 1) {
				rowData.add("Pay Ded");
			}

			rowData.add("PT");
			rowData.add("PF");
			rowData.add("ESIC");
			rowData.add("LWF");
			/* rowData.add("Society Contribution"); */
			rowData.add("Deduction AMT");
			rowData.add("Net Salary");

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);
			int cnt = 1;
			for (int i = 0; i < list.size(); i++) {
				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				cnt = cnt + i;

				// rowData.add("" + (i + 1));
				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				// rowData.add("" + cnt);
				rowData.add("" + list.get(i).getEmpCode());
				rowData.add("" + list.get(i).getName());
				rowData.add("" + list.get(i).getCmpJoiningDate());
				rowData.add("" + list.get(i).getGender());

				rowData.add("" + list.get(i).getDepartName());
				rowData.add("" + list.get(i).getDesignName());
				rowData.add("" + list.get(i).getEmpTypeName());

				rowData.add("" + list.get(i).getPayableDays());
				rowData.add("" + list.get(i).getPresentDays());
				rowData.add("" + list.get(i).getWeeklyOff());

				rowData.add(
						"" + String.format("%.2f", ReportCostants.castNumber(list.get(i).getBasicCal(), amount_round)));

				for (int k = 0; k < payRollDataForProcessing.getAllowancelist().size(); k++) {
					int find = 0;
					for (int j = 0; j < list.get(i).getPayrollAllownceList().size(); j++) {
						if (list.get(i).getPayrollAllownceList().get(j).getAllowanceId() == payRollDataForProcessing
								.getAllowancelist().get(k).getAllowanceId()) {
							rowData.add(String.format("%.2f", ReportCostants.castNumber(
									list.get(i).getPayrollAllownceList().get(j).getAllowanceValue(), amount_round)));
							rowData.add(String.format("%.2f", ReportCostants.castNumber(
									list.get(i).getPayrollAllownceList().get(j).getAllowanceValueCal(), amount_round)));
							payRollDataForProcessing.getAllowancelist().get(k).setGrossSalPer(
									(float) (payRollDataForProcessing.getAllowancelist().get(k).getGrossSalPer()
											+ list.get(i).getPayrollAllownceList().get(j).getAllowanceValue()));
							payRollDataForProcessing.getAllowancelist().get(k)
									.setTaxPer((float) (payRollDataForProcessing.getAllowancelist().get(k).getTaxPer()
											+ list.get(i).getPayrollAllownceList().get(j).getAllowanceValueCal()));
							find = 1;
							break;

						}
					}
					if (find == 0) {
						rowData.add(String.format("%.2f", ReportCostants.castNumber(0, amount_round)));
						rowData.add(String.format("%.2f", ReportCostants.castNumber(0, amount_round)));
					}

				}

				if (ab_deduction == 1) {

					rowData.add("" + String.format("%.2f",
							ReportCostants.castNumber(list.get(i).getAbDeduction(), amount_round)));

				}

				rowData.add("" + String.format("%.2f",
						ReportCostants.castNumber(list.get(i).getGrossSalDefault(), amount_round)));
				rowData.add(""
						+ String.format("%.2f", ReportCostants.castNumber(list.get(i).getGrossSalary(), amount_round)));

				if (payroll_claim_show == 1) {

					rowData.add("" + String.format("%.2f",
							ReportCostants.castNumber(list.get(i).getMiscExpAdd(), amount_round)));

				}

				rowData.add(
						"" + String.format("%.2f", ReportCostants.castNumber(list.get(i).getOtWages(), amount_round)));
				rowData.add("" + String.format("%.2f",
						ReportCostants.castNumber(list.get(i).getProductionInsentive(), amount_round)));
				rowData.add(""
						+ String.format("%.2f", ReportCostants.castNumber(list.get(i).getNightAllow(), amount_round)));

				rowData.add("" + String.format("%.2f",
						ReportCostants.castNumber(list.get(i).getPerformanceBonus(), amount_round)));

				if (payroll_bhatta_show == 1) {
					rowData.add(""
							+ String.format("%.2f", ReportCostants.castNumber(list.get(i).getBhatta(), amount_round)));
				}
				rowData.add(
						"" + String.format("%.2f", ReportCostants.castNumber(list.get(i).getOther1(), amount_round)));
				if (payroll_reward_show == 1) {

					rowData.add(""
							+ String.format("%.2f", ReportCostants.castNumber(list.get(i).getReward(), amount_round)));

				}
				if (payroll_advance_show == 1) {

					rowData.add("" + String.format("%.2f",
							ReportCostants.castNumber(list.get(i).getAdvanceDed(), amount_round)));

				}
				if (payroll_loan_show == 1) {

					rowData.add(""
							+ String.format("%.2f", ReportCostants.castNumber(list.get(i).getLoanDed(), amount_round)));

				}

				rowData.add(
						"" + String.format("%.2f", ReportCostants.castNumber(list.get(i).getItded(), amount_round)));
				if (payroll_payded_show == 1) {

					rowData.add(""
							+ String.format("%.2f", ReportCostants.castNumber(list.get(i).getPayDed(), amount_round)));

				}
				rowData.add(
						"" + String.format("%.2f", ReportCostants.castNumber(list.get(i).getPtDed(), amount_round)));
				rowData.add(""
						+ String.format("%.2f", ReportCostants.castNumber(list.get(i).getEmployeePf(), amount_round)));

				rowData.add("" + String.format("%.2f", ReportCostants.castNumber(list.get(i).getEsic(), amount_round)));
				rowData.add("" + String.format("%.2f", ReportCostants.castNumber(list.get(i).getMlwf(), amount_round)));
				/*
				 * rowData.add("" + String.format("%.2f",
				 * ReportCostants.castNumber(list.get(i).getSocietyContribution(),
				 * amount_round)));
				 */
				double finalDed = list.get(i).getAdvanceDed() + list.get(i).getLoanDed() + list.get(i).getItded()
						+ list.get(i).getPayDed() + list.get(i).getPtDed() + list.get(i).getEmployeePf()
						+ list.get(i).getEsic() + list.get(i).getMlwf() + list.get(i).getSocietyContribution();

				rowData.add("" + String.format("%.2f", ReportCostants.castNumber(finalDed, amount_round)));
				rowData.add(""
						+ String.format("%.2f", ReportCostants.castNumber(list.get(i).getNetSalary(), amount_round)));
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

			}

			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();
			// rowData.add("" + cnt);
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");

			rowData.add("");
			rowData.add("");
			rowData.add("");

			rowData.add("");
			rowData.add("");
			rowData.add("");

			rowData.add("");

			for (int i = 0; i < payRollDataForProcessing.getAllowancelist().size(); i++) {
				rowData.add("" + payRollDataForProcessing.getAllowancelist().get(i).getGrossSalPer());
				rowData.add("" + payRollDataForProcessing.getAllowancelist().get(i).getTaxPer());
			}

			if (ab_deduction == 1) {

				rowData.add("");

			}

			rowData.add("");
			rowData.add("");

			if (payroll_claim_show == 1) {

				rowData.add("");

			}

			rowData.add("");
			rowData.add("");
			rowData.add("");

			rowData.add("");

			if (payroll_bhatta_show == 1) {
				rowData.add("");
			}
			rowData.add("");
			if (payroll_reward_show == 1) {

				rowData.add("");

			}
			if (payroll_advance_show == 1) {

				rowData.add("");

			}
			if (payroll_loan_show == 1) {

				rowData.add("");

			}

			rowData.add("");
			if (payroll_payded_show == 1) {

				rowData.add("");

			}
			rowData.add("");
			rowData.add("");

			rowData.add("");
			rowData.add("");

			rowData.add("");
			rowData.add("");
			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);
			XSSFWorkbook wb = null;
			try {

				wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName, "Month-Year:" + month, "", 'Z');

				ExceUtil.autoSizeColumns(wb, 3);
				response.setContentType("application/vnd.ms-excel");
				String date = new SimpleDateFormat("yyyy-MM-dd_HH_mm_ss").format(new Date());
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

	@RequestMapping(value = "/payDeptReportExcel", method = RequestMethod.GET)
	public void payDeptReportExcel(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		String month = request.getParameter("date");

		String temp[] = month.split("-");

		String reportName = "Pay Register Summary the Month of" + month;
		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("limitKey", "ab_deduction");
			Setting abDeduction = Constants.getRestTemplate().postForObject(Constants.url + "/getSettingByKey", map,
					Setting.class);
			int ab_deduction = Integer.parseInt(abDeduction.getValue());

			map = new LinkedMultiValueMap<String, Object>();
			map.add("limitKey", "ammount_format_show");
			Setting getSettingByKey = Constants.getRestTemplate().postForObject(Constants.url + "/getSettingByKey", map,
					Setting.class);
			int amount_round = Integer.parseInt(getSettingByKey.getValue());

			map = new LinkedMultiValueMap<String, Object>();
			map.add("group", "PAYROLLHIDESHOW");
			Setting[] setting = Constants.getRestTemplate().postForObject(Constants.url + "/getSettingListByGroup", map,
					Setting[].class);
			List<Setting> settingList = new ArrayList<>(Arrays.asList(setting));

			int payroll_claim_show = 0;
			int payroll_advance_show = 0;
			int payroll_loan_show = 0;
			int payroll_payded_show = 0;
			int payroll_reward_show = 0;
			int payroll_bhatta_show = 0;

			for (int k = 0; k < settingList.size(); k++) {
				if (settingList.get(k).getKey().equalsIgnoreCase("payroll_claim_show")) {
					payroll_claim_show = Integer.parseInt(settingList.get(k).getValue());
				} else if (settingList.get(k).getKey().equalsIgnoreCase("payroll_advance_show")) {
					payroll_advance_show = Integer.parseInt(settingList.get(k).getValue());
				} else if (settingList.get(k).getKey().equalsIgnoreCase("payroll_loan_show")) {
					payroll_loan_show = Integer.parseInt(settingList.get(k).getValue());
				} else if (settingList.get(k).getKey().equalsIgnoreCase("payroll_payded_show")) {
					payroll_payded_show = Integer.parseInt(settingList.get(k).getValue());
				} else if (settingList.get(k).getKey().equalsIgnoreCase("payroll_reward_show")) {
					payroll_reward_show = Integer.parseInt(settingList.get(k).getValue());
				} else if (settingList.get(k).getKey().equalsIgnoreCase("payroll_bhatta_show")) {
					payroll_bhatta_show = Integer.parseInt(settingList.get(k).getValue());
				}
			}

			int locId = (int) session.getAttribute("liveLocationId");
			map = new LinkedMultiValueMap<String, Object>();

			map.add("month", temp[0]);
			map.add("year", temp[1]);
			map.add("locId", locId);
			PayRollDataForProcessing payRollDataForProcessing = Constants.getRestTemplate()
					.postForObject(Constants.url + "departmentwisePayrollReport", map, PayRollDataForProcessing.class);
			List<GetDeptPayReport> list = payRollDataForProcessing.getDeptreportlist();

			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();

			// rowData.add("Sr. No");
			rowData.add("Department Name");
			rowData.add("Basic");
			for (int i = 0; i < payRollDataForProcessing.getAllowancelist().size(); i++) {
				rowData.add("" + payRollDataForProcessing.getAllowancelist().get(i).getName());
				payRollDataForProcessing.getAllowancelist().get(i).setTaxPer(0);
			}

			rowData.add("Production Incentive");
			rowData.add("Performance Incentive");
			rowData.add("Night Allowance");
			rowData.add("Performance Bonus");

			if (payroll_claim_show == 1) {
				rowData.add("Claim ADD");
			}
			if (payroll_bhatta_show == 1) {
				rowData.add("Bhatta");
			}
			if (payroll_reward_show == 1) {
				rowData.add("Reward");
			}
			rowData.add("Other1");
			rowData.add("Total Earning");

			if (payroll_advance_show == 1) {
				rowData.add("Adv");
			}
			if (payroll_loan_show == 1) {
				rowData.add("Loan");
			}

			rowData.add("TDS");
			if (payroll_payded_show == 1) {
				rowData.add("Pay Ded");
			}

			rowData.add("PT");
			rowData.add("PF");
			rowData.add("ESIC");
			rowData.add("LWF");
			/* rowData.add("Society Contribution"); */
			rowData.add("Deduction AMT");
			rowData.add("Net Salary");

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);
			int cnt = 1;

			double totBasic = 0;
			double totClaim = 0;
			double totProduction = 0;
			double totPerformance = 0;
			double totNightAll = 0;
			double totPerformanceBon = 0;
			double totBhatta = 0;
			double totOther = 0;
			double totReward = 0;
			double totEarning = 0;
			double totadv = 0;
			double totloan = 0;
			double tottds = 0;
			double totpayded = 0;
			double totpt = 0;
			double totpf = 0;
			double totesic = 0;
			double totlwf = 0;
			double totdudctionamt = 0;
			double totnetsalary = 0;

			for (int i = 0; i < list.size(); i++) {
				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				cnt = cnt + i;

				// rowData.add("" + (i + 1));
				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				// rowData.add("" + cnt);

				rowData.add("" + list.get(i).getDepartName());

				rowData.add(
						"" + String.format("%.2f", ReportCostants.castNumber(list.get(i).getBasicCal(), amount_round)));
				totBasic = ReportCostants.castNumber(totBasic + list.get(i).getBasicCal(), amount_round);

				for (int k = 0; k < payRollDataForProcessing.getAllowancelist().size(); k++) {
					int find = 0;
					for (int j = 0; j < list.get(i).getPayrollAllownceList().size(); j++) {
						if (list.get(i).getPayrollAllownceList().get(j).getAllowanceId() == payRollDataForProcessing
								.getAllowancelist().get(k).getAllowanceId()) {

							rowData.add(String.format("%.2f", ReportCostants.castNumber(
									list.get(i).getPayrollAllownceList().get(j).getAllowanceValueCal(), amount_round)));

							payRollDataForProcessing.getAllowancelist().get(k)
									.setTaxPer((float) (payRollDataForProcessing.getAllowancelist().get(k).getTaxPer()
											+ list.get(i).getPayrollAllownceList().get(j).getAllowanceValueCal()));
							find = 1;
							break;

						}
					}
					if (find == 0) {

						rowData.add(String.format("%.2f", ReportCostants.castNumber(0, amount_round)));
					}

				}

				rowData.add(
						"" + String.format("%.2f", ReportCostants.castNumber(list.get(i).getOtWages(), amount_round)));
				totProduction = ReportCostants.castNumber(totProduction + list.get(i).getOtWages(), amount_round);

				rowData.add("" + String.format("%.2f",
						ReportCostants.castNumber(list.get(i).getProductionInsentive(), amount_round)));
				totPerformance = ReportCostants.castNumber(totPerformance + list.get(i).getProductionInsentive(),
						amount_round);

				rowData.add(""
						+ String.format("%.2f", ReportCostants.castNumber(list.get(i).getNightAllow(), amount_round)));
				totNightAll = ReportCostants.castNumber(totNightAll + list.get(i).getNightAllow(), amount_round);

				rowData.add("" + String.format("%.2f",
						ReportCostants.castNumber(list.get(i).getPerformanceBonus(), amount_round)));
				totPerformanceBon = ReportCostants.castNumber(totPerformanceBon + list.get(i).getPerformanceBonus(),
						amount_round);

				if (payroll_claim_show == 1) {

					rowData.add("" + String.format("%.2f",
							ReportCostants.castNumber(list.get(i).getMiscExpAdd(), amount_round)));
					totClaim = ReportCostants.castNumber(totClaim + list.get(i).getMiscExpAdd(), amount_round);

				}

				if (payroll_bhatta_show == 1) {
					rowData.add(""
							+ String.format("%.2f", ReportCostants.castNumber(list.get(i).getBhatta(), amount_round)));
					totBhatta = ReportCostants.castNumber(totBhatta + list.get(i).getBhatta(), amount_round);
				}
				if (payroll_reward_show == 1) {

					rowData.add(""
							+ String.format("%.2f", ReportCostants.castNumber(list.get(i).getReward(), amount_round)));
					totReward = ReportCostants.castNumber(totReward + list.get(i).getReward(), amount_round);

				}

				rowData.add(
						"" + String.format("%.2f", ReportCostants.castNumber(list.get(i).getOther1(), amount_round)));
				totOther = ReportCostants.castNumber(totOther + list.get(i).getOther1(), amount_round);
				rowData.add(
						"" + String.format("%.2f",
								ReportCostants.castNumber(list.get(i).getGrossSalary() + list.get(i).getOtWages()
										+ list.get(i).getProductionInsentive() + list.get(i).getPerformanceBonus()
										+ list.get(i).getNightAllow() + list.get(i).getMiscExpAdd()
										+ list.get(i).getBhatta() + list.get(i).getReward() + list.get(i).getOther1(),
										amount_round)));
				totEarning = ReportCostants.castNumber(totEarning + list.get(i).getGrossSalary()
						+ list.get(i).getOtWages() + list.get(i).getProductionInsentive()
						+ list.get(i).getPerformanceBonus() + list.get(i).getNightAllow() + list.get(i).getMiscExpAdd()
						+ list.get(i).getBhatta() + list.get(i).getReward() + list.get(i).getOther1(), amount_round);

				if (payroll_advance_show == 1) {

					rowData.add("" + String.format("%.2f",
							ReportCostants.castNumber(list.get(i).getAdvanceDed(), amount_round)));
					totadv = ReportCostants.castNumber(totadv + list.get(i).getAdvanceDed(), amount_round);

				}
				if (payroll_loan_show == 1) {

					rowData.add(""
							+ String.format("%.2f", ReportCostants.castNumber(list.get(i).getLoanDed(), amount_round)));
					totloan = ReportCostants.castNumber(totloan + list.get(i).getLoanDed(), amount_round);

				}

				rowData.add(
						"" + String.format("%.2f", ReportCostants.castNumber(list.get(i).getItded(), amount_round)));
				tottds = ReportCostants.castNumber(tottds + list.get(i).getItded(), amount_round);
				if (payroll_payded_show == 1) {

					rowData.add(""
							+ String.format("%.2f", ReportCostants.castNumber(list.get(i).getPayDed(), amount_round)));
					totpayded = ReportCostants.castNumber(totpayded + list.get(i).getPayDed(), amount_round);
				}
				rowData.add(
						"" + String.format("%.2f", ReportCostants.castNumber(list.get(i).getPtDed(), amount_round)));
				totpt = ReportCostants.castNumber(totpt + list.get(i).getPtDed(), amount_round);
				rowData.add(""
						+ String.format("%.2f", ReportCostants.castNumber(list.get(i).getEmployeePf(), amount_round)));
				totpf = ReportCostants.castNumber(totpf + list.get(i).getEmployeePf(), amount_round);

				rowData.add("" + String.format("%.2f", ReportCostants.castNumber(list.get(i).getEsic(), amount_round)));
				totesic = ReportCostants.castNumber(totesic + list.get(i).getEsic(), amount_round);

				rowData.add("" + String.format("%.2f", ReportCostants.castNumber(list.get(i).getMlwf(), amount_round)));
				totlwf = ReportCostants.castNumber(totlwf + list.get(i).getMlwf(), amount_round);
				/*
				 * rowData.add("" + String.format("%.2f",
				 * ReportCostants.castNumber(list.get(i).getSocietyContribution(),
				 * amount_round)));
				 */
				double finalDed = list.get(i).getAdvanceDed() + list.get(i).getLoanDed() + list.get(i).getItded()
						+ list.get(i).getPayDed() + list.get(i).getPtDed() + list.get(i).getEmployeePf()
						+ list.get(i).getEsic() + list.get(i).getMlwf() + list.get(i).getSocietyContribution();

				rowData.add("" + String.format("%.2f", ReportCostants.castNumber(finalDed, amount_round)));
				totdudctionamt = ReportCostants.castNumber(totdudctionamt + finalDed, amount_round);
				rowData.add(""
						+ String.format("%.2f", ReportCostants.castNumber(list.get(i).getNetSalary(), amount_round)));
				totnetsalary = ReportCostants.castNumber(totnetsalary + list.get(i).getNetSalary(), amount_round);

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

			}

			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();
			// rowData.add("" + cnt);
			rowData.add("Total");
			rowData.add("" + totBasic);
			for (int i = 0; i < payRollDataForProcessing.getAllowancelist().size(); i++) {
				rowData.add("" + payRollDataForProcessing.getAllowancelist().get(i).getTaxPer());
			}

			rowData.add("" + totProduction);
			rowData.add("" + totPerformance);
			rowData.add("" + totNightAll);
			rowData.add("" + totPerformanceBon);

			if (payroll_claim_show == 1) {
				rowData.add("" + totClaim);
			}
			if (payroll_bhatta_show == 1) {
				rowData.add("" + totBhatta);
			}
			if (payroll_reward_show == 1) {
				rowData.add("" + totReward);
			}
			rowData.add("" + totOther);
			rowData.add("" + totEarning);

			if (payroll_advance_show == 1) {
				rowData.add("" + totadv);
			}
			if (payroll_loan_show == 1) {
				rowData.add("" + totloan);
			}

			rowData.add("" + tottds);
			if (payroll_payded_show == 1) {
				rowData.add("" + totpayded);
			}

			rowData.add("" + totpt);
			rowData.add("" + totpf);
			rowData.add("" + totesic);
			rowData.add("" + totlwf);
			/* rowData.add("Society Contribution"); */
			rowData.add("" + totdudctionamt);
			rowData.add("" + totnetsalary);

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

			XSSFWorkbook wb = null;
			try {

				wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName, "Month-Year:" + month, "", 'Z');

				ExceUtil.autoSizeColumns(wb, 3);
				response.setContentType("application/vnd.ms-excel");
				String date = new SimpleDateFormat("yyyy-MM-dd_HH_mm_ss").format(new Date());
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

	@RequestMapping(value = "/showbankTransferReport", method = RequestMethod.GET)
	public void showbankTransferReport(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		String month = request.getParameter("date");

		String temp[] = month.split("-");

		String reportName = "Bank Transfer Report of  Month -" + month;
		try {

			int bankId = Integer.parseInt(request.getParameter("bankId"));

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			int locId = (int) session.getAttribute("liveLocationId");
			map = new LinkedMultiValueMap<String, Object>();

			map.add("month", temp[0]);
			map.add("year", temp[1]);
			map.add("locId", locId);
			map.add("bankId", bankId);
			BankTrasferReport[] bankTrasferReport = Constants.getRestTemplate()
					.postForObject(Constants.url + "getBankTransferReport", map, BankTrasferReport[].class);
			List<BankTrasferReport> list = new ArrayList<>(Arrays.asList(bankTrasferReport));

			map = new LinkedMultiValueMap<>();
			map.add("companyId", 1);

			Bank[] bank = Constants.getRestTemplate().postForObject(Constants.url + "/getAllBanks", map, Bank[].class);

			List<Bank> bankList = new ArrayList<Bank>(Arrays.asList(bank));

			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();

			rowData.add("Sr. No");
			rowData.add("Name");
			rowData.add("Account No");
			rowData.add("Net Pay");

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);
			int cnt = 1;

			double totAmt = 0;
			for (int j = 0; j < bankList.size(); j++) {

				if (bankList.get(j).getBankId() == bankId) {

					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					// rowData.add("" + cnt);
					rowData.add("");
					rowData.add("" + bankList.get(j).getName());
					rowData.add("");
					rowData.add("");
					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

					for (int i = 0; i < list.size(); i++) {

						expoExcel = new ExportToExcel();
						rowData = new ArrayList<String>();
						cnt = cnt + i;

						// rowData.add("" + (i + 1));
						expoExcel = new ExportToExcel();
						rowData = new ArrayList<String>();
						rowData.add("" + (i + 1));
						rowData.add("" + list.get(i).getName());
						rowData.add("" + list.get(i).getAccNo());
						rowData.add("" + list.get(i).getNetSalary());
						totAmt = ReportCostants.castNumber(totAmt + Double.parseDouble(list.get(i).getNetSalary()), 2);

						expoExcel.setRowData(rowData);
						exportToExcelList.add(expoExcel);

					}
					break;
				}
			}

			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();
			// rowData.add("" + cnt);
			rowData.add("Total");

			rowData.add("");
			rowData.add("");
			rowData.add("" + totAmt);
			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

			XSSFWorkbook wb = null;
			try {

				wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName, "Month-Year:" + month, "", 'D');

				ExceUtil.autoSizeColumns(wb, 3);
				response.setContentType("application/vnd.ms-excel");
				String date = new SimpleDateFormat("yyyy-MM-dd_HH_mm_ss").format(new Date());
				response.setHeader("Content-disposition", "attachment; filename=" + reportName + "-" + date + ".xlsx");
				wb.write(response.getOutputStream());

			} catch (IOException ioe) {
				throw new RuntimeException("Error writing spreadsheet to output stream");
			} finally {
				if (wb != null) {
					wb.close();
				}
			}

		} catch (

		Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/showAdvanceSkipRep", method = RequestMethod.GET)
	public void showAdvanceSkipRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Employee Advance Skip Report";

		HttpSession session = request.getSession();

		String month = request.getParameter("date");

		String temp[] = month.split("-");

		try {
			int locId = (int) session.getAttribute("liveLocationId");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("companyId", 1);
			map.add("month", temp[0]);
			map.add("year", temp[1]);
			map.add("locId", locId);
			GetAdvance[] resArray = Constants.getRestTemplate().postForObject(Constants.url + "getAdvanceReport", map,
					GetAdvance[].class);
			List<GetAdvance> progList = new ArrayList<>(Arrays.asList(resArray));

			AdvanceDetails[] resArray1 = Constants.getRestTemplate()
					.postForObject(Constants.url + "getAllAdvanceDetails", map, AdvanceDetails[].class);
			List<AdvanceDetails> progList1 = new ArrayList<>(Arrays.asList(resArray1));

			String header = "";
			String title = "                 ";

			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			Document document = new Document(PageSize._11X17);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(9);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 2.0f, 3.0f, 5.5f, 3.0f, 3.0f, 2.0f, 3.0f, 3.5f, 3.5f });
			Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
			// BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																	// BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Code", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Advance Date", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Advance Amt", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Skip Count", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Skip Remarks", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Skipped By", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Skip DateTime", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);
			double totAdv = 0;

			int index = 0;
			for (int i = 0; i < progList.size(); i++) {
				PdfPCell cell;
				// System.err.println("I " + i);
				int flag = 0;
				GetAdvance prog = progList.get(i);
				for (int k = 0; k < progList1.size(); k++) {

					if (progList1.get(k).getAdvId() == prog.getId()) {

						flag = flag + 1;
						if (flag == 1) {

							index++;
							cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
							cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
							cell.setHorizontalAlignment(Element.ALIGN_CENTER);

							table.addCell(cell);

							cell = new PdfPCell(new Phrase("" + prog.getEmpCode(), headFontData));
							cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
							cell.setHorizontalAlignment(Element.ALIGN_LEFT);

							table.addCell(cell);

							cell = new PdfPCell(new Phrase(
									"" + prog.getFirstName().concat(" ").concat(prog.getSurname()), headFontData));
							cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
							cell.setHorizontalAlignment(Element.ALIGN_LEFT);

							table.addCell(cell);

							cell = new PdfPCell(new Phrase("" + prog.getAdvDate(), headFontData));
							cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
							cell.setHorizontalAlignment(Element.ALIGN_CENTER);

							table.addCell(cell);

							cell = new PdfPCell(new Phrase("" + prog.getAdvAmount(), headFontData));
							cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
							cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

							table.addCell(cell);

							cell = new PdfPCell(new Phrase("" + prog.getSkipId(), headFontData));
							cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
							cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

							table.addCell(cell);
						} else {

							cell = new PdfPCell(new Phrase("", headFontData));
							cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
							cell.setHorizontalAlignment(Element.ALIGN_CENTER);

							table.addCell(cell);

							cell = new PdfPCell(new Phrase("", headFontData));
							cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
							cell.setHorizontalAlignment(Element.ALIGN_LEFT);

							table.addCell(cell);

							cell = new PdfPCell(new Phrase("", headFontData));
							cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
							cell.setHorizontalAlignment(Element.ALIGN_LEFT);

							table.addCell(cell);

							cell = new PdfPCell(new Phrase("", headFontData));
							cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
							cell.setHorizontalAlignment(Element.ALIGN_CENTER);

							table.addCell(cell);

							cell = new PdfPCell(new Phrase("", headFontData));
							cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
							cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

							table.addCell(cell);

							cell = new PdfPCell(new Phrase("", headFontData));
							cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
							cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

							table.addCell(cell);
						}

						cell = new PdfPCell(new Phrase("" + progList1.get(k).getSkipRemarks(), headFontData));
						cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);

						table.addCell(cell);

						cell = new PdfPCell(new Phrase("" + progList1.get(k).getExVar1(), headFontData));
						cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);

						table.addCell(cell);

						cell = new PdfPCell(new Phrase("" + progList1.get(k).getSkipLoginTime(), headFontData));
						cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);

						table.addCell(cell);

					}

				}

				if (flag == 0) {

					index++;
					cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_CENTER);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getEmpCode(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_LEFT);

					table.addCell(cell);

					cell = new PdfPCell(
							new Phrase("" + prog.getFirstName().concat(" ").concat(prog.getSurname()), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_LEFT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getAdvDate(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_CENTER);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getAdvAmount(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getSkipId(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + "-", headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_LEFT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + "-", headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_LEFT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + "-", headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_LEFT);

					table.addCell(cell);

				}
				totAdv = totAdv + prog.getAdvAmount();
			}

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));
			document.add(new Paragraph("Month-Year: " + month));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);
			document.add(new Paragraph("Total Advance Amt: " + totAdv));
			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p"));
			// System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Sr. No");
				rowData.add("Emp Code");
				rowData.add("Emp Name");
				rowData.add("Adv Date");
				rowData.add("Adv Amount");
				rowData.add("Skip Count");
				rowData.add("Skip Remarks");
				rowData.add("Prev Skipped By ");
				rowData.add("Prev Skipped DateTime ");

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;
				double advAmt = 0;
				for (int i = 0; i < progList.size(); i++) {
					System.err.println("i:" + i);

					int flag = 0;

					for (int k = 0; k < progList1.size(); k++) {

						if (progList1.get(k).getAdvId() == progList.get(i).getId()) {
							flag = flag + 1;
							expoExcel = new ExportToExcel();
							rowData = new ArrayList<String>();
							if (flag == 1) {

								cnt = cnt + i;
								rowData.add("" + (i + 1));
								rowData.add("" + progList.get(i).getEmpCode());
								rowData.add("" + progList.get(i).getFirstName().concat(" ")
										.concat(progList.get(i).getSurname()));
								rowData.add("" + progList.get(i).getAdvDate());
								rowData.add("" + progList.get(i).getAdvAmount());
								rowData.add("" + progList.get(i).getSkipId());
							} else {
								rowData.add("" + " ");
								rowData.add("" + " ");
								rowData.add("" + " ");
								rowData.add("" + " ");
								rowData.add("" + " ");
								rowData.add("" + " ");
							}
							rowData.add("" + progList1.get(k).getSkipRemarks());

							rowData.add("" + progList1.get(k).getExVar1());

							rowData.add("" + progList1.get(k).getSkipLoginTime());
							expoExcel.setRowData(rowData);
							exportToExcelList.add(expoExcel);
						}

					}

					if (flag == 0) {
						expoExcel = new ExportToExcel();
						rowData = new ArrayList<String>();
						cnt = cnt + i;
						rowData.add("" + (i + 1));
						rowData.add("" + progList.get(i).getEmpCode());
						rowData.add(
								"" + progList.get(i).getFirstName().concat(" ").concat(progList.get(i).getSurname()));
						rowData.add("" + progList.get(i).getAdvDate());
						rowData.add("" + progList.get(i).getAdvAmount());
						rowData.add("" + progList.get(i).getSkipId());
						rowData.add("-");
						rowData.add("-");
						rowData.add("-");
						expoExcel.setRowData(rowData);
						exportToExcelList.add(expoExcel);

					}
					advAmt = advAmt + progList.get(i).getAdvAmount();

				}
				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName, "Month-Year: " + month,
							"Total Advance: " + advAmt, 'I');

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

//***Attendence Report
	@RequestMapping(value = "/showEmpAttendRegisterRep", method = RequestMethod.GET)
	public void showEmpAttendRegisterRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "ATTENDANCE REGISTER";

		HttpSession session = request.getSession();

		String date = request.getParameter("date");

		String temp[] = date.split("-");

		String year = temp[1];
		String month = temp[0];
		if (month.length() == 1) {
			month = "0".concat(month);
		}

		LocalDate date3 = LocalDate.of(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt("01"));
		int daysToday = date3.lengthOfMonth();

		String fromDate = year.concat("-").concat(month).concat("-").concat("01");
		String toDate = year.concat("-").concat(month).concat("-").concat(String.valueOf(daysToday));

		Boolean ret = false;
		try {
			int locId = (int) session.getAttribute("liveLocationId");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("companyId", 1);
			map.add("fromDate", fromDate);
			map.add("toDate", toDate);
			map.add("locId", locId);
			GetDailyDailyRecord[] resArray = Constants.getRestTemplate()
					.postForObject(Constants.url + "getAttendenceRegReport", map, GetDailyDailyRecord[].class);
			List<GetDailyDailyRecord> progList = new ArrayList<>(Arrays.asList(resArray));
			// System.err.println("daily rec" + progList.toString());
			map = new LinkedMultiValueMap<>();
			map.add("empRes", -1);
			map.add("companyId", 1);

			EmployeeMaster[] empArr = Constants.getRestTemplate().postForObject(Constants.url + "/getAllEmp", map,
					EmployeeMaster[].class);
			List<EmployeeMaster> empList = new ArrayList<EmployeeMaster>(Arrays.asList(empArr));

			String header = "";
			String title = "                 ";

			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			Document document = new Document(PageSize.A1);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));
			// System.err.println("daysToday" + daysToday);
			PdfPTable table = new PdfPTable(3 + daysToday);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			float f[];
			f = new float[3 + daysToday];
			f[0] = 2.0f;
			f[1] = 3.0f;
			f[2] = 6.0f;

			for (int i = 3; i <= 2 + daysToday; i++) {
				f[i] = 2.5f;

				// System.err.println("float Array" + f[i]);

			}

			table.setWidths(f);
			Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
			// BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																	// BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Code", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			for (int j = 1; j <= daysToday; j++) {

				hcell = new PdfPCell(new Phrase(String.valueOf(j), tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

			}

			int index = 0;
			for (int i = 0; i < empList.size(); i++) {

				if (locId == empList.get(i).getLocationId()) {

					EmployeeMaster prog = empList.get(i);
					int empId = prog.getEmpId();

					index++;
					PdfPCell cell;
					cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_CENTER);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getEmpCode(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_LEFT);

					table.addCell(cell);

					cell = new PdfPCell(
							new Phrase("" + prog.getFirstName().concat(" ").concat(prog.getSurname()), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_LEFT);

					table.addCell(cell);

					for (int j = 1; j <= daysToday; j++) {

						int flag = 0;
						String stat = null;
						for (int p = 0; p < progList.size(); p++) {
							int dayCurr = progList.get(p).getEmpType();

							if (dayCurr == j && empId == progList.get(p).getEmpId()) {
								flag = 1;
								stat = progList.get(p).getAttsSdShow();
								break;
							}
						}
						if (flag == 1) {
							cell = new PdfPCell(new Phrase("" + stat, headFontData));
							cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
							cell.setHorizontalAlignment(Element.ALIGN_CENTER);
							table.addCell(cell);
						} else {
							cell = new PdfPCell(new Phrase("" + "-", headFontData));
							cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
							cell.setHorizontalAlignment(Element.ALIGN_CENTER);
							table.addCell(cell);
						}

					}
				}
			}

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));
			document.add(new Paragraph("Month-Year:" + date));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p"));
			// System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Sr. No");
				rowData.add("Emp Code");
				rowData.add("Emp Name");

				for (int j = 1; j <= daysToday; j++) {
					rowData.add(String.valueOf(j));
				}
				char colCoun = 'E';

				/*
				 * if(daysToday==28) { colCoun='AB'; }else if(daysToday==30) {
				 * 
				 * colCoun="AE"; }else { colCoun="AF"; }
				 */
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;

				for (int i = 0; i < empList.size(); i++) {

					if (locId == empList.get(i).getLocationId()) {

						expoExcel = new ExportToExcel();
						rowData = new ArrayList<String>();

						cnt = cnt + i;
						int emp = empList.get(i).getEmpId();

						rowData.add("" + (i + 1));
						rowData.add("" + empList.get(i).getEmpCode());
						rowData.add("" + empList.get(i).getFirstName().concat(" ").concat(empList.get(i).getSurname()));

						for (int j = 1; j <= daysToday; j++) {
							int flag = 0;
							String stat = null;
							for (int l = 0; l < progList.size(); l++) {
								int dayCurr = progList.get(l).getEmpType();
								if (dayCurr == j && emp == progList.get(l).getEmpId()) {
									flag = 1;
									stat = progList.get(l).getAttsSdShow();
									break;
								}
							}
							if (flag == 1) {

								rowData.add("" + stat);
							} else {
								rowData.add("" + "-");
							}

						}
						expoExcel.setRowData(rowData);
						exportToExcelList.add(expoExcel);
					}
				}

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName, "Month-Year:" + date, "", colCoun);

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date1 = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date1 + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/showAdvancePaymentYearlyRep", method = RequestMethod.GET)
	public void showAdvancePaymentYearlyRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Yearly Advance Amount";

		HttpSession session = request.getSession();

		String month = request.getParameter("date");

		String temp[] = month.split("-");

		try {
			int locId = (int) session.getAttribute("liveLocationId");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("companyId", 1);
			map.add("year", temp[1]);
			map.add("locId", locId);
			GetYearlyAdvanceNew[] resArray = Constants.getRestTemplate()
					.postForObject(Constants.url + "getAdvanceYearlyReport", map, GetYearlyAdvanceNew[].class);
			List<GetYearlyAdvanceNew> progList = new ArrayList<>(Arrays.asList(resArray));

			String header = "";
			String title = "                 ";

			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			Document document = new Document(PageSize._11X17);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(16);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 2.0f, 3.0f, 5.5f, 2.2f, 2.2f, 2.2f, 2.2f, 2.2f, 2.2f, 2.2f, 2.2f, 2.2f, 2.2f,
					2.2f, 2.2f, 2.2f });
			Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
			// BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																	// BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Code", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Jan", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Feb", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("March", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);
			hcell = new PdfPCell(new Phrase("April", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("May", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("June", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);
			hcell = new PdfPCell(new Phrase("July", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Aug", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Sep", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);
			hcell = new PdfPCell(new Phrase("Oct", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Nov", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Dec", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Total", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			int index = 0;
			for (int i = 0; i < progList.size(); i++) {
				// System.err.println("I " + i);
				GetYearlyAdvanceNew prog = progList.get(i);

				index++;
				PdfPCell cell;
				cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpCode(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpName(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getJanCount(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getFebCount(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getMarchCount(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getMayCount(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);
				cell = new PdfPCell(new Phrase("" + prog.getMarchCount(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);
				cell = new PdfPCell(new Phrase("" + prog.getJunCount(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);
				cell = new PdfPCell(new Phrase("" + prog.getJulCount(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);
				cell = new PdfPCell(new Phrase("" + prog.getAugCount(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);
				cell = new PdfPCell(new Phrase("" + prog.getSepCount(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);
				cell = new PdfPCell(new Phrase("" + prog.getOctCount(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getNovCount(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getDecCount(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getTotal(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(cell);

			}

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));
			document.add(new Paragraph("Year:" + temp[1]));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p"));
			// System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Sr. No");
				rowData.add("Emp Code");
				rowData.add("Emp Name");
				rowData.add("Jan");
				rowData.add("Feb");
				rowData.add("March");
				rowData.add("April");
				rowData.add("May");
				rowData.add("June");
				rowData.add("July");
				rowData.add("Aug");
				rowData.add("Sep");
				rowData.add("Oct");
				rowData.add("Nov");
				rowData.add("Dec");
				rowData.add("Total");

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;
				for (int i = 0; i < progList.size(); i++) {
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					cnt = cnt + i;

					rowData.add("" + (i + 1));
					rowData.add("" + progList.get(i).getEmpCode());
					rowData.add("" + progList.get(i).getEmpName());
					rowData.add("" + progList.get(i).getJanCount());
					rowData.add("" + progList.get(i).getFebCount());
					rowData.add("" + progList.get(i).getMarchCount());
					rowData.add("" + progList.get(i).getAprCount());

					rowData.add("" + progList.get(i).getMayCount());
					rowData.add("" + progList.get(i).getJunCount());

					rowData.add("" + progList.get(i).getJulCount());
					rowData.add("" + progList.get(i).getAugCount());

					rowData.add("" + progList.get(i).getSepCount());
					rowData.add("" + progList.get(i).getOctCount());

					rowData.add("" + progList.get(i).getNovCount());
					rowData.add("" + progList.get(i).getDecCount());
					rowData.add("" + progList.get(i).getTotal());

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

				}

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName, "Year:" + temp[1], "", 'P');

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/showEmpLateMarkRep", method = RequestMethod.GET)
	public void showEmpLateMarkRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Employee Late Mark";

		HttpSession session = request.getSession();

		String leaveDateRange = request.getParameter("leaveDateRange");
		String[] arrOfStr = leaveDateRange.split("to", 2);

		Boolean ret = false;
		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("companyId", 1);
			map.add("fromDate", DateConvertor.convertToYMD(arrOfStr[0]));
			map.add("toDate", DateConvertor.convertToYMD(arrOfStr[1]));
			DailyAttendance[] resArray = Constants.getRestTemplate()
					.postForObject(Constants.url + "getEmpLateMarkReport", map, DailyAttendance[].class);
			List<DailyAttendance> progList = new ArrayList<>(Arrays.asList(resArray));
			System.err.println("data:" + progList.toString());
			String header = "";
			String title = "                 ";

			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			Document document = new Document(PageSize.A4);
			document.setMargins(5, 5, 2, 2);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(8);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 1.5f, 2.2f, 4.0f, 2.5f, 4.0f, 2.0f, 2.0f, 2.0f });
			Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
			// BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																	// BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("Sr. No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Code", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Date", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Shift Name", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Late Min", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("In Time", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Out Time", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			int index = 0;
			for (int i = 0; i < progList.size(); i++) {

				DailyAttendance prog = progList.get(i);

				index++;
				PdfPCell cell;
				cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpCode(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpName(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + DateConvertor.convertToDMY(prog.getAttDate()), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getCurrentShiftname(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getLateMin(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getInTime(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getOutTime(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

			}

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));
			document.add(new Paragraph("Date" + arrOfStr[0] + "To" + arrOfStr[1]));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p"));
			// System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();
				rowData.add("Sr.No.");
				rowData.add("Employee Code");
				rowData.add("Employee Name");
				rowData.add("Date");
				rowData.add("Shift Name");
				rowData.add("Late Min");
				rowData.add("In Time");
				rowData.add("Out Time");

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;
				for (int i = 0; i < progList.size(); i++) {
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					cnt = cnt + i;
					rowData.add("" + (i + 1));
					rowData.add("" + progList.get(i).getEmpCode());
					rowData.add("" + progList.get(i).getEmpName());
					rowData.add("" + DateConvertor.convertToDMY(progList.get(i).getAttDate()));
					rowData.add("" + progList.get(i).getCurrentShiftname());
					rowData.add("" + progList.get(i).getLateMin());
					rowData.add("" + progList.get(i).getInTime());
					rowData.add("" + progList.get(i).getOutTime());
					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

				}

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
							"Date:" + arrOfStr[0] + "To" + arrOfStr[1], "", 'H');

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/showEmpAttendanceRep", method = RequestMethod.GET)
	public void showEmpAttendanceRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "DAILY ATTENDANCE SUMMARY";

		HttpSession session = request.getSession();

		String leaveDateRange = request.getParameter("singleDateRange");
		// String[] arrOfStr = leaveDateRange.split("to", 2);
		System.out.println("Dates--------" + leaveDateRange);

		try {

			int locId = (int) session.getAttribute("liveLocationId");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("companyId", 1);
			map.add("fromDate", DateConvertor.convertToYMD(leaveDateRange));
			map.add("toDate", DateConvertor.convertToYMD(leaveDateRange));
			map.add("locId", locId);
			EmpAttendeanceRep[] resArray = Constants.getRestTemplate()
					.postForObject(Constants.url + "getDailyAttendenceReport", map, EmpAttendeanceRep[].class);
			List<EmpAttendeanceRep> progList = new ArrayList<>(Arrays.asList(resArray));
			System.err.println("data:" + progList.toString());
			String header = "";
			String title = "                 ";

			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			Document document = new Document(PageSize.A4);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(4);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 3.0f, 3.0f, 3.0f, 3.0f });
			Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
			// BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																	// BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("Employee Present", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee On Leave", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Absent ", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee On Week-off", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			int index = 0;
			for (int i = 0; i < progList.size(); i++) {

				EmpAttendeanceRep prog = progList.get(i);

				index++;
				PdfPCell cell;

				cell = new PdfPCell(new Phrase("" + prog.getEmpPresent(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getPaidLeave(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getUnpaidLeave(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getWeekOff(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

			}

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));
			document.add(new Paragraph("Date: " + leaveDateRange + "To" + leaveDateRange));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p"));
			// System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Employee Present");
				rowData.add("Employee On Leave");
				rowData.add("Employee Absent");
				rowData.add("Employee On Week-off");

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;
				for (int i = 0; i < progList.size(); i++) {
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					cnt = cnt + i;

					rowData.add("" + progList.get(i).getEmpPresent());
					rowData.add("" + progList.get(i).getPaidLeave());
					rowData.add("" + progList.get(i).getUnpaidLeave());
					rowData.add("" + progList.get(i).getWeekOff());

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

				}

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
							"Date:" + leaveDateRange + "To" + leaveDateRange, "", 'D');

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/showDailyEmpAttendanceRepExcel", method = RequestMethod.GET)
	public void showDailyEmpAttendanceRepExcel(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		String leaveDateRange = request.getParameter("leaveDateRange");
		String[] arrOfStr = leaveDateRange.split("to", 2);
		// System.out.println("Dates--------" + leaveDateRange);
		String reportName = "Daily Attendance Register From Date : " + arrOfStr[0].trim() + "To Date : "
				+ arrOfStr[1].trim();
		int p = Integer.parseInt(request.getParameter("p"));
		try {

			int locId = (int) session.getAttribute("liveLocationId");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("fromDate", DateConvertor.convertToYMD(arrOfStr[0].trim()));
			map.add("toDate", DateConvertor.convertToYMD(arrOfStr[1].trim()));
			map.add("locId", locId);
			DateAndDay[] resArray = Constants.getRestTemplate()
					.postForObject(Constants.url + "getAttendanceSheetReport", map, DateAndDay[].class);
			List<DateAndDay> progList = new ArrayList<>(Arrays.asList(resArray));

			if (p == 1) {
				String header = "";
				String title = "";
				DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");

				Document document = new Document(PageSize.A4);
				document.setMargins(5, 5, 0, 0);
				document.setMarginMirroring(false);

				String FILE_PATH = Constants.REPORT_SAVE;
				File file = new File(FILE_PATH);

				PdfWriter writer = null;

				FileOutputStream out = new FileOutputStream(FILE_PATH);
				try {
					writer = PdfWriter.getInstance(document, out);
				} catch (DocumentException e) {

					e.printStackTrace();
				}

				ItextPageEvent event = new ItextPageEvent(header, title, "", "");

				writer.setPageEvent(event);
				// writer.add(new Paragraph("Curricular Aspects"));

				PdfPTable table = new PdfPTable(8);

				table.setHeaderRows(1);

				table.setWidthPercentage(100);
				table.setWidths(new float[] { 3.8f, 2.7f, 2.0f, 2.0f, 2.0f, 2.0f, 3.0f, 2.0f });
				Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
				// BaseColor.BLACK);
				Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																		// BaseColor.BLACK);
				tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

				PdfPCell hcell = new PdfPCell();
				hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

				/*
				 * hcell = new PdfPCell(new Phrase("Date", tableHeaderFont));
				 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
				 * table.addCell(hcell);
				 */

				/*
				 * hcell = new PdfPCell(new Phrase("Employee Code", tableHeaderFont));
				 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
				 * table.addCell(hcell);
				 */

				hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
				hcell.setPadding(5);
				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Department", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
				hcell.setPadding(5);
				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Status", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
				hcell.setPadding(5);
				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("In Time", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
				hcell.setPadding(5);
				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Out Time", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
				hcell.setPadding(5);
				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Working HRS", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
				hcell.setPadding(5);
				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Shift Name", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
				hcell.setPadding(5);
				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("OT HRS", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
				hcell.setPadding(5);
				table.addCell(hcell);

				int index = 0;
				for (int i = 0; i < progList.size(); i++) {

					DateAndDay prog = progList.get(i);

					index++;
					PdfPCell cell;

					cell = new PdfPCell(new Phrase("" + prog.getDate() + ", " + prog.getDay(), headFontData));
					cell.setColspan(8);
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_LEFT);
					cell.setPadding(5);
					table.addCell(cell);

					for (int j = 0; j < prog.getFinalDailyList().size(); j++) {

						cell = new PdfPCell(new Phrase("" + prog.getFinalDailyList().get(j).getEmpName() + " ("
								+ prog.getFinalDailyList().get(j).getEmpCode() + ")", headFontData));
						cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);
						cell.setPadding(5);
						table.addCell(cell);

						cell = new PdfPCell(new Phrase("" + prog.getFinalDailyList().get(j).getName(), headFontData));
						cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);
						cell.setPadding(5);
						table.addCell(cell);

						cell = new PdfPCell(
								new Phrase("" + prog.getFinalDailyList().get(j).getAttsSdShow(), headFontData));
						cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
						cell.setHorizontalAlignment(Element.ALIGN_CENTER);
						cell.setPadding(5);
						table.addCell(cell);

						cell = new PdfPCell(new Phrase("" + prog.getFinalDailyList().get(j).getInTime(), headFontData));
						cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
						cell.setHorizontalAlignment(Element.ALIGN_CENTER);
						cell.setPadding(5);
						table.addCell(cell);

						cell = new PdfPCell(
								new Phrase("" + prog.getFinalDailyList().get(j).getOutTime(), headFontData));
						cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
						cell.setHorizontalAlignment(Element.ALIGN_CENTER);
						cell.setPadding(5);
						table.addCell(cell);

						cell = new PdfPCell(
								new Phrase("" + prog.getFinalDailyList().get(j).getWorkingHrs(), headFontData));
						cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
						cell.setHorizontalAlignment(Element.ALIGN_CENTER);
						cell.setPadding(5);
						table.addCell(cell);

						cell = new PdfPCell(
								new Phrase("" + prog.getFinalDailyList().get(j).getCurrentShiftname(), headFontData));
						cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);
						cell.setPadding(5);
						table.addCell(cell);

						cell = new PdfPCell(new Phrase("" + prog.getFinalDailyList().get(j).getOtHr(), headFontData));
						cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
						cell.setHorizontalAlignment(Element.ALIGN_CENTER);
						table.addCell(cell);

					}

				}

				System.out.println("sdffffffffffffff");
				document.open();
				Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

				Paragraph name = new Paragraph(reportName, hf);
				name.setAlignment(Element.ALIGN_CENTER);
				document.add(name);
				document.add(new Paragraph("\n"));
				// document.add(new Paragraph("Date: " + arrOfStr[0].trim() + " - " +
				// arrOfStr[1].trim()));

				document.add(new Paragraph("\n"));

				document.add(table);

				// int totalPages = writer.getPageNumber();
				document.close();
				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Date");
				rowData.add("Employee Code");
				rowData.add("Employee Name");
				rowData.add("Department");
				rowData.add("Status");
				rowData.add("In Time");
				rowData.add("Out Time");
				rowData.add("Working HRS");
				rowData.add("Shift Name");
				rowData.add("OT HRS");
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				int cnt = 1;

				for (int i = 0; i < progList.size(); i++) {

					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					rowData.add("" + progList.get(i).getDate() + ", " + progList.get(i).getDay());
					rowData.add("");
					rowData.add("");
					rowData.add("");
					rowData.add("");
					rowData.add("");
					rowData.add("");
					rowData.add("");
					rowData.add("");
					rowData.add("");

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

					for (int j = 0; j < progList.get(i).getFinalDailyList().size(); j++) {
						expoExcel = new ExportToExcel();
						rowData = new ArrayList<String>();
						rowData.add("");
						rowData.add("" + progList.get(i).getFinalDailyList().get(j).getEmpCode());
						rowData.add("" + progList.get(i).getFinalDailyList().get(j).getEmpName());
						rowData.add("" + progList.get(i).getFinalDailyList().get(j).getName());
						rowData.add("" + progList.get(i).getFinalDailyList().get(j).getAttsSdShow());
						rowData.add("" + progList.get(i).getFinalDailyList().get(j).getInTime());
						rowData.add("" + progList.get(i).getFinalDailyList().get(j).getOutTime());
						rowData.add("" + progList.get(i).getFinalDailyList().get(j).getWorkingHrs());
						rowData.add("" + progList.get(i).getFinalDailyList().get(j).getCurrentShiftname());
						rowData.add("" + progList.get(i).getFinalDailyList().get(j).getOtHr());

						expoExcel.setRowData(rowData);
						exportToExcelList.add(expoExcel);
					}
				}
				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
							"Date:" + leaveDateRange + "To" + leaveDateRange, "", 'J');

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd_hh_mm_ss").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}
		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	// *******************************Loan Reports****************************

	@RequestMapping(value = "/showEmpLoanRep", method = RequestMethod.GET)
	public void showEmpLoanRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "EMPLOYEE LOAN REPORT";

		HttpSession session = request.getSession();

		String leaveDateRange = request.getParameter("leaveDateRange");
		String[] arrOfStr = leaveDateRange.split("to", 2);

		Boolean ret = false;
		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("companyId", 1);
			map.add("fromDate", DateConvertor.convertToYMD(arrOfStr[0]));
			map.add("toDate", DateConvertor.convertToYMD(arrOfStr[1]));
			EmpAttendeanceRep[] resArray = Constants.getRestTemplate()
					.postForObject(Constants.url + "getDailyAttendenceReport", map, EmpAttendeanceRep[].class);
			List<EmpAttendeanceRep> progList = new ArrayList<>(Arrays.asList(resArray));
			System.err.println("data:" + progList.toString());
			String header = "";
			String title = "                 ";

			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			Document document = new Document(PageSize.A4);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(4);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 3.0f, 3.0f, 3.0f, 3.0f });
			Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
			// BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																	// BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("Employee Present", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee On Leave", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Absent ", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee On Week-off", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			int index = 0;
			for (int i = 0; i < progList.size(); i++) {

				EmpAttendeanceRep prog = progList.get(i);

				index++;
				PdfPCell cell;

				cell = new PdfPCell(new Phrase("" + prog.getEmpPresent(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getPaidLeave(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getUnpaidLeave(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getWeekOff(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

			}

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));
			document.add(new Paragraph("Date: " + arrOfStr[0] + "To" + arrOfStr[1]));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p"));
			// System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Employee Present");
				rowData.add("Employee On Leave");
				rowData.add("Employee Absent");
				rowData.add("Employee On Week-off");

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;
				for (int i = 0; i < progList.size(); i++) {
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					cnt = cnt + i;

					rowData.add("" + progList.get(i).getEmpPresent());
					rowData.add("" + progList.get(i).getPaidLeave());
					rowData.add("" + progList.get(i).getUnpaidLeave());
					rowData.add("" + progList.get(i).getWeekOff());

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

				}

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
							"Date:" + arrOfStr[0] + "To" + arrOfStr[1], "", 'D');

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/showLoanRep", method = RequestMethod.GET)
	public void showLoanRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Employee Loan Report";

		HttpSession session = request.getSession();

		String month = request.getParameter("date");

		String temp[] = month.split("-");
		Boolean ret = false;
		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("month", temp[0]);
			map.add("year", temp[1]);
			GetLoanReport[] resArray = Constants.getRestTemplate().postForObject(Constants.url + "getLoanReport", map,
					GetLoanReport[].class);
			List<GetLoanReport> progList = new ArrayList<>(Arrays.asList(resArray));

			String header = "";
			String title = "                 ";
			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			Document document = new Document(PageSize._11X17);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(10);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 2.0f, 3.0f, 5.5f, 3.5f, 3.5f, 3.5f, 3.5f, 3.5f, 3.5f, 3.5f });
			Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
			// BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																	// BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Code", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Application No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Loan Amt", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Loan Repay Start", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Loan Repay End", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Current Total Paid", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Current Total Outstanding", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Status", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			int index = 0;
			for (int i = 0; i < progList.size(); i++) {
				// System.err.println("I " + i);
				GetLoanReport prog = progList.get(i);

				index++;
				PdfPCell cell;
				cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpCode(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpName(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getLoanApplNo(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getLoanAmt(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getLoanRepayStart(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getLoanRepayEnd(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getCurrentTotpaid(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getCurrentOutstanding(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getLoanStatus(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

			}

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));
			document.add(new Paragraph("Month-Year: " + month));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p"));
			// System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Sr. No");
				rowData.add("Emp Code");
				rowData.add("Emp Name");
				rowData.add("Application No");
				rowData.add("Loan Amt");
				rowData.add("Loan Repay Start");
				rowData.add("Loan Repay End");
				rowData.add("Current Total Paid");
				rowData.add("Current Total Outstanding");
				rowData.add("Status");

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;
				for (int i = 0; i < progList.size(); i++) {
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					cnt = cnt + i;

					rowData.add("" + (i + 1));
					rowData.add("" + progList.get(i).getEmpCode());
					rowData.add("" + progList.get(i).getEmpName());
					rowData.add("" + progList.get(i).getLoanApplNo());
					rowData.add("" + progList.get(i).getLoanAmt());
					rowData.add("" + progList.get(i).getLoanRepayStart());
					rowData.add("" + progList.get(i).getLoanRepayEnd());
					rowData.add("" + progList.get(i).getCurrentTotpaid());
					rowData.add("" + progList.get(i).getCurrentOutstanding());
					rowData.add("" + progList.get(i).getLoanStatus());

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

				}

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName, "Month-Year:" + month, "", 'J');

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/showLoanDedRep", method = RequestMethod.GET)
	public void showLoanDedRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Loan Deduction Report";

		String leaveDateRange = request.getParameter("date");
		String[] arrOfStr = leaveDateRange.split("-");
		Boolean ret = false;
		HttpSession session = request.getSession();

		int locId = (int) session.getAttribute("liveLocationId");

		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("month", arrOfStr[0]);
			map.add("year", arrOfStr[1]);
			map.add("locId", locId);
			LoanDedReport[] resArray = Constants.getRestTemplate().postForObject(Constants.url + "getLoanDedReport",
					map, LoanDedReport[].class);
			List<LoanDedReport> progList = new ArrayList<>(Arrays.asList(resArray));
			double loanAmtTot = 0;
			double loanEmiAmtTot = 0;
			double loanEmiIntrestAmtTot = 0;
			double paindingTot = 0;
			double paidTot = 0;

			String header = "";
			String title = "                 ";
			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			Document document = new Document(PageSize._11X17);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(5);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 2.0f, 3.0f, 5.5f, 4.5f, 3.5f });
			Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
			// BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																	// BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Code", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Department", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Amount", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			int index = 0;
			loanAmtTot = 0;
			loanEmiAmtTot = 0;
			loanEmiIntrestAmtTot = 0;
			paindingTot = 0;
			paidTot = 0;
			for (int i = 0; i < progList.size(); i++) {
				// System.err.println("I " + i);
				LoanDedReport prog = progList.get(i);

				index++;
				PdfPCell cell;
				cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpCode(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpName(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getDepartmentName(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getAmountEmi(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(cell);

				loanAmtTot = loanAmtTot + prog.getAmountEmi();

			}

			PdfPCell cell;
			cell = new PdfPCell(new Phrase("Total", headFontData));
			cell.setColspan(4);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(cell);

			cell = new PdfPCell(new Phrase("" + loanAmtTot, headFontData));
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(cell);

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));
			document.add(new Paragraph("Date Range: " + leaveDateRange));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p"));
			// System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {

				loanAmtTot = 0;
				loanEmiAmtTot = 0;
				loanEmiIntrestAmtTot = 0;
				paindingTot = 0;
				paidTot = 0;

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Sr. No");
				rowData.add("Emp Code");
				rowData.add("Emp Name");
				rowData.add("Department");
				rowData.add("Amount");

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;
				for (int i = 0; i < progList.size(); i++) {
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					cnt = cnt + i;

					rowData.add("" + (i + 1));
					rowData.add("" + progList.get(i).getEmpCode());
					rowData.add("" + progList.get(i).getEmpName());
					rowData.add("" + progList.get(i).getDepartmentName());
					rowData.add("" + progList.get(i).getAmountEmi());

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

					loanAmtTot = loanAmtTot + progList.get(i).getAmountEmi();

				}

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName, " Month-Year :" + leaveDateRange,
							",Total Loan Amt:" + loanAmtTot, 'E');

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	private static final int BUFFER_SIZE = 4096;

	@RequestMapping(value = "/ecrUploadFile", method = RequestMethod.GET)
	public void ecrUploadFile(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Loan Deduction Report";

		String leaveDateRange = request.getParameter("date");
		String[] arrOfStr = leaveDateRange.split("-");

		HttpSession session = request.getSession();

		int locId = (int) session.getAttribute("liveLocationId");
		int cmpId = 0;
		try {
			cmpId = Integer.parseInt(request.getParameter("subCmpId"));

		} catch (Exception e) {
			cmpId = 0;
		}
		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("month", arrOfStr[0]);
			map.add("year", arrOfStr[1]);
			map.add("locId", locId);
			map.add("cmpId", cmpId);
			EcrFileData[] resArray = Constants.getRestTemplate().postForObject(Constants.url + "getEcrFileData", map,
					EcrFileData[].class);
			List<EcrFileData> progList = new ArrayList<>(Arrays.asList(resArray));

			// System.out.println(progList);
			File file = new File(Constants.EPF_SAVE);
			if (file.createNewFile()) {
				System.out.println("File created: " + file.getName());
			} else {
				System.out.println("File already exists.");
			}

			PrintWriter writer = new PrintWriter(Constants.EPF_SAVE, "UTF-8");

			for (int i = 0; i < progList.size(); i++) {
				writer.println(progList.get(i).getUan() + "#~#" + progList.get(i).getFirstName() + " "
						+ progList.get(i).getMiddleName() + " " + progList.get(i).getSurname() + "#~#"
						+ progList.get(i).getGrossSalary() + "#~#" + progList.get(i).getEpfWages() + "#~#"
						+ progList.get(i).getEpsWages() + "#~#" + progList.get(i).getEpsWages() + "#~#"
						+ progList.get(i).getEmployeePf() + "#~#" + progList.get(i).getEmployerEps() + "#~#"
						+ progList.get(i).getEmployerPf() + "#~#" + progList.get(i).getNcpDays() + "#~#0");
			}

			// writer.println("The second line");
			writer.close();

			// FileUtils.writeStringToFile(file, "helloooo");

			if (file != null) {
				String date = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss").format(new Date());
				response.setContentType("application/text");

				response.addHeader("content-disposition",
						String.format("inline; filename=\"%s\"", "epf_" + date + ".txt"));

				response.setContentLength((int) file.length());

				InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

				try {
					FileCopyUtils.copy(inputStream, response.getOutputStream());
				} catch (IOException e) {
					// System.out.println("Excep in Opening a Pdf File");
					e.printStackTrace();
				}
			}
		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/ecrArrearsUploadFile", method = RequestMethod.GET)
	public void ecrArrearsUploadFile(HttpServletRequest request, HttpServletResponse response) {

		String leaveDateRange = request.getParameter("date");
		String[] arrOfStr = leaveDateRange.split("-");

		HttpSession session = request.getSession();

		int locId = (int) session.getAttribute("liveLocationId");
		int cmpId = 0;
		try {
			cmpId = Integer.parseInt(request.getParameter("subCmpId"));

		} catch (Exception e) {
			cmpId = 0;
		}
		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("month", arrOfStr[0]);
			map.add("year", arrOfStr[1]);
			map.add("locId", locId);
			map.add("cmpId", cmpId);
			EcrFileData[] resArray = Constants.getRestTemplate().postForObject(Constants.url + "getArrearsEcrFileData",
					map, EcrFileData[].class);
			List<EcrFileData> progList = new ArrayList<>(Arrays.asList(resArray));

			// System.out.println(progList);
			File file = new File(Constants.EPF_SAVE);
			if (file.createNewFile()) {
				System.out.println("File created: " + file.getName());
			} else {
				System.out.println("File already exists.");
			}

			PrintWriter writer = new PrintWriter(Constants.EPF_SAVE, "UTF-8");

			for (int i = 0; i < progList.size(); i++) {
				writer.println(progList.get(i).getUan() + "#~#" + progList.get(i).getFirstName() + " "
						+ progList.get(i).getMiddleName() + " " + progList.get(i).getSurname() + "#~#"
						+ progList.get(i).getGrossSalary() + "#~#" + progList.get(i).getEpfWages() + "#~#"
						+ progList.get(i).getEpsWages() + "#~#" + progList.get(i).getEpsWages() + "#~#"
						+ progList.get(i).getEmployeePf() + "#~#" + progList.get(i).getEmployerEps() + "#~#"
						+ progList.get(i).getEmployerPf() + "#~#" + progList.get(i).getNcpDays() + "#~#0");
			}

			// writer.println("The second line");
			writer.close();

			// FileUtils.writeStringToFile(file, "helloooo");

			if (file != null) {
				String date = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss").format(new Date());
				response.setContentType("application/text");

				response.addHeader("content-disposition",
						String.format("inline; filename=\"%s\"", "epf_" + date + ".txt"));

				response.setContentLength((int) file.length());

				InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

				try {
					FileCopyUtils.copy(inputStream, response.getOutputStream());
				} catch (IOException e) {
					// System.out.println("Excep in Opening a Pdf File");
					e.printStackTrace();
				}
			}
		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/showLoanLedgerReort", method = RequestMethod.GET)
	public void showLoanLedgerReort(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Loan Ledger Report";

		String leaveDateRange = request.getParameter("leaveDateRange");
		String[] arrOfStr = leaveDateRange.split("to", 2);
		Boolean ret = false;
		HttpSession session = request.getSession();

		String[] fromMonthYear = arrOfStr[0].split("-");
		String[] toMonthYear = arrOfStr[1].split("-");

		int locId = (int) session.getAttribute("liveLocationId");

		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("fromMonth", fromMonthYear[1].trim());
			map.add("toMonth", toMonthYear[1].trim());
			map.add("fromYear", fromMonthYear[2].trim());
			map.add("toYear", toMonthYear[2].trim());
			map.add("locId", locId);
			EmpOpningLoanList[] resArray = Constants.getRestTemplate()
					.postForObject(Constants.url + "payLoanLedgerReport", map, EmpOpningLoanList[].class);
			List<EmpOpningLoanList> progList = new ArrayList<>(Arrays.asList(resArray));

			String header = "";
			String title = "                 ";

			Document document = new Document(PageSize._11X17);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(6);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 2.5f, 5.5f, 4.5f, 4.5f, 3.5f, 3.5f });
			Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
			// BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																	// BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("-", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Discription", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Month", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Paid", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Returned", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Balance Amt", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			table.addCell(hcell);

			int index = 0;

			for (int i = 0; i < progList.size(); i++) {
				// System.err.println("I " + i);
				EmpOpningLoanList prog = progList.get(i);
				double balAmt = 0;
				index++;
				PdfPCell cell;

				cell = new PdfPCell(new Phrase("" + prog.getEmpName(), headFontData));
				cell.setColspan(6);
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				table.addCell(cell);

				for (int j = 0; j < prog.getLedgerList().size(); j++) {

					PdfPCell cell1;

					cell1 = new PdfPCell(new Phrase("", headFontData));
					cell1.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell1.setHorizontalAlignment(Element.ALIGN_LEFT);
					table.addCell(cell1);

					cell1 = new PdfPCell(new Phrase("" + prog.getLedgerList().get(j).getCaptionName(), headFontData));
					cell1.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell1.setHorizontalAlignment(Element.ALIGN_LEFT);
					table.addCell(cell1);

					cell1 = new PdfPCell(new Phrase("" + prog.getLedgerList().get(j).getMonthName(), headFontData));
					cell1.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell1.setHorizontalAlignment(Element.ALIGN_LEFT);
					table.addCell(cell1);

					cell1 = new PdfPCell(new Phrase("" + prog.getLedgerList().get(j).getPaid(), headFontData));
					cell1.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell1.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table.addCell(cell1);

					cell1 = new PdfPCell(new Phrase("" + prog.getLedgerList().get(j).getReturnAmt(), headFontData));
					cell1.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell1.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table.addCell(cell1);

					balAmt = balAmt + prog.getLedgerList().get(j).getPaid()
							- prog.getLedgerList().get(j).getReturnAmt();

					cell1 = new PdfPCell(new Phrase("" + balAmt, headFontData));
					cell1.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell1.setHorizontalAlignment(Element.ALIGN_RIGHT);
					table.addCell(cell1);

				}

			}

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));
			document.add(new Paragraph("Month : " + fromMonthYear[1].trim() + "-" + fromMonthYear[2].trim() + " To "
					+ toMonthYear[1].trim() + "-" + toMonthYear[2].trim()));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p"));
			// System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Emp Name");
				rowData.add("Discription");
				rowData.add("Month");
				rowData.add("Paid");
				rowData.add("Returned");
				rowData.add("Balace");
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				for (int i = 0; i < progList.size(); i++) {

					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();

					rowData.add("" + progList.get(i).getEmpName());
					rowData.add("-");
					rowData.add("-");
					rowData.add("-");
					rowData.add("-");
					rowData.add("-");

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

					double balAmt = 0;

					for (int j = 0; j < progList.get(i).getLedgerList().size(); j++) {

						expoExcel = new ExportToExcel();
						rowData = new ArrayList<String>();

						rowData.add("");
						rowData.add("" + progList.get(i).getLedgerList().get(j).getCaptionName());
						rowData.add("" + progList.get(i).getLedgerList().get(j).getMonthName());
						rowData.add("" + progList.get(i).getLedgerList().get(j).getPaid());
						rowData.add("" + progList.get(i).getLedgerList().get(j).getReturnAmt());
						balAmt = balAmt + progList.get(i).getLedgerList().get(j).getPaid()
								- progList.get(i).getLedgerList().get(j).getReturnAmt();
						rowData.add("" + balAmt);

						expoExcel.setRowData(rowData);
						exportToExcelList.add(expoExcel);
					}

				}

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName, "",
							" , Month : " + fromMonthYear[1].trim() + "-" + fromMonthYear[2].trim() + " To "
									+ toMonthYear[1].trim() + "-" + toMonthYear[2].trim(),
							'F');
					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/showAdvanceDeudctionReport", method = RequestMethod.GET)
	public void showAdvanceDeudctionReport(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Advance Deduct Report";

		String leaveDateRange = request.getParameter("date");
		String[] arrOfStr = leaveDateRange.split("-");
		Boolean ret = false;
		HttpSession session = request.getSession();

		int locId = (int) session.getAttribute("liveLocationId");

		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("month", arrOfStr[0]);
			map.add("year", arrOfStr[1]);
			map.add("locId", locId);
			EmpOpningLoanList[] resArray = Constants.getRestTemplate()
					.postForObject(Constants.url + "getAdvanceDeductionReport", map, EmpOpningLoanList[].class);
			List<EmpOpningLoanList> progList = new ArrayList<>(Arrays.asList(resArray));

			String header = "";
			String title = "";

			Document document = new Document(PageSize._11X17);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(3);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 2.5f, 5.5f, 4.5f });
			Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
			// BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																	// BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Amount", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			table.addCell(hcell);

			int index = 0;
			double balAmt = 0;
			DecimalFormat df = new DecimalFormat("#.00");

			for (int i = 0; i < progList.size(); i++) {
				// System.err.println("I " + i);
				EmpOpningLoanList prog = progList.get(i);

				index++;
				PdfPCell cell;

				cell = new PdfPCell(new Phrase("" + index, headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpName(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + Double.parseDouble(df.format(prog.getOpAmt())), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(cell);
				balAmt = balAmt + prog.getOpAmt();

			}

			hcell = new PdfPCell();

			hcell = new PdfPCell(new Phrase("Total", headFontData));
			hcell.setColspan(2);
			hcell.setHorizontalAlignment(Element.ALIGN_RIGHT);
			hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("" + Double.parseDouble(df.format(balAmt)), headFontData));
			hcell.setHorizontalAlignment(Element.ALIGN_RIGHT);
			hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			table.addCell(hcell);

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));
			document.add(new Paragraph("Month : " + arrOfStr[0] + "-" + arrOfStr[1]));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p"));
			// System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();
				rowData.add("Sr.No.");
				rowData.add("Emp Name");
				rowData.add("Ammount");
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				for (int i = 0; i < progList.size(); i++) {

					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					rowData.add("" + (i + 1));
					rowData.add("" + progList.get(i).getEmpName());
					rowData.add("" + progList.get(i).getOpAmt());

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

				}

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName, "",
							" , Month : " + arrOfStr[0] + "-" + arrOfStr[1], 'C');
					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	/*
	 * @RequestMapping(value = "/showLoanYearlyRep", method = RequestMethod.GET)
	 * public void showLoanYearlyRep(HttpServletRequest request, HttpServletResponse
	 * response) {
	 * 
	 * String reportName = "Yearly Loan Amount";
	 * 
	 * HttpSession session = request.getSession();
	 * 
	 * String month = request.getParameter("date");
	 * 
	 * String temp[] = month.split("-"); Boolean ret = false; try {
	 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
	 * Object>(); map.add("companyId", 1); map.add("year", temp[1]); GetYearlyLoan[]
	 * resArray = Constants.getRestTemplate() .postForObject(Constants.url +
	 * "getLoanYearlyReport", map, GetYearlyLoan[].class); List<GetYearlyLoan>
	 * progList = new ArrayList<>(Arrays.asList(resArray));
	 * 
	 * 
	 * map = new LinkedMultiValueMap<>(); map.add("empRes", -1);
	 * map.add("companyId", 1);
	 * 
	 * EmployeeMaster[] empArr =
	 * Constants.getRestTemplate().postForObject(Constants.url + "/getAllEmp", map,
	 * EmployeeMaster[].class); List<EmployeeMaster> empList = new
	 * ArrayList<EmployeeMaster>(Arrays.asList(empArr));
	 * 
	 * String header = ""; String title = "                 ";
	 * 
	 * DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy"); String repDate =
	 * DF2.format(new Date());
	 * 
	 * Document document = new Document(PageSize._11X17); document.setMargins(5, 5,
	 * 0, 0); document.setMarginMirroring(false);
	 * 
	 * String FILE_PATH = Constants.REPORT_SAVE; File file = new File(FILE_PATH);
	 * 
	 * PdfWriter writer = null;
	 * 
	 * FileOutputStream out = new FileOutputStream(FILE_PATH); try { writer =
	 * PdfWriter.getInstance(document, out); } catch (DocumentException e) {
	 * 
	 * e.printStackTrace(); }
	 * 
	 * ItextPageEvent event = new ItextPageEvent(header, title, "", "");
	 * 
	 * writer.setPageEvent(event); // writer.add(new
	 * Paragraph("Curricular Aspects"));
	 * 
	 * PdfPTable table = new PdfPTable(16);
	 * 
	 * table.setHeaderRows(1);
	 * 
	 * table.setWidthPercentage(100); table.setWidths(new float[] { 2.0f, 3.0f,
	 * 5.5f, 2.2f, 2.2f, 2.2f, 2.2f, 2.2f, 2.2f, 2.2f, 2.2f, 2.2f, 2.2f, 2.2f, 2.2f,
	 * 2.2f }); Font headFontData = ReportCostants.headFontData;// new
	 * Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL, // BaseColor.BLACK); Font
	 * tableHeaderFont = ReportCostants.tableHeaderFont; // new
	 * Font(FontFamily.HELVETICA, 12, Font.BOLD, // BaseColor.BLACK);
	 * tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);
	 * 
	 * PdfPCell hcell = new PdfPCell();
	 * hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);
	 * 
	 * hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
	 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
	 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
	 * 
	 * table.addCell(hcell);
	 * 
	 * hcell = new PdfPCell(new Phrase("Employee Code", tableHeaderFont));
	 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
	 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
	 * 
	 * table.addCell(hcell);
	 * 
	 * hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
	 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
	 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
	 * 
	 * table.addCell(hcell);
	 * 
	 * hcell = new PdfPCell(new Phrase("Jan", tableHeaderFont));
	 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
	 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
	 * 
	 * table.addCell(hcell);
	 * 
	 * hcell = new PdfPCell(new Phrase("Feb", tableHeaderFont));
	 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
	 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
	 * 
	 * table.addCell(hcell);
	 * 
	 * hcell = new PdfPCell(new Phrase("March", tableHeaderFont));
	 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
	 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
	 * 
	 * table.addCell(hcell); hcell = new PdfPCell(new Phrase("April",
	 * tableHeaderFont)); hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
	 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
	 * 
	 * table.addCell(hcell);
	 * 
	 * hcell = new PdfPCell(new Phrase("May", tableHeaderFont));
	 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
	 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
	 * 
	 * table.addCell(hcell);
	 * 
	 * hcell = new PdfPCell(new Phrase("June", tableHeaderFont));
	 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
	 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
	 * 
	 * table.addCell(hcell); hcell = new PdfPCell(new Phrase("July",
	 * tableHeaderFont)); hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
	 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
	 * 
	 * table.addCell(hcell);
	 * 
	 * hcell = new PdfPCell(new Phrase("Aug", tableHeaderFont));
	 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
	 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
	 * 
	 * table.addCell(hcell);
	 * 
	 * hcell = new PdfPCell(new Phrase("Sep", tableHeaderFont));
	 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
	 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
	 * 
	 * table.addCell(hcell); hcell = new PdfPCell(new Phrase("Oct",
	 * tableHeaderFont)); hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
	 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
	 * 
	 * table.addCell(hcell);
	 * 
	 * hcell = new PdfPCell(new Phrase("Nov", tableHeaderFont));
	 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
	 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
	 * 
	 * table.addCell(hcell);
	 * 
	 * hcell = new PdfPCell(new Phrase("Dec", tableHeaderFont));
	 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
	 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
	 * 
	 * table.addCell(hcell);
	 * 
	 * hcell = new PdfPCell(new Phrase("Total", tableHeaderFont));
	 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
	 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
	 * 
	 * table.addCell(hcell);
	 * 
	 * 
	 * 
	 * 
	 * int index = 0;
	 * 
	 * for (int j = 0; j < empList.size(); j++) {
	 * 
	 * int empId=empList.get(j).getEmpId();
	 * 
	 * for (int i = 0; i < progList.size(); i++) { GetYearlyLoan prog =
	 * progList.get(i);
	 * 
	 * 
	 * if(prog.getEmpId()==empId &&) {
	 * 
	 * }
	 * 
	 * 
	 * 
	 * // System.err.println("I " + i);
	 * 
	 * 
	 * index++; PdfPCell cell; cell = new PdfPCell(new Phrase(String.valueOf(index),
	 * headFontData)); cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	 * cell.setHorizontalAlignment(Element.ALIGN_CENTER);
	 * 
	 * table.addCell(cell);
	 * 
	 * cell = new PdfPCell(new Phrase("" + prog.getEmpCode(), headFontData));
	 * cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	 * cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	 * 
	 * table.addCell(cell);
	 * 
	 * cell = new PdfPCell(new Phrase("" + prog.getEmpName(), headFontData));
	 * cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	 * cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	 * 
	 * table.addCell(cell);
	 * 
	 * cell = new PdfPCell(new Phrase("" + prog.getJanCount(), headFontData));
	 * cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
	 * 
	 * table.addCell(cell);
	 * 
	 * cell = new PdfPCell(new Phrase("" + prog.getFebCount(), headFontData));
	 * cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
	 * 
	 * table.addCell(cell);
	 * 
	 * cell = new PdfPCell(new Phrase("" + prog.getMarchCount(), headFontData));
	 * cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
	 * 
	 * table.addCell(cell);
	 * 
	 * cell = new PdfPCell(new Phrase("" + prog.getMayCount(), headFontData));
	 * cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
	 * 
	 * table.addCell(cell); cell = new PdfPCell(new Phrase("" +
	 * prog.getMarchCount(), headFontData));
	 * cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
	 * 
	 * table.addCell(cell); cell = new PdfPCell(new Phrase("" + prog.getJunCount(),
	 * headFontData)); cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
	 * 
	 * table.addCell(cell); cell = new PdfPCell(new Phrase("" + prog.getJulCount(),
	 * headFontData)); cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
	 * 
	 * table.addCell(cell); cell = new PdfPCell(new Phrase("" + prog.getAugCount(),
	 * headFontData)); cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
	 * 
	 * table.addCell(cell); cell = new PdfPCell(new Phrase("" + prog.getSepCount(),
	 * headFontData)); cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
	 * 
	 * table.addCell(cell); cell = new PdfPCell(new Phrase("" + prog.getOctCount(),
	 * headFontData)); cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT); table.addCell(cell);
	 * 
	 * cell = new PdfPCell(new Phrase("" + prog.getNovCount(), headFontData));
	 * cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT); table.addCell(cell);
	 * 
	 * cell = new PdfPCell(new Phrase("" + prog.getDecCount(), headFontData));
	 * cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT); table.addCell(cell);
	 * 
	 * cell = new PdfPCell(new Phrase("" + prog.getTotal(), headFontData));
	 * cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT); table.addCell(cell);
	 * 
	 * }}
	 * 
	 * document.open(); Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f,
	 * Font.UNDERLINE, BaseColor.BLACK);
	 * 
	 * Paragraph name = new Paragraph(reportName, hf);
	 * name.setAlignment(Element.ALIGN_CENTER); document.add(name); document.add(new
	 * Paragraph("\n")); document.add(new Paragraph("Year:" + temp[1]));
	 * 
	 * document.add(new Paragraph("\n")); DateFormat DF = new
	 * SimpleDateFormat("dd-MM-yyyy");
	 * 
	 * document.add(table);
	 * 
	 * int totalPages = writer.getPageNumber();
	 * 
	 * // System.out.println("Page no " + totalPages);
	 * 
	 * document.close(); int p = Integer.parseInt(request.getParameter("p")); //
	 * System.err.println("p " + p);
	 * 
	 * if (p == 1) {
	 * 
	 * if (file != null) {
	 * 
	 * String mimeType = URLConnection.guessContentTypeFromName(file.getName());
	 * 
	 * if (mimeType == null) {
	 * 
	 * mimeType = "application/pdf";
	 * 
	 * }
	 * 
	 * response.setContentType(mimeType);
	 * 
	 * response.addHeader("content-disposition",
	 * String.format("inline; filename=\"%s\"", file.getName()));
	 * 
	 * response.setContentLength((int) file.length());
	 * 
	 * InputStream inputStream = new BufferedInputStream(new FileInputStream(file));
	 * 
	 * try { FileCopyUtils.copy(inputStream, response.getOutputStream()); } catch
	 * (IOException e) { // System.out.println("Excep in Opening a Pdf File");
	 * e.printStackTrace(); } } } else {
	 * 
	 * List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();
	 * 
	 * ExportToExcel expoExcel = new ExportToExcel(); List<String> rowData = new
	 * ArrayList<String>();
	 * 
	 * rowData.add("Sr. No"); rowData.add("Emp Code"); rowData.add("Emp Name");
	 * rowData.add("Jan"); rowData.add("Feb"); rowData.add("March");
	 * rowData.add("April"); rowData.add("May"); rowData.add("June");
	 * rowData.add("July"); rowData.add("Aug"); rowData.add("Sep");
	 * rowData.add("Oct"); rowData.add("Nov"); rowData.add("Dec");
	 * rowData.add("Total");
	 * 
	 * expoExcel.setRowData(rowData); exportToExcelList.add(expoExcel); int cnt = 1;
	 * for (int i = 0; i < progList.size(); i++) { expoExcel = new ExportToExcel();
	 * rowData = new ArrayList<String>(); cnt = cnt + i;
	 * 
	 * rowData.add("" + (i + 1)); rowData.add("" + progList.get(i).getEmpCode());
	 * rowData.add("" + progList.get(i).getEmpName()); rowData.add("" +
	 * progList.get(i).getJanCount()); rowData.add("" +
	 * progList.get(i).getFebCount()); rowData.add("" +
	 * progList.get(i).getMarchCount()); rowData.add("" +
	 * progList.get(i).getAprCount());
	 * 
	 * rowData.add("" + progList.get(i).getMayCount()); rowData.add("" +
	 * progList.get(i).getJunCount());
	 * 
	 * rowData.add("" + progList.get(i).getJulCount()); rowData.add("" +
	 * progList.get(i).getAugCount());
	 * 
	 * rowData.add("" + progList.get(i).getSepCount()); rowData.add("" +
	 * progList.get(i).getOctCount());
	 * 
	 * rowData.add("" + progList.get(i).getNovCount()); rowData.add("" +
	 * progList.get(i).getDecCount()); rowData.add("" + progList.get(i).getTotal());
	 * 
	 * expoExcel.setRowData(rowData); exportToExcelList.add(expoExcel);
	 * 
	 * }
	 * 
	 * XSSFWorkbook wb = null; try {
	 * 
	 * wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName, "Year:" +
	 * temp[1], "", 'P');
	 * 
	 * ExceUtil.autoSizeColumns(wb, 3);
	 * response.setContentType("application/vnd.ms-excel"); String date = new
	 * SimpleDateFormat("yyyy-MM-dd").format(new Date());
	 * response.setHeader("Content-disposition", "attachment; filename=" +
	 * reportName + "-" + date + ".xlsx"); wb.write(response.getOutputStream());
	 * 
	 * } catch (IOException ioe) { throw new
	 * RuntimeException("Error writing spreadsheet to output stream"); } finally {
	 * if (wb != null) { wb.close(); } } }
	 * 
	 * } catch (Exception e) {
	 * 
	 * System.err.println("Exce in showProgReport " + e.getMessage());
	 * e.printStackTrace();
	 * 
	 * } }
	 */
	// ******************PF Statement***********************

	@RequestMapping(value = "/showEmpPfRep", method = RequestMethod.GET)
	public void showEmpPfRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Employee PF Statement";
		String leaveDateRange = request.getParameter("leaveDateRange");
		String[] arrOfStr = leaveDateRange.split("to", 2);
		int cmpId = 0;
		try {
			cmpId = Integer.parseInt(request.getParameter("subCmpId"));

		} catch (Exception e) {
			cmpId = 0;
		}

		String cmpName = "-";

		try {
			HttpSession session = request.getSession();
			int locId = (int) session.getAttribute("liveLocationId");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("companyId", cmpId);
			map.add("fromDate", arrOfStr[0]);
			map.add("toDate", arrOfStr[1]);
			map.add("locId", locId);
			GetSalaryCalcReport[] resArray = Constants.getRestTemplate().postForObject(Constants.url + "getPfStatement",
					map, GetSalaryCalcReport[].class);
			List<GetSalaryCalcReport> progList = new ArrayList<>(Arrays.asList(resArray));

			String header = "";
			String title = "                 ";
			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			Document document = new Document(PageSize._11X17);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(6);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 2.0f, 3.0f, 6.5f, 3.5f, 3.5f, 3.5f });
			Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
			// BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																	// BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Code", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("EPF Wages", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee's Contribution PF", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("EPF %", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			int index = 0;
			for (int i = 0; i < progList.size(); i++) {
				// System.err.println("I " + i);
				GetSalaryCalcReport prog = progList.get(i);

				index++;
				PdfPCell cell;
				cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpCode(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpName(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEpfWages(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmployeePf(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEpfPercentage(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);
				if (cmpId != 0) {
					cmpName = prog.getCompanyName();

				}

			}

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));
			document.add(new Paragraph("Date Range: " + leaveDateRange));
			document.add(new Paragraph("Company Name: " + cmpName));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p"));
			// System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Sr. No");
				rowData.add("Emp Code");
				rowData.add("Emp Name");
				rowData.add("EPF Wages");
				rowData.add("Employee's Contribution PF");
				rowData.add("EPF %");

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;
				for (int i = 0; i < progList.size(); i++) {
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					cnt = cnt + i;

					rowData.add("" + (i + 1));
					rowData.add("" + progList.get(i).getEmpCode());
					rowData.add("" + progList.get(i).getEmpName());
					rowData.add("" + progList.get(i).getEpfWages());
					rowData.add("" + progList.get(i).getEmployeePf());
					rowData.add("" + progList.get(i).getEpfPercentage());

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

					if (cmpId != 0) {
						cmpName = progList.get(i).getCompanyName();

					}

				}

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
							"Date Range:" + leaveDateRange + " Company Name:" + cmpName, "", 'F');

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/showEmployerPfRep", method = RequestMethod.GET)
	public void showEmployerPfRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Employer PF  Statement";

		HttpSession session = request.getSession();

		String leaveDateRange = request.getParameter("leaveDateRange");
		String[] arrOfStr = leaveDateRange.split("to", 2);
		int cmpId = 0;
		try {
			cmpId = Integer.parseInt(request.getParameter("subCmpId"));

		} catch (Exception e) {
			cmpId = 0;
		}
		String cmpName = "-";

		try {

			int locId = (int) session.getAttribute("liveLocationId");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("companyId", cmpId);
			map.add("fromDate", arrOfStr[0]);
			map.add("toDate", arrOfStr[1]);
			map.add("locId", locId);

			GetSalaryCalcReport[] resArray = Constants.getRestTemplate().postForObject(Constants.url + "getPfStatement",
					map, GetSalaryCalcReport[].class);
			List<GetSalaryCalcReport> progList = new ArrayList<>(Arrays.asList(resArray));

			String header = "";
			String title = "                 ";
			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			Document document = new Document(PageSize._11X17);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(5);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 2.0f, 3.0f, 5.5f, 3.5f, 3.5f });
			Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
			// BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																	// BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Code", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("EPS Contribution", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("EPF Difference", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			/*
			 * hcell = new PdfPCell(new Phrase("EPF %", tableHeaderFont));
			 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			 * 
			 * table.addCell(hcell);
			 */

			int index = 0;
			for (int i = 0; i < progList.size(); i++) {
				// System.err.println("I " + i);
				GetSalaryCalcReport prog = progList.get(i);

				index++;
				PdfPCell cell;
				cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpCode(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpName(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmployerEps(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmployerPf(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(cell);

				/*
				 * cell = new PdfPCell(new Phrase("" + prog.getEpfEmployerPercentage(),
				 * headFontData)); cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				 * 
				 * table.addCell(cell);
				 */

				if (cmpId != 0) {
					cmpName = prog.getCompanyName();

				}

			}

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));
			document.add(new Paragraph("Date Range: " + leaveDateRange));
			document.add(new Paragraph("Company Name: " + cmpName));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p"));
			// System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Sr. No");
				rowData.add("Emp Code");
				rowData.add("Emp Name");
				rowData.add("EPS Contribution");
				rowData.add("EPF Difference");
				/* rowData.add("EPF %"); */

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;
				for (int i = 0; i < progList.size(); i++) {
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					cnt = cnt + i;

					rowData.add("" + (i + 1));
					rowData.add("" + progList.get(i).getEmpCode());
					rowData.add("" + progList.get(i).getEmpName());
					rowData.add("" + progList.get(i).getEmployerEps());
					rowData.add("" + progList.get(i).getEmployerPf());
					/* rowData.add("" + progList.get(i).getEpfEmployerPercentage()); */

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

					if (cmpId != 0) {

						cmpName = progList.get(i).getCompanyName();
					}

				}

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
							"DateRange:" + leaveDateRange + " Company Name:" + cmpName, "", 'F');

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/showEmployeeEmployerPfRep", method = RequestMethod.GET)
	public void showEmployeeEmployerPfRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Employee Employer PF  Statement";

		HttpSession session = request.getSession();

		String leaveDateRange = request.getParameter("leaveDateRange");
		String[] arrOfStr = leaveDateRange.split("to", 2);
		int cmpId = 0;
		try {
			cmpId = Integer.parseInt(request.getParameter("subCmpId"));

		} catch (Exception e) {
			cmpId = 0;
		}

		String cmpName = "-";

		Boolean ret = false;
		try {
			int locId = (int) session.getAttribute("liveLocationId");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("companyId", cmpId);
			map.add("fromDate", arrOfStr[0]);
			map.add("toDate", arrOfStr[1]);
			map.add("locId", locId);
			GetSalaryCalcReport[] resArray = Constants.getRestTemplate().postForObject(Constants.url + "getPfStatement",
					map, GetSalaryCalcReport[].class);
			List<GetSalaryCalcReport> progList = new ArrayList<>(Arrays.asList(resArray));

			String header = "";
			String title = "                 ";
			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			Document document = new Document(PageSize._11X17);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(8);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 2.0f, 6.5f, 3.0f, 3.0f, 2.5f, 2.5f, 2.5f, 2.5f });
			Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
			// BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																	// BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("PF A/c No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("UAN No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("EPF Wages", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Contribution EPF", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("EPF Difference", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("EPS Value", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			int index = 0;
			for (int i = 0; i < progList.size(); i++) {
				// System.err.println("I " + i);
				GetSalaryCalcReport prog = progList.get(i);

				index++;
				PdfPCell cell;
				cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpName() + " (" + prog.getEmpCode() + ")", headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(prog.getCompanyName(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(prog.getNameSd(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEpfWages(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmployeePf(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmployerPf(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmployerEps(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(cell);

				if (cmpId != 0) {
					cmpName = prog.getCompanyName();

				}

			}

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));
			document.add(new Paragraph("DateRange: " + leaveDateRange));
			document.add(new Paragraph("Company Name: " + cmpName));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p"));
			// System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Sr. No");
				rowData.add("Emp Name");
				rowData.add("PF A/C No.");
				rowData.add("UAN No.");
				rowData.add("EPF Wages");
				rowData.add("Contribution EPF");
				rowData.add("EPF Difference");
				rowData.add("EPS Value");
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;
				for (int i = 0; i < progList.size(); i++) {
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					cnt = cnt + i;

					rowData.add("" + (i + 1));
					rowData.add("" + progList.get(i).getEmpName() + " " + progList.get(i).getEmpCode());
					rowData.add("" + progList.get(i).getCompanyName());
					rowData.add("" + progList.get(i).getNameSd());
					rowData.add("" + progList.get(i).getEpfWages());
					rowData.add("" + progList.get(i).getEmployeePf());
					rowData.add("" + progList.get(i).getEmployerEps());
					rowData.add("" + progList.get(i).getEmployerPf());

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

					if (cmpId != 0) {

						cmpName = progList.get(i).getCompanyName();
					}

				}

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
							"DateRange:" + leaveDateRange + " Company Name:" + cmpName, "", 'H');

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/showPfSummaryReport", method = RequestMethod.GET)
	public void showPfSummaryReport(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Employee Employer PF Summary Statement";

		HttpSession session = request.getSession();

		String leaveDateRange = request.getParameter("leaveDateRange");
		String[] arrOfStr = leaveDateRange.split("to", 2);
		int cmpId = 0;
		try {
			cmpId = Integer.parseInt(request.getParameter("subCmpId"));

		} catch (Exception e) {
			cmpId = 0;
		}

		String cmpName = "-";

		Boolean ret = false;
		try {
			int locId = (int) session.getAttribute("liveLocationId");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("companyId", cmpId);
			map.add("fromDate", arrOfStr[0]);
			map.add("toDate", arrOfStr[1]);
			map.add("locId", locId);
			GetPfStatementSummary[] resArray = Constants.getRestTemplate()
					.postForObject(Constants.url + "getPfStatementSummary", map, GetPfStatementSummary[].class);
			List<GetPfStatementSummary> progList = new ArrayList<>(Arrays.asList(resArray));

			String header = "";
			String title = "                 ";
			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			Document document = new Document(PageSize._11X17);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(8);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 2.0f, 6.5f, 3.0f, 3.0f, 2.5f, 2.5f, 2.5f, 2.5f });
			Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
			// BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																	// BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("PF A/c No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("UAN No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("EPF Wages", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Contribution EPF", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("EPF Difference", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("EPS Value", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			int index = 0;
			for (int i = 0; i < progList.size(); i++) {
				// System.err.println("I " + i);
				GetPfStatementSummary prog = progList.get(i);

				index++;
				PdfPCell cell;
				cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpName() + " (" + prog.getEmpCode() + ")", headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(prog.getPfNo(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(prog.getUan(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEpfWages(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmployeePf(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmployerPf(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmployerEps(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(cell);

			}

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));
			document.add(new Paragraph("DateRange: " + leaveDateRange));
			// document.add(new Paragraph("Company Name: " + cmpName));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p"));
			// System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Sr. No");
				rowData.add("Emp Name");
				rowData.add("PF A/C No.");
				rowData.add("UAN No.");
				rowData.add("EPF Wages");
				rowData.add("Contribution EPF");
				rowData.add("EPF Difference");
				rowData.add("EPS Value");
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;
				for (int i = 0; i < progList.size(); i++) {
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					cnt = cnt + i;

					rowData.add("" + (i + 1));
					rowData.add("" + progList.get(i).getEmpName() + " " + progList.get(i).getEmpCode());
					rowData.add("" + progList.get(i).getPfNo());
					rowData.add("" + progList.get(i).getUan());
					rowData.add("" + progList.get(i).getEpfWages());
					rowData.add("" + progList.get(i).getEmployeePf());
					rowData.add("" + progList.get(i).getEmployerEps());
					rowData.add("" + progList.get(i).getEmployerPf());

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

				}

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName, "DateRange:" + leaveDateRange, "",
							'H');

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy_MM_dd_HH_mm_ss").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/showEmpPfRepEmpWise", method = RequestMethod.GET)
	public void showEmpPfRepEmpWise(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Employee PF Statement";

		int empId = 0;
		try {
			empId = Integer.parseInt(request.getParameter("empId1"));

		} catch (Exception e) {
			empId = 0;

		}
		String fromDate = request.getParameter("datepickerFromRep");
		String toDate = request.getParameter("datepickerToRep");

		System.err.println("empId :" + empId);

		Boolean ret = false;
		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("empId", empId);
			map.add("fromDate", fromDate);
			map.add("toDate", toDate);

			GetSalaryCalcReport[] resArray = Constants.getRestTemplate()
					.postForObject(Constants.url + "getEmpPfStatement", map, GetSalaryCalcReport[].class);
			List<GetSalaryCalcReport> progList = new ArrayList<>(Arrays.asList(resArray));

			String header = "";
			String title = "                 ";
			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			Document document = new Document(PageSize._11X17);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(6);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 2.0f, 3.0f, 6.5f, 3.0f, 3.0f, 3.0f });
			Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
			// BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																	// BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Code", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("EPF Wages", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee's Contribution PF", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("EPF %", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			int index = 0;
			for (int i = 0; i < progList.size(); i++) {
				// System.err.println("I " + i);
				GetSalaryCalcReport prog = progList.get(i);

				index++;
				PdfPCell cell;
				cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpCode(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpName(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEpfWages(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmployeePf(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEpfPercentage(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

			}

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));
			document.add(new Paragraph("DateRange: " + fromDate + "To" + toDate));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p"));
			// System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Sr. No");
				rowData.add("Emp Code");
				rowData.add("Emp Name");
				rowData.add("EPF Wages");
				rowData.add("Employee's Contribution PF");
				rowData.add("EPF %");

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;
				for (int i = 0; i < progList.size(); i++) {
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					cnt = cnt + i;

					rowData.add("" + (i + 1));
					rowData.add("" + progList.get(i).getEmpCode());
					rowData.add("" + progList.get(i).getEmpName());
					rowData.add("" + progList.get(i).getEpfWages());
					rowData.add("" + progList.get(i).getEmployeePf());
					rowData.add("" + progList.get(i).getEpfPercentage());

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

				}

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
							"Date Range:" + fromDate + "To" + toDate, "", 'F');

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/getPtChallanRep", method = RequestMethod.GET)
	public void getPtChallanRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Professsional Tax Challen";

		String leaveDateRange = request.getParameter("date");
		String[] arrOfStr = leaveDateRange.split("-");
		int cmpId = 0;
		try {
			cmpId = Integer.parseInt(request.getParameter("subCmpId"));

		} catch (Exception e) {
			cmpId = 0;
		}

		System.err.println("cmpId" + cmpId);

		String cmpName = "-";

		Boolean ret = false;
		try {

			HttpSession session = request.getSession();
			int locId = (int) session.getAttribute("liveLocationId");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("companyId", cmpId);
			map.add("month", arrOfStr[0]);
			map.add("year", arrOfStr[1]);
			map.add("locId", locId);
			GetPtChallan[] resArray = Constants.getRestTemplate().postForObject(Constants.url + "getPtChallanRep", map,
					GetPtChallan[].class);
			List<GetPtChallan> progList = new ArrayList<>(Arrays.asList(resArray));

			String header = "";
			String title = "                 ";
			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			Document document = new Document(PageSize._11X17);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(5);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 2.0f, 5.5f, 3.5f, 3.5f, 3.5f });
			Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
			// BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																	// BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);
			hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			hcell.setPadding(5);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("PT Limit", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			hcell.setPadding(5);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Rate Per Month", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			hcell.setPadding(5);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("No. of Employees", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			hcell.setPadding(5);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Total Amount", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			hcell.setPadding(5);
			table.addCell(hcell);

			int totalEmp = 0;
			double totalAMT = 0;

			int index = 0;
			for (int i = 0; i < progList.size(); i++) {
				// System.err.println("I " + i);
				GetPtChallan prog = progList.get(i);

				index++;
				PdfPCell cell;
				cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				cell.setPadding(5);
				table.addCell(cell);

				cell = new PdfPCell(
						new Phrase("" + prog.getMinVal() + "-" + prog.getMaxVal() + " (" + prog.getGenderName() + ") ",
								headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setPadding(5);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getAmount(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				cell.setPadding(5);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getCount(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				cell.setPadding(5);
				table.addCell(cell);
				totalEmp = totalEmp + prog.getCount();

				cell = new PdfPCell(new Phrase("" + (prog.getCount() * prog.getAmount()), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				cell.setPadding(5);
				table.addCell(cell);
				totalAMT = totalAMT + (prog.getCount() * prog.getAmount());

			}

			PdfPCell cell;
			cell = new PdfPCell(new Phrase("Total", headFontData));
			cell.setColspan(3);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setPadding(5);
			table.addCell(cell);

			cell = new PdfPCell(new Phrase("" + totalEmp, headFontData));
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
			cell.setPadding(5);
			table.addCell(cell);

			cell = new PdfPCell(new Phrase("" + totalAMT, headFontData));
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
			cell.setPadding(5);
			table.addCell(cell);

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));
			document.add(new Paragraph("Month : " + leaveDateRange));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p"));
			// System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {

				map = new LinkedMultiValueMap<String, Object>();
				map.add("companyId", cmpId);
				MstCompanySub mstCompanySub = Constants.getRestTemplate()
						.postForObject(Constants.url + "getSubCompanyById", map, MstCompanySub.class);
				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();
				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Employees whose Monthly Salary / Wages");
				rowData.add("Rate of Tax Per Month");
				rowData.add("No. of Employees");
				rowData.add("Amount of Tax Deducted");

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;

				for (int i = 0; i < progList.size(); i++) {

					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					cnt = cnt + i;
					String caption = "SALARY>=" + progList.get(i).getMinVal() + " AND SALARY<="
							+ progList.get(i).getMaxVal() + " ( " + progList.get(i).getGenderName() + " )";
					rowData.add("" + caption);
					rowData.add("" + progList.get(i).getAmount());
					rowData.add("" + progList.get(i).getCount());
					rowData.add("" + (progList.get(i).getCount() * progList.get(i).getAmount()));
					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

				}

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("");
				rowData.add("");
				rowData.add("");
				rowData.add("");
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("TOTAL AMOUNT");
				rowData.add("");
				rowData.add("" + totalEmp);
				rowData.add("" + totalAMT);
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("INTERESET IF ANY");
				rowData.add("");
				rowData.add("");
				rowData.add("0");
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("");
				rowData.add("");
				rowData.add("");
				rowData.add("");
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("LESS EXCESS TAX PAID IN THE PREVIOUS YR/QTR/MONTH");
				rowData.add("");
				rowData.add("");
				rowData.add("");
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("");
				rowData.add("");
				rowData.add("");
				rowData.add("");
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("NET AMOUNT PAYABLE");
				rowData.add("");
				rowData.add("");
				rowData.add("" + totalAMT);
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("TOTAL AMOUNT PAID Rs. " + EnglishNumberToWords.convert((long) totalAMT).toUpperCase()
						+ " ONLY");
				rowData.add("");
				rowData.add("");
				rowData.add("" + totalAMT);
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("");
				rowData.add("");
				rowData.add("");
				rowData.add("");
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("");
				rowData.add("");
				rowData.add("");
				rowData.add("");
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("PROFESSIONAL TAX REGISTRATION NO.");
				rowData.add("");
				rowData.add("");
				rowData.add("PERIOD TO");
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("");
				rowData.add("");
				rowData.add("");
				rowData.add("" + arrOfStr[0] + "/" + arrOfStr[1]);
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("NAME & ADDRESS: ");
				rowData.add("" + mstCompanySub.getCompanyName() + ", " + mstCompanySub.getLongAdd1());
				rowData.add("");
				rowData.add("");
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("");
				rowData.add("");
				rowData.add("");
				rowData.add("");
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("THE ABOVE STATEMENTS ARE TRUE TO THE BEST OF MY KNOWLEDGE AND BELIEF.");
				rowData.add("");
				rowData.add("");
				rowData.add("");
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("DATE:");
				rowData.add("");
				rowData.add("");
				rowData.add("");
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("");
				rowData.add("");
				rowData.add("");
				rowData.add("");
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("PLACE:");
				rowData.add("");
				rowData.add("");
				rowData.add("");
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("");
				rowData.add("FOR THE TREASYRY USE ONLY");
				rowData.add("");
				rowData.add("");
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("RECEIVED Rs. ");
				rowData.add("" + EnglishNumberToWords.convert((long) totalAMT).toUpperCase() + " ONLY");
				rowData.add("");
				rowData.add("" + totalAMT);
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("DATE OF ENTRY");
				rowData.add("");
				rowData.add("");
				rowData.add("");
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("Treasurer");
				rowData.add("Accountant");
				rowData.add("");
				rowData.add("");
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				XSSFWorkbook wb = null;
				try {

					/*
					 * wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName, "Month :" +
					 * leaveDateRange, "", 'E');
					 */
					wb = ExceUtil.createPTChalan(exportToExcelList, "", reportName, "Month :" + leaveDateRange, "",
							'D');

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd_hh_mm_ss").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/showEmpPTStatRep", method = RequestMethod.GET)
	public void showEmpPTStatRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Professional Tax Statement";
		String leaveDateRange = request.getParameter("leaveDateRange");
		String[] arrOfStr = leaveDateRange.split("to", 2);
		int cmpId = 0;
		try {
			cmpId = Integer.parseInt(request.getParameter("subCmpId"));

		} catch (Exception e) {
			cmpId = 0;
		}

		System.err.println("cmpId" + cmpId);

		String cmpName = "-";
		Boolean ret = false;
		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

			if (cmpId != 0) {
				map.add("companyId", cmpId);
				MstCompanySub comp = Constants.getRestTemplate().postForObject(Constants.url + "/getSubCompanyById",
						map, MstCompanySub.class);
				cmpName = comp.getCompanyName();
			}
			HttpSession session = request.getSession();
			int locId = (int) session.getAttribute("liveLocationId");

			map = new LinkedMultiValueMap<String, Object>();
			map.add("companyId", cmpId);
			map.add("fromDate", arrOfStr[0]);
			map.add("toDate", arrOfStr[1]);
			map.add("locId", locId);
			GetSalaryCalcReport[] resArray = Constants.getRestTemplate().postForObject(Constants.url + "getPtStatement",
					map, GetSalaryCalcReport[].class);
			List<GetSalaryCalcReport> progList = new ArrayList<>(Arrays.asList(resArray));

			String header = "";
			String title = "                 ";
			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			Document document = new Document(PageSize._11X17);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(5);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 2.0f, 3.0f, 6.5f, 3.5f, 3.5f });
			Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
			// BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																	// BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Code", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Month-Year", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			/*
			 * hcell = new PdfPCell(new Phrase("PT calculated On", tableHeaderFont));
			 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			 * 
			 * table.addCell(hcell);
			 */

			hcell = new PdfPCell(new Phrase("PT Amount", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			int index = 0;
			for (int i = 0; i < progList.size(); i++) {
				// System.err.println("I " + i);
				GetSalaryCalcReport prog = progList.get(i);

				index++;
				PdfPCell cell;
				cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpCode(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpName(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getCalcMonth() + "-" + prog.getCalcYear(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				/*
				 * cell = new PdfPCell(new Phrase("" + prog.getGrossSalary(), headFontData));
				 * cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT); table.addCell(cell);
				 */

				cell = new PdfPCell(new Phrase("" + prog.getPtDed(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);
				if (cmpId != 0) {
					cmpName = prog.getCompanyName();

				}

			}

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));
			document.add(new Paragraph("Date Range: " + leaveDateRange));
			document.add(new Paragraph("Company Name: " + cmpName));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p"));
			// System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Sr. No");
				rowData.add("Emp Code");
				rowData.add("Emp Name");
				rowData.add("Month-Year %");
				// rowData.add("PT calculated On");
				rowData.add("PT Amount");

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;
				for (int i = 0; i < progList.size(); i++) {
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					cnt = cnt + i;

					rowData.add("" + (i + 1));
					rowData.add("" + progList.get(i).getEmpCode());
					rowData.add("" + progList.get(i).getEmpName());
					rowData.add("" + progList.get(i).getCalcMonth() + "-" + progList.get(i).getCalcYear());
					// rowData.add("" + progList.get(i).getGrossSalary());
					rowData.add("" + progList.get(i).getPtDed());

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

					if (cmpId != 0) {
						cmpName = progList.get(i).getCompanyName();

					}

				}

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
							"Date Range:" + leaveDateRange + " Company Name:" + cmpName, "", 'F');

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/showMlwfStatRep", method = RequestMethod.GET)
	public void showMlwfStatRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "LWF Statement";
		String leaveDateRange = request.getParameter("leaveDateRange");
		String[] arrOfStr = leaveDateRange.split("to", 2);
		int cmpId = 0;
		try {
			cmpId = Integer.parseInt(request.getParameter("subCmpId"));

		} catch (Exception e) {
			cmpId = 0;
		}
		HttpSession session = request.getSession();
		int locId = (int) session.getAttribute("liveLocationId");

		String cmpName = "-";
		Boolean ret = false;
		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

			if (cmpId != 0) {
				map.add("companyId", cmpId);
				MstCompanySub comp = Constants.getRestTemplate().postForObject(Constants.url + "/getSubCompanyById",
						map, MstCompanySub.class);
				cmpName = comp.getCompanyName();
			}

			map = new LinkedMultiValueMap<String, Object>();
			map.add("companyId", cmpId);
			map.add("fromDate", arrOfStr[0]);
			map.add("toDate", arrOfStr[1]);
			map.add("locId", locId);
			GetSalaryCalcReport[] resArray = Constants.getRestTemplate()
					.postForObject(Constants.url + "getMLWFStatement", map, GetSalaryCalcReport[].class);
			List<GetSalaryCalcReport> progList = new ArrayList<>(Arrays.asList(resArray));

			String header = "";
			String title = "                 ";
			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			Document document = new Document(PageSize._11X17);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(8);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 2.0f, 3.0f, 6.5f, 3.5f, 3.5f, 3.5f, 3.5f, 3.5f });
			Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
			// BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																	// BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Code", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Department", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			/*
			 * hcell = new PdfPCell(new Phrase("DOB", tableHeaderFont));
			 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			 * 
			 * table.addCell(hcell);
			 */

			hcell = new PdfPCell(new Phrase("Gross Salary", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee's LWF", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employer's LWF", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Total", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			int index = 0;
			for (int i = 0; i < progList.size(); i++) {
				// System.err.println("I " + i);
				GetSalaryCalcReport prog = progList.get(i);

				index++;
				PdfPCell cell;
				cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpCode(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpName(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getNameSd(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getGrossSalary(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getMlwf(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmployerMlwf(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + (prog.getEmployerMlwf() + prog.getMlwf()), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

			}

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));
			document.add(new Paragraph("Date Range: " + leaveDateRange));
			document.add(new Paragraph("Company Name: " + cmpName));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p"));
			// System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Sr. No");
				rowData.add("Emp Code");
				rowData.add("Emp Name");
				rowData.add("Department");
				rowData.add("Gross Salary");
				rowData.add("Employee's LWF");
				rowData.add("Employer's LWF");
				rowData.add("Total");

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;
				for (int i = 0; i < progList.size(); i++) {
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					cnt = cnt + i;

					rowData.add("" + (i + 1));
					rowData.add("" + progList.get(i).getEmpCode());
					rowData.add("" + progList.get(i).getEmpName());
					rowData.add("" + progList.get(i).getNameSd());
					rowData.add("" + progList.get(i).getMlwf());
					rowData.add("" + progList.get(i).getEmployerMlwf());
					rowData.add("" + (progList.get(i).getEmployerMlwf() + progList.get(i).getMlwf()));

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

				}

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
							"Date Range:" + leaveDateRange + " Company Name:" + cmpName, "", 'H');

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd_hh_mm_ss").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/showStatutoryEsicRep", method = RequestMethod.GET)
	public void showStatutoryEsicRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Statutory ESIC Statement";
		String leaveDateRange = request.getParameter("leaveDateRange");
		String[] arrOfStr = leaveDateRange.split("to", 2);
		int cmpId = 0;
		try {
			cmpId = Integer.parseInt(request.getParameter("subCmpId"));

		} catch (Exception e) {
			cmpId = 0;
		}

		double salWagesTot = 0;
		double empCalTot = 0;
		double empr = 0;
		double tot = 0;

		System.err.println("cmpId" + cmpId);

		String cmpName = "-";
		Boolean ret = false;
		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

			if (cmpId != 0) {
				map.add("companyId", cmpId);
				MstCompanySub comp = Constants.getRestTemplate().postForObject(Constants.url + "/getSubCompanyById",
						map, MstCompanySub.class);
				cmpName = comp.getCompanyName();
			}
			HttpSession session = request.getSession();
			int locId = (int) session.getAttribute("liveLocationId");
			map = new LinkedMultiValueMap<String, Object>();
			map.add("companyId", cmpId);
			map.add("fromDate", arrOfStr[0]);
			map.add("toDate", arrOfStr[1]);
			map.add("locId", locId);
			StatutoryEsicRep[] resArray = Constants.getRestTemplate().postForObject(Constants.url + "getStatutoryEsic",
					map, StatutoryEsicRep[].class);
			List<StatutoryEsicRep> progList = new ArrayList<>(Arrays.asList(resArray));

			String header = "";
			String title = "                 ";
			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			Document document = new Document(PageSize._11X17);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(9);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 2.0f, 3.0f, 7.0f, 3.5f, 2f, 3.5f, 3.5f, 3.5f, 3.5f });
			Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
			// BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																	// BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Code", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("ESIC No", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Days", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Month-Year", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Sal/Wages", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee's Contr.ESIC", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employer's Contr.ESIC", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			int index = 0;
			salWagesTot = 0;
			empCalTot = 0;
			empr = 0;
			tot = 0;
			for (int i = 0; i < progList.size(); i++) {
				// System.err.println("I " + i);
				StatutoryEsicRep prog = progList.get(i);

				index++;
				PdfPCell cell;
				cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpCode(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpName(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEsicNo(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getPresentDays(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getMonth() + "-" + prog.getYear(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEsicWagesCal(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEsic(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmployerEsic(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				salWagesTot = salWagesTot + prog.getEsicWagesCal();
				empCalTot = empCalTot + prog.getEsic();
				empr = empr + prog.getEmployerEsic();

			}
			tot = salWagesTot + empCalTot + empr;

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));
			document.add(new Paragraph("Date Range: " + leaveDateRange));
			document.add(new Paragraph("Company Name: " + cmpName));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);
			document.add(new Paragraph("Total Salary Wages: " + salWagesTot));
			document.add(new Paragraph("Employee Contri: " + empCalTot));
			document.add(new Paragraph("Employer Contri: " + empr));
			document.add(new Paragraph("Total: " + tot));

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p"));
			// System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {
				salWagesTot = 0;
				empCalTot = 0;
				empr = 0;
				tot = 0;

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Sr. No");
				rowData.add("Emp Code");
				rowData.add("Emp Name");
				rowData.add("ESIC No");
				rowData.add("Present Days");
				rowData.add("Month-Year");
				rowData.add("Sal/Wages");
				rowData.add("Employee's Contr.ESIC");
				rowData.add("Employer's Contr.ESIC");

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;
				for (int i = 0; i < progList.size(); i++) {
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					cnt = cnt + i;

					rowData.add("" + (i + 1));
					rowData.add("" + progList.get(i).getEmpCode());
					rowData.add("" + progList.get(i).getEmpName());
					rowData.add("" + progList.get(i).getEsicNo());
					rowData.add("" + progList.get(i).getPresentDays());
					rowData.add("" + progList.get(i).getMonth() + "-" + progList.get(i).getYear());
					rowData.add("" + progList.get(i).getEsicWagesCal());
					rowData.add("" + progList.get(i).getEsic());
					rowData.add("" + progList.get(i).getEmployerEsic());
					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

					salWagesTot = salWagesTot + progList.get(i).getEsicWagesCal();
					empCalTot = empCalTot + progList.get(i).getEsic();
					empr = empr + progList.get(i).getEmployerEsic();

				}

				tot = salWagesTot + empCalTot + empr;

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
							"Date Range:" + leaveDateRange + " Company Name:" + cmpName,
							"Total Sal Wages:" + salWagesTot + ",Employee Contribution:" + empCalTot
									+ ",Employer Contribution:" + empr + ",Total" + tot,
							'I');

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	// ***Bonus*********************

	@RequestMapping(value = "/showBonusRep", method = RequestMethod.GET)
	public void showBonusRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Employee Bonus Details";
		String bonusId = request.getParameter("bonusId");

		double bonusAmt = 0;

		Boolean ret = false;
		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

			map = new LinkedMultiValueMap<String, Object>();
			map.add("bonusId", bonusId);

			BonusMaster bonus = Constants.getRestTemplate().postForObject(Constants.url + "/getBonusById", map,
					BonusMaster.class);

			BonusCalc[] resArray = Constants.getRestTemplate().postForObject(Constants.url + "getBonusReportByBonusId",
					map, BonusCalc[].class);
			List<BonusCalc> progList = new ArrayList<>(Arrays.asList(resArray));

			System.err.println("progList" + progList.toString());

			String header = "";
			String title = "                 ";
			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			Document document = new Document(PageSize._11X17);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(9);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 2.0f, 3.0f, 7.0f, 3.5f, 2f, 3.5f, 3.5f, 3.5f, 3.5f });
			Font headFontData = ReportCostants.headFontData;
			new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL, BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont;

			new Font(FontFamily.HELVETICA, 12, Font.BOLD,

					BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Code", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Total Bonus Days ", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Bonus Wages", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Gross Bonus Amt", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Paid Bonus Amt", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Paid Bonus Date", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Is Bonus Sheet finalized", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			int index = 0;
			bonusAmt = 0;
			for (int i = 0; i < progList.size(); i++) { //
				System.err.println("I " + i);
				BonusCalc prog = progList.get(i);

				index++;
				PdfPCell cell;
				cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getCompanyEmpCode(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpName(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getTotalBonusDays(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getTotalBonusWages(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getGrossBonusAmt(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getPaidBonusAmt(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getPaidBonusDate(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getIsBonussheetFinalized(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				bonusAmt = bonusAmt + prog.getTotalBonusWages();

			}

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));

			document.add(new Paragraph("Bonus Title: " + bonus.getFyTitle()));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);

			document.add(new Paragraph("Total Bonus Amt: " + bonusAmt));

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p")); //
			System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) { // System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {
				bonusAmt = 0;

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Sr. No");
				rowData.add("Emp Code");
				rowData.add("Emp Name");
				rowData.add("Total Bonus Days");
				rowData.add("Bonus Wages");
				rowData.add("Gross Bonus Amt");
				rowData.add("Paid Bonus Amt");
				rowData.add("Paid Bonus Date");
				rowData.add("Is Bonus Sheet finalized");

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;
				bonusAmt = 0;
				for (int i = 0; i < progList.size(); i++) {
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					cnt = cnt + i;

					rowData.add("" + (i + 1));
					rowData.add("" + progList.get(i).getCompanyEmpCode());
					rowData.add("" + progList.get(i).getEmpName());
					rowData.add("" + progList.get(i).getTotalBonusDays());
					rowData.add("" + progList.get(i).getTotalBonusWages());
					rowData.add("" + progList.get(i).getGrossBonusAmt());
					rowData.add("" + progList.get(i).getPaidBonusAmt());
					rowData.add("" + progList.get(i).getPaidBonusDate());
					rowData.add("" + progList.get(i).getIsBonussheetFinalized());
					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);
					bonusAmt = bonusAmt + progList.get(i).getTotalBonusWages();
				}

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName, "Bonus Title:" + bonus.getFyTitle(),
							"Total Bonus Amt:" + bonusAmt, 'I');

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/showExgratiaRep", method = RequestMethod.GET)
	public void showExgratiaRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Employee Bonus Details";
		String bonusId = request.getParameter("bonusId");

		double bonusAmt = 0;

		Boolean ret = false;
		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

			map = new LinkedMultiValueMap<String, Object>();
			map.add("bonusId", bonusId);

			BonusMaster bonus = Constants.getRestTemplate().postForObject(Constants.url + "/getBonusById", map,
					BonusMaster.class);

			BonusCalc[] resArray = Constants.getRestTemplate().postForObject(Constants.url + "getBonusReportByBonusId",
					map, BonusCalc[].class);
			List<BonusCalc> progList = new ArrayList<>(Arrays.asList(resArray));

			System.err.println("progList" + progList.toString());

			String header = "";
			String title = "                 ";
			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			Document document = new Document(PageSize._11X17);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(9);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 2.0f, 3.0f, 7.0f, 3.5f, 2f, 3.5f, 3.5f, 3.5f, 3.5f });
			Font headFontData = ReportCostants.headFontData;
			new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL, BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont;

			new Font(FontFamily.HELVETICA, 12, Font.BOLD,

					BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Code", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Total Exgratia Days ", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Exgratia Wages", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Gross Exgratia Amt", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Paid Exgratia Amt", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Paid Exgratia Date", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Is Exgratia Sheet finalized", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			int index = 0;
			for (int i = 0; i < progList.size(); i++) { //
				System.err.println("I " + i);
				BonusCalc prog = progList.get(i);

				index++;
				PdfPCell cell;
				cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getCompanyEmpCode(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpName(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getTotalExgretiaDays(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getTotalExgretiaWages(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getGrossExgretiaAmt(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getPaidExgretiaAmt(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getPaidExgretiaDate(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getIsExgretiaFinalized(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				bonusAmt = bonusAmt + prog.getTotalExgretiaWages();

			}

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));

			document.add(new Paragraph("Bonus Title: " + bonus.getFyTitle()));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);

			document.add(new Paragraph("Total Exgratia Amt: " + bonusAmt));

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p")); //
			System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) { // System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {
				bonusAmt = 0;

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Sr. No");
				rowData.add("Emp Code");
				rowData.add("Emp Name");
				rowData.add("Total Exgratia Days");
				rowData.add("Exgratia Wages");
				rowData.add("Gross Exgratia Amt");
				rowData.add("Paid Exgratia Amt");
				rowData.add("Paid Exgratia Date");
				rowData.add("Is Exgratia Finalized");

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;
				for (int i = 0; i < progList.size(); i++) {
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					cnt = cnt + i;

					rowData.add("" + (i + 1));
					rowData.add("" + progList.get(i).getCompanyEmpCode());
					rowData.add("" + progList.get(i).getEmpName());
					rowData.add("" + progList.get(i).getTotalExgretiaDays());
					rowData.add("" + progList.get(i).getTotalExgretiaWages());
					rowData.add("" + progList.get(i).getGrossExgretiaAmt());
					rowData.add("" + progList.get(i).getPaidExgretiaAmt());
					rowData.add("" + progList.get(i).getPaidExgretiaDate());
					rowData.add("" + progList.get(i).getIsExgretiaFinalized());
					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);
					bonusAmt = bonusAmt + progList.get(i).getTotalExgretiaWages();
				}

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
							"Exgratia Title:" + bonus.getFyTitle(), "Total Exgratia Amt:" + bonusAmt, 'I');

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/showEsiSummaryRep", method = RequestMethod.GET)
	public void showEsiSummaryRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "ESI Statement";
		String leaveDateRange = request.getParameter("leaveDateRange");
		String[] arrOfStr = leaveDateRange.split("to", 2);
		int cmpId = 0;
		try {
			cmpId = Integer.parseInt(request.getParameter("subCmpId"));

		} catch (Exception e) {
			cmpId = 0;
		}

		System.err.println("cmpId" + cmpId);

		String cmpName = "-";
		Boolean ret = false;
		try {
			HttpSession session = request.getSession();
			int locId = (int) session.getAttribute("liveLocationId");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

			if (cmpId != 0) {
				map.add("companyId", cmpId);
				MstCompanySub comp = Constants.getRestTemplate().postForObject(Constants.url + "/getSubCompanyById",
						map, MstCompanySub.class);
				cmpName = comp.getCompanyName();
			}

			map = new LinkedMultiValueMap<String, Object>();
			map.add("companyId", cmpId);
			map.add("fromDate", arrOfStr[0]);
			map.add("toDate", arrOfStr[1]);
			map.add("locId", locId);
			EsiSumaryRep[] resArray = Constants.getRestTemplate().postForObject(Constants.url + "getEsiSummaryReport",
					map, EsiSumaryRep[].class);
			List<EsiSumaryRep> progList = new ArrayList<>(Arrays.asList(resArray));

			String header = "";
			String title = "                 ";
			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			Document document = new Document(PageSize._11X17);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(6);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 2.0f, 3.0f, 6.5f, 3.5f, 3.5f, 3.5f });
			Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
			// BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																	// BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Count", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Month-Year", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee's Contribution", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employer's Contribution", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Total", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			int index = 0;
			for (int i = 0; i < progList.size(); i++) {
				// System.err.println("I " + i);
				EsiSumaryRep prog = progList.get(i);

				index++;
				PdfPCell cell;
				cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getNoEmp(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getCalcMonth() + "-" + prog.getCalcYear(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmpContribution(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getEmperContribution(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getTotalContribution(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

			}

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));
			document.add(new Paragraph("Date Range: " + leaveDateRange));
			document.add(new Paragraph("Company Name: " + cmpName));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p"));
			// System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Sr. No");
				rowData.add("Employee Count");
				rowData.add("Month-Year");
				rowData.add("Employee's Contribution");
				rowData.add("Employer's Contribution");
				rowData.add("Total");

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;
				for (int i = 0; i < progList.size(); i++) {
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					cnt = cnt + i;

					rowData.add("" + (i + 1));
					rowData.add("" + progList.get(i).getNoEmp());
					rowData.add("" + progList.get(i).getCalcMonth() + "-" + progList.get(i).getCalcYear());
					rowData.add("" + progList.get(i).getEmpContribution());
					rowData.add("" + progList.get(i).getEmperContribution());
					rowData.add("" + progList.get(i).getTotalContribution());

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

				}

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
							"Date Range:" + leaveDateRange + " Company Name:" + cmpName, "", 'F');

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/showEsicDataUpload", method = RequestMethod.GET)
	public void showEsicDataUpload(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "ESI Data To Upload";
		String leaveDateRange = request.getParameter("date");
		String[] arrOfStr = leaveDateRange.split("-");
		int cmpId = 0;
		try {
			cmpId = Integer.parseInt(request.getParameter("subCmpId"));

		} catch (Exception e) {
			cmpId = 0;
		}

		String cmpName = "-";
		Boolean ret = false;
		try {
			HttpSession session = request.getSession();
			int locId = (int) session.getAttribute("liveLocationId");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

			if (cmpId != 0) {
				map.add("companyId", cmpId);
				MstCompanySub comp = Constants.getRestTemplate().postForObject(Constants.url + "/getSubCompanyById",
						map, MstCompanySub.class);
				cmpName = comp.getCompanyName();
			}

			map = new LinkedMultiValueMap<String, Object>();
			map.add("companyId", cmpId);
			map.add("month", arrOfStr[0]);
			map.add("year", arrOfStr[1]);
			map.add("locId", locId);
			StatutoryEsicRep[] resArray = Constants.getRestTemplate()
					.postForObject(Constants.url + "showEsicDataUpload", map, StatutoryEsicRep[].class);
			List<StatutoryEsicRep> progList = new ArrayList<>(Arrays.asList(resArray));

			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();

			rowData.add("IPNUMBER");
			rowData.add("IPNAME");
			rowData.add("NOOFDAYS");
			rowData.add("ESI_SALARY");
			rowData.add("REASON");
			rowData.add("LASTDAYOFWORKING");

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);
			int cnt = 1;
			for (int i = 0; i < progList.size(); i++) {

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();

				rowData.add("" + progList.get(i).getEsicNo());
				rowData.add("" + progList.get(i).getEmpName());
				rowData.add("" + progList.get(i).getPresentDays());
				if (progList.get(i).getReason() == "") {
					rowData.add("" + progList.get(i).getEsicWagesCal());
				} else {
					rowData.add("0");
				}

				rowData.add("" + progList.get(i).getReason());
				if (progList.get(i).getReason() == "") {
					rowData.add("");
				} else {
					rowData.add("" + progList.get(i).getEsicLeaveDate());
				}

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

			}

			XSSFWorkbook wb = null;
			try {

				wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
						"Date Range:" + leaveDateRange + " Company Name:" + cmpName, "", 'F');

				ExceUtil.autoSizeColumns(wb, 3);
				response.setContentType("application/vnd.ms-excel");
				String date = new SimpleDateFormat("yyyy-MM-dd_hh_mm_ss").format(new Date());
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

	@RequestMapping(value = "/showLwfDataUpload", method = RequestMethod.GET)
	public void showLwfDataUpload(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "LWF Data To Upload";
		String leaveDateRange = request.getParameter("date");
		String[] arrOfStr = leaveDateRange.split("-");

		String cmpName = "-";
		Boolean ret = false;
		try {
			HttpSession session = request.getSession();
			int locId = (int) session.getAttribute("liveLocationId");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

			map = new LinkedMultiValueMap<String, Object>();
			map.add("month", arrOfStr[0]);
			map.add("year", arrOfStr[1]);
			map.add("locId", locId);
			LwfChallanData lwfChallanData = Constants.getRestTemplate()
					.postForObject(Constants.url + "getLwfDataForChallan", map, LwfChallanData.class);

			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();
			rowData.add("");
			rowData.add("No. of Employee");
			rowData.add("EEC Rs.");
			rowData.add("ERC Rs.");
			rowData.add("Penal Int.");
			rowData.add("Total");
			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();
			rowData.add("Total number of employees whose names stood on the establishment register");
			rowData.add("" + lwfChallanData.getEmpCount());
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();
			rowData.add("Total number of Managers");
			rowData.add("" + lwfChallanData.getLwfNoCount());
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();
			rowData.add("Employees working in supervisory capacity drawing wages exceeding Rs.3000 pm (refer note 2)");
			rowData.add("0");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();
			rowData.add(
					"Employees drawing wages upto & inclusive of Rs. 3000.00 pm EEC @ 6.00 per employee ERC @ 18.00 per employee");
			rowData.add("0");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();
			rowData.add(" Employees drawing wages exceeding Rs. 3000.00 pm EEC @ " + lwfChallanData.getEmployeeValue()
					+ " per employee ERC @ " + lwfChallanData.getEmployerValue() + " per employee");
			rowData.add("" + lwfChallanData.getCountLwf());
			rowData.add("" + lwfChallanData.getMlwf());
			rowData.add("" + lwfChallanData.getEmployerMlwf());
			rowData.add("");
			rowData.add("" + (lwfChallanData.getEmployerMlwf() + lwfChallanData.getMlwf()));
			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

			expoExcel = new ExportToExcel();
			rowData = new ArrayList<String>();
			rowData.add("Total");
			rowData.add("" + lwfChallanData.getEmpCount());
			rowData.add("" + lwfChallanData.getMlwf());
			rowData.add("" + lwfChallanData.getEmployerMlwf());
			rowData.add("");
			rowData.add("" + (lwfChallanData.getEmployerMlwf() + lwfChallanData.getMlwf()));
			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

			XSSFWorkbook wb = null;
			try {

				wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName, "Month :" + leaveDateRange, "", 'F');

				ExceUtil.autoSizeColumns(wb, 3);
				response.setContentType("application/vnd.ms-excel");
				String date = new SimpleDateFormat("yyyy-MM-dd_hh_mm_ss").format(new Date());
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
//leave 

	@RequestMapping(value = "/showEmpLeaveHistoryRepNew", method = RequestMethod.GET)
	public void showEmpLeaveHistoryRep(HttpServletRequest request, HttpServletResponse response) {
		List<EmpLeaveHistoryRep> progList = new ArrayList<EmpLeaveHistoryRep>();
		String reportName = "Employee Leave Pending Report";
		List<EmpLeaveHistoryRep> employeeInfoList = new ArrayList<EmpLeaveHistoryRep>();
		HttpSession session = request.getSession();
		LoginResponse userObj = (LoginResponse) session.getAttribute("UserDetail");
		try {

			int empId = Integer.parseInt(request.getParameter("empId1"));
			int calYrId = Integer.parseInt(request.getParameter("calYrId"));
			String cal_yr = request.getParameter("cal_yr");
			int locId = (int) session.getAttribute("liveLocationId");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("empId", empId);
			map.add("calYrId", calYrId);
			map.add("locId", locId);
			EmpLeaveHistoryRep[] employeeInfo = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getLeaveHistoryRep", map, EmpLeaveHistoryRep[].class);

			employeeInfoList = new ArrayList<EmpLeaveHistoryRep>(Arrays.asList(employeeInfo));
			// System.out.println("employeeInfoList" + employeeInfoList.toString());

			map = new LinkedMultiValueMap<>();
			map.add("locId", locId);
			EmployeeMaster[] emp = Constants.getRestTemplate().postForObject(
					Constants.url + "/getEmplistForAssignAuthorityAllByLocId", map, EmployeeMaster[].class);

			List<EmployeeMaster> empList1 = new ArrayList<EmployeeMaster>(Arrays.asList(emp));

			List<LeaveHistTemp> finalList = new ArrayList<LeaveHistTemp>();

			for (int i = 0; i < empList1.size(); i++) {
				LeaveHistTemp fin = new LeaveHistTemp();
				fin.setEmpName(empList1.get(i).getFirstName().concat(" ").concat(empList1.get(i).getSurname()));

				List<EmpLeaveHistoryRep> subList = new ArrayList<EmpLeaveHistoryRep>();
				for (int j = 0; j < employeeInfoList.size(); j++) {

					if (empList1.get(i).getEmpId() == employeeInfoList.get(j).getEmpId()) {
						subList.add(employeeInfoList.get(j));
					}

				}
				fin.setRec(subList);
				finalList.add(fin);
			}

			// System.out.println("final ****" + finalList.toString());
			Document document = new Document(PageSize.A4);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			String header = "";
			String title = "                 ";

			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(8);

			table.setHeaderRows(1);

			try {
				table.setWidthPercentage(100);
				table.setWidths(new float[] { 2.0f, 5.0f, 4.5f, 4.5f, 4.5f, 4.5f, 4.5f, 4.5f });
				Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
				// BaseColor.BLACK);
				Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																		// BaseColor.BLACK);
				tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

				PdfPCell hcell = new PdfPCell();
				hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

				hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Leave Type", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Carry Forward", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Earned", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Approved", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Applied", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Balanced", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				int index = 0;
				for (int i = 0; i < finalList.size(); i++) {
					// System.err.println("I " + i);
					LeaveHistTemp prog = finalList.get(i);

					for (int j = 0; j < prog.getRec().size(); j++) {
						index++;
						PdfPCell cell;
						cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
						cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
						cell.setHorizontalAlignment(Element.ALIGN_CENTER);

						table.addCell(cell);

						if (j == 0) {
							cell = new PdfPCell(new Phrase("" + prog.getEmpName(), headFontData));
							cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
							cell.setHorizontalAlignment(Element.ALIGN_LEFT);

							table.addCell(cell);
						} else {
							cell = new PdfPCell(new Phrase("", headFontData));
							cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
							cell.setHorizontalAlignment(Element.ALIGN_LEFT);

							table.addCell(cell);
						}

						cell = new PdfPCell(new Phrase("" + prog.getRec().get(j).getLvTitle(), headFontData));
						cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);

						table.addCell(cell);

						cell = new PdfPCell(new Phrase("" + prog.getRec().get(j).getBalLeave(), headFontData));
						cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
						cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

						table.addCell(cell);

						cell = new PdfPCell(new Phrase("" + prog.getRec().get(j).getLvsAllotedLeaves(), headFontData));
						cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
						cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

						table.addCell(cell);

						cell = new PdfPCell(new Phrase("" + prog.getRec().get(j).getSactionLeave(), headFontData));
						cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
						cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

						table.addCell(cell);

						cell = new PdfPCell(new Phrase("" + prog.getRec().get(j).getAplliedLeaeve(), headFontData));
						cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
						cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

						table.addCell(cell);

						float x = prog.getRec().get(j).getBalLeave() + prog.getRec().get(j).getLvsAllotedLeaves()
								- prog.getRec().get(j).getSactionLeave() - prog.getRec().get(j).getAplliedLeaeve();

						cell = new PdfPCell(new Phrase("" + x, headFontData));
						cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
						cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

						table.addCell(cell);

					}

				}

				document.open();
				Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

				Paragraph name = new Paragraph(reportName, hf);
				name.setAlignment(Element.ALIGN_CENTER);
				document.add(name);
				document.add(new Paragraph("\n"));

				document.add(new Paragraph("Year:" + cal_yr));
				document.add(new Paragraph("\n"));

				DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

				document.add(table);

				int totalPages = writer.getPageNumber();

				// System.out.println("Page no " + totalPages);

				document.close();
				int p = Integer.parseInt(request.getParameter("p"));
				// System.err.println("p " + p);

				if (p == 1) {

					if (file != null) {

						String mimeType = URLConnection.guessContentTypeFromName(file.getName());

						if (mimeType == null) {

							mimeType = "application/pdf";

						}

						response.setContentType(mimeType);

						response.addHeader("content-disposition",
								String.format("inline; filename=\"%s\"", file.getName()));

						response.setContentLength((int) file.length());

						InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

						try {
							FileCopyUtils.copy(inputStream, response.getOutputStream());
						} catch (IOException e) {
							// System.out.println("Excep in Opening a Pdf File");
							e.printStackTrace();
						}
					}
				} else {

					List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

					ExportToExcel expoExcel = new ExportToExcel();
					List<String> rowData = new ArrayList<String>();

					rowData.add("Sr. No");
					rowData.add("Employee Name");
					rowData.add("Leave Type");
					rowData.add("Carry Forward");
					rowData.add("Earned");
					rowData.add("Approved");
					rowData.add("Applied");
					rowData.add("Balanced");
					expoExcel.setRowData(rowData);

					exportToExcelList.add(expoExcel);
					int cnt = 1;
					for (int i = 0; i < finalList.size(); i++) {

						for (int j = 0; j < finalList.get(i).getRec().size(); j++) {
							expoExcel = new ExportToExcel();
							rowData = new ArrayList<String>();

							rowData.add("" + (cnt));
							if (j == 0) {
								rowData.add("" + finalList.get(i).getEmpName());

							} else {
								rowData.add("");
							}

							rowData.add("" + finalList.get(i).getRec().get(j).getLvTitle());
							rowData.add("" + finalList.get(i).getRec().get(j).getBalLeave());
							rowData.add("" + finalList.get(i).getRec().get(j).getLvsAllotedLeaves());
							rowData.add("" + finalList.get(i).getRec().get(j).getSactionLeave());
							rowData.add("" + finalList.get(i).getRec().get(j).getAplliedLeaeve());
							float a = finalList.get(i).getRec().get(j).getBalLeave()
									+ finalList.get(i).getRec().get(j).getLvsAllotedLeaves()
									- finalList.get(i).getRec().get(j).getSactionLeave()
									- finalList.get(i).getRec().get(j).getAplliedLeaeve();

							rowData.add("" + a);

							expoExcel.setRowData(rowData);
							cnt = cnt + 1;
							exportToExcelList.add(expoExcel);
						}

					}

					XSSFWorkbook wb = null;
					try {
						System.out.println("exportToExcelList" + exportToExcelList.toString());

						wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName, " Date:" + cal_yr + "", "",
								'H');

						ExceUtil.autoSizeColumns(wb, 3);
						response.setContentType("application/vnd.ms-excel");
						String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
						response.setHeader("Content-disposition",
								"attachment; filename=" + reportName + "-" + date + ".xlsx");
						wb.write(response.getOutputStream());

					} catch (IOException ioe) {
						throw new RuntimeException("Error writing spreadsheet to output stream");
					} finally {
						if (wb != null) {
							wb.close();
						}
					}

				}

			} catch (DocumentException ex) {

				// System.out.println("Pdf Generation Error: " + ex.getMessage());

				ex.printStackTrace();

			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}

	}

	@RequestMapping(value = "/showEmpLeaveApplicationRep", method = RequestMethod.GET)
	public void showEmpLeaveApplicationRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Employee Leave Application Tracking";
		int empId = Integer.parseInt(request.getParameter("empId1"));
		int calYrId = Integer.parseInt(request.getParameter("calYrId"));
		String cal_yr = request.getParameter("cal_yr");

		Boolean ret = false;
		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("empId", empId);

			EmployeeMaster emp = Constants.getRestTemplate().postForObject(Constants.url + "/getEmployeeById", map,
					EmployeeMaster.class);

			map = new LinkedMultiValueMap<>();
			map.add("empId", empId);
			map.add("calYrId", calYrId);

			LeaveApply[] employeeInfo = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getLeaveApplicationEmpReport", map, LeaveApply[].class);

			List<LeaveApply> progList = new ArrayList<LeaveApply>(Arrays.asList(employeeInfo));

			String header = "";
			String title = "                 ";
			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			Document document = new Document(PageSize._11X17);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(5);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 2.0f, 3.0f, 3.0f, 2.5f, 6.5f });
			Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
			// BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																	// BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("From Date", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("To Date ", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("No of Days", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Status", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			int index = 0;
			for (int i = 0; i < progList.size(); i++) {

				// System.err.println("I " + i);
				LeaveApply prog = progList.get(i);
				int stat = progList.get(i).getExInt1();
				String status = new String();
				if (stat == 1) {
					status = " applied & pending for approval";

				} else if (stat == 7) {
					status = "Cancelled by employee";
				} else if (stat == 2) {
					status = "Approved By  Intial Authority";
				} else if (stat == 8) {
					status = "Rejected By  Intial Authority";
				} else if (stat == 3) {
					status = "Approved By  Final Authority";
				} else {
					status = "Rejected By  Final Authority";
				}

				index++;
				PdfPCell cell;
				cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getLeaveFromdt(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getLeaveTodt(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getLeaveNumDays(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + status, headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

			}

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));
			document.add(new Paragraph(
					"Employee Name: " + emp.getFirstName() + " " + emp.getMiddleName() + " " + emp.getSurname()));
			document.add(new Paragraph("Calender Year: " + cal_yr));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p"));
			// System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Sr. No");
				rowData.add("From Date");
				rowData.add("To Date");
				rowData.add("No of Day");
				rowData.add("Status");

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;
				for (int i = 0; i < progList.size(); i++) {

					int stat = progList.get(i).getExInt1();
					String status = new String();
					if (stat == 1) {
						status = " applied & pending for approval";

					} else if (stat == 7) {
						status = "Cancelled by employee";
					} else if (stat == 2) {
						status = "Approved By  Intial Authority";
					} else if (stat == 8) {
						status = "Rejected By  Intial Authority";
					} else if (stat == 3) {
						status = "Approved By  Final Authority";
					} else {
						status = "Rejected By  Final Authority";
					}

					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					cnt = cnt + i;

					rowData.add("" + (i + 1));
					rowData.add("" + progList.get(i).getLeaveFromdt());
					rowData.add("" + progList.get(i).getLeaveTodt());
					rowData.add("" + progList.get(i).getLeaveNumDays());
					rowData.add("" + status);

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

				}

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName, "Cal Year:" + cal_yr + "Emp Name"
							+ emp.getFirstName() + " " + emp.getMiddleName() + " " + emp.getSurname(), "", 'E');

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/showEmpDedRep", method = RequestMethod.GET)
	public void showEmpDedRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Employee Payment Deduction";

		Boolean ret = false;
		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			double dedTot = 0;

			int empId = 0;
			try {
				empId = Integer.parseInt(request.getParameter("empId1"));

			} catch (Exception e) {
				empId = 0;

			}

			String fromDate = request.getParameter("datepickerFromRep");
			String toDate = request.getParameter("datepickerToRep");

			map = new LinkedMultiValueMap<>();
			map.add("empId", empId);

			EmployeeMaster emp = Constants.getRestTemplate().postForObject(Constants.url + "/getEmployeeById", map,
					EmployeeMaster.class);

			map = new LinkedMultiValueMap<>();
			map.add("empId", empId);
			map.add("fromDate", fromDate);
			map.add("toDate", toDate);
			map.add("flag", 0);

			PayDeductionDetails[] employeeInfo = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getEmpPayDed", map, PayDeductionDetails[].class);

			List<PayDeductionDetails> progList = new ArrayList<PayDeductionDetails>(Arrays.asList(employeeInfo));

			String header = "";
			String title = "                 ";
			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			Document document = new Document(PageSize._11X17);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(7);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 2.0f, 3.0f, 6.5f, 3.5f, 3.5f, 3.5f, 3.5f });
			Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
			// BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																	// BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Code", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Deduction Month-Year", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Deduction Type", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Deduction Rate", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Deduction Remark", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			int index = 0;
			for (int i = 0; i < progList.size(); i++) {
				// System.err.println("I " + i);
				PayDeductionDetails prog = progList.get(i);

				index++;
				PdfPCell cell;
				cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getMakerEnterDatetime(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getExVar1(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getMonth() + "-" + prog.getYear(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getExVar2(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getDedRate(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getDedRemark(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				dedTot = dedTot + prog.getDedRate();

			}

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));
			document.add(new Paragraph(
					"Employee Name: " + emp.getFirstName() + " " + emp.getMiddleName() + " " + emp.getSurname()));
			document.add(new Paragraph("Year: " + fromDate + " to " + toDate));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);

			document.add(new Paragraph("Total Deduction Amt: " + dedTot));

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p"));
			// System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Sr. No");
				rowData.add("Emp Code");
				rowData.add("Emp Name");
				rowData.add("Deduction Month-Year");
				rowData.add("Deduction Type");
				rowData.add("Deduction Rate");
				rowData.add("Deduction Remark");

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;
				dedTot = 0;
				for (int i = 0; i < progList.size(); i++) {
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					cnt = cnt + i;

					rowData.add("" + (i + 1));
					rowData.add("" + progList.get(i).getMakerEnterDatetime());
					rowData.add("" + progList.get(i).getExVar1());
					rowData.add("" + progList.get(i).getMonth() + "-" + progList.get(i).getYear());

					rowData.add("" + progList.get(i).getExVar2());
					rowData.add("" + progList.get(i).getDedRate());
					rowData.add("" + progList.get(i).getDedRemark());

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);
					dedTot = dedTot + progList.get(i).getDedRate();
				}

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
							" Year:" + fromDate + " to " + toDate + "Emp Name" + emp.getFirstName() + " "
									+ emp.getMiddleName() + " " + emp.getSurname(),
							"Total Deduction Amt: " + dedTot, 'G');

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/showEmpDedRepAll", method = RequestMethod.GET)
	public void showEmpDedRepAll(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Employee Payment Deduction";

		Boolean ret = false;
		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			double dedTot = 0;
			String leaveDateRange = request.getParameter("leaveDateRange");
			String[] arrOfStr = leaveDateRange.split("to", 2);

			map = new LinkedMultiValueMap<>();
			map.add("empId", 0);
			map.add("fromDate", arrOfStr[0]);
			map.add("toDate", arrOfStr[1]);
			map.add("flag", 1);

			PayDeductionDetails[] employeeInfo = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getEmpPayDed", map, PayDeductionDetails[].class);

			List<PayDeductionDetails> progList = new ArrayList<PayDeductionDetails>(Arrays.asList(employeeInfo));

			String header = "";
			String title = "                 ";
			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			Document document = new Document(PageSize._11X17);
			document.setMargins(5, 5, 0, 0);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(7);

			table.setHeaderRows(1);

			table.setWidthPercentage(100);
			table.setWidths(new float[] { 2.0f, 3.0f, 6.5f, 3.5f, 3.5f, 3.5f, 3.5f });
			Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
			// BaseColor.BLACK);
			Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																	// BaseColor.BLACK);
			tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

			PdfPCell hcell = new PdfPCell();
			hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

			hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Code", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Deduction Month-Year", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Deduction Type", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Deduction Total", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			/*
			 * hcell = new PdfPCell(new Phrase("Deduction Total", tableHeaderFont));
			 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
			 * 
			 * table.addCell(hcell);
			 */

			hcell = new PdfPCell(new Phrase("Deduction Remark", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			int index = 0;
			for (int i = 0; i < progList.size(); i++) {
				// System.err.println("I " + i);
				PayDeductionDetails prog = progList.get(i);

				index++;
				PdfPCell cell;
				cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getMakerEnterDatetime(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getExVar1(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getMonth() + "-" + prog.getYear(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getExVar2(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + prog.getDedRate(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				/*
				 * cell = new PdfPCell(new Phrase("" + prog.getDedTotal(), headFontData));
				 * cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				 * 
				 * table.addCell(cell);
				 */

				cell = new PdfPCell(new Phrase("" + prog.getDedRemark(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				dedTot = dedTot + prog.getDedRate();

			}

			document.open();
			Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

			Paragraph name = new Paragraph(reportName, hf);
			name.setAlignment(Element.ALIGN_CENTER);
			document.add(name);
			document.add(new Paragraph("\n"));
			document.add(new Paragraph(""));
			document.add(new Paragraph("Year: " + leaveDateRange));

			document.add(new Paragraph("\n"));
			DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

			document.add(table);

			document.add(new Paragraph("Total Deduction Amt: " + dedTot));

			int totalPages = writer.getPageNumber();

			// System.out.println("Page no " + totalPages);

			document.close();
			int p = Integer.parseInt(request.getParameter("p"));
			// System.err.println("p " + p);

			if (p == 1) {

				if (file != null) {

					String mimeType = URLConnection.guessContentTypeFromName(file.getName());

					if (mimeType == null) {

						mimeType = "application/pdf";

					}

					response.setContentType(mimeType);

					response.addHeader("content-disposition", String.format("inline; filename=\"%s\"", file.getName()));

					response.setContentLength((int) file.length());

					InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

					try {
						FileCopyUtils.copy(inputStream, response.getOutputStream());
					} catch (IOException e) {
						// System.out.println("Excep in Opening a Pdf File");
						e.printStackTrace();
					}
				}
			} else {

				List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

				ExportToExcel expoExcel = new ExportToExcel();
				List<String> rowData = new ArrayList<String>();

				rowData.add("Sr. No");
				rowData.add("Emp Code");
				rowData.add("Emp Name");
				rowData.add("Deduction Month-Year");
				rowData.add("Deduction Type");
				rowData.add("Deduction Total");
				// rowData.add("Deduction Total");
				rowData.add("Deduction Remark");

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;
				dedTot = 0;
				for (int i = 0; i < progList.size(); i++) {
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					cnt = cnt + i;

					rowData.add("" + (i + 1));
					rowData.add("" + progList.get(i).getMakerEnterDatetime());
					rowData.add("" + progList.get(i).getExVar1());
					rowData.add("" + progList.get(i).getMonth() + "-" + progList.get(i).getYear());

					rowData.add("" + progList.get(i).getExVar2());
					rowData.add("" + progList.get(i).getDedRate());
					// rowData.add("" + progList.get(i).getDedTotal());
					rowData.add("" + progList.get(i).getDedRemark());

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);
					dedTot = dedTot + progList.get(i).getDedRate();
				}

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName, " Year:" + leaveDateRange,
							"Total Deduction Amt: " + dedTot, 'H');

					ExceUtil.autoSizeColumns(wb, 3);
					response.setContentType("application/vnd.ms-excel");
					String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					response.setHeader("Content-disposition",
							"attachment; filename=" + reportName + "-" + date + ".xlsx");
					wb.write(response.getOutputStream());

				} catch (IOException ioe) {
					throw new RuntimeException("Error writing spreadsheet to output stream");
				} finally {
					if (wb != null) {
						wb.close();
					}
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/arearReport", method = RequestMethod.GET)
	public void arearReport(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		String monthAndYear = request.getParameter("date");
		String subCmpId = request.getParameter("subCmpId");
		String temp[] = monthAndYear.split("-");

		try {
			int locId = (int) session.getAttribute("liveLocationId");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("month", temp[0]);
			map.add("year", temp[1]);
			map.add("locId", locId);
			map.add("companyId", subCmpId);

			PayRollDataForProcessing payRollDataForProcessing = Constants.getRestTemplate()
					.postForObject(Constants.url + "getArearsGenratedList", map, PayRollDataForProcessing.class);
			List<GetPayrollGeneratedList> list = payRollDataForProcessing.getPayrollGeneratedList();

			String[] monthAndYearsplt = monthAndYear.split("-");
			String[] monthNames = { "January", "February", "March", "April", "May", "June", "July", "August",
					"September", "October", "November", "December" };
			String monthName = monthNames[Integer.parseInt(monthAndYearsplt[0]) - 1];

			String reportName = "Arrears For the Month of " + monthName + " " + monthAndYearsplt[1];

			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();

			rowData.add("EMP Name");
			rowData.add("EMP Type");
			rowData.add("Department");
			rowData.add("Designation");

			rowData.add("Payable Days");
			rowData.add("Gross Salary");
			rowData.add("Basic");
			for (int i = 0; i < payRollDataForProcessing.getAllowancelist().size(); i++) {
				rowData.add("" + payRollDataForProcessing.getAllowancelist().get(i).getName());

			}
			rowData.add("Production Incentive");
			rowData.add("Performance Incentive");
			rowData.add("PT");
			rowData.add("PF");
			rowData.add("ESIC");
			rowData.add("Net Salary");

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);

			int cnt = 1;
			float empTotal = 0;

			for (int i = 0; i < list.size(); i++) {

				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("" + list.get(i).getName() + " (" + list.get(i).getEmpCode() + ")");
				rowData.add("" + list.get(i).getEmpTypeName());
				rowData.add("" + list.get(i).getDepartName());
				rowData.add("" + list.get(i).getDesignName());
				rowData.add("" + list.get(i).getPayableDays());
				rowData.add("" + list.get(i).getGrossSalDefault());
				rowData.add("" + String.format("%.2f", list.get(i).getBasicCal()));

				for (int k = 0; k < payRollDataForProcessing.getAllowancelist().size(); k++) {
					int find = 0;
					for (int j = 0; j < list.get(i).getPayrollAllownceList().size(); j++) {
						if (list.get(i).getPayrollAllownceList().get(j).getAllowanceId() == payRollDataForProcessing
								.getAllowancelist().get(k).getAllowanceId()) {
							rowData.add(String.format("%.2f", ReportCostants.castNumber(
									list.get(i).getPayrollAllownceList().get(j).getAllowanceValueCal(), 1)));
							find = 1;
							break;

						}
					}
					if (find == 0) {
						rowData.add(String.format("%.2f", ReportCostants.castNumber(0, 1)));
					}

				}

				/*
				 * double finalDed = list.get(i).getAdvanceDed() + list.get(i).getLoanDed() +
				 * list.get(i).getItded() + list.get(i).getPayDed() + list.get(i).getPtDed() +
				 * list.get(i).getEmployeePf() + list.get(i).getEsic() + list.get(i).getMlwf() +
				 * list.get(i).getSocietyContribution();
				 * 
				 * rowData.add("" + String.format("%.2f", ReportCostants.castNumber(finalDed,
				 * 1)));
				 */
				rowData.add("" + String.format("%.2f", ReportCostants.castNumber(list.get(i).getOtWages(), 1)));
				rowData.add(
						"" + String.format("%.2f", ReportCostants.castNumber(list.get(i).getProductionInsentive(), 1)));
				rowData.add("" + String.format("%.2f", ReportCostants.castNumber(list.get(i).getPtDed(), 1)));
				rowData.add("" + String.format("%.2f", ReportCostants.castNumber(list.get(i).getEmployeePf(), 1)));
				rowData.add("" + String.format("%.2f", ReportCostants.castNumber(list.get(i).getEsic(), 1)));
				rowData.add("" + String.format("%.2f", ReportCostants.castNumber(list.get(i).getNetSalary(), 1)));
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

				cnt = cnt + 1;

			}

			XSSFWorkbook wb = null;
			try {
				// System.out.println("exportToExcelList" + exportToExcelList.toString());

				wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName, " ", "", 'Z');

				ExceUtil.autoSizeColumns(wb, 3);
				response.setContentType("application/vnd.ms-excel");
				String date = new SimpleDateFormat("yyyy_MM_dd_hh_mm_ss").format(new Date());
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

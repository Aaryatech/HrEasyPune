package com.ats.hreasy.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLConnection;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ats.hreasy.common.AcessController;
import com.ats.hreasy.common.Constants;
import com.ats.hreasy.common.DateConvertor;
import com.ats.hreasy.common.ExceUtil;
import com.ats.hreasy.common.ExportToExcel;
import com.ats.hreasy.common.ItextPageEvent;
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
import com.ats.hreasy.model.MstCompanySub;
import com.ats.hreasy.model.PayRollDataForProcessing;
import com.ats.hreasy.model.Setting;
import com.ats.hreasy.model.report.GetSalaryCalcReport;
import com.ats.hreasy.model.report.StatutoryEsicRep;
import com.ats.hrmgt.model.assets.AMCExpirationDetail;
import com.ats.hrmgt.model.assets.AssetNotificatn;
import com.ats.hrmgt.model.assets.ServicingDashDetails;
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
			fromMonth = request.getParameter("fromMonth");
			toMonth = request.getParameter("toMonth");
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

	@RequestMapping(value = "/generateArears", method = RequestMethod.POST)
	public String insertFinalPayRollAndDeleteFroTemp(HttpServletRequest request, HttpServletResponse response,
			Model model) {
		String mav = "redirect:/empListForArear";

		HttpSession session = request.getSession();
		try {

			//mav = "redirect:/selectMonthForPayRoll";

			Info info = Constants.getRestTemplate().postForObject(Constants.url + "/insertFinalArearsValue",
					empInfoForArearlist, Info.class);

			if (info.isError() == false) {
				session.setAttribute("successMsg", "Arrears Generated Successfully");
			} else {
				session.setAttribute("errorMsg", "Failed to Generated Arrears");
			}

		} catch (Exception e) {
			session.setAttribute("errorMsg", "Failed to Generated Arrears");
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

					HashMap<String, Double> map = new HashMap<String, Double>();
					double basicOldTotal = 0;
					double basicCurrentTotal = 0;
					double basicDiffTotal = 0;
					double basicCalTotal = 0;
					double totalDiff = 0;
					double totalNet = 0;

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
						map.put(allowanceList.get(j).getAllowanceId() + "Old" + empInfoForArearlist.get(i).getEmpId(),
								0.0);
						map.put(allowanceList.get(j).getAllowanceId() + "Current"
								+ empInfoForArearlist.get(i).getEmpId(), 0.0);
						map.put(allowanceList.get(j).getAllowanceId() + "Diff" + empInfoForArearlist.get(i).getEmpId(),
								0.0);
						map.put(allowanceList.get(j).getAllowanceId() + "Cal" + empInfoForArearlist.get(i).getEmpId(),
								0.0);
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
						rowData.add("" + empInfoForArearlist.get(i).getGeneratedPayrollList().get(j).getBasicDefault());
						rowData.add("" + empInfoForArearlist.get(i).getBasic());
						rowData.add("" + empInfoForArearlist.get(i).getGeneratedPayrollList().get(j).getSalBasicDiff());
						rowData.add(
								"" + empInfoForArearlist.get(i).getGeneratedPayrollList().get(j).getBasicCalArear());

						totalDiff = totalDiff
								+ empInfoForArearlist.get(i).getGeneratedPayrollList().get(j).getSalTotalDiff();
						totalNet = totalNet
								+ empInfoForArearlist.get(i).getGeneratedPayrollList().get(j).getNetCalArear();
						basicOldTotal = basicOldTotal
								+ empInfoForArearlist.get(i).getGeneratedPayrollList().get(j).getBasicDefault();
						basicCurrentTotal = basicCurrentTotal + empInfoForArearlist.get(i).getBasic();
						basicDiffTotal = basicDiffTotal
								+ empInfoForArearlist.get(i).getGeneratedPayrollList().get(j).getSalBasicDiff();
						basicCalTotal = basicCalTotal
								+ empInfoForArearlist.get(i).getGeneratedPayrollList().get(j).getBasicCalArear();

						for (int m = 0; m < allowanceList.size(); m++) {
							for (int k = 0; k < empInfoForArearlist.get(i).getGeneratedPayrollList().get(j)
									.getDifAlloList().size(); k++) {

								if (empInfoForArearlist.get(i).getGeneratedPayrollList().get(j).getDifAlloList().get(k)
										.getAllowanceId() == allowanceList.get(m).getAllowanceId()) {

									double old = map
											.get(allowanceList.get(m).getAllowanceId() + "Old"
													+ empInfoForArearlist.get(i).getEmpId())
											+ empInfoForArearlist.get(i).getGeneratedPayrollList().get(j)
													.getDifAlloList().get(k).getAllowanceValueCal();
									double current = map
											.get(allowanceList.get(m).getAllowanceId() + "Current"
													+ empInfoForArearlist.get(i).getEmpId())
											+ empInfoForArearlist.get(i).getGeneratedPayrollList().get(j)
													.getDifAlloList().get(k).getAllowanceValue();
									double diff = map
											.get(allowanceList.get(m).getAllowanceId() + "Diff"
													+ empInfoForArearlist.get(i).getEmpId())
											+ empInfoForArearlist.get(i).getGeneratedPayrollList().get(j)
													.getDifAlloList().get(k).getAllowanceDifference();
									double cal = map
											.get(allowanceList.get(m).getAllowanceId() + "Cal"
													+ empInfoForArearlist.get(i).getEmpId())
											+ empInfoForArearlist.get(i).getGeneratedPayrollList().get(j)
													.getDifAlloList().get(k).getArearCal();

									map.put(allowanceList.get(m).getAllowanceId() + "Old"
											+ empInfoForArearlist.get(i).getEmpId(), old);
									map.put(allowanceList.get(m).getAllowanceId() + "Current"
											+ empInfoForArearlist.get(i).getEmpId(), current);
									map.put(allowanceList.get(m).getAllowanceId() + "Diff"
											+ empInfoForArearlist.get(i).getEmpId(), diff);
									map.put(allowanceList.get(m).getAllowanceId() + "Cal"
											+ empInfoForArearlist.get(i).getEmpId(), cal);

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
					rowData.add("" + totalDiff);
					rowData.add("" + totalNet);
					rowData.add("" + basicOldTotal);
					rowData.add("" + basicCurrentTotal);
					rowData.add("" + basicDiffTotal);
					rowData.add("" + basicCalTotal);
					for (int m = 0; m < allowanceList.size(); m++) {

						double old = map.get(
								allowanceList.get(m).getAllowanceId() + "Old" + empInfoForArearlist.get(i).getEmpId());
						double current = map.get(allowanceList.get(m).getAllowanceId() + "Current"
								+ empInfoForArearlist.get(i).getEmpId());
						double diff = map.get(
								allowanceList.get(m).getAllowanceId() + "Diff" + empInfoForArearlist.get(i).getEmpId());
						double cal = map.get(
								allowanceList.get(m).getAllowanceId() + "Cal" + empInfoForArearlist.get(i).getEmpId());
						rowData.add("" + old);
						rowData.add("" + current);
						rowData.add("" + diff);
						rowData.add("" + cal);
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
	
	@RequestMapping(value = "/showArrearsEmployerPfRep", method = RequestMethod.GET)
	public void showArrearsEmployerPfRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Arrears Employer PF  Statement";

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

			GetSalaryCalcReport[] resArray = Constants.getRestTemplate().postForObject(Constants.url + "getArrearsPfStatement",
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
	
	@RequestMapping(value = "/showArrearsEmpPfRep", method = RequestMethod.GET)
	public void showArrearsEmpPfRep(HttpServletRequest request, HttpServletResponse response) {

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
			GetSalaryCalcReport[] resArray = Constants.getRestTemplate().postForObject(Constants.url + "getArrearsPfStatement",
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
	
	@RequestMapping(value = "/showArrearsStatutoryEsicRep", method = RequestMethod.GET)
	public void showArrearsStatutoryEsicRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Arrears Statutory ESIC Statement";
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
			StatutoryEsicRep[] resArray = Constants.getRestTemplate().postForObject(Constants.url + "getArearsStatutoryEsic",
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

}

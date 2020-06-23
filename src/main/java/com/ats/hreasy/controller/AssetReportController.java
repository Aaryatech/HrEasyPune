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
import java.util.List;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ats.hreasy.common.Constants;
import com.ats.hreasy.common.DateConvertor;
import com.ats.hreasy.common.ExceUtil;
import com.ats.hreasy.common.ExportToExcel;
import com.ats.hreasy.common.ItextPageEvent;
import com.ats.hreasy.common.ReportCostants;
import com.ats.hreasy.model.AssetVendor;
import com.ats.hreasy.model.Location;
import com.ats.hreasy.model.LoginResponse;
import com.ats.hreasy.model.MstCompanySub;
import com.ats.hreasy.model.report.GetYearlyAdvanceNew;
import com.ats.hrmgt.model.assets.AMCExpirationDetail;
import com.ats.hrmgt.model.assets.AssetNotificatn;
import com.ats.hrmgt.model.assets.AssetsDashDetails;
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
public class AssetReportController {

	@RequestMapping(value = "/assetsReports", method = RequestMethod.GET)
	public String assetsDashboard(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "asset/assetsReportPage";
		
		Date date = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat sf1 = new SimpleDateFormat("yyyy-MM-dd");
		
		HttpSession session = request.getSession();
		
		MultiValueMap<String, Object> map=null;
		
		LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");
		try {
			
			map = new LinkedMultiValueMap<>();
			map.add("companyId", 1);
			
			Location[] location = Constants.getRestTemplate().postForObject(Constants.url + "/getLocationList", map,
					Location[].class);
			List<Location> locationList = new ArrayList<Location>(Arrays.asList(location));
			model.addAttribute("locationList", locationList);
			
			AssetVendor[] assetVendorArr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllAssetVendor"
					, AssetVendor[].class);
			List<AssetVendor> assetVendorList = new ArrayList<AssetVendor>(Arrays.asList(assetVendorArr));
			model.addAttribute("assetVendorList",  assetVendorList);
			
			AssetNotificatn[] assetArr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllAssetsForNotifiction"
					, AssetNotificatn[].class);
			List<AssetNotificatn> assetRtnPndngList = new ArrayList<AssetNotificatn>(Arrays.asList(assetArr));
			model.addAttribute("assetRtnPndngList", assetRtnPndngList);
			
			AMCExpirationDetail[] assetAMCExpiryArr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllAssetsAMCForNotifiction"
					, AMCExpirationDetail[].class);
			List<AMCExpirationDetail> assetAMCExpiryList = new ArrayList<AMCExpirationDetail>(Arrays.asList(assetAMCExpiryArr));			
			model.addAttribute("assetAMCExpiryList", assetAMCExpiryList);
						
			ServicingDashDetails[] assetServiceArr = Constants.getRestTemplate().getForObject(Constants.url + "/getServicingDetails"
					, ServicingDashDetails[].class);
			List<ServicingDashDetails> assetServiceList = new ArrayList<ServicingDashDetails>(Arrays.asList(assetServiceArr));			
			model.addAttribute("assetServiceList", assetServiceList);
		}catch (Exception e) {
			
		}
		return mav;
	}

	
	@RequestMapping(value = "/getAllAssetsDetails", method = RequestMethod.GET)
	public void showAdvancePaymentYearlyRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "All Assets";
		
		String fromDate = null;
		String toDate = null;
		String location = null;
		String vendor = null;
		
		
		MultiValueMap<String, Object> map = null;

		HttpSession session = request.getSession();

		Boolean ret = false;
		try {
			List<AssetsDashDetails> assetDash = new ArrayList<AssetsDashDetails>();
			StringBuilder sb = new StringBuilder();
			
			
			int vendorIds = Integer.parseInt(request.getParameter("vendorsId"));
			
			int locId = Integer.parseInt(request.getParameter("locId"));
			
			String leaveDateRange = request.getParameter("dateRange");
			String[] arrOfStr = leaveDateRange.split("to", 2);	
			
			System.out.println(vendorIds+"  "+locId+"  "+arrOfStr[0]+"-"+arrOfStr[1]);
			
			map = new LinkedMultiValueMap<>();

			if (locId != 0) {
				map.add("locId", locId);
				Location loc = Constants.getRestTemplate().postForObject(Constants.url + "/getLocationById",
						map, Location.class);
				location = loc.getLocName();
			}
			
			
				map.add("assetVendorId", vendorIds);
				AssetVendor res = Constants.getRestTemplate().postForObject(Constants.url + "/getAssetVendorById",
						map, AssetVendor.class);
				
				
				if(vendorIds!=0) {
					vendor = res.getCompName();
				}else {
					vendor = "All";
				}
			
			
			
			fromDate = arrOfStr[0];
			toDate = arrOfStr[1];
			
				map = new LinkedMultiValueMap<>();
				map.add("locId", locId);
				map.add("vendorIds", vendorIds);
				map.add("fromDate", DateConvertor.convertToYMD(arrOfStr[0]));
				map.add("toDate", DateConvertor.convertToYMD(arrOfStr[1]));
				
				AssetsDashDetails[] assetArr = Constants.getRestTemplate().postForObject(Constants.url + "/getAssetsDashDetails", map,
						AssetsDashDetails[].class);
				assetDash = new ArrayList<AssetsDashDetails>(Arrays.asList(assetArr));
				
				
				System.out.println("Asset Dashboard Data-------------"+assetDash);

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
			table.setWidths(new float[] { 2.0f, 3.0f, 2.2f, 2.2f, 2.2f, 2.2f, 2.2f, 2.2f});
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

			hcell = new PdfPCell(new Phrase("Asset Detail", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Category", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);
			
			hcell = new PdfPCell(new Phrase("Model", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);

			hcell = new PdfPCell(new Phrase("Serial No.", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);
			
			hcell = new PdfPCell(new Phrase("Purchase Date", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);		
			
			hcell = new PdfPCell(new Phrase("Purchase Vendor", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);
			
			hcell = new PdfPCell(new Phrase("Location", tableHeaderFont));
			hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

			table.addCell(hcell);
			


			int index = 0;
			for (int i = 0; i < assetDash.size(); i++) {
				// System.err.println("I " + i);
				AssetsDashDetails asset = assetDash.get(i);

				index++;
				PdfPCell cell;
				cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + asset.getAssetCode()+" - "+asset.getAssetName(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + asset.getCatName(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);

				table.addCell(cell);
				
				
				cell = new PdfPCell(new Phrase("" + asset.getAssetModel(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + asset.getAssetSrno(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);
				
				cell = new PdfPCell(new Phrase("" + asset.getAssetPurDate(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);

				cell = new PdfPCell(new Phrase("" + asset.getCompName(), headFontData));
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

				table.addCell(cell);
				
				cell = new PdfPCell(new Phrase("" + asset.getLocName(), headFontData));
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
			document.add(new Paragraph("Location: " + location));
			document.add(new Paragraph("\n"));
			document.add(new Paragraph("Vendor: " + vendor));
			document.add(new Paragraph("\n"));
			document.add(new Paragraph("Date Range: " + fromDate+" to "+ toDate));

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
				rowData.add("Asset Detail");
				rowData.add("Category");
				rowData.add("Model");
				rowData.add("Serial No.");
				rowData.add("Purchase Date");
				rowData.add("Purchase Vendor");
				rowData.add("Location");
								

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);
				int cnt = 1;
				for (int i = 0; i < assetDash.size(); i++) {
					expoExcel = new ExportToExcel();
					rowData = new ArrayList<String>();
					cnt = cnt + i;

					rowData.add("" + (i + 1));
					rowData.add("" + assetDash.get(i).getAssetCode()+" - "+assetDash.get(i).getAssetName());
					rowData.add("" + assetDash.get(i).getCatName());
					rowData.add("" + assetDash.get(i).getAssetModel());
					rowData.add("" + assetDash.get(i).getAssetSrno());
					rowData.add("" + assetDash.get(i).getAssetPurDate());
					rowData.add("" + assetDash.get(i).getCompName());
					rowData.add("" + assetDash.get(i).getLocName());
					
					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);

				}

				XSSFWorkbook wb = null;
				try {

					wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName, "Location : "+location+"      Vendor : "+vendor+"\n Date : "+fromDate+" to "+toDate, "", 'P');

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

			System.err.println("Exce in getAllAssetsDetails " + e.getMessage());
			e.printStackTrace();

		}
	}
}

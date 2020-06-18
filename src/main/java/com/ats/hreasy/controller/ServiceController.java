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
import org.springframework.web.servlet.ModelAndView;

import com.ats.hreasy.common.AcessController;
import com.ats.hreasy.common.Constants;
import com.ats.hreasy.common.DateConvertor;
import com.ats.hreasy.common.FormValidation;
import com.ats.hreasy.common.VpsImageUpload;
import com.ats.hreasy.model.AccessRightModule;
import com.ats.hreasy.model.AssetServicing;
import com.ats.hreasy.model.AssetVendor;
import com.ats.hreasy.model.Assets;
import com.ats.hreasy.model.AssetsDetailsList;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.Location;
import com.ats.hreasy.model.LoginResponse;
import com.ats.hreasy.model.Setting;

@Controller
@Scope("session")
public class ServiceController {

	
	@RequestMapping(value = "/showAssetForServicing", method = RequestMethod.GET)
	public ModelAndView showAssetForServicing(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		ModelAndView model = null;
		List<AssetsDetailsList> assetsList = new ArrayList<AssetsDetailsList>();
		
		// LoginResponse userObj = (LoginResponse) session.getAttribute("UserDetail");
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("showAssetForServicing", "showAssetForServicing", 1, 0, 0, 0, newModuleList);

		if (view.isError() == true) {

			model = new ModelAndView("accessDenied");

		} else {

			try {
				model = new ModelAndView("servicing/assetForServicing");

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				
				map = new LinkedMultiValueMap<>();
				map.add("companyId", 1);

				Location[] location = Constants.getRestTemplate().postForObject(Constants.url + "/getLocationList", map,
						Location[].class);
				List<Location> locationList = new ArrayList<Location>(Arrays.asList(location));
				model.addObject("locationList", locationList);
				int locId = 0;
				try {
					locId = Integer.parseInt(request.getParameter("locId_list"));
				}catch (Exception e) {
					 locId = 0;
					 System.out.println(e.getMessage());
					e.printStackTrace();
				}
				
				map = new LinkedMultiValueMap<>();
				map.add("locId", locId);				

				if(locId>0) {
					
					AssetsDetailsList[] assetArr = Constants.getRestTemplate().postForObject(Constants.url + "/getAllAssetsByLocation", map
							, AssetsDetailsList[].class);
					assetsList = new ArrayList<AssetsDetailsList>(Arrays.asList(assetArr));
				}else {
					
				AssetsDetailsList[] assetArr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllAssets"
						, AssetsDetailsList[].class);
				assetsList = new ArrayList<AssetsDetailsList>(Arrays.asList(assetArr));
				}
				for (int i = 0; i < assetsList.size(); i++) {

					assetsList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(assetsList.get(i).getAssetId())));
				}

				Info edit = AcessController.checkAccess("showAssetForServicing", "showAssetForServicing", 0, 0, 1, 0,
						newModuleList);
				Info delete = AcessController.checkAccess("showAssetForServicing", "showAssetForServicing", 0, 0, 0, 1,
						newModuleList);
				Info add = AcessController.checkAccess("showAssetForServicing", "showAssetForServicing", 0, 1, 0, 0,
						newModuleList);
				
				if (add.isError() == false) {
					model.addObject("addAccess", 0);
				}
				if (edit.isError() == false) {
					model.addObject("editAccess", 0);
				}
				if (delete.isError() == false) {
					model.addObject("deleteAccess", 0);
				}
				model.addObject("assetsList", assetsList);

			} catch (Exception e) {
				System.out.println("Exception in showAllAssets : " + e.getMessage());
				e.printStackTrace();
			}
		}
		return model;
	}
	
	
	
	
	@RequestMapping(value = "/addAssetServicing", method = RequestMethod.GET)
	public ModelAndView addAssetServicing(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		ModelAndView model = null;
		
		try {
			
			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("showAssetForServicing", "showAssetForServicing", 0, 1, 0, 0, newModuleList);

			if (view.isError() == true) {

				model = new ModelAndView("accessDenied");

			} else {
				model = new ModelAndView("servicing/addServicing");
				
				AssetVendor[] assetVendorArr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllAssetVendor"
						, AssetVendor[].class);
				List<AssetVendor> assetVendorList = new ArrayList<AssetVendor>(Arrays.asList(assetVendorArr));
				model.addObject("assetVendorList",  assetVendorList);
				
				String base64encodedString = request.getParameter("assetId");
				String assetId = FormValidation.DecodeKey(base64encodedString);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("assetId", assetId);
				
				AssetsDetailsList asset = Constants.getRestTemplate().postForObject(Constants.url + "/getAssetInfoById", map,
						AssetsDetailsList.class);
				model.addObject("asset",  asset);
				
				model.addObject("title",  "Add Asset Servicing");				
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	
	
	@RequestMapping(value = "/submitSaveAssetServicing", method = RequestMethod.POST)
	public String submitInsertAsset(HttpServletRequest request, HttpServletResponse response,
		@RequestParam("doc") MultipartFile doc) {

		HttpSession session = request.getSession();
		LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("submitSaveAssetServicing", "showAssetForServicing", 0, 1, 0, 0, newModuleList);
		String a = new String();
		MultiValueMap<String, Object> map  = null;
		if (view.isError() == true) {

			a = "redirect:/accessDenied";

		} else {

			a = "redirect:/showAssetForServicing";
			try {
				
				Date date = new Date();
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				
				String assetImage = sf.format(date)+"_"+doc.getOriginalFilename();

				System.out.println("Profile Image------------" + assetImage);

				VpsImageUpload upload = new VpsImageUpload();
				Info info = upload.saveUploadedImge(doc, Constants.empDocSaveUrl, assetImage, Constants.values, 0, 0, 0, 0,
						0);
				
				AssetServicing assetService = new AssetServicing();
				int serviceId  = 0;
				try {
					serviceId = Integer.parseInt(request.getParameter("serviceId"));
				}catch (Exception e) {
					serviceId  = 0;
				}
				
				assetService.settServicingId(serviceId);				
				assetService.setAssetId(Integer.parseInt(request.getParameter("assetId")));
				assetService.setBillAmt(Float.parseFloat(request.getParameter("serv_bill_amt")));
				assetService.setBillDocFile(assetImage);
				assetService.setServiceDate(request.getParameter("serv_date"));
				assetService.setServiceDesc(request.getParameter("serv_desc"));
				assetService.setServiceRemark(request.getParameter("serv_remark"));
				assetService.setServiceType(Integer.parseInt(request.getParameter("serv_type")));
				assetService.setNextServiceDate("0000-00-00");
				assetService.setVendorId(Integer.parseInt(request.getParameter("serviceVendorId")));
				assetService.setDelStatus(1);				
				assetService.setExInt1(0);
				assetService.setExVar1("NA");
				assetService.setExInt2(0);
				assetService.setExVar2("NA");
				assetService.setMakerUserId(userObj.getUserId());
				assetService.setUpdateDatetime(sf.format(date));	
				

				AssetServicing res = Constants.getRestTemplate().postForObject(Constants.url + "/saveAssetsService", assetService,
						AssetServicing.class);

					if (res.getAssetId()>0) {						
						session.setAttribute("successMsg", "Asset Service Inserted Successfully");
					}
					else {
					
						session.setAttribute("errorMsg", "Failed to Insert Asset Service");
					}

				

			} catch (Exception e) {
				e.printStackTrace();
				session.setAttribute("errorMsg", "Failed to Insert Asset Service");
			}
		}

		return a;
	}
	
	
	@RequestMapping(value = "/editAssetServicing", method = RequestMethod.GET)
	public ModelAndView editAssetServicing(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		ModelAndView model = null;
		MultiValueMap<String, Object> map=null;
		try {
			
			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("editAssetServicing", "showAssetForServicing", 0, 0, 1, 0, newModuleList);

			if (view.isError() == true) {

				model = new ModelAndView("accessDenied");

			} else {
				model = new ModelAndView("servicing/editServicing");
				
			//	String base64encodedString = request.getParameter("servicingId");
			//	String servicingId = FormValidation.DecodeKey(base64encodedString);
				int serviceId = Integer.parseInt(request.getParameter("servicingId"));
				map = new LinkedMultiValueMap<>();
				map.add("serviceId", serviceId);
				
				AssetServicing service = Constants.getRestTemplate().postForObject(Constants.url + "/getAssetServicingById", map,
						AssetServicing.class);
				model.addObject("service", service);	
				
				map = new LinkedMultiValueMap<>();
				map.add("assetId", service.getAssetId());
				
				AssetsDetailsList asset = Constants.getRestTemplate().postForObject(Constants.url + "/getAssetInfoById", map,
						AssetsDetailsList.class);
				model.addObject("asset",  asset);
				
				AssetVendor[] assetVendorArr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllAssetVendor"
						, AssetVendor[].class);
				List<AssetVendor> assetVendorList = new ArrayList<AssetVendor>(Arrays.asList(assetVendorArr));
				model.addObject("assetVendorList",  assetVendorList);
				
				model.addObject("title",  "Edit Asset Servicing");				
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping(value = "/deleteAssetService", method = RequestMethod.GET)
	public String deleteAssetService(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		String a = null;

		try {

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");

			Info view = AcessController.checkAccess("deleteAssetService", "showAssetForServicing", 0, 0, 0, 1, newModuleList);
			if (view.isError() == true) {

				a = "redirect:/accessDenied";

			}

			else {

				a = "redirect:/showAssetForServicing";

				//String base64encodedString = request.getParameter("assetVendorId");
				//String assetVendorId = FormValidation.DecodeKey(base64encodedString);
				int serviceId = Integer.parseInt(request.getParameter("serviceId"));
				
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("serviceId", serviceId);
				
				Info info = Constants.getRestTemplate().postForObject(Constants.url + "/deleteAssetServiceById", map,
						Info.class);

				if (info.isError() == false) {
					session.setAttribute("successMsg", info.getMsg());
				} else {
					session.setAttribute("errorMsg", info.getMsg());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("errorMsg", "Failed to Delete");
		}
		return a;
	}

	
}

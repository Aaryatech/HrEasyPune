package com.ats.hreasy.controller;

import java.util.ArrayList;
import java.util.Arrays;
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
import org.springframework.web.servlet.ModelAndView;

import com.ats.hreasy.common.AcessController;
import com.ats.hreasy.common.Constants;
import com.ats.hreasy.common.FormValidation;
import com.ats.hreasy.model.AccessRightModule;
import com.ats.hreasy.model.AssetVendor;
import com.ats.hreasy.model.AssetsDetailsList;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.Location;

@Controller
@Scope("session")
public class ServiceController {

	
	@RequestMapping(value = "/showAssetForServicing", method = RequestMethod.GET)
	public ModelAndView showAssetForServicing(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		ModelAndView model = null;

		// LoginResponse userObj = (LoginResponse) session.getAttribute("UserDetail");
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("showAllAssets", "showAllAssets", 1, 0, 0, 0, newModuleList);

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

				AssetsDetailsList[] assetArr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllAssets"
						, AssetsDetailsList[].class);
				List<AssetsDetailsList> assetsList = new ArrayList<AssetsDetailsList>(Arrays.asList(assetArr));

				for (int i = 0; i < assetsList.size(); i++) {

					assetsList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(assetsList.get(i).getAssetId())));
				}

				Info edit = AcessController.checkAccess("showAllAssets", "showAllAssets", 0, 0, 1, 0,
						newModuleList);
				Info delete = AcessController.checkAccess("showAllAssets", "showAllAssets", 0, 0, 0, 1,
						newModuleList);
				Info add = AcessController.checkAccess("showAllAssets", "showAllAssets", 0, 1, 0, 0,
						newModuleList);
				
				if (add.isError() == false) {
					System.out.println(" add   Accessable ");
					model.addObject("addAccess", 0);

				}
				if (edit.isError() == false) {
					System.out.println(" edit   Accessable ");
					model.addObject("editAccess", 0);
				}
				if (delete.isError() == false) {
					System.out.println(" delete   Accessable ");
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
			Info view = AcessController.checkAccess("addAssetAmc", "showAllAssets", 0, 1, 0, 0, newModuleList);

			if (view.isError() == true) {

				model = new ModelAndView("accessDenied");

			} else {
				model = new ModelAndView("servicing/addServicing");
				
				AssetVendor[] assetVendorArr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllAssetVendor"
						, AssetVendor[].class);
				List<AssetVendor> assetVendorList = new ArrayList<AssetVendor>(Arrays.asList(assetVendorArr));
				model.addObject("assetVendorList",  assetVendorList);
				
				model.addObject("title",  "Add Asset Servicing");				
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	
	
	@RequestMapping(value = "/editAssetServicing", method = RequestMethod.GET)
	public ModelAndView editAssetServicing(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		ModelAndView model = null;
		
		try {
			
			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("addAssetAmc", "showAllAssets", 0, 1, 0, 0, newModuleList);

			if (view.isError() == true) {

				model = new ModelAndView("accessDenied");

			} else {
				model = new ModelAndView("servicing/editServicing");
				
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
	

	
}

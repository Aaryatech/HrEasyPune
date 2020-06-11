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
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ats.hreasy.common.AcessController;
import com.ats.hreasy.common.Constants;
import com.ats.hreasy.common.DateConvertor;
import com.ats.hreasy.common.FormValidation;
import com.ats.hreasy.model.AccessRightModule;
import com.ats.hreasy.model.AssetCategory;
import com.ats.hreasy.model.AssetVendor;
import com.ats.hreasy.model.Assets;
import com.ats.hreasy.model.AssetsDetailsList;
import com.ats.hreasy.model.EmployeeMaster;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.Location;
import com.ats.hreasy.model.LoginResponse;
import com.ats.hreasy.model.Setting;

@Controller
@Scope("session")
public class AssetMgmtController {

	/************************Assets Category***********************/
	@RequestMapping(value = "/showAssetCategory", method = RequestMethod.GET)
	public ModelAndView showAssetCategory(HttpServletRequest request, HttpServletResponse responser) {

		HttpSession session = request.getSession();
		ModelAndView model = null;

		// LoginResponse userObj = (LoginResponse) session.getAttribute("UserDetail");
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("showAssetCategory", "showAssetCategory", 1, 0, 0, 0, newModuleList);

		if (view.isError() == true) {

			model = new ModelAndView("accessDenied");

		} else {

			try {
				model = new ModelAndView("asset/assetCatList");

				//MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				//map.add("companyId", 1);

				AssetCategory[] assetArr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllAssetCategory"
						, AssetCategory[].class);
				List<AssetCategory> assetList = new ArrayList<AssetCategory>(Arrays.asList(assetArr));

				for (int i = 0; i < assetList.size(); i++) {

					assetList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(assetList.get(i).getAssetCatId())));
				}

				Info edit = AcessController.checkAccess("showAssetCategory", "showAssetCategory", 0, 0, 1, 0,
						newModuleList);
				Info delete = AcessController.checkAccess("showAssetCategory", "showAssetCategory", 0, 0, 0, 1,
						newModuleList);
				Info add = AcessController.checkAccess("showAssetCategory", "showAssetCategory", 0, 1, 0, 0,
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
				model.addObject("assetList", assetList);

			} catch (Exception e) {
				System.out.println("Exception in showAssetCategory : " + e.getMessage());
				e.printStackTrace();
			}
		}
		
		return model;

	}
	
	@RequestMapping(value = "/addAssetCategory", method = RequestMethod.GET)
	public ModelAndView addAssetCategory(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		ModelAndView model = null;

		try {
			AssetCategory asset = new AssetCategory();
			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("addAssetCategory", "showAssetCategory", 0, 1, 0, 0, newModuleList);

			if (view.isError() == true) {

				model = new ModelAndView("accessDenied");

			} else {
				model = new ModelAndView("asset/assetCategoryAdd");
				model.addObject("asset", asset);
				model.addObject("title",  "Add Asset Category");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	
	
	@RequestMapping(value = "/submitInsertAssetCat", method = RequestMethod.POST)
	public String submitInsertAssetCat(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("addAssetCategory", "showAssetCategory", 0, 1, 0, 0, newModuleList);
		String a = new String();
		if (view.isError() == true) {

			a = "redirect:/accessDenied";

		} else {

			a = "redirect:/showAssetCategory";
			try {

				Date date = new Date();
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

				int assetCatId = 0;
				try {
					assetCatId = Integer.parseInt(request.getParameter("assetCatId"));
				}catch (Exception e) {
					assetCatId = 0;
					e.printStackTrace();
				}
			
				AssetCategory asset = new AssetCategory();

					
					asset.setAssetCatId(assetCatId);
					asset.setCatName(request.getParameter("assetCat"));					
					asset.setCatRemark(request.getParameter("remark"));					
					asset.setDelStatus(1);
					asset.setMakerUserId(userObj.getUserId());					
					asset.setUpdateDatetime(sf.format(date));
					asset.setExInt1(0);
					asset.setExVar1("NA");

					AssetCategory res = Constants.getRestTemplate().postForObject(Constants.url + "/saveAssetCat", asset,
							AssetCategory.class);

					if (res.getAssetCatId()>0) {
						if(assetCatId>0) {
							session.setAttribute("successMsg", "Asset Category Updated Successfully");
						}else {
							session.setAttribute("successMsg", "Asset Category Inserted Successfully");
						}
					} 
					else if(res.getAssetCatId()<0){
						session.setAttribute("errorMsg", "Failed to Insert Asset Category, Record Already Exist");
						a = "redirect:/addAssetCategory";
					}
					else {
					
						session.setAttribute("errorMsg", "Failed to Insert Asset Category");
					}

				

			} catch (Exception e) {
				e.printStackTrace();
				session.setAttribute("errorMsg", "Failed to Insert Record");
			}
		}

		return a;
	}
	
	@RequestMapping(value = "/editAssetCategory", method = RequestMethod.GET)
	public ModelAndView editAssetCategory(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		ModelAndView model = null;

		try {

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("editAssetCategory", "showAssetCategory", 0, 0, 1, 0, newModuleList);

			if (view.isError() == true) {

				model = new ModelAndView("accessDenied");

			} else {

				model = new ModelAndView("asset/assetCategoryAdd");
				String base64encodedString = request.getParameter("assetCatId");
				String assetCatId = FormValidation.DecodeKey(base64encodedString);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("assetCatId", assetCatId);
				AssetCategory editAsset = Constants.getRestTemplate().postForObject(Constants.url + "/getAssetCatById", map,
						AssetCategory.class);
				model.addObject("asset", editAsset);
				model.addObject("title",  "Edit Asset Category");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping(value = "/deleteAssetCat", method = RequestMethod.GET)
	public String deleteAssetCat(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		String a = null;

		try {

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");

			Info view = AcessController.checkAccess("deleteAssetCat", "showAssetCategory", 0, 0, 0, 1, newModuleList);
			if (view.isError() == true) {

				a = "redirect:/accessDenied";

			}

			else {

				a = "redirect:/showAssetCategory";

				String base64encodedString = request.getParameter("assetCatId");
				String assetCatId = FormValidation.DecodeKey(base64encodedString);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("assetCatId", assetCatId);
				Info info = Constants.getRestTemplate().postForObject(Constants.url + "/deleteAssetCat", map,
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

	
	@RequestMapping(value = "/getAssetCategoryInfo", method = RequestMethod.GET)
	public AssetCategory getAssetCategoryInfo(HttpServletRequest request, HttpServletResponse response) {
		AssetCategory res = new  AssetCategory();
		try {
			String assetCat = request.getParameter("cat");
			System.out.println("cat---------"+assetCat);
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("assetCat", assetCat);
			
			res =  Constants.getRestTemplate().postForObject(Constants.url + "/getAssetCat", map,
					AssetCategory.class);
			System.err.println("AssetCat----"+res);
		}catch (Exception e) {
			// TODO: handle exception
		}
		return res;
		
		
	}
	
	/**************************AssetVendor*****************************/
	@RequestMapping(value = "/showAssetVendor", method = RequestMethod.GET)
	public ModelAndView showAssetVendor(HttpServletRequest request, HttpServletResponse responser) {

		HttpSession session = request.getSession();
		ModelAndView model = null;

		// LoginResponse userObj = (LoginResponse) session.getAttribute("UserDetail");
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("showAssetVendor", "showAssetVendor", 1, 0, 0, 0, newModuleList);

		if (view.isError() == true) {

			model = new ModelAndView("accessDenied");

		} else {

			try {
				model = new ModelAndView("asset/assetVendorList");

				//MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				//map.add("companyId", 1);

				AssetVendor[] assetArr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllAssetVendor"
						, AssetVendor[].class);
				List<AssetVendor> assetVendorList = new ArrayList<AssetVendor>(Arrays.asList(assetArr));

				for (int i = 0; i < assetVendorList.size(); i++) {

					assetVendorList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(assetVendorList.get(i).getVendorId())));
				}

				Info edit = AcessController.checkAccess("showAssetVendor", "showAssetVendor", 0, 0, 1, 0,
						newModuleList);
				Info delete = AcessController.checkAccess("showAssetVendor", "showAssetVendor", 0, 0, 0, 1,
						newModuleList);
				Info add = AcessController.checkAccess("showAssetVendor", "showAssetVendor", 0, 1, 0, 0,
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
				model.addObject("assetVendorList", assetVendorList);

			} catch (Exception e) {
				System.out.println("Exception in showAssetVendor : " + e.getMessage());
				e.printStackTrace();
			}
		}
		
		return model;

	}
	
	@RequestMapping(value = "/addAssetVendor", method = RequestMethod.GET)
	public ModelAndView addAssetVendor(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		ModelAndView model = null;

		try {
			AssetVendor assetVendor = new AssetVendor();
			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("addAssetVendor", "showAssetVendor", 0, 1, 0, 0, newModuleList);

			if (view.isError() == true) {

				model = new ModelAndView("accessDenied");

			} else {
				model = new ModelAndView("asset/assetVendorAdd");
				model.addObject("assetVendor", assetVendor);
				model.addObject("title",  "Add Asset Vendor");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	
	
	
	@RequestMapping(value = "/submitInsertAssetVendor", method = RequestMethod.POST)
	public String submitInsertAssetVendor(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("addAssetVendor", "showAssetVendor", 0, 1, 0, 0, newModuleList);
		String a = new String();
		if (view.isError() == true) {

			a = "redirect:/accessDenied";

		} else {

			a = "redirect:/showAssetVendor";
			try {

				Date date = new Date();
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

				int assetCatId = 0;
				try {
					assetCatId = Integer.parseInt(request.getParameter("vendorId"));
				}catch (Exception e) {
					 assetCatId = 0;
					e.printStackTrace();
				}
			
				AssetVendor assetVendor = new AssetVendor();
				assetVendor.setVendorId(assetCatId);
				assetVendor.setCompAddress(request.getParameter("compAddress"));
				assetVendor.setCompName(request.getParameter("compName"));
				assetVendor.setConatctPersonName(request.getParameter("contactPersonName"));
				assetVendor.setContactNo1(request.getParameter("contact1"));
				assetVendor.setContactNo2(request.getParameter("contact2"));
				assetVendor.setContactPersonEmail(request.getParameter("contactPersonEmail"));
				assetVendor.setContactPersonNo(request.getParameter("contactPersonNo"));
				assetVendor.setGstin(request.getParameter("gstin"));
				assetVendor.setVendorCity(request.getParameter("vendorCity"));
				assetVendor.setVendorEmail(request.getParameter("vendorEmail"));
				assetVendor.setWebsite(request.getParameter("website"));								
				assetVendor.setRemark(request.getParameter("remark"));					
				assetVendor.setDelStatus(1);				
				assetVendor.setExInt1(0);
				assetVendor.setExVar1("NA");
				assetVendor.setExInt2(0);
				assetVendor.setExVar2("NA");
				assetVendor.setMakerUserId(userObj.getUserId());
				assetVendor.setUpdateDatetime(sf.format(date));
				

				AssetVendor res = Constants.getRestTemplate().postForObject(Constants.url + "/saveAssetVendor", assetVendor,
						AssetVendor.class);

					if (res.getVendorId()>0) {
						if(assetCatId>0) {
							session.setAttribute("successMsg", "Asset Vendor Updated Successfully");
						}else {
							session.setAttribute("successMsg", "Asset Vendor Inserted Successfully");
						}
					} 
					else if(res.getVendorId()<0){
						session.setAttribute("errorMsg", "Failed to Insert Asset Vendor, Record Already Exist");
						a = "redirect:/addAssetVendor";
					}
					else {
					
						session.setAttribute("errorMsg", "Failed to Insert Asset Vendor");
					}

				

			} catch (Exception e) {
				e.printStackTrace();
				session.setAttribute("errorMsg", "Failed to Insert Record");
			}
		}

		return a;
	}
	
	
	@RequestMapping(value = "/editAssetVendor", method = RequestMethod.GET)
	public ModelAndView editAssetVendor(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		ModelAndView model = null;

		try {

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("editAssetVendor", "showAssetVendor", 0, 0, 1, 0, newModuleList);

			if (view.isError() == true) {

				model = new ModelAndView("accessDenied");

			} else {

				model = new ModelAndView("asset/assetVendorAdd");
				String base64encodedString = request.getParameter("assetVendorId");
				String assetVendorId = FormValidation.DecodeKey(base64encodedString);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("assetVendorId", assetVendorId);
				AssetVendor editAsset = Constants.getRestTemplate().postForObject(Constants.url + "/getAssetVendorById", map,
						AssetVendor.class);
				model.addObject("assetVendor", editAsset);
				model.addObject("title",  "Edit Asset Vendor");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	
	
	
	@RequestMapping(value = "/deleteAssetVendor", method = RequestMethod.GET)
	public String deleteAssetVendor(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		String a = null;

		try {

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");

			Info view = AcessController.checkAccess("deleteAssetVendor", "showAssetVendor", 0, 0, 0, 1, newModuleList);
			if (view.isError() == true) {

				a = "redirect:/accessDenied";

			}

			else {

				a = "redirect:/showAssetVendor";

				String base64encodedString = request.getParameter("assetVendorId");
				String assetVendorId = FormValidation.DecodeKey(base64encodedString);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("assetVendorId", assetVendorId);
				Info info = Constants.getRestTemplate().postForObject(Constants.url + "/deleteAssetVendorById", map,
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
		/****************************Assets********************************/
	@RequestMapping(value = "/showAllAssets", method = RequestMethod.GET)
	public ModelAndView showAllAssets(HttpServletRequest request, HttpServletResponse responser) {

		HttpSession session = request.getSession();
		ModelAndView model = null;

		// LoginResponse userObj = (LoginResponse) session.getAttribute("UserDetail");
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("showAllAssets", "showAllAssets", 1, 0, 0, 0, newModuleList);

		if (view.isError() == true) {

			model = new ModelAndView("accessDenied");

		} else {

			try {
				model = new ModelAndView("asset/assetsList");

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
	
	
	@RequestMapping(value = "/addAsset", method = RequestMethod.GET)
	public ModelAndView addAsset(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		ModelAndView model = null;
		String invoiceNo = new String();
		MultiValueMap<String, Object> map = null;
		try {
			Assets asset = new Assets();
			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("addAsset", "showAllAssets", 0, 1, 0, 0, newModuleList);

			if (view.isError() == true) {

				model = new ModelAndView("accessDenied");

			} else {
				model = new ModelAndView("asset/addAsset");
				
				AssetCategory[] assetArr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllAssetCategory"
						, AssetCategory[].class);
				List<AssetCategory> assetCatList = new ArrayList<AssetCategory>(Arrays.asList(assetArr));
				model.addObject("assetCatList",  assetCatList);
				
				AssetVendor[] assetVendorArr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllAssetVendor"
						, AssetVendor[].class);
				List<AssetVendor> assetVendorList = new ArrayList<AssetVendor>(Arrays.asList(assetVendorArr));
				model.addObject("assetVendorList",  assetVendorList);
				
				map = new LinkedMultiValueMap<>();
				map.add("limitKey", "assetCodeValue");
				
				Setting settingValue = Constants.getRestTemplate().postForObject(Constants.url + "/getSettingByKey", map,
						Setting.class);
				
				map = new LinkedMultiValueMap<>();
				map.add("limitKey", "assetCodeLength");
				
				Setting strLength = Constants.getRestTemplate().postForObject(Constants.url + "/getSettingByKey", map,
						Setting.class);
				
				map = new LinkedMultiValueMap<>();
				map.add("limitKey", "assetCodeStr");
				Setting astCodeStr = Constants.getRestTemplate().postForObject(Constants.url + "/getSettingByKey", map,
						Setting.class);
				try {
					
					int strLnth = Integer.parseInt(strLength.getValue());
					int strVal = Integer.parseInt(settingValue.getValue());
					
					invoiceNo =astCodeStr.getValue()+"_"+String.format("%0"+strLnth+"d" , strVal);
					//System.out.println("------------------"+invoiceNo);
				}catch (Exception e) {
					e.printStackTrace();
				}
				
				asset.setAssetCode(invoiceNo);
				model.addObject("asset", asset);
				model.addObject("title",  "Add Asset");				
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	
	
	@RequestMapping(value = "/submitInsertAsset", method = RequestMethod.POST)
	public String submitInsertAsset(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("submitInsertAsset", "showAllAssets", 0, 1, 0, 0, newModuleList);
		String a = new String();
		MultiValueMap<String, Object> map  = null;
		if (view.isError() == true) {

			a = "redirect:/accessDenied";

		} else {

			a = "redirect:/showAllAssets";
			try {
				
				Date date = new Date();
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				int assetId = 0;
				try {
					assetId = Integer.parseInt(request.getParameter("assetId"));
				}catch (Exception e) {
					assetId = 0;
					e.printStackTrace();					
				}
				
				Assets assets = new Assets();
				assets.setAssetCatId(Integer.parseInt(request.getParameter("assetCatId")));
				assets.setAssetCode(request.getParameter("assetCode"));
				assets.setAssetDesc(request.getParameter("assetDesc"));
				assets.setAssetId(assetId);
				assets.setAssetMake(request.getParameter("assetMake"));
				assets.setAssetModel(request.getParameter("assetModel"));
				assets.setAssetName(request.getParameter("assetName"));
				assets.setAssetPurDate(DateConvertor.convertToYMD(request.getParameter("assetPurDate")));
				assets.setAssetRemark(request.getParameter("remark"));
				assets.setAssetSrno(request.getParameter("assetSrno"));
				assets.setVendorId(Integer.parseInt(request.getParameter("assetVendorId")));
				assets.setDelStatus(1);				
				assets.setExInt1(0);
				assets.setExVar1("NA");
				assets.setExInt2(0);
				assets.setExVar2("NA");
				assets.setMakerUserId(userObj.getUserId());
				assets.setUpdateDatetime(sf.format(date));
				

				Assets res = Constants.getRestTemplate().postForObject(Constants.url + "/saveAssets", assets,
						Assets.class);

					if (res.getAssetId()>0) {
						if(assetId>0) {
							session.setAttribute("successMsg", "Asset Updated Successfully");
						}else {
							
							map  = new LinkedMultiValueMap<>();
							map.add("limitKey", "assetCodeValue");
							
							Setting settingValue = Constants.getRestTemplate().postForObject(Constants.url + "/getSettingByKey", map,
									Setting.class);
							int strValue = Integer.parseInt(settingValue.getValue())+1;
							
							map.add("settingId", settingValue.getSettingId());
							map.add("val", strValue);
							Info inf = Constants.getRestTemplate().postForObject(Constants.url + "/updateSetting", map,
									Info.class);
							
							session.setAttribute("successMsg", "Asset Inserted Successfully");
						}
						
						
					}
					else {
					
						session.setAttribute("errorMsg", "Failed to Insert Asset");
					}

				

			} catch (Exception e) {
				e.printStackTrace();
				session.setAttribute("errorMsg", "Failed to Insert Asset");
			}
		}

		return a;
	}
	
	@RequestMapping(value = "/editAsset", method = RequestMethod.GET)
	public ModelAndView editAsset(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		ModelAndView model = null;

		try {

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("editAssetVendor", "showAssetVendor", 0, 0, 1, 0, newModuleList);

			if (view.isError() == true) {

				model = new ModelAndView("accessDenied");

			} else {

				model = new ModelAndView("asset/addAsset");
				String base64encodedString = request.getParameter("assetId");
				String assetId = FormValidation.DecodeKey(base64encodedString);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("assetId", assetId);
				Assets editAsset = Constants.getRestTemplate().postForObject(Constants.url + "/getAssetById", map,
						Assets.class);
				editAsset.setAssetPurDate(DateConvertor.convertToDMY(editAsset.getAssetPurDate()));
				model.addObject("asset", editAsset);
				
				AssetCategory[] assetArr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllAssetCategory"
						, AssetCategory[].class);
				List<AssetCategory> assetCatList = new ArrayList<AssetCategory>(Arrays.asList(assetArr));
				model.addObject("assetCatList",  assetCatList);
				
				AssetVendor[] assetVendorArr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllAssetVendor"
						, AssetVendor[].class);
				List<AssetVendor> assetVendorList = new ArrayList<AssetVendor>(Arrays.asList(assetVendorArr));
				model.addObject("assetVendorList",  assetVendorList);
				
				
				model.addObject("title",  "Edit Asset");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping(value = "/deleteAsset", method = RequestMethod.GET)
	public String deleteAsset(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		String a = null;

		try {

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");

			Info view = AcessController.checkAccess("deleteAssetVendor", "showAssetVendor", 0, 0, 0, 1, newModuleList);
			if (view.isError() == true) {

				a = "redirect:/accessDenied";

			}

			else {

				a = "redirect:/showAllAssets";

				String base64encodedString = request.getParameter("assetId");
				String assetId = FormValidation.DecodeKey(base64encodedString);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("assetId", assetId);
				Info info = Constants.getRestTemplate().postForObject(Constants.url + "/deleteAssetById", map,
						Info.class);

				if (info.isError() == false) {
					session.setAttribute("successMsg", info.getMsg());
				} else {
					session.setAttribute("errorMsg", info.getMsg());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("errorMsg", "Failed to Delete Asset");
		}
		return a;
	}
	
	/*****************************************************************************/
	
	@RequestMapping(value = "/manageAssets", method = RequestMethod.GET)
	public ModelAndView manageAssets(HttpServletRequest request, HttpServletResponse responser) {

		HttpSession session = request.getSession();
		ModelAndView model = null;

		// LoginResponse userObj = (LoginResponse) session.getAttribute("UserDetail");
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("manageAssets", "manageAssets", 1, 0, 0, 0, newModuleList);

		if (view.isError() == true) {

			model = new ModelAndView("accessDenied");

		} else {

			try {
				model = new ModelAndView("asset/manageAssets");

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				
				map = new LinkedMultiValueMap<>();
				map.add("companyId", 1);

				Location[] location = Constants.getRestTemplate().postForObject(Constants.url + "/getLocationList", map,
						Location[].class);
				List<Location> locationList = new ArrayList<Location>(Arrays.asList(location));
				model.addObject("locationList", locationList);

				Info edit = AcessController.checkAccess("manageAssets", "manageAssets", 0, 0, 1, 0,
						newModuleList);
				Info delete = AcessController.checkAccess("manageAssets", "manageAssets", 0, 0, 0, 1,
						newModuleList);
				Info add = AcessController.checkAccess("manageAssets", "manageAssets", 0, 1, 0, 0,
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

			} catch (Exception e) {
				System.out.println("Exception in 	 : " + e.getMessage());
				e.printStackTrace();
			}
		}
		
		return model;

	}
	
	
	@RequestMapping(value = "/assignAssets", method = RequestMethod.GET)
	public ModelAndView assignAssets(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		ModelAndView model = null;

		try {

//			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
//			Info view = AcessController.checkAccess("assignAssets", "manageAssets", 0, 0, 1, 0, newModuleList);
//
//			if (view.isError() == true) {
//
//				model = new ModelAndView("accessDenied");
//
//			} else {
//
//				model = new ModelAndView("asset/assignAssets");
//				
//			}
			model = new ModelAndView("asset/assignAssets");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	
	
	
	@RequestMapping(value = "/returnAssets", method = RequestMethod.GET)
	public ModelAndView returnAssets(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		ModelAndView model = null;

		try {
			model = new ModelAndView("asset/returnAssets");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
}

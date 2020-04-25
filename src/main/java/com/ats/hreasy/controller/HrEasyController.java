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
import com.ats.hreasy.model.Bank;
import com.ats.hreasy.model.CalenderYear;
import com.ats.hreasy.model.Contractor;
import com.ats.hreasy.model.Department;
import com.ats.hreasy.model.Designation;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.Location;
import com.ats.hreasy.model.LoginResponse;
import com.ats.hreasy.model.Setting;
import com.ats.hreasy.model.SlabMaster;
import com.ats.hreasy.model.WeekoffCategory;

@Controller
@Scope("session")
public class HrEasyController {

	Date date = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String currDate = sf.format(date);

	/****************************** Designation ********************************/
	@RequestMapping(value = "/showDesignationList", method = RequestMethod.GET)
	public ModelAndView showLocationList(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		// LoginResponse userObj = (LoginResponse) session.getAttribute("UserDetail");

		ModelAndView model = null;

		try {

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("showDesignationList", "showDesignationList", 1, 0, 0, 0,
					newModuleList);

			if (view.isError() == true) {

				model = new ModelAndView("accessDenied");

			} else {

				model = new ModelAndView("master/designationList");
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("companyId", 1);
				Designation[] designation = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getAllDesignationsListBySortNo", map, Designation[].class);

				List<Designation> designationList = new ArrayList<Designation>(Arrays.asList(designation));

				for (int i = 0; i < designationList.size(); i++) {

					designationList.get(i)
							.setExVar1(FormValidation.Encrypt(String.valueOf(designationList.get(i).getDesigId())));
				}

				model.addObject("designationList", designationList);

				Info add = AcessController.checkAccess("showDesignationList", "showDesignationList", 0, 1, 0, 0,
						newModuleList);
				Info edit = AcessController.checkAccess("showDesignationList", "showDesignationList", 0, 0, 1, 0,
						newModuleList);
				Info delete = AcessController.checkAccess("showDesignationList", "showDesignationList", 0, 0, 0, 1,
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

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/dsesignationAdd", method = RequestMethod.GET)
	public ModelAndView locationAdd(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		ModelAndView model = null;

		try {
			Designation desig = new Designation();

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("dsesignationAdd", "showDesignationList", 0, 1, 0, 0,
					newModuleList);

			if (view.isError() == true) {

				model = new ModelAndView("accessDenied");

			} else {

				model = new ModelAndView("master/designationAdd");
				model.addObject("desig", desig);
				model.addObject("title", "Add Designation");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/submitInsertDesignation", method = RequestMethod.POST)
	public String submitInsertDesignation(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {

		String a = null;

		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("dsesignationAdd", "showDesignationList", 0, 1, 0, 0, newModuleList);

		if (view.isError() == true) {

			a = "redirect:/accessDenied";

		} else {
			try {
				a = "redirect:/showDesignationList";
				Designation desig = new Designation();
				
				/* String sh[]=request.getParameter("desigShortName").split("-"); */
				desig.setRemarks(request.getParameter("remark"));

				desig.setCompanyId(1);
				desig.setDelStatus(1);
				desig.setDesigId(Integer.parseInt(request.getParameter("desigId")));
				desig.setExInt1(Integer.parseInt(request.getParameter("sortNo")));
				desig.setExInt2(0);
				desig.setExVar1("NA");
				desig.setExVar2("NA");
				desig.setIsActive(1);
				desig.setMakerEnterDatetime(currDate);
				desig.setName(request.getParameter("desigName"));
				desig.setNameSd(request.getParameter("desigShortName"));
				
				

				Designation saveDesig = Constants.getRestTemplate().postForObject(Constants.url + "/saveDesignation",
						desig, Designation.class);
				if (saveDesig != null) {
					if(desig.getDesigId()>0) {
						session.setAttribute("successMsg", "Designation Updated Successfully");
					}else {
						session.setAttribute("successMsg", "Designation Inserted Successfully");
					}
				} else {
					session.setAttribute("errorMsg", "Failed to Update Record");
				}

			} catch (Exception e) {
				e.printStackTrace();
				session.setAttribute("errorMsg", "Failed to Update Record");
			}
		}

		return a;

	}

	@RequestMapping(value = "/editDesignation", method = RequestMethod.GET)
	public ModelAndView editDesignation(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		Designation desig = new Designation();
		ModelAndView model = null;

		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("editDesignation", "showDesignationList", 0, 0, 1, 0, newModuleList);

		if (view.isError() == true) {

			model = new ModelAndView("accessDenied");

		} else {
			try {
				model = new ModelAndView("master/designationAdd");

				String base64encodedString = request.getParameter("desigId");
				String desigId = FormValidation.DecodeKey(base64encodedString);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("desigId", desigId);
				map.add("companyId", 1);
				desig = Constants.getRestTemplate().postForObject(Constants.url + "/getDesignationById", map,
						Designation.class);
				model.addObject("desig", desig);
				model.addObject("title", "Edit Designation");

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return model;

	}

	@RequestMapping(value = "/deleteDesignation", method = RequestMethod.GET)
	public String deleteDesignation(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String a = null;

		try {

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");

			Info view = AcessController.checkAccess("deleteDesignation", "showDesignationList", 0, 0, 0, 1,
					newModuleList);
			if (view.isError() == true) {

				a = "redirect:/accessDenied";

			}

			else {

				a = "redirect:/showDesignationList";

				String base64encodedString = request.getParameter("desigId");
				String desigId = FormValidation.DecodeKey(base64encodedString);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("desigId", desigId);
				map.add("companyId", 1);
				Integer emp = Constants.getRestTemplate().postForObject(Constants.url + "/getEmpByDesignationId", map,
						Integer.class);

				if (emp == 0) {

					Info res = Constants.getRestTemplate().postForObject(Constants.url + "/deleteDesignationById", map,
							Info.class);

					if (res.isError()) {
						session.setAttribute("errorMsg", "Failed to Delete Designation");
					} else {
						session.setAttribute("successMsg", "Designation Deleted Successfully");

					}
				} else {
					session.setAttribute("errorMsg",
							"Failed to Delete - Designation assigned to " + emp + " employees ");
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("errorMsg", "Failed to Delete");
		}

		return a;
	}

	/****************************** Contractor ********************************/
	@RequestMapping(value = "/showContractorsList", method = RequestMethod.GET)
	public ModelAndView showContractorsList(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		// LoginResponse userObj = (LoginResponse) session.getAttribute("UserDetail");

		ModelAndView model = null;

		try {

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("showContractorsList", "showContractorsList", 1, 0, 0, 0,
					newModuleList);

			if (view.isError() == true) {

				model = new ModelAndView("accessDenied");

			} else {

				model = new ModelAndView("master/contractorList");
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("companyId", 1);
				Contractor[] contractor = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getAllContractors", map, Contractor[].class);

				List<Contractor> contractorsList = new ArrayList<Contractor>(Arrays.asList(contractor));

				for (int i = 0; i < contractorsList.size(); i++) {

					contractorsList.get(i).setExVar1(
							FormValidation.Encrypt(String.valueOf(contractorsList.get(i).getContractorId())));
				}

				model.addObject("contractorsList", contractorsList);

				Info add = AcessController.checkAccess("showContractorsList", "showContractorsList", 0, 1, 0, 0,
						newModuleList);
				Info edit = AcessController.checkAccess("showContractorsList", "showContractorsList", 0, 0, 1, 0,
						newModuleList);
				Info delete = AcessController.checkAccess("showContractorsList", "showContractorsList", 0, 0, 0, 1,
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

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/contractorAdd", method = RequestMethod.GET)
	public ModelAndView contractorAdd(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		ModelAndView model = null;

		try {
			Contractor contract = new Contractor();

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("contractorAdd", "showContractorsList", 0, 1, 0, 0, newModuleList);

			if (view.isError() == true) {

				model = new ModelAndView("accessDenied");

			} else {

				model = new ModelAndView("master/addContractor");
				model.addObject("title", "Add Contractor");
				model.addObject("contract", contract);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/insertContractor", method = RequestMethod.POST)
	public String insertContractor(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String a = null;
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("contractorAdd", "showContractorsList", 0, 1, 0, 0, newModuleList);

		if (view.isError() == true) {
			a = "redirect:/accessDenied";

		} else {
			a = "redirect:/showContractorsList";

			try {

				Contractor contract = new Contractor();

				contract.setContractorId(Integer.parseInt(request.getParameter("contractorId")));
				contract.setAddress(request.getParameter("address"));
				contract.setCompanyId(1);
				contract.setDelStatus(1);
				contract.setDuration(request.getParameter("duration"));
				contract.setEmail(request.getParameter("email"));
				contract.setEsicNo(request.getParameter("esic"));
				contract.setIsActive(1);
				contract.setLicenceNo(request.getParameter("licenceNo"));
				contract.setMakerEnterDatetime(currDate);
				contract.setMobileNo(request.getParameter("mobileNo"));
				contract.setOfficeNo(request.getParameter("officeNo"));
				contract.setOrgName(request.getParameter("organisation"));
				contract.setOwner(request.getParameter("owner"));
				contract.setPanNo(request.getParameter("panNo"));
				contract.setPfNo(request.getParameter("pf"));
				contract.setRemark(request.getParameter("remark"));
				contract.setService("NA");
				contract.setVatNo(request.getParameter("vat"));
				contract.setExInt1(0);
				contract.setExInt2(0);
				contract.setExVar1("NA");
				contract.setExVar2("NA");

				Contractor saveDesig = Constants.getRestTemplate().postForObject(Constants.url + "/saveContractor",
						contract, Contractor.class);

				if (saveDesig != null) {
					if(contract.getContractorId()>0) {
						session.setAttribute("successMsg", "Contractor Updated Successfully");
					}else {
						session.setAttribute("successMsg", "Contractor Inserted Successfully");
					}
				} else {
					session.setAttribute("errorMsg", "Failed to Update Record");
				}

			} catch (Exception e) {
				e.printStackTrace();
				session.setAttribute("errorMsg", "Failed to Update Record");
			}
		}

		return a;

	}

	@RequestMapping(value = "/editContractor", method = RequestMethod.GET)
	public ModelAndView editContractor(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		Contractor contract = new Contractor();
		ModelAndView model = null;

		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("editContractor", "showContractorsList", 0, 1, 0, 0, newModuleList);

		if (view.isError() == true) {

			model = new ModelAndView("accessDenied");

		} else {

			try {
				model = new ModelAndView("master/addContractor");
				model.addObject("title", "Edit Contractor");
				String base64encodedString = request.getParameter("contractor");
				String contractorId = FormValidation.DecodeKey(base64encodedString);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("contractorId", contractorId);

				contract = Constants.getRestTemplate().postForObject(Constants.url + "/getContractorById", map,
						Contractor.class);
				model.addObject("contract", contract);

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return model;

	}

	@RequestMapping(value = "/deleteContractor", method = RequestMethod.GET)
	public String deleteContractor(HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		String a = null;

		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");

		Info view = AcessController.checkAccess("deleteContractor", "showContractorsList", 0, 0, 0, 1, newModuleList);
		if (view.isError() == true) {

			a = "redirect:/accessDenied";

		}

		else {

			a = "redirect:/showContractorsList";

			try {
				String base64encodedString = request.getParameter("contractor");
				String contractorId = FormValidation.DecodeKey(base64encodedString);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("contractorId", contractorId);
				map.add("companyId", 1);

				Integer emp = Constants.getRestTemplate().postForObject(Constants.url + "/getEmpByContractorId", map,
						Integer.class);

				System.out.println("Emp-------------------" + emp);
				if (emp == 0) {

					Info res = Constants.getRestTemplate().postForObject(Constants.url + "/deleteContractor", map,
							Info.class);

					if (res.isError()) {
						session.setAttribute("errorMsg", "Failed to Delete Contractor");
					} else {
						session.setAttribute("successMsg", "Contractor Deleted Successfully");

					}
				} else {
					session.setAttribute("errorMsg", "Failed to Delete - Contractor contain " + emp + " employees");
				}
			} catch (Exception e) {
				e.printStackTrace();
				session.setAttribute("errorMsg", "Failed to Delete");
			}

		}
		return a;
	}

	/****************************** Department ********************************/
	@RequestMapping(value = "/showDepartmentList", method = RequestMethod.GET)
	public ModelAndView showDepartmentList(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		// LoginResponse userObj = (LoginResponse) session.getAttribute("UserDetail");

		ModelAndView model = null;

		try {

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("showDepartmentList", "showDepartmentList", 1, 0, 0, 0,
					newModuleList);

			if (view.isError() == true) {

				model = new ModelAndView("accessDenied");

			} else {

				model = new ModelAndView("master/departmentList");

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("companyId", 1);

				Department[] department = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getAllDepartments", map, Department[].class);

				List<Department> departmentList = new ArrayList<Department>(Arrays.asList(department));

				for (int i = 0; i < departmentList.size(); i++) {

					departmentList.get(i)
							.setExVar1(FormValidation.Encrypt(String.valueOf(departmentList.get(i).getDepartId())));
				}

				model.addObject("departmentList", departmentList);

				Info add = AcessController.checkAccess("showDepartmentList", "showDepartmentList", 0, 1, 0, 0,
						newModuleList);
				Info edit = AcessController.checkAccess("showDepartmentList", "showDepartmentList", 0, 0, 1, 0,
						newModuleList);
				Info delete = AcessController.checkAccess("showDepartmentList", "showDepartmentList", 0, 0, 0, 1,
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

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/departmentAdd", method = RequestMethod.GET)
	public ModelAndView departmentAdd(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		ModelAndView model = null;

		try {
			Department dept = new Department();

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("departmentAdd", "showDepartmentList", 0, 1, 0, 0, newModuleList);

			if (view.isError() == true) {

				model = new ModelAndView("accessDenied");

			} else {

				model = new ModelAndView("master/addDepartment");
				model.addObject("dept", dept);
				model.addObject("title", "Add Department");

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/submitInsertDepartment", method = RequestMethod.POST)
	public String submitInsertDpartment(HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("departmentAdd", "showDepartmentList", 0, 1, 0, 0, newModuleList);
		String a = null;
		if (view.isError() == true) {

			a = "redirect:/accessDenied";
		} else {

			a = "redirect:/showDepartmentList";
			try {

				Department dept = new Department();

				dept.setCompanyId(1);
				dept.setDelStatus(1);
				dept.setDepartId(Integer.parseInt(request.getParameter("deptId")));
				dept.setExInt1(0);
				dept.setExInt2(0);
				dept.setExVar1("NA");
				dept.setExVar2("NA");
				dept.setIsActive(1);
				dept.setMakerEnterDatetime(currDate);
				dept.setName(request.getParameter("deptName"));
				dept.setNameSd(request.getParameter("deptShortName"));
				dept.setRemarks(request.getParameter("remark"));

				Department saveDepart = Constants.getRestTemplate().postForObject(Constants.url + "/saveDepartment",
						dept, Department.class);
				if (saveDepart != null) {
					if(dept.getDepartId()>0) {
						session.setAttribute("successMsg", "Department Updated Successfully");
					}
					else {
						session.setAttribute("successMsg", "Department Inserted Successfully");
					}
					
				} else {
					session.setAttribute("errorMsg", "Failed to Update Record");
				}

			} catch (Exception e) {
				e.printStackTrace();
				session.setAttribute("errorMsg", "Failed to Update Record");
			}
		}
		return a;

	}

	@RequestMapping(value = "/editDepartment", method = RequestMethod.GET)
	public ModelAndView editDepartment(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		Department dept = new Department();
		ModelAndView model = null;
		try {

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("editDepartment", "showDepartmentList", 0, 0, 1, 0, newModuleList);

			if (view.isError() == true) {

				model = new ModelAndView("accessDenied");

			} else {
				model = new ModelAndView("master/addDepartment");

				String base64encodedString = request.getParameter("deptId");
				String deptId = FormValidation.DecodeKey(base64encodedString);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("deptId", deptId);

				dept = Constants.getRestTemplate().postForObject(Constants.url + "/getDepartmentById", map,
						Department.class);
				model.addObject("dept", dept);
				model.addObject("title", "Edit Department");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;

	}

	@RequestMapping(value = "/deleteDepartment", method = RequestMethod.GET)
	public String deleteDepartment(HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		String a = null;
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");

		Info view = AcessController.checkAccess("deleteDepartment", "showDepartmentList", 0, 0, 0, 1, newModuleList);
		if (view.isError() == true) {

			a = "redirect:/accessDenied";

		}

		else {

			a = "redirect:/showDepartmentList";
			try {
				String base64encodedString = request.getParameter("deptId");
				String deptId = FormValidation.DecodeKey(base64encodedString);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("deptId", deptId);
				map.add("companyId", 1);

				Integer emp = Constants.getRestTemplate().postForObject(Constants.url + "/getEmpByDeptId", map,
						Integer.class);

				System.out.println("Emp-------------------" + emp);
				if (emp == 0) {

					Info res = Constants.getRestTemplate().postForObject(Constants.url + "/deleteDepartment", map,
							Info.class);

					if (res.isError()) {
						session.setAttribute("errorMsg", "Failed to Delete Department");
					} else {
						session.setAttribute("successMsg", "Department Deleted Successfully");

					}
				} else {
					session.setAttribute("errorMsg", "Failed to Delete - Department assigned to " + emp + " employees");
				}
			} catch (Exception e) {
				e.printStackTrace();
				session.setAttribute("errorMsg", "Failed to Delete");
			}
		}

		return a;
	}

	/****************************** Bank *********************************/
	@RequestMapping(value = "/showBankList", method = RequestMethod.GET)
	public ModelAndView showBankList(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		// LoginResponse userObj = (LoginResponse) session.getAttribute("UserDetail");

		ModelAndView model = null;

		try {

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("showBankList", "showBankList", 1, 0, 0, 0, newModuleList);

			if (view.isError() == true) {

				model = new ModelAndView("accessDenied");

			} else {

				model = new ModelAndView("master/bankList");

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("companyId", 1);

				Bank[] bank = Constants.getRestTemplate().postForObject(Constants.url + "/getAllBanks", map,
						Bank[].class);

				List<Bank> bankList = new ArrayList<Bank>(Arrays.asList(bank));

				for (int i = 0; i < bankList.size(); i++) {

					bankList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(bankList.get(i).getBankId())));
				}

				model.addObject("bankList", bankList);

				Info add = AcessController.checkAccess("showBankList", "showBankList", 0, 1, 0, 0, newModuleList);
				Info edit = AcessController.checkAccess("showBankList", "showBankList", 0, 0, 1, 0, newModuleList);
				Info delete = AcessController.checkAccess("showBankList", "showBankList", 0, 0, 0, 1, newModuleList);

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

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/bankAdd", method = RequestMethod.GET)
	public ModelAndView bankAdd(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		ModelAndView model = null;

		try {
			Bank bank = new Bank();

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("bankAdd", "showBankList", 0, 1, 0, 0, newModuleList);

			if (view.isError() == true) {

				model = new ModelAndView("accessDenied");

			} else {

				model = new ModelAndView("master/addBank");
				model.addObject("bank", bank);
				model.addObject("title", "Add Bank");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/submitInsertBank", method = RequestMethod.POST)
	public String submitInsertBank(HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		String a = null;

		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("bankAdd", "showBankList", 0, 1, 0, 0, newModuleList);

		if (view.isError() == true) {
			a = "redirect:/accessDenied";

		} else {

			a = "redirect:/showBankList";
			try {

				Bank bank = new Bank();

				bank.setBankId(Integer.parseInt(request.getParameter("bankId")));
				bank.setAddress(request.getParameter("address"));
				bank.setBranchName(request.getParameter("branchName"));
				bank.setCompanyId(1);
				bank.setIfscCode(request.getParameter("ifscCode"));
				
				try {
					bank.setMicrCode(request.getParameter("micrCode"));

				} catch (Exception e) {
					bank.setMicrCode("");

				}
				bank.setName(request.getParameter("bankName"));
				bank.setDelStatus(1);
				bank.setExInt1(0);
				bank.setExInt2(0);
				bank.setExVar1("NA");
				bank.setExVar2("NA");

				Bank saveDepart = Constants.getRestTemplate().postForObject(Constants.url + "/saveBank", bank,
						Bank.class);
				if (saveDepart != null) {
					if(bank.getBankId()>0) {
						session.setAttribute("successMsg", "Bank Updated Successfully");
					}else {
						session.setAttribute("successMsg", "Bank Inserted Successfully");
					}
				} else {
					session.setAttribute("errorMsg", "Failed to Save Bank");
				}

			} catch (Exception e) {
				e.printStackTrace();
				session.setAttribute("errorMsg", "Failed to Update Record");
			}
		}

		return a;

	}

	@RequestMapping(value = "/editBank", method = RequestMethod.GET)
	public ModelAndView editBank(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		Bank bank = new Bank();
		ModelAndView model = null;

		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("editBank", "showBankList", 0, 1, 0, 0, newModuleList);

		if (view.isError() == true) {

			model = new ModelAndView("accessDenied");

		} else {

			try {
				model = new ModelAndView("master/addBank");

				String base64encodedString = request.getParameter("bankId");
				String bankId = FormValidation.DecodeKey(base64encodedString);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("bankId", bankId);

				bank = Constants.getRestTemplate().postForObject(Constants.url + "/getBankById", map, Bank.class);
				model.addObject("bank", bank);
				model.addObject("title", "Edit Bank");

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return model;

	}

	@RequestMapping(value = "/deleteBank", method = RequestMethod.GET)
	public String deleteBank(HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		String a = null;

		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");

		Info view = AcessController.checkAccess("deleteBank", "showBankList", 0, 0, 0, 1, newModuleList);
		if (view.isError() == true) {

			a = "redirect:/accessDenied";

		}

		else {

			a = "redirect:/showBankList";

			try {
				String base64encodedString = request.getParameter("bankId");
				String bankId = FormValidation.DecodeKey(base64encodedString);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("bankId", bankId);

				Info res = Constants.getRestTemplate().postForObject(Constants.url + "/deleteBank", map, Info.class);

				System.err.println("errorMsg"+res.getMsg());
				if (res.isError() == false) {
					session.setAttribute("successMsg", res.getMsg());
				} else {
					session.setAttribute("errorMsg", res.getMsg());
				}

			} catch (Exception e) {
				e.printStackTrace();
				session.setAttribute("errorMsg", "Failed to Delete");
			}
		}

		return a;
	}

	/****************************** Calender Year ********************************/
	@RequestMapping(value = "/showCalYearList", method = RequestMethod.GET)
	public ModelAndView showCalYearList(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		// LoginResponse userObj = (LoginResponse) session.getAttribute("UserDetail");

		ModelAndView model = null;

		try {

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("showCalYearList", "showCalYearList", 1, 0, 0, 0,
					newModuleList);

			if (view.isError() == true) {

				model = new ModelAndView("accessDenied");

			} else {

				model = new ModelAndView("master/calYearList");

				//MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				//map.add("companyId", 1);

				CalenderYear[] calYear = Constants.getRestTemplate()
						.getForObject(Constants.url + "/getCalculateYearList", CalenderYear[].class);

				List<CalenderYear> calYearList = new ArrayList<CalenderYear>(Arrays.asList(calYear));

				for (int i = 0; i < calYearList.size(); i++) {

					calYearList.get(i).setExVar2(FormValidation.Encrypt(String.valueOf(calYearList.get(i).getCalYrId())));
				}

				model.addObject("calYearList", calYearList);

				Info add = AcessController.checkAccess("showCalYearList", "showCalYearList", 0, 1, 0, 0,
						newModuleList);
				Info edit = AcessController.checkAccess("showCalYearList", "showCalYearList", 0, 0, 1, 0,
						newModuleList);
				Info delete = AcessController.checkAccess("showCalYearList", "showCalYearList", 0, 0, 0, 1,
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

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/calYearAdd", method = RequestMethod.GET)
	public ModelAndView calYearAdd(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		ModelAndView model = null;

		try {
			CalenderYear calYear = new CalenderYear();

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("calYearAdd", "showCalYearList", 0, 1, 0, 0, newModuleList);

			if (view.isError() == true) {

				model = new ModelAndView("accessDenied");

			} else {

				model = new ModelAndView("master/addCalYear");
				model.addObject("calYear", calYear);
				model.addObject("title", "Add Calendar Year");

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping(value = "/submitInsertCalYear", method = RequestMethod.POST)
	public String submitInsertCalYear(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");
		String a = new String();
		/*
		 * List<AccessRightModule> newModuleList = (List<AccessRightModule>)
		 * session.getAttribute("moduleJsonList"); Info view =
		 * AcessController.checkAccess("locationAdd", "showLocationList", 0, 1, 0, 0,
		 * newModuleList); if (view.isError() == true) {
		 * 
		 * a = "redirect:/accessDenied";
		 * 
		 * } else {
		 */
		a = "redirect:/showCalYearList";
		try {

			Date date = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			int calYearId = 0;
			int isCurrYear = 0;
			try {
				calYearId = Integer.parseInt(request.getParameter("calYearId"));
				isCurrYear = Integer.parseInt(request.getParameter("check_year"));
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
				
			

			String fromDate = request.getParameter("from_date");
			String toDate = request.getParameter("to_date");
			String remark = request.getParameter("remark");

				CalenderYear year = new CalenderYear();
				year.setCalYrId(calYearId);
				year.setCalYrFromDate(DateConvertor.convertToYMD(fromDate));				
				year.setCalYrToDate(DateConvertor.convertToYMD(toDate));
				year.setExInt1(0);
				year.setExInt2(0);
				year.setExInt3(0);
				year.setExVar1(remark);
				year.setExVar2("1");
				year.setExVar3("1");
				year.setIsCurrent(isCurrYear);

				CalenderYear res = Constants.getRestTemplate().postForObject(Constants.url + "/saveCalYear",
						year, CalenderYear.class);

				if (res != null) {
					if (calYearId == 0) {
						session.setAttribute("successMsg", "Calendar Year Inserted Successfully");
					} else {
						session.setAttribute("successMsg", "Calendar Year Updated Successfully");

					}

				} else {
					session.setAttribute("errorMsg", "Failed to Insert Record");
				}

			

		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("errorMsg", "Failed to Insert Record");
		}
		// }

		return a;
	}
	@RequestMapping(value = "/editCalYear", method = RequestMethod.GET)
	public ModelAndView editCalYear(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		CalenderYear calYear = new CalenderYear();
		ModelAndView model = null;

		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("editCalYear", "showCalYearList", 0, 1, 0, 0, newModuleList);

		if (view.isError() == true) {

			model = new ModelAndView("accessDenied");

		} else {

			try {
				model = new ModelAndView("master/addCalYear");

				String base64encodedString = request.getParameter("calYearId");
				String calYearId = FormValidation.DecodeKey(base64encodedString);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("calYearId", Integer.parseInt(calYearId));

				calYear = Constants.getRestTemplate().postForObject(Constants.url + "/getCalYearById", map, CalenderYear.class);
				
				calYear.setCalYrFromDate(DateConvertor.convertToDMY(calYear.getCalYrFromDate()));
				calYear.setCalYrToDate(DateConvertor.convertToDMY(calYear.getCalYrToDate()));
				model.addObject("calYear", calYear);
				model.addObject("title", "Edit Calendar Year");

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return model;

	}
	
	/***********************Slab Salary for Professional Tax *********************/
	@RequestMapping(value = "/showSlaSlabProTax", method = RequestMethod.GET)
	public ModelAndView showSlaSlabProTax(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		// LoginResponse userObj = (LoginResponse) session.getAttribute("UserDetail");

		ModelAndView model = null;

		try {

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("showSlaSlabProTax", "showSlaSlabProTax", 1, 0, 0, 0,
					newModuleList);

			if (view.isError() == true) {

				model = new ModelAndView("accessDenied");

			} else {

				model = new ModelAndView("master/salSlabProTaxList");

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("companyId", 1);

				SlabMaster[] salSlab = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getAllSalSlab", map, SlabMaster[].class);

				List<SlabMaster> salSlabList = new ArrayList<SlabMaster>(Arrays.asList(salSlab));

				for (int i = 0; i < salSlabList.size(); i++) {

					salSlabList.get(i)
							.setExVar1(FormValidation.Encrypt(String.valueOf(salSlabList.get(i).getSlabId())));
				}

				model.addObject("salSlabList", salSlabList);

				Info add = AcessController.checkAccess("showSlaSlabProTax", "showSlaSlabProTax", 0, 1, 0, 0,
						newModuleList);
				Info edit = AcessController.checkAccess("showSlaSlabProTax", "showSlaSlabProTax", 0, 0, 1, 0,
						newModuleList);
				Info delete = AcessController.checkAccess("showSlaSlabProTax", "showSlaSlabProTax", 0, 0, 0, 1,
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

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/addSalSlab", method = RequestMethod.GET)
	public ModelAndView addSalSlab(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		ModelAndView model = null;

		try {
			SlabMaster slab = new SlabMaster();

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("addSalSlab", "showSlaSlabProTax", 0, 1, 0, 0, newModuleList);

			if (view.isError() == true) {

				model = new ModelAndView("accessDenied");

			} else {

				model = new ModelAndView("master/addsalslab");
				model.addObject("slab", slab);
				model.addObject("title", "Add Slab Salary for Professional Tax");

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping(value = "/insertSalSlabProTax", method = RequestMethod.POST)
	public String insertSalSlabProTax(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		LoginResponse userObj = (LoginResponse) session.getAttribute("userInfo");
		String a = new String();
		/*
		 * List<AccessRightModule> newModuleList = (List<AccessRightModule>)
		 * session.getAttribute("moduleJsonList"); Info view =
		 * AcessController.checkAccess("locationAdd", "showLocationList", 0, 1, 0, 0,
		 * newModuleList); if (view.isError() == true) {
		 * 
		 * a = "redirect:/accessDenied";
		 * 
		 * } else {
		 */
		a = "redirect:/showSlaSlabProTax";
		try {

			Date date = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			int slabId = 0;
			try {
				slabId = Integer.parseInt(request.getParameter("slabId"));
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}

				SlabMaster slab = new SlabMaster();
				
				slab.setGender(0);
				slab.setSlabId(slabId);
				slab.setSalTermId(0);
				slab.setMinVal(Integer.parseInt(request.getParameter("minValue")));
				slab.setMaxVal(Integer.parseInt(request.getParameter("maxValue")));
				slab.setAmount(Integer.parseInt(request.getParameter("amount")));
				slab.setExInt1(0);
				slab.setExInt2(0);
				slab.setExInt3(0);
				slab.setExVar1("1");
				slab.setExVar2("1");
				slab.setExVar3("1");

				SlabMaster res = Constants.getRestTemplate().postForObject(Constants.url + "/saveSalSlab",
						slab, SlabMaster.class);

				if (res != null) {
					if (slabId == 0) {
						session.setAttribute("successMsg", "Slab Salary for Professional Tax Inserted Successfully");
					} else {
						session.setAttribute("successMsg", "Slab Salary for Professional Tax Updated Successfully");

					}

				} else {
					session.setAttribute("errorMsg", "Failed to Insert Record");
				}

			

		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("errorMsg", "Failed to Insert Record");
		}
		
		return a;
	}
	
	@RequestMapping(value = "/editSalSlab", method = RequestMethod.GET)
	public ModelAndView editSalSlab(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		SlabMaster slab = new SlabMaster();
		ModelAndView model = null;

		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("editSalSlab", "showSlaSlabProTax", 0, 1, 0, 0, newModuleList);

		if (view.isError() == true) {

			model = new ModelAndView("accessDenied");

		} else {

			try {
				model = new ModelAndView("master/addsalslab");

				String base64encodedString = request.getParameter("slabId");
				String slabId = FormValidation.DecodeKey(base64encodedString);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("slabId", Integer.parseInt(slabId));

				slab = Constants.getRestTemplate().postForObject(Constants.url + "/getSalSlabById", map, SlabMaster.class);
				
				model.addObject("slab", slab);
				model.addObject("title", "Edit Slab Salary for Professional Tax");

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return model;

	}
	
	
	/***********************Setting Labels List *********************/
	@RequestMapping(value = "/showSettingLabelsList", method = RequestMethod.GET)
	public ModelAndView showSettingLabelsList(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		// LoginResponse userObj = (LoginResponse) session.getAttribute("UserDetail");

		ModelAndView model = null;

		try {

			List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("showSettingLabelsList", "showSettingLabelsList", 1, 0, 0, 0,
					newModuleList);

			if (view.isError() == true) {

				model = new ModelAndView("accessDenied");

			} else {

				model = new ModelAndView("master/salSettingLabels");

			
				Setting[] setting = Constants.getRestTemplate()
						.getForObject(Constants.url + "/getAllSettingLabels", Setting[].class);

				List<Setting> settingList = new ArrayList<Setting>(Arrays.asList(setting));

				for (int i = 0; i < settingList.size(); i++) {

					settingList.get(i)
							.setExVar1(FormValidation.Encrypt(String.valueOf(settingList.get(i).getSettingId())));
				}

				model.addObject("settingList", settingList);

				Info add = AcessController.checkAccess("showSettingLabelsList", "showSettingLabelsList", 0, 1, 0, 0,
						newModuleList);
				Info edit = AcessController.checkAccess("showSettingLabelsList", "showSettingLabelsList", 0, 0, 1, 0,
						newModuleList);
				Info delete = AcessController.checkAccess("showSettingLabelsList", "showSettingLabelsList", 0, 0, 0, 1,
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

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	
	
	@RequestMapping(value = "/editSettingLable", method = RequestMethod.GET)
	public ModelAndView editSettingLable(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		Setting setting = new Setting();
		ModelAndView model = null;

		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("editSettingLable", "showSettingLabelsList", 0, 1, 0, 0, newModuleList);

		if (view.isError() == true) {

			model = new ModelAndView("accessDenied");

		} else {

			try {
				model = new ModelAndView("master/editSettingLable");

				String base64encodedString = request.getParameter("settingId");
				String settingId = FormValidation.DecodeKey(base64encodedString);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("settingId", Integer.parseInt(settingId));

				setting = Constants.getRestTemplate().postForObject(Constants.url + "/getSettingById", map, Setting.class);
				setting.setExVar1(FormValidation.Encrypt(String.valueOf(setting.getSettingId())));
				
				model.addObject("setting", setting);
				model.addObject("title", "Edit Setting Value");

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return model;

	}
	
	@RequestMapping(value = "/updateSettingValue", method = RequestMethod.POST)
	public String updateSettingValue(HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		String a = null;

		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");

		Info view = AcessController.checkAccess("updateSettingValue", "showSettingLabelsList", 0, 0, 0, 1, newModuleList);
		if (view.isError() == true) {

			a = "redirect:/accessDenied";

		}

		else {

			a = "redirect:/showSettingLabelsList";

			try {
				MultiValueMap<String, Object> map = null;
				Info res = new Info();
				
				String base64encodedString = request.getParameter("settingId");
				String settingId = FormValidation.DecodeKey(base64encodedString);
				
				String value = request.getParameter("set_value");
				System.out.println("Value----------"+value);
				
				map = new LinkedMultiValueMap<>();
				map.add("settingId", Integer.parseInt(settingId));
				map.add("val", value);

				res = Constants.getRestTemplate().postForObject(Constants.url + "/updateSetting", map, Info.class);
				
				System.err.println("errorMsg"+res.getMsg());
				if (res.isError() == false) {
					session.setAttribute("successMsg", res.getMsg());
				} else {
					session.setAttribute("errorMsg", res.getMsg());
				}

			} catch (Exception e) {
				e.printStackTrace();
				session.setAttribute("errorMsg", "Failed to Delete");
			}
		}

		return a;
	}

}

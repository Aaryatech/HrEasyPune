package com.ats.hreasy.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ats.hreasy.common.AcessController;
import com.ats.hreasy.common.Constants;
import com.ats.hreasy.common.FormValidation;
import com.ats.hreasy.model.AccessRightModule;
import com.ats.hreasy.model.Contractor;
import com.ats.hreasy.model.Department;
import com.ats.hreasy.model.Designation;
import com.ats.hreasy.model.EmpSalAllowance;
import com.ats.hreasy.model.EmpSalaryInfo;
import com.ats.hreasy.model.EmpType;
import com.ats.hreasy.model.EmployeDoc;
import com.ats.hreasy.model.EmployeeAllDetails;
import com.ats.hreasy.model.EmployeeMaster;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.Location;
import com.ats.hreasy.model.MstCompany;
import com.ats.hreasy.model.MstEmpType;
import com.ats.hreasy.model.SkillRates;
import com.ats.hreasy.model.TblEmpBankInfo;
import com.ats.hreasy.model.TblEmpInfo;
import com.ats.hreasy.model.TblEmpNominees;
import com.ats.hreasy.model.User;

import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

@Controller
@Scope("session")
public class ProfileController {

	@RequestMapping(value = "/getProfile", method = RequestMethod.GET)
	public String getProfile(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "profile";

		return mav;

	}

	@RequestMapping(value = "/getEmployeeProfile", method = RequestMethod.GET)
	@ResponseBody 
	public EmployeeAllDetails getEmployeeProfile(HttpServletRequest request, HttpServletResponse response, Model model) {
		MultiValueMap<String, Object> map = null;
		EmployeeAllDetails empAllDtls = null;
		try {
			String compName= "NA";
			String deptName = "NA";
			String locName = "NA";
			String designation = "NA";
			String contractorName = "NA";
			String skill = "NA";
			String empType = "NA";
			String empAccessRole = "NA";
			/*List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
			Info view = AcessController.checkAccess("getEmployeeProfile", "getEmployeeProfile", 1, 0, 0, 0, newModuleList);

			if (view.isError() == true) {

				mav = "accessDenied";

			} else {*/
			
				empAllDtls = new EmployeeAllDetails();
				String base64encodedString = request.getParameter("empId");
				String empId = FormValidation.DecodeKey(base64encodedString);

				System.out.println("Decrypt-----" + empId);
				map = new LinkedMultiValueMap<>();
				map.add("empId", Integer.parseInt(empId));

				EmployeeMaster emp = Constants.getRestTemplate().postForObject(Constants.url + "/getEmployeeById", map,
				EmployeeMaster.class);
				try {
				 compName= getCompany(emp.getCmpCode());
				 deptName = getDepartment(emp.getDepartId());
				 locName = getLocation(emp.getLocationId());
				 designation = getDesignation(emp.getDesignationId());
				 contractorName = getContractor(emp.getContractorId());
				 skill = getEmpSkill(emp.getExInt2());
				 empType = getEmpType(emp.getEmpType());
				 empAccessRole = getEmpAccessRoll(Integer.parseInt(emp.getEmpCategory()));
				}catch (Exception e) {
					 compName= "NA";
					 deptName = "NA";
					 locName = "NA";
					 designation = "NA";
					 contractorName = "NA";
					 skill = "NA";
					 empType = "NA";
					 empAccessRole = "NA";
				}
				
				/*map = new LinkedMultiValueMap<>();
				map.add("EmpId", Integer.parseInt(empId));
				
				User user = Constants.getRestTemplate().postForObject(Constants.url + "/findUserInfoByEmpId", map,
						User.class);
				String accessblLoc = getAccessblLoc(user.getLocId()); 
				System.out.println("Accessable Location--------"+accessblLoc);*/
				
				
				
				emp.setCompName(compName);
				emp.setDepartName(deptName);
				emp.setLocation(locName);
				emp.setDesingntn(designation);
				emp.setContractorName(contractorName);
				emp.setSkillType(skill);
				emp.setEmpWorkType(empType);
				emp.setEmpCat(empAccessRole);
				
				empAllDtls.setEmpDtl(emp);
				
				
							
				TblEmpInfo empPersInfo = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getEmployeePersonalInfo", map, TblEmpInfo.class);
				// System.out.println("Edit EmpPersonal Info-------" + empPersInfo);
				empAllDtls.setEmpPersDtl(empPersInfo);

				
				TblEmpNominees empNom = Constants.getRestTemplate().postForObject(Constants.url + "/getEmployeeNominee",
						map, TblEmpNominees.class);
				// System.out.println("Edit Emp Nominee Info-------" + empNom);
				empAllDtls.setEmpNomDtl(empNom);

				TblEmpBankInfo empBank = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getEmployeeBankInfo", map, TblEmpBankInfo.class);
				// System.out.println("Edit Emp Bank Info-------" + empBank);
				empAllDtls.setEmpBankDtl(empBank);

				EmpSalaryInfo empSalInfo = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getEmployeeSalInfo", map, EmpSalaryInfo.class);
				// System.out.println("Salary Info-------" + empSalInfo);
				empAllDtls.setEmpSalDtl(empSalInfo);

				EmpSalAllowance[] empSalAllowance = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getEmployeeSalAllowances", map, EmpSalAllowance[].class);

				List<EmpSalAllowance> empAllowncList = new ArrayList<EmpSalAllowance>(Arrays.asList(empSalAllowance));
				// System.out.println("EmpSalAllowance Info-------" +empAllowncList);
				empAllDtls.setEmpAllowncDtl(empAllowncList);

				EmployeDoc[] docArr = Constants.getRestTemplate().postForObject(Constants.url + "/getEmployeeDocs", map,
						EmployeDoc[].class);
				List<EmployeDoc> docList = new ArrayList<EmployeDoc>(Arrays.asList(docArr));
				empAllDtls.setDocDtl(docList);

				

			System.err.println("Employee Detail Data-----------"+empAllDtls);
			/*}*/
		} catch (Exception e) {
			e.getMessage();
		}
		return empAllDtls;

	}

	/*public String getAccessblLoc(String locId) {
		System.out.println("Accessable Location--------"+locId);
		Location location = Constants.getRestTemplate().postForObject(Constants.url + "/getLocationById", map,
				Location.class);
		return locId;
	}*/

	public String getEmpAccessRoll(int empTypeId) {
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
		map.add("empTypeId", empTypeId);
		EmpType empType = Constants.getRestTemplate().postForObject(Constants.url + "/getEmpTypeById", map,
				EmpType.class);
		return empType.getEmpTypeName();
	}

	public String getEmpType(int empType) {
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
		map.add("empTypeId", empType);
		MstEmpType empTypeList = Constants.getRestTemplate()
				.postForObject(Constants.url + "/getMstEmpTypeById", map, MstEmpType.class);
		return empTypeList.getName();
	}


	public String getEmpSkill(int skillId) {
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
		map.add("skillId", skillId);
		SkillRates skill = Constants.getRestTemplate().postForObject(Constants.url + "/getSkillById", map,
				SkillRates.class);
		return skill.getName();
	}

	public String getContractor(int contractorId) {
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
		map.add("contractorId", contractorId);
		Contractor contractor = Constants.getRestTemplate()
				.postForObject(Constants.url + "/getContractorById", map, Contractor.class);
		return contractor.getOwner();
	}

	public String getDesignation(int designationId) {
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
		map.add("desigId", designationId);
		Designation designation = Constants.getRestTemplate()
				.postForObject(Constants.url + "/getDesignationById", map, Designation.class);
		return designation.getName();
	}

	public String getLocation(int locationId) {
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
		map.add("locId", locationId);
		Location location = Constants.getRestTemplate().postForObject(Constants.url + "/getLocationById", map,
				Location.class);
		return location.getLocName();
	}

	public String getDepartment(int departId) {
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
		map.add("deptId", departId);
		Department department = Constants.getRestTemplate()
				.postForObject(Constants.url + "/getDepartmentById", map, Department.class);
		return department.getName();
	}

	public String getCompany(int cmpCode) {
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
		map.add("companyId", cmpCode);
		MstCompany comp = Constants.getRestTemplate().postForObject(Constants.url + "/getCompanyById", map,
				MstCompany.class);
		
		return comp.getCompanyName();
	}
}

package com.ats.hreasy.model;

import java.util.List;
 

public class EmpInfoWithDateInfoListForRaster {
	
	private String empCode;
	private int empId;
	private String empName;

	List<RoutePlanDetail> sttsList;

	public String getEmpCode() {
		return empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}

	public int getEmpId() {
		return empId;
	}

	public void setEmpId(int empId) {
		this.empId = empId;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public List<RoutePlanDetail> getSttsList() {
		return sttsList;
	}

	public void setSttsList(List<RoutePlanDetail> sttsList) {
		this.sttsList = sttsList;
	}

	@Override
	public String toString() {
		return "EmpInfoWithDateInfoListForRaster [empCode=" + empCode + ", empId=" + empId + ", empName=" + empName
				+ ", sttsList=" + sttsList + "]";
	}
	
	

}

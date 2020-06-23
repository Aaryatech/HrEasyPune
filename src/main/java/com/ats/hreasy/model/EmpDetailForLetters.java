package com.ats.hreasy.model;
 

public class EmpDetailForLetters {
	 
	private int empId; 
	private String empCode; 
	private String firsName; 
	private String middleName; 
	private String surname; 
	private String deptName; 
	private String empDesgn; 
	private String locName; 
	private String orgName; 
	private String subCompName; 
	private String cmpJoiningDate; 
	private String cmpLeavingDate;
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public String getEmpCode() {
		return empCode;
	}
	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}
	public String getFirsName() {
		return firsName;
	}
	public void setFirsName(String firsName) {
		this.firsName = firsName;
	}
	public String getMiddleName() {
		return middleName;
	}
	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}
	public String getSurname() {
		return surname;
	}
	public void setSurname(String surname) {
		this.surname = surname;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getEmpDesgn() {
		return empDesgn;
	}
	public void setEmpDesgn(String empDesgn) {
		this.empDesgn = empDesgn;
	}
	public String getLocName() {
		return locName;
	}
	public void setLocName(String locName) {
		this.locName = locName;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getSubCompName() {
		return subCompName;
	}
	public void setSubCompName(String subCompName) {
		this.subCompName = subCompName;
	}
	public String getCmpJoiningDate() {
		return cmpJoiningDate;
	}
	public void setCmpJoiningDate(String cmpJoiningDate) {
		this.cmpJoiningDate = cmpJoiningDate;
	}
	public String getCmpLeavingDate() {
		return cmpLeavingDate;
	}
	public void setCmpLeavingDate(String cmpLeavingDate) {
		this.cmpLeavingDate = cmpLeavingDate;
	}
	@Override
	public String toString() {
		return "EmpDetailForLetters [empId=" + empId + ", empCode=" + empCode + ", firsName=" + firsName
				+ ", middleName=" + middleName + ", surname=" + surname + ", deptName=" + deptName + ", empDesgn="
				+ empDesgn + ", locName=" + locName + ", orgName=" + orgName + ", subCompName=" + subCompName
				+ ", cmpJoiningDate=" + cmpJoiningDate + ", cmpLeavingDate=" + cmpLeavingDate + "]";
	}
	
	

}

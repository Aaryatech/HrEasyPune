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
	private String owner;
	private String mobile;
	private String subCompName; 
	private String cmpJoiningDate; 
	private String cmpLeavingDate;  
	private String orinalJoining; 
	private String orinalLeaving;
	private String address; 
	private String maritalStatus; 
	private String gender;
	
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
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getMaritalStatus() {
		return maritalStatus;
	}
	public void setMaritalStatus(String maritalStatus) {
		this.maritalStatus = maritalStatus;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getOrinalJoining() {
		return orinalJoining;
	}
	public void setOrinalJoining(String orinalJoining) {
		this.orinalJoining = orinalJoining;
	}
	public String getOrinalLeaving() {
		return orinalLeaving;
	}
	public void setOrinalLeaving(String orinalLeaving) {
		this.orinalLeaving = orinalLeaving;
	}
	@Override
	public String toString() {
		return "EmpDetailForLetters [empId=" + empId + ", empCode=" + empCode + ", firsName=" + firsName
				+ ", middleName=" + middleName + ", surname=" + surname + ", deptName=" + deptName + ", empDesgn="
				+ empDesgn + ", locName=" + locName + ", orgName=" + orgName + ", owner=" + owner + ", mobile=" + mobile
				+ ", subCompName=" + subCompName + ", cmpJoiningDate=" + cmpJoiningDate + ", cmpLeavingDate="
				+ cmpLeavingDate + ", orinalJoining=" + orinalJoining + ", orinalLeaving=" + orinalLeaving
				+ ", address=" + address + ", maritalStatus=" + maritalStatus + ", gender=" + gender + "]";
	}
	
	

}

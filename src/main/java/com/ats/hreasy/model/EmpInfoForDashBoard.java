package com.ats.hreasy.model;
 
public class EmpInfoForDashBoard {
	
	 
	private int empId ; 
	private String empCode ; 
	private String empName; 
	private String designationName; 
	private String departmentName; 
	private String contactNo;
	private String profilePic;
	
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
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getDesignationName() {
		return designationName;
	}
	public void setDesignationName(String designationName) {
		this.designationName = designationName;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public String getContactNo() {
		return contactNo;
	}
	public void setContactNo(String contactNo) {
		this.contactNo = contactNo;
	}
	public String getProfilePic() {
		return profilePic;
	}
	public void setProfilePic(String profilePic) {
		this.profilePic = profilePic;
	}
	@Override
	public String toString() {
		return "EmpInfoForDashBoard [empId=" + empId + ", empCode=" + empCode + ", empName=" + empName
				+ ", designationName=" + designationName + ", departmentName=" + departmentName + ", contactNo="
				+ contactNo + ", profilePic=" + profilePic + "]";
	}
	
	

}

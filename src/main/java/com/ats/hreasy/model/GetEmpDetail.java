package com.ats.hreasy.model;

public class GetEmpDetail {
	private int empId;  
	private String deptName; 
	private String empDesgn; 
	private String locName; 
	private String empTypeName;
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
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
	public String getEmpTypeName() {
		return empTypeName;
	}
	public void setEmpTypeName(String empTypeName) {
		this.empTypeName = empTypeName;
	}
	@Override
	public String toString() {
		return "GetEmpDetail [empId=" + empId + ", deptName=" + deptName + ", empDesgn=" + empDesgn + ", locName="
				+ locName + ", empTypeName=" + empTypeName + "]";
	}
	
	

}

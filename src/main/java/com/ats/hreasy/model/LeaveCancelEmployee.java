package com.ats.hreasy.model;

public class LeaveCancelEmployee {
	
	private int empId;
	private String empCode;
	private String empName;
	private String leaveType;
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
	public String getLeaveType() {
		return leaveType;
	}
	public void setLeaveType(String leaveType) {
		this.leaveType = leaveType;
	}
	@Override
	public String toString() {
		return "LeaveCancelEmployee [empId=" + empId + ", empCode=" + empCode + ", empName=" + empName + ", leaveType="
				+ leaveType + "]";
	}
	
	

}

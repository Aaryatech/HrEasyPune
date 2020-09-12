package com.ats.hreasy.model;
 

public class DashboardLeavePending {
	 
	private int leaveId;
	private int empId; 
	private int lvTypeId; 
	private String leaveFromdt; 
	private String leaveTodt; 
	private int leaveNumDays;  
	private String empName;  
	private String initialAuthName;  
	private String finalAuthName;  
	private String leaveTitle;
	 
	public int getLeaveId() {
		return leaveId;
	}
	public void setLeaveId(int leaveId) {
		this.leaveId = leaveId;
	}
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public int getLvTypeId() {
		return lvTypeId;
	}
	public void setLvTypeId(int lvTypeId) {
		this.lvTypeId = lvTypeId;
	}
	public String getLeaveFromdt() {
		return leaveFromdt;
	}
	public void setLeaveFromdt(String leaveFromdt) {
		this.leaveFromdt = leaveFromdt;
	}
	public String getLeaveTodt() {
		return leaveTodt;
	}
	public void setLeaveTodt(String leaveTodt) {
		this.leaveTodt = leaveTodt;
	}
	public int getLeaveNumDays() {
		return leaveNumDays;
	}
	public void setLeaveNumDays(int leaveNumDays) {
		this.leaveNumDays = leaveNumDays;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getInitialAuthName() {
		return initialAuthName;
	}
	public void setInitialAuthName(String initialAuthName) {
		this.initialAuthName = initialAuthName;
	}
	public String getFinalAuthName() {
		return finalAuthName;
	}
	public void setFinalAuthName(String finalAuthName) {
		this.finalAuthName = finalAuthName;
	}
	public String getLeaveTitle() {
		return leaveTitle;
	}
	public void setLeaveTitle(String leaveTitle) {
		this.leaveTitle = leaveTitle;
	}
	@Override
	public String toString() {
		return "DashboardLeavePending [leaveId=" + leaveId + ", empId=" + empId + ", lvTypeId=" + lvTypeId
				+ ", leaveFromdt=" + leaveFromdt + ", leaveTodt=" + leaveTodt + ", leaveNumDays=" + leaveNumDays
				+ ", empName=" + empName + ", initialAuthName=" + initialAuthName + ", finalAuthName=" + finalAuthName
				+ ", leaveTitle=" + leaveTitle + "]";
	}

	
}

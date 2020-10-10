package com.ats.hreasy.model;
 

public class DailyAttendaceReport {
	 
	private String id; 
	private String empCode; 
	private String empName ; 
	private String attDate; 
	private String attStatus; 
	private String workingHrs; 
	private String inTime; 
	private int empId; 
	private int currentShiftid; 
	private int lateMin; 
	private String currentShiftname; 
	private String outTime; 
	private String attsSdShow; 
	private String otHr; 
	private String name;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public String getAttDate() {
		return attDate;
	}
	public void setAttDate(String attDate) {
		this.attDate = attDate;
	}
	public String getAttStatus() {
		return attStatus;
	}
	public void setAttStatus(String attStatus) {
		this.attStatus = attStatus;
	}
	public String getWorkingHrs() {
		return workingHrs;
	}
	public void setWorkingHrs(String workingHrs) {
		this.workingHrs = workingHrs;
	}
	public String getInTime() {
		return inTime;
	}
	public void setInTime(String inTime) {
		this.inTime = inTime;
	}
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public int getCurrentShiftid() {
		return currentShiftid;
	}
	public void setCurrentShiftid(int currentShiftid) {
		this.currentShiftid = currentShiftid;
	}
	public int getLateMin() {
		return lateMin;
	}
	public void setLateMin(int lateMin) {
		this.lateMin = lateMin;
	}
	public String getCurrentShiftname() {
		return currentShiftname;
	}
	public void setCurrentShiftname(String currentShiftname) {
		this.currentShiftname = currentShiftname;
	}
	public String getOutTime() {
		return outTime;
	}
	public void setOutTime(String outTime) {
		this.outTime = outTime;
	}
	public String getAttsSdShow() {
		return attsSdShow;
	}
	public void setAttsSdShow(String attsSdShow) {
		this.attsSdShow = attsSdShow;
	}
	public String getOtHr() {
		return otHr;
	}
	public void setOtHr(String otHr) {
		this.otHr = otHr;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Override
	public String toString() {
		return "DailyAttendaceReport [id=" + id + ", empCode=" + empCode + ", empName=" + empName + ", attDate="
				+ attDate + ", attStatus=" + attStatus + ", workingHrs=" + workingHrs + ", inTime=" + inTime
				+ ", empId=" + empId + ", currentShiftid=" + currentShiftid + ", lateMin=" + lateMin
				+ ", currentShiftname=" + currentShiftname + ", outTime=" + outTime + ", attsSdShow=" + attsSdShow
				+ ", otHr=" + otHr + ", name=" + name + "]";
	}
	
	

}

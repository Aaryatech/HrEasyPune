package com.ats.hreasy.model;
 
public class SelfAttendanceDetail {
	
	private String id; 
 	private String empCode;
 	private String empName; 
	private String attDate;
	private String attStatus; 
	private String lvSumupId;
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
	public String getLvSumupId() {
		return lvSumupId;
	}
	public void setLvSumupId(String lvSumupId) {
		this.lvSumupId = lvSumupId;
	}
	@Override
	public String toString() {
		return "SelfAttendanceDetail [id=" + id + ", empCode=" + empCode + ", empName=" + empName + ", attDate="
				+ attDate + ", attStatus=" + attStatus + ", lvSumupId=" + lvSumupId + "]";
	} 

}

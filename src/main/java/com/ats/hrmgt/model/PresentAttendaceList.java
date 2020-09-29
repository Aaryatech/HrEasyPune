package com.ats.hrmgt.model;

public class PresentAttendaceList {
	
	private String id;
	private int empId;
	private String empName;
	private String attStatus;
	private int lateMin;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public String getAttStatus() {
		return attStatus;
	}
	public void setAttStatus(String attStatus) {
		this.attStatus = attStatus;
	}
	public int getLateMin() {
		return lateMin;
	}
	public void setLateMin(int lateMin) {
		this.lateMin = lateMin;
	}
	@Override
	public String toString() {
		return "PresentAttendaceList [id=" + id + ", empId=" + empId + ", empName=" + empName + ", attStatus="
				+ attStatus + ", lateMin=" + lateMin + "]";
	}

}

package com.ats.hreasy.model;
 

public class EmpGraphDetail {
 
	private int id; 
	private int empId; 
	private String month; 
	private String lateMin; 
	private String lateMark;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	 
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	} 
	public String getLateMin() {
		return lateMin;
	}
	public void setLateMin(String lateMin) {
		this.lateMin = lateMin;
	}
	public String getLateMark() {
		return lateMark;
	}
	public void setLateMark(String lateMark) {
		this.lateMark = lateMark;
	}
	@Override
	public String toString() {
		return "EmpGraphDetail [id=" + id + ", empId=" + empId + ", month=" + month + ", lateMin=" + lateMin
				+ ", lateMark=" + lateMark + "]";
	}
	
	
	
	
}

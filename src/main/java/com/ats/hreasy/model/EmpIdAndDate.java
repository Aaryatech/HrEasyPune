package com.ats.hreasy.model;

public class EmpIdAndDate {
	
	private int empId;
	private String date;
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	@Override
	public String toString() {
		return "EmpIdAndDate [empId=" + empId + ", date=" + date + "]";
	}
	
	

}

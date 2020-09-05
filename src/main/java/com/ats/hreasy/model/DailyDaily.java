package com.ats.hreasy.model;

//Sachin 05-09-2020

public class DailyDaily {
	
	private int id;
	
	private int empId;
	
	private String otHr;
	
	private String attDate;
	
	private String dayName;
	

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

	public String getOtHr() {
		return otHr;
	}

	public void setOtHr(String otHr) {
		this.otHr = otHr;
	}

	public String getAttDate() {
		return attDate;
	}

	public void setAttDate(String attDate) {
		this.attDate = attDate;
	}

	
	public String getDayName() {
		return dayName;
	}

	public void setDayName(String dayName) {
		this.dayName = dayName;
	}

	@Override
	public String toString() {
		return "DailyDaily [id=" + id + ", empId=" + empId + ", otHr=" + otHr + ", attDate=" + attDate + ", dayName="
				+ dayName + "]";
	}

	
	
}

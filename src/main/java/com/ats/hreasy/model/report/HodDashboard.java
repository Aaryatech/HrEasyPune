package com.ats.hreasy.model.report;

public class HodDashboard {
	private int empId;
	private String firstName;
	private String surname,empCode;
	
	private float presentDays;
	private float weekOffCovered;
	private float abDays;
	private float lastMonthPendWoff;
	private float otLastMonth;
	private float workingDays;
	
	public String getEmpCode() {
		return empCode;
	}
	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}
	@Override
	public String toString() {
		return "HodDashboard [empId=" + empId + ", firstName=" + firstName + ", surname=" + surname + ", empCode="
				+ empCode + ", presentDays=" + presentDays + ", weekOffCovered=" + weekOffCovered + ", abDays=" + abDays
				+ ", lastMonthPendWoff=" + lastMonthPendWoff + ", otLastMonth=" + otLastMonth + ", workingDays="
				+ workingDays + "]";
	}
	
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getSurname() {
		return surname;
	}
	public void setSurname(String surname) {
		this.surname = surname;
	}
	public float getPresentDays() {
		return presentDays;
	}
	public void setPresentDays(float presentDays) {
		this.presentDays = presentDays;
	}
	public float getWeekOffCovered() {
		return weekOffCovered;
	}
	public void setWeekOffCovered(float weekOffCovered) {
		this.weekOffCovered = weekOffCovered;
	}
	public float getAbDays() {
		return abDays;
	}
	public void setAbDays(float abDays) {
		this.abDays = abDays;
	}
	public float getLastMonthPendWoff() {
		return lastMonthPendWoff;
	}
	public void setLastMonthPendWoff(float lastMonthPendWoff) {
		this.lastMonthPendWoff = lastMonthPendWoff;
	}
	public float getOtLastMonth() {
		return otLastMonth;
	}
	public void setOtLastMonth(float otLastMonth) {
		this.otLastMonth = otLastMonth;
	}
	public float getWorkingDays() {
		return workingDays;
	}
	public void setWorkingDays(float workingDays) {
		this.workingDays = workingDays;
	}
	
	
}

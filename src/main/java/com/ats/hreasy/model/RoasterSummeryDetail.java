package com.ats.hreasy.model;
 

public class RoasterSummeryDetail {
	 
	private int empId; 
	private String empCode; 
	private String firstName; 
	private String middleName; 
	private String surname; 
	private int offDayCount; 
	private int ffCount; 
	private int lateMark; 
	private int lateMin; 
	private int km; 
	private float incentive;
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
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getMiddleName() {
		return middleName;
	}
	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}
	public String getSurname() {
		return surname;
	}
	public void setSurname(String surname) {
		this.surname = surname;
	}
	public int getOffDayCount() {
		return offDayCount;
	}
	public void setOffDayCount(int offDayCount) {
		this.offDayCount = offDayCount;
	}
	public int getFfCount() {
		return ffCount;
	}
	public void setFfCount(int ffCount) {
		this.ffCount = ffCount;
	}
	public int getLateMark() {
		return lateMark;
	}
	public void setLateMark(int lateMark) {
		this.lateMark = lateMark;
	}
	public int getLateMin() {
		return lateMin;
	}
	public void setLateMin(int lateMin) {
		this.lateMin = lateMin;
	}
	public int getKm() {
		return km;
	}
	public void setKm(int km) {
		this.km = km;
	}
	public float getIncentive() {
		return incentive;
	}
	public void setIncentive(float incentive) {
		this.incentive = incentive;
	}
	@Override
	public String toString() {
		return "RoasterSummeryDetail [empId=" + empId + ", empCode=" + empCode + ", firstName=" + firstName
				+ ", middleName=" + middleName + ", surname=" + surname + ", offDayCount=" + offDayCount + ", ffCount="
				+ ffCount + ", lateMark=" + lateMark + ", lateMin=" + lateMin + ", km=" + km + ", incentive="
				+ incentive + "]";
	}
	
	

}

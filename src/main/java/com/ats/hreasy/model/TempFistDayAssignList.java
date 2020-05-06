package com.ats.hreasy.model;
 

public class TempFistDayAssignList {
	 
	private int id; 
	private int empId; 
	private String date; 
	private String extra1; 
	private int extra2; 
	private int shiftId; 
	private String firstName; 
	private String middleName;  
	private String surname; 
	private String empCode; 
	private int shiftGroup; 
	private int shiftType; 
	private String shiftName; 
	private String shiftGroupName;
	
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
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getExtra1() {
		return extra1;
	}
	public void setExtra1(String extra1) {
		this.extra1 = extra1;
	}
	public int getExtra2() {
		return extra2;
	}
	public void setExtra2(int extra2) {
		this.extra2 = extra2;
	}
	public int getShiftId() {
		return shiftId;
	}
	public void setShiftId(int shiftId) {
		this.shiftId = shiftId;
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
	public String getEmpCode() {
		return empCode;
	}
	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}
	public int getShiftGroup() {
		return shiftGroup;
	}
	public void setShiftGroup(int shiftGroup) {
		this.shiftGroup = shiftGroup;
	}
	public int getShiftType() {
		return shiftType;
	}
	public void setShiftType(int shiftType) {
		this.shiftType = shiftType;
	}
	public String getShiftName() {
		return shiftName;
	}
	public void setShiftName(String shiftName) {
		this.shiftName = shiftName;
	}
	public String getShiftGroupName() {
		return shiftGroupName;
	}
	public void setShiftGroupName(String shiftGroupName) {
		this.shiftGroupName = shiftGroupName;
	}
	@Override
	public String toString() {
		return "TempFistDayAssignList [id=" + id + ", empId=" + empId + ", date=" + date + ", extra1=" + extra1
				+ ", extra2=" + extra2 + ", shiftId=" + shiftId + ", firstName=" + firstName + ", middleName="
				+ middleName + ", surname=" + surname + ", empCode=" + empCode + ", shiftGroup=" + shiftGroup
				+ ", shiftType=" + shiftType + ", shiftName=" + shiftName + ", shiftGroupName=" + shiftGroupName + "]";
	}
	
	

}

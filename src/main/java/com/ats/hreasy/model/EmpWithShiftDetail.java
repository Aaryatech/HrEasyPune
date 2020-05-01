package com.ats.hreasy.model;

import java.util.List;
 

public class EmpWithShiftDetail {
	
	 
	private int empId ; 
	private String empCode ; 
	private String name; 
	private int groupId; 
	private int groupType; 
	private int shiftId; 
	private int locationId; 
	private int holidayCategory; 
	private int weekendCategory; 
	private List<DateWiseProjection> dateprojectlist; 
	List<EmpShiftAllocationDetail> shiftallocationDetailList;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getGroupId() {
		return groupId;
	}
	public void setGroupId(int groupId) {
		this.groupId = groupId;
	}
	public int getGroupType() {
		return groupType;
	}
	public void setGroupType(int groupType) {
		this.groupType = groupType;
	}
	public int getShiftId() {
		return shiftId;
	}
	public void setShiftId(int shiftId) {
		this.shiftId = shiftId;
	}
	public int getLocationId() {
		return locationId;
	}
	public void setLocationId(int locationId) {
		this.locationId = locationId;
	}
	public int getHolidayCategory() {
		return holidayCategory;
	}
	public void setHolidayCategory(int holidayCategory) {
		this.holidayCategory = holidayCategory;
	}
	public int getWeekendCategory() {
		return weekendCategory;
	}
	public void setWeekendCategory(int weekendCategory) {
		this.weekendCategory = weekendCategory;
	}
	public List<DateWiseProjection> getDateprojectlist() {
		return dateprojectlist;
	}
	public void setDateprojectlist(List<DateWiseProjection> dateprojectlist) {
		this.dateprojectlist = dateprojectlist;
	}
	public List<EmpShiftAllocationDetail> getShiftallocationDetailList() {
		return shiftallocationDetailList;
	}
	public void setShiftallocationDetailList(List<EmpShiftAllocationDetail> shiftallocationDetailList) {
		this.shiftallocationDetailList = shiftallocationDetailList;
	}
	@Override
	public String toString() {
		return "EmpWithShiftDetail [empId=" + empId + ", empCode=" + empCode + ", name=" + name + ", groupId=" + groupId
				+ ", groupType=" + groupType + ", shiftId=" + shiftId + ", locationId=" + locationId
				+ ", holidayCategory=" + holidayCategory + ", weekendCategory=" + weekendCategory + ", dateprojectlist="
				+ dateprojectlist + ", shiftallocationDetailList=" + shiftallocationDetailList + "]";
	}
	
	
	

}

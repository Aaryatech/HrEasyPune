package com.ats.hreasy.model;
 

public class CountOfAssignPending {
	
	private String id; 
	private int empTypeCount; 
	private int shiftCount; 
	private int locationCount ; 
	private int holidayCount; 
	private int weekendCount;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getEmpTypeCount() {
		return empTypeCount;
	}
	public void setEmpTypeCount(int empTypeCount) {
		this.empTypeCount = empTypeCount;
	}
	public int getShiftCount() {
		return shiftCount;
	}
	public void setShiftCount(int shiftCount) {
		this.shiftCount = shiftCount;
	}
	public int getLocationCount() {
		return locationCount;
	}
	public void setLocationCount(int locationCount) {
		this.locationCount = locationCount;
	}
	public int getHolidayCount() {
		return holidayCount;
	}
	public void setHolidayCount(int holidayCount) {
		this.holidayCount = holidayCount;
	}
	public int getWeekendCount() {
		return weekendCount;
	}
	public void setWeekendCount(int weekendCount) {
		this.weekendCount = weekendCount;
	}
	@Override
	public String toString() {
		return "CountOfAssignPending [id=" + id + ", empTypeCount=" + empTypeCount + ", shiftCount=" + shiftCount
				+ ", locationCount=" + locationCount + ", holidayCount=" + holidayCount + ", weekendCount="
				+ weekendCount + "]";
	}
	
	

}

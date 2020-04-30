package com.ats.hreasy.model;

import java.util.List;
 

public class HolidayListCatWise {
	 
	private String id; 
	private int calYrId; 
	private int catId; 
	private String hoCatName;  
	private int optionalHoliday; 
	private int naCount; 
	private int fixedCount; 
	private int optionalCount; 
	private String yearDate; 
	List<GetHoliday> holidaylist;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getCalYrId() {
		return calYrId;
	}
	public void setCalYrId(int calYrId) {
		this.calYrId = calYrId;
	}
	public int getCatId() {
		return catId;
	}
	public void setCatId(int catId) {
		this.catId = catId;
	}
	public String getHoCatName() {
		return hoCatName;
	}
	public void setHoCatName(String hoCatName) {
		this.hoCatName = hoCatName;
	}
	public int getOptionalHoliday() {
		return optionalHoliday;
	}
	public void setOptionalHoliday(int optionalHoliday) {
		this.optionalHoliday = optionalHoliday;
	}
	public int getNaCount() {
		return naCount;
	}
	public void setNaCount(int naCount) {
		this.naCount = naCount;
	}
	public int getFixedCount() {
		return fixedCount;
	}
	public void setFixedCount(int fixedCount) {
		this.fixedCount = fixedCount;
	}
	public int getOptionalCount() {
		return optionalCount;
	}
	public void setOptionalCount(int optionalCount) {
		this.optionalCount = optionalCount;
	}
	public List<GetHoliday> getHolidaylist() {
		return holidaylist;
	}
	public void setHolidaylist(List<GetHoliday> holidaylist) {
		this.holidaylist = holidaylist;
	}
	public String getYearDate() {
		return yearDate;
	}
	public void setYearDate(String yearDate) {
		this.yearDate = yearDate;
	}
	@Override
	public String toString() {
		return "HolidayListCatWise [id=" + id + ", calYrId=" + calYrId + ", catId=" + catId + ", hoCatName=" + hoCatName
				+ ", optionalHoliday=" + optionalHoliday + ", naCount=" + naCount + ", fixedCount=" + fixedCount
				+ ", optionalCount=" + optionalCount + ", yearDate=" + yearDate + ", holidaylist=" + holidaylist + "]";
	}
	
	

}

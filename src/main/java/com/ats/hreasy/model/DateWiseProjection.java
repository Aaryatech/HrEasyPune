package com.ats.hreasy.model;

public class DateWiseProjection {
	
	private String date;
	private int shiftId;
	private String shiftName;
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getShiftId() {
		return shiftId;
	}
	public void setShiftId(int shiftId) {
		this.shiftId = shiftId;
	}
	public String getShiftName() {
		return shiftName;
	}
	public void setShiftName(String shiftName) {
		this.shiftName = shiftName;
	}
	@Override
	public String toString() {
		return "DateWiseProjection [date=" + date + ", shiftId=" + shiftId + ", shiftName=" + shiftName + "]";
	}

}

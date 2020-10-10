package com.ats.hreasy.model;

import java.util.List;
 
public class DateAndDay {
	
	private String date;
	private String day;
	private List<DailyAttendaceReport> finalDailyList;
	
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public List<DailyAttendaceReport> getFinalDailyList() {
		return finalDailyList;
	}
	public void setFinalDailyList(List<DailyAttendaceReport> finalDailyList) {
		this.finalDailyList = finalDailyList;
	}
	@Override
	public String toString() {
		return "DateAndDay [date=" + date + ", day=" + day + ", finalDailyList=" + finalDailyList + "]";
	}
	
	

}

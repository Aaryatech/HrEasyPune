package com.ats.hreasy.model;

public class DateAndDay {
	
	private String date;
	private String day;
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
	@Override
	public String toString() {
		return "DateAndDay [date=" + date + ", day=" + day + "]";
	}
	
	

}

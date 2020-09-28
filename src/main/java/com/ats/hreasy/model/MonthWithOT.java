package com.ats.hreasy.model;

import java.util.List;
 
public class MonthWithOT {

	private String month;
	private List<TotalOT> otlist;
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public List<TotalOT> getOtlist() {
		return otlist;
	}
	public void setOtlist(List<TotalOT> otlist) {
		this.otlist = otlist;
	}
	@Override
	public String toString() {
		return "MonthWithOT [month=" + month + ", otlist=" + otlist + "]";
	}
	
	
	
	
}

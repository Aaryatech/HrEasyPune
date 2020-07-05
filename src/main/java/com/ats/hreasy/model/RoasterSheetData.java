package com.ats.hreasy.model;

import java.util.List;
 

public class RoasterSheetData {
	
	private List<String> dates;
	private List<EmpInfoWithDateInfoListForRaster> infomationList;
	private List<DateAndDay> dateAndDayList;
	public List<String> getDates() {
		return dates;
	}
	public void setDates(List<String> dates) {
		this.dates = dates;
	}
	public List<EmpInfoWithDateInfoListForRaster> getInfomationList() {
		return infomationList;
	}
	public void setInfomationList(List<EmpInfoWithDateInfoListForRaster> infomationList) {
		this.infomationList = infomationList;
	}
	public List<DateAndDay> getDateAndDayList() {
		return dateAndDayList;
	}
	public void setDateAndDayList(List<DateAndDay> dateAndDayList) {
		this.dateAndDayList = dateAndDayList;
	}
	@Override
	public String toString() {
		return "RoasterSheetData [dates=" + dates + ", infomationList=" + infomationList + ", dateAndDayList="
				+ dateAndDayList + "]";
	}
	
	

}

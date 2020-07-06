package com.ats.hreasy.model;

import java.util.List;
 

public class RoasterSheetData {
	
	private List<String> dates;
	private List<EmpInfoWithDateInfoListForRaster> infomationList;
	private List<DateAndDay> dateAndDayList;
	private List<RoasterSummeryDetail> roasterSummeryDetailList;
	private List<TypeWiseRoasterList> typeWiseRoasterList;
	private List<RouteType> routeTypelist;
	private List<RoutePlanDetailWithName> routePlanDetailWithNamelist;
	
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
	
	public List<RoasterSummeryDetail> getRoasterSummeryDetailList() {
		return roasterSummeryDetailList;
	}
	public void setRoasterSummeryDetailList(List<RoasterSummeryDetail> roasterSummeryDetailList) {
		this.roasterSummeryDetailList = roasterSummeryDetailList;
	}
	public List<TypeWiseRoasterList> getTypeWiseRoasterList() {
		return typeWiseRoasterList;
	}
	public void setTypeWiseRoasterList(List<TypeWiseRoasterList> typeWiseRoasterList) {
		this.typeWiseRoasterList = typeWiseRoasterList;
	}
	public List<RouteType> getRouteTypelist() {
		return routeTypelist;
	}
	public void setRouteTypelist(List<RouteType> routeTypelist) {
		this.routeTypelist = routeTypelist;
	}
	public List<RoutePlanDetailWithName> getRoutePlanDetailWithNamelist() {
		return routePlanDetailWithNamelist;
	}
	public void setRoutePlanDetailWithNamelist(List<RoutePlanDetailWithName> routePlanDetailWithNamelist) {
		this.routePlanDetailWithNamelist = routePlanDetailWithNamelist;
	}
	@Override
	public String toString() {
		return "RoasterSheetData [dates=" + dates + ", infomationList=" + infomationList + ", dateAndDayList="
				+ dateAndDayList + ", roasterSummeryDetailList=" + roasterSummeryDetailList + ", typeWiseRoasterList="
				+ typeWiseRoasterList + ", routeTypelist=" + routeTypelist + ", routePlanDetailWithNamelist="
				+ routePlanDetailWithNamelist + "]";
	}
	
	

}

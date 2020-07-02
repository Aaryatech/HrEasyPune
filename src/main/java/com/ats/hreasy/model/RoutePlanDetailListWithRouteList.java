package com.ats.hreasy.model;
 
import java.util.List;

public class RoutePlanDetailListWithRouteList {

	List<RouteList> routeList;
	List<RoutePlanDetailWithName> driverPlanList;
	public List<RouteList> getRouteList() {
		return routeList;
	}
	public void setRouteList(List<RouteList> routeList) {
		this.routeList = routeList;
	}
	public List<RoutePlanDetailWithName> getDriverPlanList() {
		return driverPlanList;
	}
	public void setDriverPlanList(List<RoutePlanDetailWithName> driverPlanList) {
		this.driverPlanList = driverPlanList;
	}
	@Override
	public String toString() {
		return "RoutePlanDetailListWithRouteList [routeList=" + routeList + ", driverPlanList=" + driverPlanList + "]";
	}

}

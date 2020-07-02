package com.ats.hrmgt.model;
 

public class PlanHistoryRouteWise {
	 
	private int id; 
	private int routeId; 
	private String routeName; 
	private int count; 
	private float incentive; 
	private int km;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getRouteId() {
		return routeId;
	}
	public void setRouteId(int routeId) {
		this.routeId = routeId;
	}
	public String getRouteName() {
		return routeName;
	}
	public void setRouteName(String routeName) {
		this.routeName = routeName;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public float getIncentive() {
		return incentive;
	}
	public void setIncentive(float incentive) {
		this.incentive = incentive;
	}
	public int getKm() {
		return km;
	}
	public void setKm(int km) {
		this.km = km;
	}
	@Override
	public String toString() {
		return "PlanHistoryRouteWise [id=" + id + ", routeId=" + routeId + ", routeName=" + routeName + ", count="
				+ count + ", incentive=" + incentive + ", km=" + km + "]";
	}
	
	

}

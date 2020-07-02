package com.ats.hreasy.model;

public class RouteListFromOps {
	
	private int routeId; 
    private String route_name; 
    private String route_seq_no; 
    private String fr_ids; 
    private String fr_names; 
    private String fr_codes;
	public int getRouteId() {
		return routeId;
	}
	public void setRouteId(int routeId) {
		this.routeId = routeId;
	}
	public String getRoute_name() {
		return route_name;
	}
	public void setRoute_name(String route_name) {
		this.route_name = route_name;
	}
	public String getRoute_seq_no() {
		return route_seq_no;
	}
	public void setRoute_seq_no(String route_seq_no) {
		this.route_seq_no = route_seq_no;
	}
	public String getFr_ids() {
		return fr_ids;
	}
	public void setFr_ids(String fr_ids) {
		this.fr_ids = fr_ids;
	}
	public String getFr_names() {
		return fr_names;
	}
	public void setFr_names(String fr_names) {
		this.fr_names = fr_names;
	}
	public String getFr_codes() {
		return fr_codes;
	}
	public void setFr_codes(String fr_codes) {
		this.fr_codes = fr_codes;
	}
	@Override
	public String toString() {
		return "RouteListFromOps [routeId=" + routeId + ", route_name=" + route_name + ", route_seq_no=" + route_seq_no
				+ ", fr_ids=" + fr_ids + ", fr_names=" + fr_names + ", fr_codes=" + fr_codes + "]";
	}
    
    

}

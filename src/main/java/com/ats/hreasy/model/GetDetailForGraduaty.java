package com.ats.hreasy.model;

public class GetDetailForGraduaty {
	
	private String uuid ; 
	private double basic ; 
	private double allowanceValue;
	private String cmpJoiningDate ; 
	private String service ;
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public double getBasic() {
		return basic;
	}
	public void setBasic(double basic) {
		this.basic = basic;
	}
	public double getAllowanceValue() {
		return allowanceValue;
	}
	public void setAllowanceValue(double allowanceValue) {
		this.allowanceValue = allowanceValue;
	}
	public String getCmpJoiningDate() {
		return cmpJoiningDate;
	}
	public void setCmpJoiningDate(String cmpJoiningDate) {
		this.cmpJoiningDate = cmpJoiningDate;
	}
	public String getService() {
		return service;
	}
	public void setService(String service) {
		this.service = service;
	}
	@Override
	public String toString() {
		return "GetDetailForGraduaty [uuid=" + uuid + ", basic=" + basic + ", allowanceValue=" + allowanceValue
				+ ", cmpJoiningDate=" + cmpJoiningDate + ", service=" + service + "]";
	}
	
	

}

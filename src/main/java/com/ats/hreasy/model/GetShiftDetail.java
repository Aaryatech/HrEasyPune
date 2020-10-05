package com.ats.hreasy.model;
 
public class GetShiftDetail {
	 
	 
	private int id; 
	private String shiftname; 
	private String fromtime; 
	private String totime; 
	private int changeable; 
	private int changewith; 
	private int companyId; 
	private int maxLateTimeAllowed; 
	private String shiftHr; 
	private String shiftHalfdayHr; 
	private int earlyGoingMin; 
	private String otCalculatedTime; 
	private int otCalculatedAfterHr; 
	private String shiftOtHour; 
	private int departmentId; 
	private int selfGroupId; 
	private int status; 
	private int locationId; 
	private String shortName;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getShiftname() {
		return shiftname;
	}
	public void setShiftname(String shiftname) {
		this.shiftname = shiftname;
	}
	public String getFromtime() {
		return fromtime;
	}
	public void setFromtime(String fromtime) {
		this.fromtime = fromtime;
	}
	public String getTotime() {
		return totime;
	}
	public void setTotime(String totime) {
		this.totime = totime;
	}
	public int getChangeable() {
		return changeable;
	}
	public void setChangeable(int changeable) {
		this.changeable = changeable;
	}
	public int getChangewith() {
		return changewith;
	}
	public void setChangewith(int changewith) {
		this.changewith = changewith;
	}
	public int getCompanyId() {
		return companyId;
	}
	public void setCompanyId(int companyId) {
		this.companyId = companyId;
	}
	public int getMaxLateTimeAllowed() {
		return maxLateTimeAllowed;
	}
	public void setMaxLateTimeAllowed(int maxLateTimeAllowed) {
		this.maxLateTimeAllowed = maxLateTimeAllowed;
	}
	public String getShiftHr() {
		return shiftHr;
	}
	public void setShiftHr(String shiftHr) {
		this.shiftHr = shiftHr;
	}
	public String getShiftHalfdayHr() {
		return shiftHalfdayHr;
	}
	public void setShiftHalfdayHr(String shiftHalfdayHr) {
		this.shiftHalfdayHr = shiftHalfdayHr;
	}
	public int getEarlyGoingMin() {
		return earlyGoingMin;
	}
	public void setEarlyGoingMin(int earlyGoingMin) {
		this.earlyGoingMin = earlyGoingMin;
	}
	public String getOtCalculatedTime() {
		return otCalculatedTime;
	}
	public void setOtCalculatedTime(String otCalculatedTime) {
		this.otCalculatedTime = otCalculatedTime;
	}
	public int getOtCalculatedAfterHr() {
		return otCalculatedAfterHr;
	}
	public void setOtCalculatedAfterHr(int otCalculatedAfterHr) {
		this.otCalculatedAfterHr = otCalculatedAfterHr;
	}
	public String getShiftOtHour() {
		return shiftOtHour;
	}
	public void setShiftOtHour(String shiftOtHour) {
		this.shiftOtHour = shiftOtHour;
	}
	public int getDepartmentId() {
		return departmentId;
	}
	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}
	public int getSelfGroupId() {
		return selfGroupId;
	}
	public void setSelfGroupId(int selfGroupId) {
		this.selfGroupId = selfGroupId;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getLocationId() {
		return locationId;
	}
	public void setLocationId(int locationId) {
		this.locationId = locationId;
	}
	public String getShortName() {
		return shortName;
	}
	public void setShortName(String shortName) {
		this.shortName = shortName;
	}
	@Override
	public String toString() {
		return "GetShiftDetail [id=" + id + ", shiftname=" + shiftname + ", fromtime=" + fromtime + ", totime=" + totime
				+ ", changeable=" + changeable + ", changewith=" + changewith + ", companyId=" + companyId
				+ ", maxLateTimeAllowed=" + maxLateTimeAllowed + ", shiftHr=" + shiftHr + ", shiftHalfdayHr="
				+ shiftHalfdayHr + ", earlyGoingMin=" + earlyGoingMin + ", otCalculatedTime=" + otCalculatedTime
				+ ", otCalculatedAfterHr=" + otCalculatedAfterHr + ", shiftOtHour=" + shiftOtHour + ", departmentId="
				+ departmentId + ", selfGroupId=" + selfGroupId + ", status=" + status + ", locationId=" + locationId
				+ ", shortName=" + shortName + "]";
	}
	
	
	

}
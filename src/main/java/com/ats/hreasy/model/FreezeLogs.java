package com.ats.hreasy.model;
 

public class FreezeLogs {
	
	private int logid; 
	private String ipAddress; 
	private String userAgent; 
	private int userId; 
	private String makerEnterDatetime; 
	private String employeeIds; 
	private String freezeType; 
	private String freezeMonth; 
	private String comments;
	public int getLogid() {
		return logid;
	}
	public void setLogid(int logid) {
		this.logid = logid;
	}
	public String getIpAddress() {
		return ipAddress;
	}
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}
	public String getUserAgent() {
		return userAgent;
	}
	public void setUserAgent(String userAgent) {
		this.userAgent = userAgent;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getMakerEnterDatetime() {
		return makerEnterDatetime;
	}
	public void setMakerEnterDatetime(String makerEnterDatetime) {
		this.makerEnterDatetime = makerEnterDatetime;
	}
	public String getEmployeeIds() {
		return employeeIds;
	}
	public void setEmployeeIds(String employeeIds) {
		this.employeeIds = employeeIds;
	}
	public String getFreezeType() {
		return freezeType;
	}
	public void setFreezeType(String freezeType) {
		this.freezeType = freezeType;
	}
	public String getFreezeMonth() {
		return freezeMonth;
	}
	public void setFreezeMonth(String freezeMonth) {
		this.freezeMonth = freezeMonth;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	@Override
	public String toString() {
		return "FreezeLogs [logid=" + logid + ", ipAddress=" + ipAddress + ", userAgent=" + userAgent + ", userId="
				+ userId + ", makerEnterDatetime=" + makerEnterDatetime + ", employeeIds=" + employeeIds
				+ ", freezeType=" + freezeType + ", freezeMonth=" + freezeMonth + ", comments=" + comments + "]";
	}
	
	

}

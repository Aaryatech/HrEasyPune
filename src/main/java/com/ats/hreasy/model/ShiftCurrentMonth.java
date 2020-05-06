package com.ats.hreasy.model;
 

public class ShiftCurrentMonth {
	 
	private int id; 
	private int companyId; 
	private int locId; 
	private String date; 
	private int lastUpdatedBy; 
	private String lastUpdateDatetime; 
	private int isCurrent; 
	private int extraInt1; 
	private int extraInt2;  
	private String extraVarchar1;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCompanyId() {
		return companyId;
	}
	public void setCompanyId(int companyId) {
		this.companyId = companyId;
	}
	public int getLocId() {
		return locId;
	}
	public void setLocId(int locId) {
		this.locId = locId;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getLastUpdatedBy() {
		return lastUpdatedBy;
	}
	public void setLastUpdatedBy(int lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}
	public String getLastUpdateDatetime() {
		return lastUpdateDatetime;
	}
	public void setLastUpdateDatetime(String lastUpdateDatetime) {
		this.lastUpdateDatetime = lastUpdateDatetime;
	}
	public int getIsCurrent() {
		return isCurrent;
	}
	public void setIsCurrent(int isCurrent) {
		this.isCurrent = isCurrent;
	}
	public int getExtraInt1() {
		return extraInt1;
	}
	public void setExtraInt1(int extraInt1) {
		this.extraInt1 = extraInt1;
	}
	public int getExtraInt2() {
		return extraInt2;
	}
	public void setExtraInt2(int extraInt2) {
		this.extraInt2 = extraInt2;
	}
	public String getExtraVarchar1() {
		return extraVarchar1;
	}
	public void setExtraVarchar1(String extraVarchar1) {
		this.extraVarchar1 = extraVarchar1;
	}
	@Override
	public String toString() {
		return "ShiftCurrentMonth [id=" + id + ", companyId=" + companyId + ", locId=" + locId + ", date=" + date
				+ ", lastUpdatedBy=" + lastUpdatedBy + ", lastUpdateDatetime=" + lastUpdateDatetime + ", isCurrent="
				+ isCurrent + ", extraInt1=" + extraInt1 + ", extraInt2=" + extraInt2 + ", extraVarchar1="
				+ extraVarchar1 + "]";
	}
	
	

}

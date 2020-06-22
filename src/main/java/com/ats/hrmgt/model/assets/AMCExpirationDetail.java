package com.ats.hrmgt.model.assets;

public class AMCExpirationDetail {
	
	private int amcId;
	private int assetId;
	private String amcFrDate;
	private String amcToDate;
	private float amcAmt;
	private String assetCode;
	private String assetName;
	private String catName;
	private String compName;
	private String contactNo1;
	private String conatctPersonName;
	private String contactPersonNo;
	private String contactPersonEmail;
	private int amcDueDays;
	private int alarmDays;
	public int getAmcId() {
		return amcId;
	}
	public void setAmcId(int amcId) {
		this.amcId = amcId;
	}
	public int getAssetId() {
		return assetId;
	}
	public void setAssetId(int assetId) {
		this.assetId = assetId;
	}
	public String getAmcFrDate() {
		return amcFrDate;
	}
	public void setAmcFrDate(String amcFrDate) {
		this.amcFrDate = amcFrDate;
	}
	public String getAmcToDate() {
		return amcToDate;
	}
	public void setAmcToDate(String amcToDate) {
		this.amcToDate = amcToDate;
	}
	public float getAmcAmt() {
		return amcAmt;
	}
	public void setAmcAmt(float amcAmt) {
		this.amcAmt = amcAmt;
	}
	public String getAssetCode() {
		return assetCode;
	}
	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
	}
	public String getAssetName() {
		return assetName;
	}
	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}
	public String getCatName() {
		return catName;
	}
	public void setCatName(String catName) {
		this.catName = catName;
	}
	public String getCompName() {
		return compName;
	}
	public void setCompName(String compName) {
		this.compName = compName;
	}
	public String getContactNo1() {
		return contactNo1;
	}
	public void setContactNo1(String contactNo1) {
		this.contactNo1 = contactNo1;
	}
	public String getConatctPersonName() {
		return conatctPersonName;
	}
	public void setConatctPersonName(String conatctPersonName) {
		this.conatctPersonName = conatctPersonName;
	}
	public String getContactPersonNo() {
		return contactPersonNo;
	}
	public void setContactPersonNo(String contactPersonNo) {
		this.contactPersonNo = contactPersonNo;
	}
	public String getContactPersonEmail() {
		return contactPersonEmail;
	}
	public void setContactPersonEmail(String contactPersonEmail) {
		this.contactPersonEmail = contactPersonEmail;
	}
	public int getAmcDueDays() {
		return amcDueDays;
	}
	public void setAmcDueDays(int amcDueDays) {
		this.amcDueDays = amcDueDays;
	}
	public int getAlarmDays() {
		return alarmDays;
	}
	public void setAlarmDays(int alarmDays) {
		this.alarmDays = alarmDays;
	}
	@Override
	public String toString() {
		return "AMCExpirationDetail [amcId=" + amcId + ", assetId=" + assetId + ", amcFrDate=" + amcFrDate
				+ ", amcToDate=" + amcToDate + ", amcAmt=" + amcAmt + ", assetCode=" + assetCode + ", assetName="
				+ assetName + ", catName=" + catName + ", compName=" + compName + ", contactNo1=" + contactNo1
				+ ", conatctPersonName=" + conatctPersonName + ", contactPersonNo=" + contactPersonNo
				+ ", contactPersonEmail=" + contactPersonEmail + ", amcDueDays=" + amcDueDays + ", alarmDays="
				+ alarmDays + "]";
	}
}

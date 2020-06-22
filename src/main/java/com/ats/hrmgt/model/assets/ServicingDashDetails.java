package com.ats.hrmgt.model.assets;

public class ServicingDashDetails {
	private int tServicingId;
	private int assetId;
	private String serviceDate;
	private String nextServiceDate;
	private float billAmt;
	private String assetCode;
	private String assetName;
	private String catName;
	private String compName;
	private String contactNo1;
	private String conatctPersonName;
	private String contactPersonNo;
	private String contactPersonEmail;
	private int servDueDays;
	private int alarmDays;
	public int gettServicingId() {
		return tServicingId;
	}
	public void settServicingId(int tServicingId) {
		this.tServicingId = tServicingId;
	}
	public int getAssetId() {
		return assetId;
	}
	public void setAssetId(int assetId) {
		this.assetId = assetId;
	}
	public String getServiceDate() {
		return serviceDate;
	}
	public void setServiceDate(String serviceDate) {
		this.serviceDate = serviceDate;
	}
	public String getNextServiceDate() {
		return nextServiceDate;
	}
	public void setNextServiceDate(String nextServiceDate) {
		this.nextServiceDate = nextServiceDate;
	}
	public float getBillAmt() {
		return billAmt;
	}
	public void setBillAmt(float billAmt) {
		this.billAmt = billAmt;
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
	public int getServDueDays() {
		return servDueDays;
	}
	public void setServDueDays(int servDueDays) {
		this.servDueDays = servDueDays;
	}
	public int getAlarmDays() {
		return alarmDays;
	}
	public void setAlarmDays(int alarmDays) {
		this.alarmDays = alarmDays;
	}
	@Override
	public String toString() {
		return "ServicingDashDetails [tServicingId=" + tServicingId + ", assetId=" + assetId + ", serviceDate="
				+ serviceDate + ", nextServiceDate=" + nextServiceDate + ", billAmt=" + billAmt + ", assetCode="
				+ assetCode + ", assetName=" + assetName + ", catName=" + catName + ", compName=" + compName
				+ ", contactNo1=" + contactNo1 + ", conatctPersonName=" + conatctPersonName + ", contactPersonNo="
				+ contactPersonNo + ", contactPersonEmail=" + contactPersonEmail + ", servDueDays=" + servDueDays
				+ ", alarmDays=" + alarmDays + "]";
	}

}

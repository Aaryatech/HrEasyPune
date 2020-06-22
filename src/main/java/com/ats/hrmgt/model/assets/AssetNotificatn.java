package com.ats.hrmgt.model.assets;

public class AssetNotificatn {

	private int assetId;
	private String assetCode;
	private String assetTransId;
	private String assetCatId;
	private String catName;
	private String assetName;
	private String useToDate;
	private String useFromDate;
	private int returnNotifctnDays;
	private int returtnInDays;
	private String empCode;
	private int alarmDays;
	private String firstName;
	private String surname;
	private String deptName;
	private String empDesgn;
	private String mobileNo1;
	private String emailId;
	public int getAssetId() {
		return assetId;
	}
	public void setAssetId(int assetId) {
		this.assetId = assetId;
	}
	public String getAssetCode() {
		return assetCode;
	}
	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
	}
	public String getAssetTransId() {
		return assetTransId;
	}
	public void setAssetTransId(String assetTransId) {
		this.assetTransId = assetTransId;
	}
	public String getAssetCatId() {
		return assetCatId;
	}
	public void setAssetCatId(String assetCatId) {
		this.assetCatId = assetCatId;
	}
	public String getCatName() {
		return catName;
	}
	public void setCatName(String catName) {
		this.catName = catName;
	}
	public String getAssetName() {
		return assetName;
	}
	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}
	public String getUseToDate() {
		return useToDate;
	}
	public void setUseToDate(String useToDate) {
		this.useToDate = useToDate;
	}
	public String getUseFromDate() {
		return useFromDate;
	}
	public void setUseFromDate(String useFromDate) {
		this.useFromDate = useFromDate;
	}
	public int getReturnNotifctnDays() {
		return returnNotifctnDays;
	}
	public void setReturnNotifctnDays(int returnNotifctnDays) {
		this.returnNotifctnDays = returnNotifctnDays;
	}
	public int getReturtnInDays() {
		return returtnInDays;
	}
	public void setReturtnInDays(int returtnInDays) {
		this.returtnInDays = returtnInDays;
	}
	public String getEmpCode() {
		return empCode;
	}
	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}
	public int getAlarmDays() {
		return alarmDays;
	}
	public void setAlarmDays(int alarmDays) {
		this.alarmDays = alarmDays;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getSurname() {
		return surname;
	}
	public void setSurname(String surname) {
		this.surname = surname;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getEmpDesgn() {
		return empDesgn;
	}
	public void setEmpDesgn(String empDesgn) {
		this.empDesgn = empDesgn;
	}
	public String getMobileNo1() {
		return mobileNo1;
	}
	public void setMobileNo1(String mobileNo1) {
		this.mobileNo1 = mobileNo1;
	}
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	@Override
	public String toString() {
		return "AssetNotificatn [assetId=" + assetId + ", assetCode=" + assetCode + ", assetTransId=" + assetTransId
				+ ", assetCatId=" + assetCatId + ", catName=" + catName + ", assetName=" + assetName + ", useToDate="
				+ useToDate + ", useFromDate=" + useFromDate + ", returnNotifctnDays=" + returnNotifctnDays
				+ ", returtnInDays=" + returtnInDays + ", empCode=" + empCode + ", alarmDays=" + alarmDays
				+ ", firstName=" + firstName + ", surname=" + surname + ", deptName=" + deptName + ", empDesgn="
				+ empDesgn + ", mobileNo1=" + mobileNo1 + ", emailId=" + emailId + "]";
	}
		
}

package com.ats.hrmgt.model.assets;

public class AssetLogReport {
	
	private int assetLogId;
	private int assetId;
	private int assetTransId;
	private String assetLogDesc;
	private String assetLogDate;
	private int makerUserId;
	private String updateDateTime;
	private String empCode;
	private String firstName;
	private String surname;
	private String deptName;
	private String empDesgn;
	private String assetName;
	private String assetCode;
	public int getAssetLogId() {
		return assetLogId;
	}
	public void setAssetLogId(int assetLogId) {
		this.assetLogId = assetLogId;
	}
	public int getAssetId() {
		return assetId;
	}
	public void setAssetId(int assetId) {
		this.assetId = assetId;
	}
	public int getAssetTransId() {
		return assetTransId;
	}
	public void setAssetTransId(int assetTransId) {
		this.assetTransId = assetTransId;
	}
	public String getAssetLogDesc() {
		return assetLogDesc;
	}
	public void setAssetLogDesc(String assetLogDesc) {
		this.assetLogDesc = assetLogDesc;
	}
	public String getAssetLogDate() {
		return assetLogDate;
	}
	public void setAssetLogDate(String assetLogDate) {
		this.assetLogDate = assetLogDate;
	}
	public int getMakerUserId() {
		return makerUserId;
	}
	public void setMakerUserId(int makerUserId) {
		this.makerUserId = makerUserId;
	}
	public String getUpdateDateTime() {
		return updateDateTime;
	}
	public void setUpdateDateTime(String updateDateTime) {
		this.updateDateTime = updateDateTime;
	}
	public String getEmpCode() {
		return empCode;
	}
	public void setEmpCode(String empCode) {
		this.empCode = empCode;
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
	public String getAssetName() {
		return assetName;
	}
	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}
	public String getAssetCode() {
		return assetCode;
	}
	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
	}
	@Override
	public String toString() {
		return "AssetLogReport [assetLogId=" + assetLogId + ", assetId=" + assetId + ", assetTransId=" + assetTransId
				+ ", assetLogDesc=" + assetLogDesc + ", assetLogDate=" + assetLogDate + ", makerUserId=" + makerUserId
				+ ", updateDateTime=" + updateDateTime + ", empCode=" + empCode + ", firstName=" + firstName
				+ ", surname=" + surname + ", deptName=" + deptName + ", empDesgn=" + empDesgn + ", assetName="
				+ assetName + ", assetCode=" + assetCode + "]";
	}
	
}

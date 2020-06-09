package com.ats.hreasy.model;

public class AssetVendor {
	
	private int vendorId;
	private String compName;
	private String compAddress;
	private String vendorCity;
	private String contactNo1;
	private String contactNo2;
	private String vendorEmail;
	private String website;
	private String gstin;
	private String conatctPersonName;
	private String contactPersonNo;
	private String contactPersonEmail;
	private String remark;
	private int exInt1;
	private String exVar1;
	private int exInt2;
	private String exVar2;
	private int makerUserId;
	private String updateDatetime;
	private int delStatus;
	
	public int getVendorId() {
		return vendorId;
	}
	public void setVendorId(int vendorId) {
		this.vendorId = vendorId;
	}
	public String getCompName() {
		return compName;
	}
	public void setCompName(String compName) {
		this.compName = compName;
	}
	public String getCompAddress() {
		return compAddress;
	}
	public void setCompAddress(String compAddress) {
		this.compAddress = compAddress;
	}
	public String getVendorCity() {
		return vendorCity;
	}
	public void setVendorCity(String vendorCity) {
		this.vendorCity = vendorCity;
	}
	public String getContactNo1() {
		return contactNo1;
	}
	public void setContactNo1(String contactNo1) {
		this.contactNo1 = contactNo1;
	}
	public String getContactNo2() {
		return contactNo2;
	}
	public void setContactNo2(String contactNo2) {
		this.contactNo2 = contactNo2;
	}
	public String getVendorEmail() {
		return vendorEmail;
	}
	public void setVendorEmail(String vendorEmail) {
		this.vendorEmail = vendorEmail;
	}
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
	public String getGstin() {
		return gstin;
	}
	public void setGstin(String gstin) {
		this.gstin = gstin;
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
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public int getExInt1() {
		return exInt1;
	}
	public void setExInt1(int exInt1) {
		this.exInt1 = exInt1;
	}
	public String getExVar1() {
		return exVar1;
	}
	public void setExVar1(String exVar1) {
		this.exVar1 = exVar1;
	}
	public int getDelStatus() {
		return delStatus;
	}
	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}
	public int getExInt2() {
		return exInt2;
	}
	public void setExInt2(int exInt2) {
		this.exInt2 = exInt2;
	}
	public String getExVar2() {
		return exVar2;
	}
	public void setExVar2(String exVar2) {
		this.exVar2 = exVar2;
	}
	public int getMakerUserId() {
		return makerUserId;
	}
	public void setMakerUserId(int makerUserId) {
		this.makerUserId = makerUserId;
	}
	public String getUpdateDatetime() {
		return updateDatetime;
	}
	public void setUpdateDatetime(String updateDatetime) {
		this.updateDatetime = updateDatetime;
	}
	@Override
	public String toString() {
		return "AssetVendor [vendorId=" + vendorId + ", compName=" + compName + ", compAddress=" + compAddress
				+ ", vendorCity=" + vendorCity + ", contactNo1=" + contactNo1 + ", contactNo2=" + contactNo2
				+ ", vendorEmail=" + vendorEmail + ", website=" + website + ", gstin=" + gstin + ", conatctPersonName="
				+ conatctPersonName + ", contactPersonNo=" + contactPersonNo + ", contactPersonEmail="
				+ contactPersonEmail + ", remark=" + remark + ", exInt1=" + exInt1 + ", exVar1=" + exVar1 + ", exInt2="
				+ exInt2 + ", exVar2=" + exVar2 + ", makerUserId=" + makerUserId + ", updateDatetime=" + updateDatetime
				+ ", delStatus=" + delStatus + "]";
	}
			
}

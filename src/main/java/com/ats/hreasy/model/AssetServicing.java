package com.ats.hreasy.model;

public class AssetServicing {
	
	private int tServicingId;
	private int assetId;
	private int serviceType;
	private String serviceDate;
	private String nextServiceDate;
	private int vendorId;
	private String serviceDesc;
	private float billAmt;
	private String billDocFile;
	private String serviceRemark;
	private int makerUserId;
	private String updateDatetime;
	private int delStatus	;
	private int exInt1;
	private int exInt2;
	private String exVar1;
	private String exVar2;
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
	public int getServiceType() {
		return serviceType;
	}
	public void setServiceType(int serviceType) {
		this.serviceType = serviceType;
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
	public int getVendorId() {
		return vendorId;
	}
	public void setVendorId(int vendorId) {
		this.vendorId = vendorId;
	}
	public String getServiceDesc() {
		return serviceDesc;
	}
	public void setServiceDesc(String serviceDesc) {
		this.serviceDesc = serviceDesc;
	}
	public float getBillAmt() {
		return billAmt;
	}
	public void setBillAmt(float billAmt) {
		this.billAmt = billAmt;
	}
	public String getBillDocFile() {
		return billDocFile;
	}
	public void setBillDocFile(String billDocFile) {
		this.billDocFile = billDocFile;
	}
	public String getServiceRemark() {
		return serviceRemark;
	}
	public void setServiceRemark(String serviceRemark) {
		this.serviceRemark = serviceRemark;
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
	public int getDelStatus() {
		return delStatus;
	}
	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}
	public int getExInt1() {
		return exInt1;
	}
	public void setExInt1(int exInt1) {
		this.exInt1 = exInt1;
	}
	public int getExInt2() {
		return exInt2;
	}
	public void setExInt2(int exInt2) {
		this.exInt2 = exInt2;
	}
	public String getExVar1() {
		return exVar1;
	}
	public void setExVar1(String exVar1) {
		this.exVar1 = exVar1;
	}
	public String getExVar2() {
		return exVar2;
	}
	public void setExVar2(String exVar2) {
		this.exVar2 = exVar2;
	}
	@Override
	public String toString() {
		return "AssetServicing [tServicingId=" + tServicingId + ", assetId=" + assetId + ", serviceType=" + serviceType
				+ ", serviceDate=" + serviceDate + ", nextServiceDate=" + nextServiceDate + ", vendorId=" + vendorId
				+ ", serviceDesc=" + serviceDesc + ", billAmt=" + billAmt + ", billDocFile=" + billDocFile
				+ ", serviceRemark=" + serviceRemark + ", makerUserId=" + makerUserId + ", updateDatetime="
				+ updateDatetime + ", delStatus=" + delStatus + ", exInt1=" + exInt1 + ", exInt2=" + exInt2
				+ ", exVar1=" + exVar1 + ", exVar2=" + exVar2 + "]";
	}
	
	
}

package com.ats.hreasy.model;

public class AssignedAssetsList {
	
	private int assetTransId;
	private int assetId;
	private String assetCode;
	private String assetName;
	private String catName;
	private String useFromDate;
	private String useToDate;
	private String assignRemark;
	public int getAssetTransId() {
		return assetTransId;
	}
	public void setAssetTransId(int assetTransId) {
		this.assetTransId = assetTransId;
	}
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
	public String getUseFromDate() {
		return useFromDate;
	}
	public void setUseFromDate(String useFromDate) {
		this.useFromDate = useFromDate;
	}
	public String getUseToDate() {
		return useToDate;
	}
	public void setUseToDate(String useToDate) {
		this.useToDate = useToDate;
	}
	public String getAssignRemark() {
		return assignRemark;
	}
	public void setAssignRemark(String assignRemark) {
		this.assignRemark = assignRemark;
	}
	@Override
	public String toString() {
		return "AssignedAssetsList [assetTransId=" + assetTransId + ", assetId=" + assetId + ", assetCode=" + assetCode
				+ ", assetName=" + assetName + ", catName=" + catName + ", useFromDate=" + useFromDate + ", useToDate="
				+ useToDate + ", assignRemark=" + assignRemark + "]";
	}
	
}

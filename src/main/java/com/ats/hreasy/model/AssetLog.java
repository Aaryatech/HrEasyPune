package com.ats.hreasy.model;

public class AssetLog {
	
	private int assetLogId;
	private int assetId;
	private int assetTransId;
	private String assetLogDesc;
	private String assetLogDate;
	private int makerUserId;
	private String updateDateTime;
	private int delStatus;
	private int exInt1;
	private int exInt2;
	private int exVar1;
	private int exVar2;
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
	public int getExVar1() {
		return exVar1;
	}
	public void setExVar1(int exVar1) {
		this.exVar1 = exVar1;
	}
	public int getExVar2() {
		return exVar2;
	}
	public void setExVar2(int exVar2) {
		this.exVar2 = exVar2;
	}
	@Override
	public String toString() {
		return "AssetLog [assetLogId=" + assetLogId + ", assetId=" + assetId + ", assetTransId=" + assetTransId
				+ ", assetLogDesc=" + assetLogDesc + ", assetLogDate=" + assetLogDate + ", makerUserId=" + makerUserId
				+ ", updateDateTime=" + updateDateTime + ", delStatus=" + delStatus + ", exInt1=" + exInt1 + ", exInt2="
				+ exInt2 + ", exVar1=" + exVar1 + ", exVar2=" + exVar2 + "]";
	}
	
	
}

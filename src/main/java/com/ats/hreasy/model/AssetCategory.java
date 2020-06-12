package com.ats.hreasy.model;

public class AssetCategory {

	private int assetCatId;
	private String catName;
	private String catRemark;
	private int returnNotifctnDate;
	private int amcNotifctnDate;
	private int delStatus;
	private int makerUserId;
	private String updateDatetime;
	private int exInt1;
	private String exVar1;
	public int getAssetCatId() {
		return assetCatId;
	}
	public void setAssetCatId(int assetCatId) {
		this.assetCatId = assetCatId;
	}
	public String getCatName() {
		return catName;
	}
	public void setCatName(String catName) {
		this.catName = catName;
	}
	public String getCatRemark() {
		return catRemark;
	}
	public void setCatRemark(String catRemark) {
		this.catRemark = catRemark;
	}
	public int getReturnNotifctnDate() {
		return returnNotifctnDate;
	}
	public void setReturnNotifctnDate(int returnNotifctnDate) {
		this.returnNotifctnDate = returnNotifctnDate;
	}
	public int getAmcNotifctnDate() {
		return amcNotifctnDate;
	}
	public void setAmcNotifctnDate(int amcNotifctnDate) {
		this.amcNotifctnDate = amcNotifctnDate;
	}
	public int getDelStatus() {
		return delStatus;
	}
	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}
	public int getMakerUserId() {
		return makerUserId;
	}
	
	public String getUpdateDatetime() {
		return updateDatetime;
	}
	public void setMakerUserId(int makerUserId) {
		this.makerUserId = makerUserId;
	}
	public void setUpdateDatetime(String updateDatetime) {
		this.updateDatetime = updateDatetime;
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
	@Override
	public String toString() {
		return "AssetCategory [assetCatId=" + assetCatId + ", catName=" + catName + ", catRemark=" + catRemark
				+ ", returnNotifctnDate=" + returnNotifctnDate + ", amcNotifctnDate=" + amcNotifctnDate + ", delStatus="
				+ delStatus + ", makerUserId=" + makerUserId + ", updateDatetime=" + updateDatetime + ", exInt1="
				+ exInt1 + ", exVar1=" + exVar1 + "]";
	}
	
}

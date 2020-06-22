package com.ats.hrmgt.model.assets;

public class AssetsDashDetails {

	private String id;
	private int assetId;
	private String assetCode;
	private String assetName;
	private String assetMake;
	private String assetModel;
	private String assetSrno;
	private String assetPurDate;
	private String assetPurImage;
	private String locName;
	private String compName;
	private String catName;
	private int exInt1;
	private int exInt2;
	private String exVar1;
	private String exVar2;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public String getAssetMake() {
		return assetMake;
	}
	public void setAssetMake(String assetMake) {
		this.assetMake = assetMake;
	}
	public String getAssetModel() {
		return assetModel;
	}
	public void setAssetModel(String assetModel) {
		this.assetModel = assetModel;
	}
	public String getAssetSrno() {
		return assetSrno;
	}
	public void setAssetSrno(String assetSrno) {
		this.assetSrno = assetSrno;
	}
	public String getAssetPurDate() {
		return assetPurDate;
	}
	public void setAssetPurDate(String assetPurDate) {
		this.assetPurDate = assetPurDate;
	}
	public String getAssetPurImage() {
		return assetPurImage;
	}
	public void setAssetPurImage(String assetPurImage) {
		this.assetPurImage = assetPurImage;
	}
	public String getLocName() {
		return locName;
	}
	public void setLocName(String locName) {
		this.locName = locName;
	}
	public String getCompName() {
		return compName;
	}
	public void setCompName(String compName) {
		this.compName = compName;
	}
	public String getCatName() {
		return catName;
	}
	public void setCatName(String catName) {
		this.catName = catName;
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
		return "AssetsDashDetails [id=" + id + ", assetId=" + assetId + ", assetCode=" + assetCode + ", assetName="
				+ assetName + ", assetMake=" + assetMake + ", assetModel=" + assetModel + ", assetSrno=" + assetSrno
				+ ", assetPurDate=" + assetPurDate + ", assetPurImage=" + assetPurImage + ", locName=" + locName
				+ ", compName=" + compName + ", catName=" + catName + ", exInt1=" + exInt1 + ", exInt2=" + exInt2
				+ ", exVar1=" + exVar1 + ", exVar2=" + exVar2 + "]";
	}
	
}

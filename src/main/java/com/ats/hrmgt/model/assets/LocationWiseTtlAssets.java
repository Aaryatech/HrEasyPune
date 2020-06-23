package com.ats.hrmgt.model.assets;

public class LocationWiseTtlAssets {
	
	private String id; 
	private String locName; 
	private String catName; 
	private int assetCount; 
	private int assetCat_id; 
	private int locId;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getLocName() {
		return locName;
	}
	public void setLocName(String locName) {
		this.locName = locName;
	}
	public String getCatName() {
		return catName;
	}
	public void setCatName(String catName) {
		this.catName = catName;
	}
	public int getAssetCount() {
		return assetCount;
	}
	public void setAssetCount(int assetCount) {
		this.assetCount = assetCount;
	}
	public int getAssetCat_id() {
		return assetCat_id;
	}
	public void setAssetCat_id(int assetCat_id) {
		this.assetCat_id = assetCat_id;
	}
	public int getLocId() {
		return locId;
	}
	public void setLocId(int locId) {
		this.locId = locId;
	}
	@Override
	public String toString() {
		return "LocationWiseTtlAssets [id=" + id + ", locName=" + locName + ", catName=" + catName + ", assetCount="
				+ assetCount + ", assetCat_id=" + assetCat_id + ", locId=" + locId + "]";
	} 
	
	
	
}

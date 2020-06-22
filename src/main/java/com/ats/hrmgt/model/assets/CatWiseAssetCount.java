package com.ats.hrmgt.model.assets;

public class CatWiseAssetCount {

	private int assetCatId;
	private int assetCount;
	private String catName;
	public int getAssetCatId() {
		return assetCatId;
	}
	public void setAssetCatId(int assetCatId) {
		this.assetCatId = assetCatId;
	}
	public int getAssetCount() {
		return assetCount;
	}
	public void setAssetCount(int assetCount) {
		this.assetCount = assetCount;
	}
	public String getCatName() {
		return catName;
	}
	public void setCatName(String catName) {
		this.catName = catName;
	}
	@Override
	public String toString() {
		return "CatWiseAssetCount [assetCatId=" + assetCatId + ", assetCount=" + assetCount + ", catName=" + catName
				+ "]";
	}
	
}

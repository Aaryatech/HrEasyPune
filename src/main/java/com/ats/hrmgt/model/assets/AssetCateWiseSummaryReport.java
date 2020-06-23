package com.ats.hrmgt.model.assets;

public class AssetCateWiseSummaryReport {

	private int assetCatId;
	private String catName;
	private int unAssigned;
	private int assigned;
	private int lost;
	private int scrapped;
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
	public int getUnAssigned() {
		return unAssigned;
	}
	public void setUnAssigned(int unAssigned) {
		this.unAssigned = unAssigned;
	}
	public int getAssigned() {
		return assigned;
	}
	public void setAssigned(int assigned) {
		this.assigned = assigned;
	}
	public int getLost() {
		return lost;
	}
	public void setLost(int lost) {
		this.lost = lost;
	}
	public int getScrapped() {
		return scrapped;
	}
	public void setScrapped(int scrapped) {
		this.scrapped = scrapped;
	}
	@Override
	public String toString() {
		return "AssetCateWiseSummaryReport [assetCatId=" + assetCatId + ", catName=" + catName + ", unAssigned="
				+ unAssigned + ", assigned=" + assigned + ", lost=" + lost + ", scrapped=" + scrapped + "]";
	}
	
	
	
}

package com.ats.hrmgt.model.assets;

import java.util.List;

import com.ats.hreasy.model.AssetsDetailsList;

public class AssetAMCDetails {

	private List<AMCInfo> assetAMCList;
	private AssetsDetailsList assetDetails;
	public List<AMCInfo> getAssetAMCList() {
		return assetAMCList;
	}
	public void setAssetAMCList(List<AMCInfo> assetAMCList) {
		this.assetAMCList = assetAMCList;
	}
	public AssetsDetailsList getAssetDetails() {
		return assetDetails;
	}
	public void setAssetDetails(AssetsDetailsList assetDetails) {
		this.assetDetails = assetDetails;
	}
	@Override
	public String toString() {
		return "AssetAMCDetails [assetAMCList=" + assetAMCList + ", assetDetails=" + assetDetails + "]";
	}
	
}

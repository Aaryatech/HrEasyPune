package com.ats.hrmgt.model.assets;

import java.util.List;

import com.ats.hreasy.model.AssetsDetailsList;

public class AssetReturnDetails {

	private List<AssetEmpHistoryInfo> assetHistoryList;
	private AssetsDetailsList assetDetails;
	
	public AssetsDetailsList getAssetDetails() {
		return assetDetails;
	}
	public void setAssetDetails(AssetsDetailsList assetDetails) {
		this.assetDetails = assetDetails;
	}
	public List<AssetEmpHistoryInfo> getAssetHistoryList() {
		return assetHistoryList;
	}
	public void setAssetHistoryList(List<AssetEmpHistoryInfo> assetHistoryList) {
		this.assetHistoryList = assetHistoryList;
	}
	@Override
	public String toString() {
		return "AssetReturnDetails [assetHistoryList=" + assetHistoryList + ", assetDetails=" + assetDetails + "]";
	}
	
	
}

package com.ats.hrmgt.model.assets;

import java.util.List;

import com.ats.hreasy.model.ViewEmployee;

public class AssetAssignedEmp {
	List<AssetEmpInfo> assetEmpList;
	ViewEmployee empInfo;
	public List<AssetEmpInfo> getAssetEmpList() {
		return assetEmpList;
	}
	public void setAssetEmpList(List<AssetEmpInfo> assetEmpList) {
		this.assetEmpList = assetEmpList;
	}
	public ViewEmployee getEmpInfo() {
		return empInfo;
	}
	public void setEmpInfo(ViewEmployee empInfo) {
		this.empInfo = empInfo;
	}
	@Override
	public String toString() {
		return "AssetAssignedEmp [assetEmpList=" + assetEmpList + ", empInfo=" + empInfo + "]";
	}
	
}

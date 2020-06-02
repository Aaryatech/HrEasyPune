package com.ats.hreasy.model.claim;

import java.util.List;

public class TempClaimDetail {

	private int claimDetailId;

 	private String remark;
	
	private String lvTypeName;

	private int typeId;

	private float claimAmount;
	
	List<ClaimProof> proofList;

	public int getClaimDetailId() {
		return claimDetailId;
	}

	public void setClaimDetailId(int claimDetailId) {
		this.claimDetailId = claimDetailId;
	}

	 
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public int getTypeId() {
		return typeId;
	}

	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}

	public float getClaimAmount() {
		return claimAmount;
	}

	public void setClaimAmount(float claimAmount) {
		this.claimAmount = claimAmount;
	}
	 
	public String getLvTypeName() {
		return lvTypeName;
	}

	public void setLvTypeName(String lvTypeName) {
		this.lvTypeName = lvTypeName;
	}

	public List<ClaimProof> getProofList() {
		return proofList;
	}

	public void setProofList(List<ClaimProof> proofList) {
		this.proofList = proofList;
	}

	@Override
	public String toString() {
		return "TempClaimDetail [claimDetailId=" + claimDetailId + ", remark=" + remark + ", lvTypeName=" + lvTypeName
				+ ", typeId=" + typeId + ", claimAmount=" + claimAmount + ", proofList=" + proofList + "]";
	}

	 
}

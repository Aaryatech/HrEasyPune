package com.ats.hreasy.model;
 

public class GetClaimList {
	
	 
	private int caHeadId; 
	private int empId; 
	private float claimAmount;

	public int getCaHeadId() {
		return caHeadId;
	}

	public void setCaHeadId(int caHeadId) {
		this.caHeadId = caHeadId;
	}

	public int getEmpId() {
		return empId;
	}

	public void setEmpId(int empId) {
		this.empId = empId;
	}

	public float getClaimAmount() {
		return claimAmount;
	}

	public void setClaimAmount(float claimAmount) {
		this.claimAmount = claimAmount;
	}

	@Override
	public String toString() {
		return "GetClaimList [caHeadId=" + caHeadId + ", empId=" + empId + ", claimAmount=" + claimAmount + "]";
	}
	

}

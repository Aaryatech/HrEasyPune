package com.ats.hreasy.model;
 

public class GetPayDedList {
	
	 
	private String id; 
	private int empId; 
	private float amt;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getEmpId() {
		return empId;
	}

	public void setEmpId(int empId) {
		this.empId = empId;
	}

	public float getAmt() {
		return amt;
	}

	public void setAmt(float amt) {
		this.amt = amt;
	}

	@Override
	public String toString() {
		return "GetPayDedList [id=" + id + ", empId=" + empId + ", amt=" + amt + "]";
	}

}

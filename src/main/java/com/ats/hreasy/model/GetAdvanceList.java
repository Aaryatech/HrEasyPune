package com.ats.hreasy.model;
 

public class GetAdvanceList {
	
	 
	private int id; 
	private int empId; 
	private float advAmount;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getEmpId() {
		return empId;
	}

	public void setEmpId(int empId) {
		this.empId = empId;
	}

	public float getAdvAmount() {
		return advAmount;
	}

	public void setAdvAmount(float advAmount) {
		this.advAmount = advAmount;
	}

	@Override
	public String toString() {
		return "GetAdvanceList [id=" + id + ", empId=" + empId + ", advAmount=" + advAmount + "]";
	}

}

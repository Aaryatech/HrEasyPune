package com.ats.hreasy.model;
  
public class GetAdvanceDetails {
	 
	private String id; 
	private int empId; 
	private float amt; 
	private String date; 
	private String remark;

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

	 
	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Override
	public String toString() {
		return "GetAdvanceDetails [id=" + id + ", empId=" + empId + ", amt=" + amt + ", date=" + date + ", remark="
				+ remark + "]";
	}
	
	

	 
}

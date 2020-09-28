package com.ats.hreasy.model;
 
public class TotalOT {
	 
	private String id; 
	private int empId; 
	private String month; 
	private float ot;
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
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public float getOt() {
		return ot;
	}
	public void setOt(float ot) {
		this.ot = ot;
	}
	@Override
	public String toString() {
		return "TotalOT [id=" + id + ", empId=" + empId + ", month=" + month + ", ot=" + ot + "]";
	}
	
	

}

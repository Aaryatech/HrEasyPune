package com.ats.hreasy.model;
 

public class ProductionIncentiveList {
	
	 
	 
	private String id; 
	private int empId; 
	private String attDate; 
	private int hrs; 
	private int totOthr; 
	private String showHrs; 
	private String attStatus; 
	private double amt;
	
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

	 
	public String getAttDate() {
		return attDate;
	}

	public void setAttDate(String attDate) {
		this.attDate = attDate;
	}

	public int getHrs() {
		return hrs;
	}

	public void setHrs(int hrs) {
		this.hrs = hrs;
	}

	public int getTotOthr() {
		return totOthr;
	}

	public void setTotOthr(int totOthr) {
		this.totOthr = totOthr;
	}

	public double getAmt() {
		return amt;
	}

	public void setAmt(double amt) {
		this.amt = amt;
	}

	public String getShowHrs() {
		return showHrs;
	}

	public void setShowHrs(String showHrs) {
		this.showHrs = showHrs;
	}

	public String getAttStatus() {
		return attStatus;
	}

	public void setAttStatus(String attStatus) {
		this.attStatus = attStatus;
	}

	@Override
	public String toString() {
		return "ProductionIncentiveList [id=" + id + ", empId=" + empId + ", attDate=" + attDate + ", hrs=" + hrs
				+ ", totOthr=" + totOthr + ", showHrs=" + showHrs + ", attStatus=" + attStatus + ", amt=" + amt + "]";
	}

}

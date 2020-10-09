package com.ats.hrmgt.model;

import java.util.List;
 

public class EmpOpningLoanList {
	
	private String id;
	private int empId;
	private String empName;
	private String monthYear;
	private float opAmt;
	private int loanCount; 
	private List<LedgerDetailList> ledgerList;
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
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getMonthYear() {
		return monthYear;
	}
	public void setMonthYear(String monthYear) {
		this.monthYear = monthYear;
	}
	public float getOpAmt() {
		return opAmt;
	}
	public void setOpAmt(float opAmt) {
		this.opAmt = opAmt;
	}
	public int getLoanCount() {
		return loanCount;
	}
	public void setLoanCount(int loanCount) {
		this.loanCount = loanCount;
	}
	public List<LedgerDetailList> getLedgerList() {
		return ledgerList;
	}
	public void setLedgerList(List<LedgerDetailList> ledgerList) {
		this.ledgerList = ledgerList;
	}
	@Override
	public String toString() {
		return "EmpOpningLoanList [id=" + id + ", empId=" + empId + ", empName=" + empName + ", monthYear=" + monthYear
				+ ", opAmt=" + opAmt + ", loanCount=" + loanCount + ", ledgerList=" + ledgerList + "]";
	}
	
	

}

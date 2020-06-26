package com.ats.hreasy.model;
 

public class GetEmpDetailForFullPayslip {
	
	private int empId;  
	private String pfNo; 
	private String esicNo; 
	private String aadharNo; 
	private String uan;
	private String cmpJoiningDate;
	private String panCardNo;
	private double remLoanAmt;
	private String accNo;
	private String bankName;
	private String branchName;
	private String locName;
	
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public String getPfNo() {
		return pfNo;
	}
	public void setPfNo(String pfNo) {
		this.pfNo = pfNo;
	}
	public String getEsicNo() {
		return esicNo;
	}
	public void setEsicNo(String esicNo) {
		this.esicNo = esicNo;
	}
	public String getAadharNo() {
		return aadharNo;
	}
	public void setAadharNo(String aadharNo) {
		this.aadharNo = aadharNo;
	}
	public String getUan() {
		return uan;
	}
	public void setUan(String uan) {
		this.uan = uan;
	}
	public String getCmpJoiningDate() {
		return cmpJoiningDate;
	}
	public void setCmpJoiningDate(String cmpJoiningDate) {
		this.cmpJoiningDate = cmpJoiningDate;
	}
	public String getPanCardNo() {
		return panCardNo;
	}
	public void setPanCardNo(String panCardNo) {
		this.panCardNo = panCardNo;
	}
	public double getRemLoanAmt() {
		return remLoanAmt;
	}
	public void setRemLoanAmt(double remLoanAmt) {
		this.remLoanAmt = remLoanAmt;
	}
	public String getAccNo() {
		return accNo;
	}
	public void setAccNo(String accNo) {
		this.accNo = accNo;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getBranchName() {
		return branchName;
	}
	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}
	public String getLocName() {
		return locName;
	}
	public void setLocName(String locName) {
		this.locName = locName;
	}
	@Override
	public String toString() {
		return "GetEmpDetailForFullPayslip [empId=" + empId + ", pfNo=" + pfNo + ", esicNo=" + esicNo + ", aadharNo="
				+ aadharNo + ", uan=" + uan + ", cmpJoiningDate=" + cmpJoiningDate + ", panCardNo=" + panCardNo
				+ ", remLoanAmt=" + remLoanAmt + ", accNo=" + accNo + ", bankName=" + bankName + ", branchName="
				+ branchName + ", locName=" + locName + "]";
	}
	
	

}

package com.ats.hrmgt.model.assets;

public class AssetEmpHistoryInfo {
	private int assetTransId;
	
	private int assetId;
	private String assetCode;	
	private String assetName;
	
	private String useFromDate;
	private String useToDate;
	
	private String assignRemark;
	private String assignImgFile;

	private String returnRemark;
	private String returnImgFile;
	
	private int empId;
	private String empCode;
	private String firstName;
	private String surname;
	private String deptName;
	private String empDesgn;
	private String locName;
	
	public int getAssetTransId() {
		return assetTransId;
	}
	public void setAssetTransId(int assetTransId) {
		this.assetTransId = assetTransId;
	}
	public int getAssetId() {
		return assetId;
	}
	public void setAssetId(int assetId) {
		this.assetId = assetId;
	}
	public String getAssetCode() {
		return assetCode;
	}
	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
	}
	public String getAssetName() {
		return assetName;
	}
	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}
	
	public String getUseFromDate() {
		return useFromDate;
	}
	public void setUseFromDate(String useFromDate) {
		this.useFromDate = useFromDate;
	}
	
	public String getUseToDate() {
		return useToDate;
	}
	public void setUseToDate(String useToDate) {
		this.useToDate = useToDate;
	}
	
	public String getAssignRemark() {
		return assignRemark;
	}
	public void setAssignRemark(String assignRemark) {
		this.assignRemark = assignRemark;
	}
	public String getAssignImgFile() {
		return assignImgFile;
	}
	public void setAssignImgFile(String assignImgFile) {
		this.assignImgFile = assignImgFile;
	}
	public String getReturnRemark() {
		return returnRemark;
	}
	public void setReturnRemark(String returnRemark) {
		this.returnRemark = returnRemark;
	}
	public String getReturnImgFile() {
		return returnImgFile;
	}
	public void setReturnImgFile(String returnImgFile) {
		this.returnImgFile = returnImgFile;
	}
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public String getEmpCode() {
		return empCode;
	}
	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getSurname() {
		return surname;
	}
	public void setSurname(String surname) {
		this.surname = surname;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getEmpDesgn() {
		return empDesgn;
	}
	public void setEmpDesgn(String empDesgn) {
		this.empDesgn = empDesgn;
	}
	public String getLocName() {
		return locName;
	}
	public void setLocName(String locName) {
		this.locName = locName;
	}
	@Override
	public String toString() {
		return "AssetEmpHistoryInfo [assetTransId=" + assetTransId + ", assetId=" + assetId + ", assetCode=" + assetCode
				+ ", assetName=" + assetName + ", useFromDate=" + useFromDate + ", useToDate=" + useToDate
				+ ", assignRemark=" + assignRemark + ", assignImgFile=" + assignImgFile + ", returnRemark="
				+ returnRemark + ", returnImgFile=" + returnImgFile + ", empId=" + empId + ", empCode=" + empCode
				+ ", firstName=" + firstName + ", surname=" + surname + ", deptName=" + deptName + ", empDesgn="
				+ empDesgn + ", locName=" + locName + "]";
	}
	
	
	
}

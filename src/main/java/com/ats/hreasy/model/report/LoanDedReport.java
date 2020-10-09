package com.ats.hreasy.model.report;
  
public class LoanDedReport {

	private String uniqueId;
	private int empId;
	private String empCode;
	private String empName;
	private String departmentName;
	private float amountEmi;
	public String getUniqueId() {
		return uniqueId;
	}
	public void setUniqueId(String uniqueId) {
		this.uniqueId = uniqueId;
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
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public float getAmountEmi() {
		return amountEmi;
	}
	public void setAmountEmi(float amountEmi) {
		this.amountEmi = amountEmi;
	}
	@Override
	public String toString() {
		return "LoanDedReport [uniqueId=" + uniqueId + ", empId=" + empId + ", empCode=" + empCode + ", empName="
				+ empName + ", departmentName=" + departmentName + ", amountEmi=" + amountEmi + "]";
	}
 
	

}

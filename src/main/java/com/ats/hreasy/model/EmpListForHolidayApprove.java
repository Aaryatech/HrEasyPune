package com.ats.hreasy.model;
 
public class EmpListForHolidayApprove {
	
	
	private int id; 
	private int empId; 
	private int delStatus; 
	private int holidayId; 
	private int status; 
	private String holidate;
	private String remark; 
	private String empCode; 
	private String empName; 
	private String holidayName;
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
	public int getDelStatus() {
		return delStatus;
	}
	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}
	public int getHolidayId() {
		return holidayId;
	}
	public void setHolidayId(int holidayId) {
		this.holidayId = holidayId;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getHolidate() {
		return holidate;
	}
	public void setHolidate(String holidate) {
		this.holidate = holidate;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
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
	public String getHolidayName() {
		return holidayName;
	}
	public void setHolidayName(String holidayName) {
		this.holidayName = holidayName;
	}
	@Override
	public String toString() {
		return "EmpListForHolidayApprove [id=" + id + ", empId=" + empId + ", delStatus=" + delStatus + ", holidayId="
				+ holidayId + ", status=" + status + ", holidate=" + holidate + ", remark=" + remark + ", empCode="
				+ empCode + ", empName=" + empName + ", holidayName=" + holidayName + "]";
	}
	
	

}

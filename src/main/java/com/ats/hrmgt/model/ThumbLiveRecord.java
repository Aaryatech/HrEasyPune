package com.ats.hrmgt.model;
 
public class ThumbLiveRecord {
 
	private String id; 
	private String empCode; 
	private int countThumb; 
	private String thumbRecord; 
	private String empName; 
	private String deptName;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEmpCode() {
		return empCode;
	}
	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}
	public int getCountThumb() {
		return countThumb;
	}
	public void setCountThumb(int countThumb) {
		this.countThumb = countThumb;
	}
	public String getThumbRecord() {
		return thumbRecord;
	}
	public void setThumbRecord(String thumbRecord) {
		this.thumbRecord = thumbRecord;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	@Override
	public String toString() {
		return "ThumbLiveRecord [id=" + id + ", empCode=" + empCode + ", countThumb=" + countThumb + ", thumbRecord="
				+ thumbRecord + ", empName=" + empName + ", deptName=" + deptName + "]";
	}
	
	
}

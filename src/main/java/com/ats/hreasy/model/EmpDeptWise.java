package com.ats.hreasy.model;
 
public class EmpDeptWise {
	 
	private String id; 
	private int deptCount; 
	private String deptName; 
	private int departId;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getDeptCount() {
		return deptCount;
	}
	public void setDeptCount(int deptCount) {
		this.deptCount = deptCount;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public int getDepartId() {
		return departId;
	}
	public void setDepartId(int departId) {
		this.departId = departId;
	}
	@Override
	public String toString() {
		return "EmpDeptWise [id=" + id + ", deptCount=" + deptCount + ", deptName=" + deptName + ", departId="
				+ departId + "]";
	}
	
	

}

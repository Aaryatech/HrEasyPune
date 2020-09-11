package com.ats.hreasy.model.dashboard;
 
public class DeptWiseWeekoffDash {
	
	
	private String id;
	private int departId;
	
	
	private String nameSd;
	
	
	private int  empCount;


	public int getDepartId() {
		return departId;
	}


	public void setDepartId(int departId) {
		this.departId = departId;
	}


	public String getNameSd() {
		return nameSd;
	}


	public void setNameSd(String nameSd) {
		this.nameSd = nameSd;
	}


	public int getEmpCount() {
		return empCount;
	}


	public void setEmpCount(int empCount) {
		this.empCount = empCount;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	@Override
	public String toString() {
		return "DeptWiseWeekoffDash [id=" + id + ", departId=" + departId + ", nameSd=" + nameSd + ", empCount="
				+ empCount + "]";
	}
	
	
	
	
	

}

package com.ats.hreasy.model;
 
public class EmpGraphDetail {
 
	private int id; 
	private int empId; 
	private String month; 
	private String lateMin; 
	private String lateMark; 
	private int leaveCount; 
	private int lwp;
	
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
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	} 
	public String getLateMin() {
		return lateMin;
	}
	public void setLateMin(String lateMin) {
		this.lateMin = lateMin;
	}
	public String getLateMark() {
		return lateMark;
	}
	public void setLateMark(String lateMark) {
		this.lateMark = lateMark;
	}
	public int getLeaveCount() {
		return leaveCount;
	}
	public void setLeaveCount(int leaveCount) {
		this.leaveCount = leaveCount;
	}
	public int getLwp() {
		return lwp;
	}
	public void setLwp(int lwp) {
		this.lwp = lwp;
	}
	@Override
	public String toString() {
		return "EmpGraphDetail [id=" + id + ", empId=" + empId + ", month=" + month + ", lateMin=" + lateMin
				+ ", lateMark=" + lateMark + ", leaveCount=" + leaveCount + ", lwp=" + lwp + "]";
	}
	
	
	
	
}

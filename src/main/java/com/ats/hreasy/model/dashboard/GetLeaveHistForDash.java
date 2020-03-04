package com.ats.hreasy.model.dashboard;
 

 
public class GetLeaveHistForDash {
	
 	
	private int leaveId;
	 
	private String leaveFromdt;
	
	private String leaveTodt ;
	
	private float leaveNumDays;
	
	
	private String leaveEmpReason;
	
	private int exInt1;
	
	
	private String lvTitleShort;


	public int getLeaveId() {
		return leaveId;
	}


	public void setLeaveId(int leaveId) {
		this.leaveId = leaveId;
	}

 
	public String getLeaveFromdt() {
		return leaveFromdt;
	}


	public void setLeaveFromdt(String leaveFromdt) {
		this.leaveFromdt = leaveFromdt;
	}

 
	public String getLeaveTodt() {
		return leaveTodt;
	}


	public void setLeaveTodt(String leaveTodt) {
		this.leaveTodt = leaveTodt;
	}


	public float getLeaveNumDays() {
		return leaveNumDays;
	}


	public void setLeaveNumDays(float leaveNumDays) {
		this.leaveNumDays = leaveNumDays;
	}


	public String getLeaveEmpReason() {
		return leaveEmpReason;
	}


	public void setLeaveEmpReason(String leaveEmpReason) {
		this.leaveEmpReason = leaveEmpReason;
	}


	public int getExInt1() {
		return exInt1;
	}


	public void setExInt1(int exInt1) {
		this.exInt1 = exInt1;
	}


	public String getLvTitleShort() {
		return lvTitleShort;
	}


	public void setLvTitleShort(String lvTitleShort) {
		this.lvTitleShort = lvTitleShort;
	}


	@Override
	public String toString() {
		return "GetLeaveHistForDash [leaveId=" + leaveId + ", leaveFromdt=" + leaveFromdt + ", leaveTodt=" + leaveTodt
				+ ", leaveNumDays=" + leaveNumDays + ", leaveEmpReason=" + leaveEmpReason + ", exInt1=" + exInt1
				+ ", lvTitleShort=" + lvTitleShort + "]";
	}
	
	
	

}

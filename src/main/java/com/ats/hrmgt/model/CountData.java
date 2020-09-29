package com.ats.hrmgt.model;

public class CountData {

	private String id;
	private int present;
	private int absent;
	private int leavecount;
	private int latemark;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getPresent() {
		return present;
	}
	public void setPresent(int present) {
		this.present = present;
	}
	public int getAbsent() {
		return absent;
	}
	public void setAbsent(int absent) {
		this.absent = absent;
	}
	public int getLeavecount() {
		return leavecount;
	}
	public void setLeavecount(int leavecount) {
		this.leavecount = leavecount;
	}
	public int getLatemark() {
		return latemark;
	}
	public void setLatemark(int latemark) {
		this.latemark = latemark;
	}
	@Override
	public String toString() {
		return "CountData [id=" + id + ", present=" + present + ", absent=" + absent + ", leavecount=" + leavecount
				+ ", latemark=" + latemark + "]";
	}
}

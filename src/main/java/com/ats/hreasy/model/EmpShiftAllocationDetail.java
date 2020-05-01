package com.ats.hreasy.model;
 

public class EmpShiftAllocationDetail {
	
	private int id; 
	private int empId; 
	private int shiftId; 
	private String shiftDate; 
	private String shiftname; 
	private String extra;
	private int extraType;
	
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
	public int getShiftId() {
		return shiftId;
	}
	public void setShiftId(int shiftId) {
		this.shiftId = shiftId;
	}
	public String getShiftDate() {
		return shiftDate;
	}
	public void setShiftDate(String shiftDate) {
		this.shiftDate = shiftDate;
	}
	public String getShiftname() {
		return shiftname;
	}
	public void setShiftname(String shiftname) {
		this.shiftname = shiftname;
	}
	public String getExtra() {
		return extra;
	}
	public void setExtra(String extra) {
		this.extra = extra;
	}
	public int getExtraType() {
		return extraType;
	}
	public void setExtraType(int extraType) {
		this.extraType = extraType;
	}
	@Override
	public String toString() {
		return "EmpShiftAllocationDetail [id=" + id + ", empId=" + empId + ", shiftId=" + shiftId + ", shiftDate="
				+ shiftDate + ", shiftname=" + shiftname + ", extra=" + extra + ", extraType=" + extraType + "]";
	}
	
	

}

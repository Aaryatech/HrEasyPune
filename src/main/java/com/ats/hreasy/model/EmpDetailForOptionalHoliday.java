package com.ats.hreasy.model;
 

public class EmpDetailForOptionalHoliday {
	 
	private int empId; 
	private String empCode; 
	private String empName; 
	private int holidayCategory; 
	private int weekendCategory; 
	private String deptName; 
	private String empDesgn; 
	private String locName; 
	private String woCatName; 
	private String hoCatName; 
	private int usedHo; 
	private int optionalHoliday;
	private int applyHo;
	
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
	public int getHolidayCategory() {
		return holidayCategory;
	}
	public void setHolidayCategory(int holidayCategory) {
		this.holidayCategory = holidayCategory;
	}
	public int getWeekendCategory() {
		return weekendCategory;
	}
	public void setWeekendCategory(int weekendCategory) {
		this.weekendCategory = weekendCategory;
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
	public String getWoCatName() {
		return woCatName;
	}
	public void setWoCatName(String woCatName) {
		this.woCatName = woCatName;
	}
	public String getHoCatName() {
		return hoCatName;
	}
	public void setHoCatName(String hoCatName) {
		this.hoCatName = hoCatName;
	}
	public int getUsedHo() {
		return usedHo;
	}
	public void setUsedHo(int usedHo) {
		this.usedHo = usedHo;
	}
	public int getOptionalHoliday() {
		return optionalHoliday;
	}
	public void setOptionalHoliday(int optionalHoliday) {
		this.optionalHoliday = optionalHoliday;
	}
	public int getApplyHo() {
		return applyHo;
	}
	public void setApplyHo(int applyHo) {
		this.applyHo = applyHo;
	}
	@Override
	public String toString() {
		return "EmpDetailForOptionalHoliday [empId=" + empId + ", empCode=" + empCode + ", empName=" + empName
				+ ", holidayCategory=" + holidayCategory + ", weekendCategory=" + weekendCategory + ", deptName="
				+ deptName + ", empDesgn=" + empDesgn + ", locName=" + locName + ", woCatName=" + woCatName
				+ ", hoCatName=" + hoCatName + ", usedHo=" + usedHo + ", optionalHoliday=" + optionalHoliday
				+ ", applyHo=" + applyHo + "]";
	}
	
	

}

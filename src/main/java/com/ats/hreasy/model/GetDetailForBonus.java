package com.ats.hreasy.model;

public class GetDetailForBonus {
	
	private int id;
	private int empId;
	private float presentdays;
	private float weeklyoff;
	private float holiday;
	private float bonusPer;
	private double basic ; 
	private double allowanceValue;
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
	public float getPresentdays() {
		return presentdays;
	}
	public void setPresentdays(float presentdays) {
		this.presentdays = presentdays;
	}
	public float getWeeklyoff() {
		return weeklyoff;
	}
	public void setWeeklyoff(float weeklyoff) {
		this.weeklyoff = weeklyoff;
	}
	public float getHoliday() {
		return holiday;
	}
	public void setHoliday(float holiday) {
		this.holiday = holiday;
	}
	public float getBonusPer() {
		return bonusPer;
	}
	public void setBonusPer(float bonusPer) {
		this.bonusPer = bonusPer;
	}
	public double getBasic() {
		return basic;
	}
	public void setBasic(double basic) {
		this.basic = basic;
	}
	public double getAllowanceValue() {
		return allowanceValue;
	}
	public void setAllowanceValue(double allowanceValue) {
		this.allowanceValue = allowanceValue;
	}
	@Override
	public String toString() {
		return "GetDetailForBonus [id=" + id + ", empId=" + empId + ", presentdays=" + presentdays + ", weeklyoff="
				+ weeklyoff + ", holiday=" + holiday + ", bonusPer=" + bonusPer + ", basic=" + basic
				+ ", allowanceValue=" + allowanceValue + "]";
	}
	
	

}

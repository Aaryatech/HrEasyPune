package com.ats.hreasy.model;

public class AllowanceWithDifferenceForArear {
	
	private int allowanceId;
	private String name; 
	private String shortName; 
	private double allowanceValue; // current rate
	private double allowanceValueCal; //month current rate
	private double allowanceDifference;
	private double arearCal;
	public int getAllowanceId() {
		return allowanceId;
	}
	public void setAllowanceId(int allowanceId) {
		this.allowanceId = allowanceId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getAllowanceValue() {
		return allowanceValue;
	}
	public void setAllowanceValue(double allowanceValue) {
		this.allowanceValue = allowanceValue;
	}
	public double getAllowanceValueCal() {
		return allowanceValueCal;
	}
	public void setAllowanceValueCal(double allowanceValueCal) {
		this.allowanceValueCal = allowanceValueCal;
	}
	public double getAllowanceDifference() {
		return allowanceDifference;
	}
	public void setAllowanceDifference(double allowanceDifference) {
		this.allowanceDifference = allowanceDifference;
	}
	public double getArearCal() {
		return arearCal;
	}
	public void setArearCal(double arearCal) {
		this.arearCal = arearCal;
	}
	public String getShortName() {
		return shortName;
	}
	public void setShortName(String shortName) {
		this.shortName = shortName;
	}
	@Override
	public String toString() {
		return "AllowanceWithDifferenceForArear [allowanceId=" + allowanceId + ", name=" + name + ", shortName="
				+ shortName + ", allowanceValue=" + allowanceValue + ", allowanceValueCal=" + allowanceValueCal
				+ ", allowanceDifference=" + allowanceDifference + ", arearCal=" + arearCal + "]";
	}

}

package com.ats.hreasy.model.report;
 
public class GetPtChallan {
 
	private int slabId ;
	private int salTermId ;
 	private String minVal ; 
 	private String maxVal; 
 	private double amount; 
  	private int gender;
  	private int locId;
  	private int count;
  	private String genderName; 
  	
	public int getSlabId() {
		return slabId;
	}
	public void setSlabId(int slabId) {
		this.slabId = slabId;
	}
	public int getSalTermId() {
		return salTermId;
	}
	public void setSalTermId(int salTermId) {
		this.salTermId = salTermId;
	}
	public String getMinVal() {
		return minVal;
	}
	public void setMinVal(String minVal) {
		this.minVal = minVal;
	}
	public String getMaxVal() {
		return maxVal;
	}
	public void setMaxVal(String maxVal) {
		this.maxVal = maxVal;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public int getGender() {
		return gender;
	}
	public void setGender(int gender) {
		this.gender = gender;
	}
	public int getLocId() {
		return locId;
	}
	public void setLocId(int locId) {
		this.locId = locId;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getGenderName() {
		return genderName;
	}
	public void setGenderName(String genderName) {
		this.genderName = genderName;
	}
	@Override
	public String toString() {
		return "GetPtChallan [slabId=" + slabId + ", salTermId=" + salTermId + ", minVal=" + minVal + ", maxVal="
				+ maxVal + ", amount=" + amount + ", gender=" + gender + ", locId=" + locId + ", count=" + count
				+ ", genderName=" + genderName + "]";
	}

	 
}

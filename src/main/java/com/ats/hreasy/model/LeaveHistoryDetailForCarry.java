package com.ats.hreasy.model;

public class LeaveHistoryDetailForCarry {
	
	
	private String id; 
	private int empId;
    private int lvTypeId; 
	private int lvsId; 
	private String lvTitleShort; 
	private String lvTitle; 
	private float lvsAllotedLeaves; 
	private float balLeave; 
	private float aplliedLeaeve; 
	private float sactionLeave;  
	private int maxAccumulateCarryforward; 
	private int isCarryforward; 
	private int maxCarryforward; 
	private int isInCash; 
	private String lvsName;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public int getLvTypeId() {
		return lvTypeId;
	}
	public void setLvTypeId(int lvTypeId) {
		this.lvTypeId = lvTypeId;
	}
	public int getLvsId() {
		return lvsId;
	}
	public void setLvsId(int lvsId) {
		this.lvsId = lvsId;
	}
	public String getLvTitleShort() {
		return lvTitleShort;
	}
	public void setLvTitleShort(String lvTitleShort) {
		this.lvTitleShort = lvTitleShort;
	}
	public String getLvTitle() {
		return lvTitle;
	}
	public void setLvTitle(String lvTitle) {
		this.lvTitle = lvTitle;
	}
	public float getLvsAllotedLeaves() {
		return lvsAllotedLeaves;
	}
	public void setLvsAllotedLeaves(float lvsAllotedLeaves) {
		this.lvsAllotedLeaves = lvsAllotedLeaves;
	}
	public float getBalLeave() {
		return balLeave;
	}
	public void setBalLeave(float balLeave) {
		this.balLeave = balLeave;
	}
	public float getAplliedLeaeve() {
		return aplliedLeaeve;
	}
	public void setAplliedLeaeve(float aplliedLeaeve) {
		this.aplliedLeaeve = aplliedLeaeve;
	}
	public float getSactionLeave() {
		return sactionLeave;
	}
	public void setSactionLeave(float sactionLeave) {
		this.sactionLeave = sactionLeave;
	}
	public int getMaxAccumulateCarryforward() {
		return maxAccumulateCarryforward;
	}
	public void setMaxAccumulateCarryforward(int maxAccumulateCarryforward) {
		this.maxAccumulateCarryforward = maxAccumulateCarryforward;
	}
	public int getIsCarryforward() {
		return isCarryforward;
	}
	public void setIsCarryforward(int isCarryforward) {
		this.isCarryforward = isCarryforward;
	}
	public int getMaxCarryforward() {
		return maxCarryforward;
	}
	public void setMaxCarryforward(int maxCarryforward) {
		this.maxCarryforward = maxCarryforward;
	}
	public int getIsInCash() {
		return isInCash;
	}
	public void setIsInCash(int isInCash) {
		this.isInCash = isInCash;
	}
	public String getLvsName() {
		return lvsName;
	}
	public void setLvsName(String lvsName) {
		this.lvsName = lvsName;
	}
	@Override
	public String toString() {
		return "LeaveHistoryDetailForCarry [id=" + id + ", empId=" + empId + ", lvTypeId=" + lvTypeId + ", lvsId="
				+ lvsId + ", lvTitleShort=" + lvTitleShort + ", lvTitle=" + lvTitle + ", lvsAllotedLeaves="
				+ lvsAllotedLeaves + ", balLeave=" + balLeave + ", aplliedLeaeve=" + aplliedLeaeve + ", sactionLeave="
				+ sactionLeave + ", maxAccumulateCarryforward=" + maxAccumulateCarryforward + ", isCarryforward="
				+ isCarryforward + ", maxCarryforward=" + maxCarryforward + ", isInCash=" + isInCash + ", lvsName="
				+ lvsName + "]";
	}
	
	
	

}

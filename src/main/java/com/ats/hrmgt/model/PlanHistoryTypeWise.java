package com.ats.hrmgt.model;
 

public class PlanHistoryTypeWise {
	 
	private int typeId; 
	private String typeName; 
	private int delStatus; 
	private int count; 
	private float incentive; 
	private int km;
	public int getTypeId() {
		return typeId;
	}
	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public int getDelStatus() {
		return delStatus;
	}
	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public float getIncentive() {
		return incentive;
	}
	public void setIncentive(float incentive) {
		this.incentive = incentive;
	}
	public int getKm() {
		return km;
	}
	public void setKm(int km) {
		this.km = km;
	}
	@Override
	public String toString() {
		return "PlanHistoryTypeWise [typeId=" + typeId + ", typeName=" + typeName + ", delStatus=" + delStatus
				+ ", count=" + count + ", incentive=" + incentive + ", km=" + km + "]";
	}
	
	

}

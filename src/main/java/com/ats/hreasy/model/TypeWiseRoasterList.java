package com.ats.hreasy.model;
 

public class TypeWiseRoasterList {
	 
	private String id; 
	private int driverId; 
	private int typeId;
	private int typeCount;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getDriverId() {
		return driverId;
	}
	public void setDriverId(int driverId) {
		this.driverId = driverId;
	}
	public int getTypeCount() {
		return typeCount;
	}
	public void setTypeCount(int typeCount) {
		this.typeCount = typeCount;
	}
	public int getTypeId() {
		return typeId;
	}
	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}
	@Override
	public String toString() {
		return "TypeWiseRoasterList [id=" + id + ", driverId=" + driverId + ", typeId=" + typeId + ", typeCount="
				+ typeCount + "]";
	}
	
	

}

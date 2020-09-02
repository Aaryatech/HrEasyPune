package com.ats.hreasy.model;
 
public class GetAccessibleLocation {

	 
	private int empId ; 
	private String accessibleLoc ; 
	private int presentLoc ; 
	private boolean isError;
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public String getAccessibleLoc() {
		return accessibleLoc;
	}
	public void setAccessibleLoc(String accessibleLoc) {
		this.accessibleLoc = accessibleLoc;
	}
	public int getPresentLoc() {
		return presentLoc;
	}
	public void setPresentLoc(int presentLoc) {
		this.presentLoc = presentLoc;
	}
	public boolean isError() {
		return isError;
	}
	public void setError(boolean isError) {
		this.isError = isError;
	}
	@Override
	public String toString() {
		return "GetAccessibleLocation [empId=" + empId + ", accessibleLoc=" + accessibleLoc + ", presentLoc="
				+ presentLoc + ", isError=" + isError + "]";
	}
	
	
	
}

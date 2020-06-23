package com.ats.hrmgt.model.assets;

public class VendorWiseTtlAssetsReport {
	
	private int vendorId;
	private String compName;
	private String contactNo1;
	private String conatctPersonName;
	private String contactPersonNo;
	private int unAssigned;
	private int assigned;
	private int lost;
	private int scrapped;
	public int getVendorId() {
		return vendorId;
	}
	public void setVendorId(int vendorId) {
		this.vendorId = vendorId;
	}
	public String getCompName() {
		return compName;
	}
	public void setCompName(String compName) {
		this.compName = compName;
	}
	public String getContactNo1() {
		return contactNo1;
	}
	public void setContactNo1(String contactNo1) {
		this.contactNo1 = contactNo1;
	}
	public String getConatctPersonName() {
		return conatctPersonName;
	}
	public void setConatctPersonName(String conatctPersonName) {
		this.conatctPersonName = conatctPersonName;
	}
	public String getContactPersonNo() {
		return contactPersonNo;
	}
	public void setContactPersonNo(String contactPersonNo) {
		this.contactPersonNo = contactPersonNo;
	}
	public int getUnAssigned() {
		return unAssigned;
	}
	public void setUnAssigned(int unAssigned) {
		this.unAssigned = unAssigned;
	}
	public int getAssigned() {
		return assigned;
	}
	public void setAssigned(int assigned) {
		this.assigned = assigned;
	}
	public int getLost() {
		return lost;
	}
	public void setLost(int lost) {
		this.lost = lost;
	}
	public int getScrapped() {
		return scrapped;
	}
	public void setScrapped(int scrapped) {
		this.scrapped = scrapped;
	}
	@Override
	public String toString() {
		return "VendorWiseTtlAssetsReport [vendorId=" + vendorId + ", compName=" + compName + ", contactNo1="
				+ contactNo1 + ", conatctPersonName=" + conatctPersonName + ", contactPersonNo=" + contactPersonNo
				+ ", unAssigned=" + unAssigned + ", assigned=" + assigned + ", lost=" + lost + ", scrapped="
				+ scrapped + "]";
	}
	
}

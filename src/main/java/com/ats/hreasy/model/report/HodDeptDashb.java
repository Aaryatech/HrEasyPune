package com.ats.hreasy.model.report;

public class HodDeptDashb {

	private int departId;
	private String nameSd;
	private String name;
	
	private float reqEmpCount;
	private float presentDays;
	private float abDays;
	private float otLastMonth;
	private float actualEmpCount;
	public int getDepartId() {
		return departId;
	}
	public void setDepartId(int departId) {
		this.departId = departId;
	}
	public String getNameSd() {
		return nameSd;
	}
	public void setNameSd(String nameSd) {
		this.nameSd = nameSd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public float getReqEmpCount() {
		return reqEmpCount;
	}
	public void setReqEmpCount(float reqEmpCount) {
		this.reqEmpCount = reqEmpCount;
	}
	public float getPresentDays() {
		return presentDays;
	}
	public void setPresentDays(float presentDays) {
		this.presentDays = presentDays;
	}
	public float getAbDays() {
		return abDays;
	}
	public void setAbDays(float abDays) {
		this.abDays = abDays;
	}
	public float getOtLastMonth() {
		return otLastMonth;
	}
	public void setOtLastMonth(float otLastMonth) {
		this.otLastMonth = otLastMonth;
	}
	public float getActualEmpCount() {
		return actualEmpCount;
	}
	public void setActualEmpCount(float actualEmpCount) {
		this.actualEmpCount = actualEmpCount;
	}
	
	@Override
	public String toString() {
		return "HodDeptDashb [departId=" + departId + ", nameSd=" + nameSd + ", name=" + name + ", reqEmpCount="
				+ reqEmpCount + ", presentDays=" + presentDays + ", abDays=" + abDays + ", otLastMonth=" + otLastMonth
				+ ", actualEmpCount=" + actualEmpCount + "]";
	}
	
}

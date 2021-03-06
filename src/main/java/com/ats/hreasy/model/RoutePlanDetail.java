package com.ats.hreasy.model;
 

public class RoutePlanDetail {
	 
	private int planDetailId; 
	private int planHeadId; 
	private int routeId; 
	private int driverId; 
	private int isoffdayIsff; 
	private int typeId; 
	private String routeName; 
	private String frName; 
	private String frIds; 
	private int lateMark; 
	private int lateMin; 
	private String startTime; 
	private int km; 
	private float incentive; 
	private int delStatus; 
	private int extraInt1; 
	private int extraInt2; 
	private String extraVar2; 
	private String extraVar1;
	public int getPlanDetailId() {
		return planDetailId;
	}
	public void setPlanDetailId(int planDetailId) {
		this.planDetailId = planDetailId;
	}
	public int getPlanHeadId() {
		return planHeadId;
	}
	public void setPlanHeadId(int planHeadId) {
		this.planHeadId = planHeadId;
	}
	public int getRouteId() {
		return routeId;
	}
	public void setRouteId(int routeId) {
		this.routeId = routeId;
	}
	public int getDriverId() {
		return driverId;
	}
	public void setDriverId(int driverId) {
		this.driverId = driverId;
	}
	public int getIsoffdayIsff() {
		return isoffdayIsff;
	}
	public void setIsoffdayIsff(int isoffdayIsff) {
		this.isoffdayIsff = isoffdayIsff;
	}
	public int getTypeId() {
		return typeId;
	}
	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}
	public String getRouteName() {
		return routeName;
	}
	public void setRouteName(String routeName) {
		this.routeName = routeName;
	}
	public String getFrName() {
		return frName;
	}
	public void setFrName(String frName) {
		this.frName = frName;
	}
	public String getFrIds() {
		return frIds;
	}
	public void setFrIds(String frIds) {
		this.frIds = frIds;
	}
	public int getLateMark() {
		return lateMark;
	}
	public void setLateMark(int lateMark) {
		this.lateMark = lateMark;
	}
	public int getLateMin() {
		return lateMin;
	}
	public void setLateMin(int lateMin) {
		this.lateMin = lateMin;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public int getKm() {
		return km;
	}
	public void setKm(int km) {
		this.km = km;
	}
	public float getIncentive() {
		return incentive;
	}
	public void setIncentive(float incentive) {
		this.incentive = incentive;
	}
	public int getDelStatus() {
		return delStatus;
	}
	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}
	public int getExtraInt1() {
		return extraInt1;
	}
	public void setExtraInt1(int extraInt1) {
		this.extraInt1 = extraInt1;
	}
	public int getExtraInt2() {
		return extraInt2;
	}
	public void setExtraInt2(int extraInt2) {
		this.extraInt2 = extraInt2;
	}
	public String getExtraVar2() {
		return extraVar2;
	}
	public void setExtraVar2(String extraVar2) {
		this.extraVar2 = extraVar2;
	}
	public String getExtraVar1() {
		return extraVar1;
	}
	public void setExtraVar1(String extraVar1) {
		this.extraVar1 = extraVar1;
	}
	@Override
	public String toString() {
		return "RoutePlanDetail [planDetailId=" + planDetailId + ", planHeadId=" + planHeadId + ", routeId=" + routeId
				+ ", driverId=" + driverId + ", isoffdayIsff=" + isoffdayIsff + ", typeId=" + typeId + ", routeName="
				+ routeName + ", frName=" + frName + ", frIds=" + frIds + ", lateMark=" + lateMark + ", lateMin="
				+ lateMin + ", startTime=" + startTime + ", km=" + km + ", incentive=" + incentive + ", delStatus="
				+ delStatus + ", extraInt1=" + extraInt1 + ", extraInt2=" + extraInt2 + ", extraVar2=" + extraVar2
				+ ", extraVar1=" + extraVar1 + "]";
	}
	
	

}

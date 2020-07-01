package com.ats.hrmgt.model;

import java.util.List; 

public class PlanHistoryDetail {
	 
	private String id; 
	private int offdays; 
	private int ffdays; 
	private int km; 
	private int incentive;
	private String empName;
	List<PlanHistoryTypeWise> planwisehistoryList;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getOffdays() {
		return offdays;
	}

	public void setOffdays(int offdays) {
		this.offdays = offdays;
	}

	public int getFfdays() {
		return ffdays;
	}

	public void setFfdays(int ffdays) {
		this.ffdays = ffdays;
	}

	public int getKm() {
		return km;
	}

	public void setKm(int km) {
		this.km = km;
	}

	public int getIncentive() {
		return incentive;
	}

	public void setIncentive(int incentive) {
		this.incentive = incentive;
	}

	public List<PlanHistoryTypeWise> getPlanwisehistoryList() {
		return planwisehistoryList;
	}

	public void setPlanwisehistoryList(List<PlanHistoryTypeWise> planwisehistoryList) {
		this.planwisehistoryList = planwisehistoryList;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	@Override
	public String toString() {
		return "PlanHistoryDetail [id=" + id + ", offdays=" + offdays + ", ffdays=" + ffdays + ", km=" + km
				+ ", incentive=" + incentive + ", empName=" + empName + ", planwisehistoryList=" + planwisehistoryList
				+ "]";
	}
	
	

}

package com.ats.hreasy.model;
 
public class LwfChallanData {
 
	private String id; 
	private int empCount; 
	private int countLwf; 
	private int lwfNoCount; 
	private float mlwf; 
	private float employerMlwf; 
	private int locationId; 
	private int month; 
	private float employerValue; 
	private float employeeValue;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getEmpCount() {
		return empCount;
	}

	public void setEmpCount(int empCount) {
		this.empCount = empCount;
	}

	public int getCountLwf() {
		return countLwf;
	}

	public void setCountLwf(int countLwf) {
		this.countLwf = countLwf;
	}

	public int getLwfNoCount() {
		return lwfNoCount;
	}

	public void setLwfNoCount(int lwfNoCount) {
		this.lwfNoCount = lwfNoCount;
	}

	public float getMlwf() {
		return mlwf;
	}

	public void setMlwf(float mlwf) {
		this.mlwf = mlwf;
	}

	public float getEmployerMlwf() {
		return employerMlwf;
	}

	public void setEmployerMlwf(float employerMlwf) {
		this.employerMlwf = employerMlwf;
	}

	public int getLocationId() {
		return locationId;
	}

	public void setLocationId(int locationId) {
		this.locationId = locationId;
	}

	public int getMonth() {
		return month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	public float getEmployerValue() {
		return employerValue;
	}

	public void setEmployerValue(float employerValue) {
		this.employerValue = employerValue;
	}

	public float getEmployeeValue() {
		return employeeValue;
	}

	public void setEmployeeValue(float employeeValue) {
		this.employeeValue = employeeValue;
	}

	@Override
	public String toString() {
		return "LwfChallanData [id=" + id + ", empCount=" + empCount + ", countLwf=" + countLwf + ", lwfNoCount="
				+ lwfNoCount + ", mlwf=" + mlwf + ", employerMlwf=" + employerMlwf + ", locationId=" + locationId
				+ ", month=" + month + ", employerValue=" + employerValue + ", employeeValue=" + employeeValue + "]";
	}
}

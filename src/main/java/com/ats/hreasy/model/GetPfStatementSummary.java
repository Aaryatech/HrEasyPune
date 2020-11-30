package com.ats.hreasy.model;

public class GetPfStatementSummary {
	
	private int id;
	private int empId;
	private String empCode;
	private String epfWages;
	private String epfWagesEmployer;
	private String epsWages;
	private String employerEps;
	private String employeePf;
	private String employerPf;
	private String empName;
	private String pfNo;
	private String uan;
	public String getEmpCode() {
		return empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getEmpId() {
		return empId;
	}

	public void setEmpId(int empId) {
		this.empId = empId;
	}

	public String getEpfWages() {
		return epfWages;
	}

	public void setEpfWages(String epfWages) {
		this.epfWages = epfWages;
	}

	public String getEpfWagesEmployer() {
		return epfWagesEmployer;
	}

	public void setEpfWagesEmployer(String epfWagesEmployer) {
		this.epfWagesEmployer = epfWagesEmployer;
	}

	public String getEpsWages() {
		return epsWages;
	}

	public void setEpsWages(String epsWages) {
		this.epsWages = epsWages;
	}

	public String getEmployerEps() {
		return employerEps;
	}

	public void setEmployerEps(String employerEps) {
		this.employerEps = employerEps;
	}

	public String getEmployeePf() {
		return employeePf;
	}

	public void setEmployeePf(String employeePf) {
		this.employeePf = employeePf;
	}

	public String getEmployerPf() {
		return employerPf;
	}

	public void setEmployerPf(String employerPf) {
		this.employerPf = employerPf;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getPfNo() {
		return pfNo;
	}

	public void setPfNo(String pfNo) {
		this.pfNo = pfNo;
	}

	public String getUan() {
		return uan;
	}

	public void setUan(String uan) {
		this.uan = uan;
	}

	@Override
	public String toString() {
		return "GetPfStatementSummary [id=" + id + ", empId=" + empId + ", epfWages=" + epfWages + ", epfWagesEmployer="
				+ epfWagesEmployer + ", epsWages=" + epsWages + ", employerEps=" + employerEps + ", employeePf="
				+ employeePf + ", employerPf=" + employerPf + ", empName=" + empName + ", pfNo=" + pfNo + ", uan=" + uan
				+ "]";
	}

}

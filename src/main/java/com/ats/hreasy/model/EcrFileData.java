package com.ats.hreasy.model;

public class EcrFileData {
	
	private String id;
	private String uan;
	private String firstName;
	private String middleName;
	private String surname;
	
	private int grossSalary;
	private int epfWages;
	private int epfWages_employer;
	private int epsWages;
	private int employeePf	;
	private int employerEps;
	
	private int employerPf;
	private int ncpDays	;
	private int adv;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUan() {
		return uan;
	}
	public void setUan(String uan) {
		this.uan = uan;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getMiddleName() {
		return middleName;
	}
	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}
	public String getSurname() {
		return surname;
	}
	public void setSurname(String surname) {
		this.surname = surname;
	}
	public int getEpfWages() {
		return epfWages;
	}
	public void setEpfWages(int epfWages) {
		this.epfWages = epfWages;
	}
	public int getEpfWages_employer() {
		return epfWages_employer;
	}
	public void setEpfWages_employer(int epfWages_employer) {
		this.epfWages_employer = epfWages_employer;
	}
	public int getEpsWages() {
		return epsWages;
	}
	public void setEpsWages(int epsWages) {
		this.epsWages = epsWages;
	}
	public int getEmployeePf() {
		return employeePf;
	}
	public void setEmployeePf(int employeePf) {
		this.employeePf = employeePf;
	}
	public int getEmployerEps() {
		return employerEps;
	}
	public void setEmployerEps(int employerEps) {
		this.employerEps = employerEps;
	}
	public int getEmployerPf() {
		return employerPf;
	}
	public void setEmployerPf(int employerPf) {
		this.employerPf = employerPf;
	}
	public int getNcpDays() {
		return ncpDays;
	}
	public void setNcpDays(int ncpDays) {
		this.ncpDays = ncpDays;
	}
	public int getAdv() {
		return adv;
	}
	public void setAdv(int adv) {
		this.adv = adv;
	}
	public int getGrossSalary() {
		return grossSalary;
	}
	public void setGrossSalary(int grossSalary) {
		this.grossSalary = grossSalary;
	}
	@Override
	public String toString() {
		return "EcrFileData [id=" + id + ", uan=" + uan + ", firstName=" + firstName + ", middleName=" + middleName
				+ ", surname=" + surname + ", grossSalary=" + grossSalary + ", epfWages=" + epfWages
				+ ", epfWages_employer=" + epfWages_employer + ", epsWages=" + epsWages + ", employeePf=" + employeePf
				+ ", employerEps=" + employerEps + ", employerPf=" + employerPf + ", ncpDays=" + ncpDays + ", adv="
				+ adv + "]";
	}

}

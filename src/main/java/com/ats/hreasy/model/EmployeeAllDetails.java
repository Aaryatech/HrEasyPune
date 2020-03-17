package com.ats.hreasy.model;

import java.util.List;

public class EmployeeAllDetails {

	EmployeeMaster  empDtl;
	TblEmpInfo empPersDtl;
	TblEmpNominees empNomDtl;
	TblEmpBankInfo empBankDtl;
	EmpSalaryInfo empSalDtl;
	List<EmpSalAllowance> empAllowncDtl;
	List<EmployeDoc> docDtl;
	public EmployeeMaster getEmpDtl() {
		return empDtl;
	}
	public void setEmpDtl(EmployeeMaster empDtl) {
		this.empDtl = empDtl;
	}
	public TblEmpInfo getEmpPersDtl() {
		return empPersDtl;
	}
	public void setEmpPersDtl(TblEmpInfo empPersDtl) {
		this.empPersDtl = empPersDtl;
	}
	public TblEmpNominees getEmpNomDtl() {
		return empNomDtl;
	}
	public void setEmpNomDtl(TblEmpNominees empNomDtl) {
		this.empNomDtl = empNomDtl;
	}
	public TblEmpBankInfo getEmpBankDtl() {
		return empBankDtl;
	}
	public void setEmpBankDtl(TblEmpBankInfo empBankDtl) {
		this.empBankDtl = empBankDtl;
	}
	public EmpSalaryInfo getEmpSalDtl() {
		return empSalDtl;
	}
	public void setEmpSalDtl(EmpSalaryInfo empSalDtl) {
		this.empSalDtl = empSalDtl;
	}
	public List<EmpSalAllowance> getEmpAllowncDtl() {
		return empAllowncDtl;
	}
	public void setEmpAllowncDtl(List<EmpSalAllowance> empAllowncDtl) {
		this.empAllowncDtl = empAllowncDtl;
	}
	public List<EmployeDoc> getDocDtl() {
		return docDtl;
	}
	public void setDocDtl(List<EmployeDoc> docDtl) {
		this.docDtl = docDtl;
	}
	@Override
	public String toString() {
		return "EmployeeAllDetails [empDtl=" + empDtl + ", empPersDtl=" + empPersDtl + ", empNomDtl=" + empNomDtl
				+ ", empBankDtl=" + empBankDtl + ", empSalDtl=" + empSalDtl + ", empAllowncDtl=" + empAllowncDtl
				+ ", docDtl=" + docDtl + "]";
	}
	
	
}

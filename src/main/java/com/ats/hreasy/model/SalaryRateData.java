package com.ats.hreasy.model;

import java.util.List;

public class SalaryRateData {

	private List<GetEmployeeDetails> list;
	private List<EmpSalAllowance> alloList;
	private List<Allowances> allowancelist;

	public List<GetEmployeeDetails> getList() {
		return list;
	}

	public void setList(List<GetEmployeeDetails> list) {
		this.list = list;
	}

	public List<EmpSalAllowance> getAlloList() {
		return alloList;
	}

	public void setAlloList(List<EmpSalAllowance> alloList) {
		this.alloList = alloList;
	}

	public List<Allowances> getAllowancelist() {
		return allowancelist;
	}

	public void setAllowancelist(List<Allowances> allowancelist) {
		this.allowancelist = allowancelist;
	}

	@Override
	public String toString() {
		return "SalaryRateData [list=" + list + ", alloList=" + alloList + ", allowancelist=" + allowancelist + "]";
	}

}

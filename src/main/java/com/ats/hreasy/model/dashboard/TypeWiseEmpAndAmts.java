package com.ats.hreasy.model.dashboard;

public class TypeWiseEmpAndAmts {

	private String uniKey;

	private int type;

	private int totAmt;

	private int totEmp;

	private int totSkipAmt;

	private int totSkipEmp;

	public String getUniKey() {
		return uniKey;
	}

	public void setUniKey(String uniKey) {
		this.uniKey = uniKey;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getTotAmt() {
		return totAmt;
	}

	public void setTotAmt(int totAmt) {
		this.totAmt = totAmt;
	}

	public int getTotEmp() {
		return totEmp;
	}

	public void setTotEmp(int totEmp) {
		this.totEmp = totEmp;
	}

	public int getTotSkipAmt() {
		return totSkipAmt;
	}

	public void setTotSkipAmt(int totSkipAmt) {
		this.totSkipAmt = totSkipAmt;
	}

	public int getTotSkipEmp() {
		return totSkipEmp;
	}

	public void setTotSkipEmp(int totSkipEmp) {
		this.totSkipEmp = totSkipEmp;
	}

	@Override
	public String toString() {
		return "TypeWiseEmpAndAmts [uniKey=" + uniKey + ", type=" + type + ", totAmt=" + totAmt + ", totEmp=" + totEmp
				+ ", totSkipAmt=" + totSkipAmt + ", totSkipEmp=" + totSkipEmp + "]";
	}

}

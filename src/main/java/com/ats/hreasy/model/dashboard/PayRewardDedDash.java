package com.ats.hreasy.model.dashboard;

public class PayRewardDedDash {

	private String uniKey;

	private int empCount;

	private String tot;

	public String getUniKey() {
		return uniKey;
	}

	public void setUniKey(String uniKey) {
		this.uniKey = uniKey;
	}

	public int getEmpCount() {
		return empCount;
	}

	public void setEmpCount(int empCount) {
		this.empCount = empCount;
	}

	public String getTot() {
		return tot;
	}

	public void setTot(String tot) {
		this.tot = tot;
	}

	@Override
	public String toString() {
		return "PayRewardDedDash [uniKey=" + uniKey + ", empCount=" + empCount + ", tot=" + tot + "]";
	}

}

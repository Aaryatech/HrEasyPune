package com.ats.hreasy.model;
 

public class AdvanceAndLoanInfo {
	
	private double advanceAmt;
	private double loanAmt;
	public double getAdvanceAmt() {
		return advanceAmt;
	}
	public void setAdvanceAmt(double advanceAmt) {
		this.advanceAmt = advanceAmt;
	}
	public double getLoanAmt() {
		return loanAmt;
	}
	public void setLoanAmt(double loanAmt) {
		this.loanAmt = loanAmt;
	}
	@Override
	public String toString() {
		return "AdvanceAndLoanInfo [advanceAmt=" + advanceAmt + ", loanAmt=" + loanAmt + "]";
	} 
	
	

}

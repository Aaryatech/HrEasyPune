package com.ats.hreasy.model.dashboard;
 
public class LoanAdvDashDet {
	
	 
	private String uniKey;
	private String emp;
	
	private String skipId;
	
	
	private String skipTott;
	
	
	private String advTot;


	public String getUniKey() {
		return uniKey;
	}


	public void setUniKey(String uniKey) {
		this.uniKey = uniKey;
	}


	public String getEmp() {
		return emp;
	}


	public void setEmp(String emp) {
		this.emp = emp;
	}


	public String getSkipId() {
		return skipId;
	}


	public void setSkipId(String skipId) {
		this.skipId = skipId;
	}


	public String getSkipTott() {
		return skipTott;
	}


	public void setSkipTott(String skipTott) {
		this.skipTott = skipTott;
	}


	public String getAdvTot() {
		return advTot;
	}


	public void setAdvTot(String advTot) {
		this.advTot = advTot;
	}


	@Override
	public String toString() {
		return "LoanAdvDashDet [uniKey=" + uniKey + ", emp=" + emp + ", skipId=" + skipId + ", skipTott=" + skipTott
				+ ", advTot=" + advTot + "]";
	}
	
	
	
	
	
	

}

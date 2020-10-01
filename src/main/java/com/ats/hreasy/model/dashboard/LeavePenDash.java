package com.ats.hreasy.model.dashboard;

 
public class LeavePenDash {
	
	
 
	private String uniKey;
	
	
	private int  newApp;
	
	private int finalPending;
	private int ohPending;
	private int newClaimApp;
	private int finalClaimApp;
	
	public String getUniKey() {
		return uniKey;
	}

	public void setUniKey(String uniKey) {
		this.uniKey = uniKey;
	}

	public int getNewApp() {
		return newApp;
	}

	public void setNewApp(int newApp) {
		this.newApp = newApp;
	}

	public int getFinalPending() {
		return finalPending;
	}

	public void setFinalPending(int finalPending) {
		this.finalPending = finalPending;
	}

	public int getOhPending() {
		return ohPending;
	}

	public void setOhPending(int ohPending) {
		this.ohPending = ohPending;
	}

	public int getNewClaimApp() {
		return newClaimApp;
	}

	public void setNewClaimApp(int newClaimApp) {
		this.newClaimApp = newClaimApp;
	}

	public int getFinalClaimApp() {
		return finalClaimApp;
	}

	public void setFinalClaimApp(int finalClaimApp) {
		this.finalClaimApp = finalClaimApp;
	}

	@Override
	public String toString() {
		return "LeavePenDash [uniKey=" + uniKey + ", newApp=" + newApp + ", finalPending=" + finalPending
				+ ", ohPending=" + ohPending + ", newClaimApp=" + newClaimApp + ", finalClaimApp=" + finalClaimApp
				+ "]";
	}
	
	
	
	
	
	

}

package com.ats.hreasy.model;

public class OpbalAndId {
	
	private int balId;
	private float opBal;
	public int getBalId() {
		return balId;
	}
	public void setBalId(int balId) {
		this.balId = balId;
	}
	public float getOpBal() {
		return opBal;
	}
	public void setOpBal(float opBal) {
		this.opBal = opBal;
	}
	@Override
	public String toString() {
		return "OpbalAndId [balId=" + balId + ", opBal=" + opBal + "]";
	}
	
	

}

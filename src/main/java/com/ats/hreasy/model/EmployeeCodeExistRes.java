package com.ats.hreasy.model;

public class EmployeeCodeExistRes {

	private int codeExist ;
	private String lastCode ;
	public int getCodeExist() {
		return codeExist;
	}
	public void setCodeExist(int codeExist) {
		this.codeExist = codeExist;
	}
	public String getLastCode() {
		return lastCode;
	}
	public void setLastCode(String lastCode) {
		this.lastCode = lastCode;
	}
	@Override
	public String toString() {
		return "EmployeeCodeExistRes [codeExist=" + codeExist + ", lastCode=" + lastCode + "]";
	}
	 
	
	
}

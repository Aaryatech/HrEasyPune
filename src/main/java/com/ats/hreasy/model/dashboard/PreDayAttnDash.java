package com.ats.hreasy.model.dashboard;
 
public class PreDayAttnDash {
	 
	private String uniKey;
	
	
	private int  preEmp;
	
	private int  absentEmp;
	
	private int  woEmp;
	
	
	private int  lvEmp;
	
	
	private String  attnDate;


	public String getUniKey() {
		return uniKey;
	}


	public void setUniKey(String uniKey) {
		this.uniKey = uniKey;
	}


	public int getPreEmp() {
		return preEmp;
	}


	public void setPreEmp(int preEmp) {
		this.preEmp = preEmp;
	}


	public int getAbsentEmp() {
		return absentEmp;
	}


	public void setAbsentEmp(int absentEmp) {
		this.absentEmp = absentEmp;
	}


	public int getWoEmp() {
		return woEmp;
	}


	public void setWoEmp(int woEmp) {
		this.woEmp = woEmp;
	}


	public int getLvEmp() {
		return lvEmp;
	}


	public void setLvEmp(int lvEmp) {
		this.lvEmp = lvEmp;
	}


	public String getAttnDate() {
		return attnDate;
	}


	public void setAttnDate(String attnDate) {
		this.attnDate = attnDate;
	}


	@Override
	public String toString() {
		return "PreDayAttnDash [uniKey=" + uniKey + ", preEmp=" + preEmp + ", absentEmp=" + absentEmp + ", woEmp="
				+ woEmp + ", lvEmp=" + lvEmp + ", attnDate=" + attnDate + "]";
	}
	
	
	
	
	

}

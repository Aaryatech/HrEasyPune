package com.ats.hreasy.model;
 
public class AttendaceLiveCount {
  
	private int lvSumupId; 
	private String attsSdShow; 
	private int cnt;
	public int getLvSumupId() {
		return lvSumupId;
	}
	public void setLvSumupId(int lvSumupId) {
		this.lvSumupId = lvSumupId;
	}
	public String getAttsSdShow() {
		return attsSdShow;
	}
	public void setAttsSdShow(String attsSdShow) {
		this.attsSdShow = attsSdShow;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	@Override
	public String toString() {
		return "AttendaceLiveCount [lvSumupId=" + lvSumupId + ", attsSdShow=" + attsSdShow + ", cnt=" + cnt + "]";
	}
	
	
	
}

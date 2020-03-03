package com.ats.hreasy.model;

import java.util.List;
 

public class InfoForCompOffList {
	
	private boolean isError; 
	private String msg;
	private List<DailyRecordForCompOff> dailyrecordlistforcompoff;
	public boolean isError() {
		return isError;
	}
	public void setError(boolean isError) {
		this.isError = isError;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public List<DailyRecordForCompOff> getDailyrecordlistforcompoff() {
		return dailyrecordlistforcompoff;
	}
	public void setDailyrecordlistforcompoff(List<DailyRecordForCompOff> dailyrecordlistforcompoff) {
		this.dailyrecordlistforcompoff = dailyrecordlistforcompoff;
	}
	@Override
	public String toString() {
		return "InfoForCompOffList [isError=" + isError + ", msg=" + msg + "]";
	}
	
	

}

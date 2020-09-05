package com.ats.hreasy.model;

import java.util.List;
 

public class AttendaceReturnInfo {
	
	private boolean isError; 
	private String msg;
	private List<LeaveCancelEmployee> list;
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
	public List<LeaveCancelEmployee> getList() {
		return list;
	}
	public void setList(List<LeaveCancelEmployee> list) {
		this.list = list;
	}
	@Override
	public String toString() {
		return "AttendaceReturnInfo [isError=" + isError + ", msg=" + msg + ", list=" + list + "]";
	}
	
	

}

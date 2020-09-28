package com.ats.hreasy.model;
 
public class TotalOT {
	  
	private String id; 
	private int departId; 
	private String month; 
	private float ot; 
	private String dateMo; 
	private String name;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getDepartId() {
		return departId;
	}
	public void setDepartId(int departId) {
		this.departId = departId;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public float getOt() {
		return ot;
	}
	public void setOt(float ot) {
		this.ot = ot;
	}
	public String getDateMo() {
		return dateMo;
	}
	public void setDateMo(String dateMo) {
		this.dateMo = dateMo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Override
	public String toString() {
		return "TotalOT [id=" + id + ", departId=" + departId + ", month=" + month + ", ot=" + ot + ", dateMo=" + dateMo
				+ ", name=" + name + "]";
	}
	
	
	
	

}

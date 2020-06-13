package com.ats.hreasy.model;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

public class AssetAmc {
	
	private int amcId;
	private int assetId;
	private String amcFrDate;
	private String amcToDate;
	private float amcAmt;
	private String positiveRemark;
	private String negativeRemark;
	private int vendorId;
	
	private int amcStatus;
	private String termAndCondi;
	private String amcDocFile;
	
	private int makerUserId;
	private String updateDatetime;
	private int delStatus;
	private int exInt1;
	private String exVar1;
	private int exInt2;
	private String exVar2;
	public int getAmcId() {
		return amcId;
	}
	public void setAmcId(int amcId) {
		this.amcId = amcId;
	}
	public int getAssetId() {
		return assetId;
	}
	public void setAssetId(int assetId) {
		this.assetId = assetId;
	}
	public String getAmcFrDate() {
		return amcFrDate;
	}
	public void setAmcFrDate(String amcFrDate) {
		this.amcFrDate = amcFrDate;
	}
	public String getAmcToDate() {
		return amcToDate;
	}
	public void setAmcToDate(String amcToDate) {
		this.amcToDate = amcToDate;
	}
	public float getAmcAmt() {
		return amcAmt;
	}
	public void setAmcAmt(float amcAmt) {
		this.amcAmt = amcAmt;
	}
	public String getPositiveRemark() {
		return positiveRemark;
	}
	public void setPositiveRemark(String positiveRemark) {
		this.positiveRemark = positiveRemark;
	}
	public String getNegativeRemark() {
		return negativeRemark;
	}
	public void setNegativeRemark(String negativeRemark) {
		this.negativeRemark = negativeRemark;
	}
	public int getVendorId() {
		return vendorId;
	}
	public void setVendorId(int vendorId) {
		this.vendorId = vendorId;
	}
		
	public int getAmcStatus() {
		return amcStatus;
	}
	public void setAmcStatus(int amcStatus) {
		this.amcStatus = amcStatus;
	}
	
	public String getTermAndCondi() {
		return termAndCondi;
	}
	public void setTermAndCondi(String termAndCondi) {
		this.termAndCondi = termAndCondi;
	}
	public String getAmcDocFile() {
		return amcDocFile;
	}
	public void setAmcDocFile(String amcDocFile) {
		this.amcDocFile = amcDocFile;
	}
	public int getMakerUserId() {
		return makerUserId;
	}
	public void setMakerUserId(int makerUserId) {
		this.makerUserId = makerUserId;
	}
	public String getUpdateDatetime() {
		return updateDatetime;
	}
	public void setUpdateDatetime(String updateDatetime) {
		this.updateDatetime = updateDatetime;
	}
	public int getDelStatus() {
		return delStatus;
	}
	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}
	public int getExInt1() {
		return exInt1;
	}
	public void setExInt1(int exInt1) {
		this.exInt1 = exInt1;
	}
	public String getExVar1() {
		return exVar1;
	}
	public void setExVar1(String exVar1) {
		this.exVar1 = exVar1;
	}
	public int getExInt2() {
		return exInt2;
	}
	public void setExInt2(int exInt2) {
		this.exInt2 = exInt2;
	}
	public String getExVar2() {
		return exVar2;
	}
	public void setExVar2(String exVar2) {
		this.exVar2 = exVar2;
	}
	@Override
	public String toString() {
		return "AssetAmc [amcId=" + amcId + ", assetId=" + assetId + ", amcFrDate=" + amcFrDate + ", amcToDate="
				+ amcToDate + ", amcAmt=" + amcAmt + ", positiveRemark=" + positiveRemark + ", negativeRemark="
				+ negativeRemark + ", vendorId=" + vendorId + ", amcStatus=" + amcStatus + ", termAndCondi="
				+ termAndCondi + ", amcDocFile=" + amcDocFile + ", makerUserId=" + makerUserId + ", updateDatetime="
				+ updateDatetime + ", delStatus=" + delStatus + ", exInt1=" + exInt1 + ", exVar1=" + exVar1
				+ ", exInt2=" + exInt2 + ", exVar2=" + exVar2 + "]";
	}
	
}

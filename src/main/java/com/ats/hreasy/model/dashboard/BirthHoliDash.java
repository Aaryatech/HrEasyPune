package com.ats.hreasy.model.dashboard;

import java.util.List;

import com.ats.hreasy.model.HolidayMaster;

 
public class BirthHoliDash {
	
	
	private List<HolidayMaster> holiList;
	
	
	private List<GetBirthDaysForDash> birthListUpcoming;
	
	
	private List<GetBirthDaysForDash> birthListToday;


	public List<HolidayMaster> getHoliList() {
		return holiList;
	}


	public void setHoliList(List<HolidayMaster> holiList) {
		this.holiList = holiList;
	}


	 

	public List<GetBirthDaysForDash> getBirthListUpcoming() {
		return birthListUpcoming;
	}


	public void setBirthListUpcoming(List<GetBirthDaysForDash> birthListUpcoming) {
		this.birthListUpcoming = birthListUpcoming;
	}


	public List<GetBirthDaysForDash> getBirthListToday() {
		return birthListToday;
	}


	public void setBirthListToday(List<GetBirthDaysForDash> birthListToday) {
		this.birthListToday = birthListToday;
	}


	@Override
	public String toString() {
		return "BirthHoliDash [holiList=" + holiList + ", birthListUpcoming=" + birthListUpcoming + ", birthListToday="
				+ birthListToday + "]";
	}
	
	



}

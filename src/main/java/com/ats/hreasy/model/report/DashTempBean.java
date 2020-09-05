package com.ats.hreasy.model.report;

import java.util.List;

public class DashTempBean {

	List<HodDashboard> hodDashList;
	
	List<HodDeptDashb> hodDeptList;

	public List<HodDashboard> getHodDashList() {
		return hodDashList;
	}

	public void setHodDashList(List<HodDashboard> hodDashList) {
		this.hodDashList = hodDashList;
	}

	public List<HodDeptDashb> getHodDeptList() {
		return hodDeptList;
	}

	public void setHodDeptList(List<HodDeptDashb> hodDeptList) {
		this.hodDeptList = hodDeptList;
	}

	@Override
	public String toString() {
		return "DashTempBean [hodDashList=" + hodDashList + ", hodDeptList=" + hodDeptList + "]";
	}

	
	
	
}

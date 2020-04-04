package com.ats.hreasy.model.dashboard;

import java.util.List;

import com.ats.hreasy.model.SummaryDailyAttendance;

public class CommonDash {

	
	
	private BirthHoliDash birth;
	
	
	private GetNewHiresDash newHire;
	
	
	private LeavePenDash lvDet;
	
	
	private PreDayAttnDash attnDet;
	
	
	private GetAllPendingMasterDet masterDet;
	
	private List<DeptWiseWeekoffDash> deptwiseWkoff;
	
	
	private List<DeptWiseWeekoffDash> perfListDept;
	
	
	private List<GetLeaveHistForDash> lvApplList;
	private List<DeptWiseWeekoffDash> deptWiseLvAbLList;//*
	
	
	private List<DeptWiseWeekoffDash> deptWiseEmpCntList;
	
	
	private GetNewHiresDash ageDiv;
	
	
	private PayRewardDedDash rewardDet;
	
	private AgeDiversityDash ageDiversity;
	
	private AgeDiversityDash expDiversity;
	
	
	private AgeDiversityDash salDiversity;
	
	
	private PayRewardDedDash dedDet;//*
	
	
	private LoanAdvDashDet advDet;
	
	
	private LoanAdvDashDet loanDet;
	
	
	private PerformanceProdDash perfList;
	
	
	private PerformanceProdDash prodList;
	
	
	private IncentivesAmtDash icent;
	
	
	private List<DeptWiseWeekoffDash> rewardWiseDedList;
	
	
	private List<DeptWiseWeekoffDash> dedWiseDedList;
	
	
	
	private SummaryDailyAttendance attnLastMon;



	
	
	public List<GetLeaveHistForDash> getLvApplList() {
		return lvApplList;
	}



	public void setLvApplList(List<GetLeaveHistForDash> lvApplList) {
		this.lvApplList = lvApplList;
	}



	public PayRewardDedDash getRewardDet() {
		return rewardDet;
	}



	public void setRewardDet(PayRewardDedDash rewardDet) {
		this.rewardDet = rewardDet;
	}



	public BirthHoliDash getBirth() {
		return birth;
	}



	public void setBirth(BirthHoliDash birth) {
		this.birth = birth;
	}



	public GetNewHiresDash getNewHire() {
		return newHire;
	}



	public void setNewHire(GetNewHiresDash newHire) {
		this.newHire = newHire;
	}



	public LeavePenDash getLvDet() {
		return lvDet;
	}



	public void setLvDet(LeavePenDash lvDet) {
		this.lvDet = lvDet;
	}



	public PreDayAttnDash getAttnDet() {
		return attnDet;
	}



	public void setAttnDet(PreDayAttnDash attnDet) {
		this.attnDet = attnDet;
	}



	public GetAllPendingMasterDet getMasterDet() {
		return masterDet;
	}



	public void setMasterDet(GetAllPendingMasterDet masterDet) {
		this.masterDet = masterDet;
	}



	public List<DeptWiseWeekoffDash> getDeptwiseWkoff() {
		return deptwiseWkoff;
	}



	public void setDeptwiseWkoff(List<DeptWiseWeekoffDash> deptwiseWkoff) {
		this.deptwiseWkoff = deptwiseWkoff;
	}



	public List<DeptWiseWeekoffDash> getPerfListDept() {
		return perfListDept;
	}



	public void setPerfListDept(List<DeptWiseWeekoffDash> perfListDept) {
		this.perfListDept = perfListDept;
	}



	public List<DeptWiseWeekoffDash> getDeptWiseLvAbLList() {
		return deptWiseLvAbLList;
	}



	public void setDeptWiseLvAbLList(List<DeptWiseWeekoffDash> deptWiseLvAbLList) {
		this.deptWiseLvAbLList = deptWiseLvAbLList;
	}



	public List<DeptWiseWeekoffDash> getDeptWiseEmpCntList() {
		return deptWiseEmpCntList;
	}



	public void setDeptWiseEmpCntList(List<DeptWiseWeekoffDash> deptWiseEmpCntList) {
		this.deptWiseEmpCntList = deptWiseEmpCntList;
	}



	public GetNewHiresDash getAgeDiv() {
		return ageDiv;
	}



	public void setAgeDiv(GetNewHiresDash ageDiv) {
		this.ageDiv = ageDiv;
	}



	public AgeDiversityDash getAgeDiversity() {
		return ageDiversity;
	}



	public void setAgeDiversity(AgeDiversityDash ageDiversity) {
		this.ageDiversity = ageDiversity;
	}



	public AgeDiversityDash getExpDiversity() {
		return expDiversity;
	}



	public void setExpDiversity(AgeDiversityDash expDiversity) {
		this.expDiversity = expDiversity;
	}



	public AgeDiversityDash getSalDiversity() {
		return salDiversity;
	}



	public void setSalDiversity(AgeDiversityDash salDiversity) {
		this.salDiversity = salDiversity;
	}



	public PayRewardDedDash getDedDet() {
		return dedDet;
	}



	public void setDedDet(PayRewardDedDash dedDet) {
		this.dedDet = dedDet;
	}



	public LoanAdvDashDet getAdvDet() {
		return advDet;
	}



	public void setAdvDet(LoanAdvDashDet advDet) {
		this.advDet = advDet;
	}



	public LoanAdvDashDet getLoanDet() {
		return loanDet;
	}



	public void setLoanDet(LoanAdvDashDet loanDet) {
		this.loanDet = loanDet;
	}



	public PerformanceProdDash getPerfList() {
		return perfList;
	}



	public void setPerfList(PerformanceProdDash perfList) {
		this.perfList = perfList;
	}



	public PerformanceProdDash getProdList() {
		return prodList;
	}



	public void setProdList(PerformanceProdDash prodList) {
		this.prodList = prodList;
	}



	public IncentivesAmtDash getIcent() {
		return icent;
	}



	public void setIcent(IncentivesAmtDash icent) {
		this.icent = icent;
	}



	public List<DeptWiseWeekoffDash> getRewardWiseDedList() {
		return rewardWiseDedList;
	}



	public void setRewardWiseDedList(List<DeptWiseWeekoffDash> rewardWiseDedList) {
		this.rewardWiseDedList = rewardWiseDedList;
	}



	public List<DeptWiseWeekoffDash> getDedWiseDedList() {
		return dedWiseDedList;
	}



	public void setDedWiseDedList(List<DeptWiseWeekoffDash> dedWiseDedList) {
		this.dedWiseDedList = dedWiseDedList;
	}



	public SummaryDailyAttendance getAttnLastMon() {
		return attnLastMon;
	}



	public void setAttnLastMon(SummaryDailyAttendance attnLastMon) {
		this.attnLastMon = attnLastMon;
	}



	@Override
	public String toString() {
		return "CommonDash [birth=" + birth + ", newHire=" + newHire + ", lvDet=" + lvDet + ", attnDet=" + attnDet
				+ ", masterDet=" + masterDet + ", deptwiseWkoff=" + deptwiseWkoff + ", perfListDept=" + perfListDept
				+ ", lvApplList=" + lvApplList + ", deptWiseLvAbLList=" + deptWiseLvAbLList + ", deptWiseEmpCntList="
				+ deptWiseEmpCntList + ", ageDiv=" + ageDiv + ", rewardDet=" + rewardDet + ", ageDiversity="
				+ ageDiversity + ", expDiversity=" + expDiversity + ", salDiversity=" + salDiversity + ", dedDet="
				+ dedDet + ", advDet=" + advDet + ", loanDet=" + loanDet + ", perfList=" + perfList + ", prodList="
				+ prodList + ", icent=" + icent + ", rewardWiseDedList=" + rewardWiseDedList + ", dedWiseDedList="
				+ dedWiseDedList + ", attnLastMon=" + attnLastMon + "]";
	}


 
 
	
	 
}

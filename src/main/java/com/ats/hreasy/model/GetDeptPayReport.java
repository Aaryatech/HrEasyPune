package com.ats.hreasy.model;

import java.util.List;
 

public class GetDeptPayReport {
	
	private int id; 
	private String departName;
	private int departId;  
	private int calcMonth;
	private int calcYear;
	private int salTypeId; 
	private double basicCal;
	private double performanceBonus;
	private double otWages;
	private double miscExpAdd;
	private double bonusCal;
	private double exgretiaCal;
	private double daArreasCal;
	private double incrementArreasCal;
	private double epfWages;
	private double epfWagesEmployer;
	private double esicWagesCal;
	private double grossSalary;
	private double epsWages;
	private double esicWagesDec;
	private float employeePf;
	private double employerEps;
	private double employerPf;
	private float esic;
	private double employerEsic; 
	private double mlwf;
	private double tds;
	private double itded;
	private double fund;
	private double totPfAdminCh;
	private double totEdliCh;
	private double totEdliAdminCh;
	private int ncpDays; 
	private double ptDed;
	private double advanceDed;
	private double loanDed;
	private double miscExpDed;
	private int miscExpDedDeduct;
	private double netSalary; 
	private double payDed; 
	private double societyContribution; 
	private double basicDefault;
	private double abDeduction; 
	private double productionInsentive; 
	private double presentInsentive;
	private double nightAllow; 
	private double grossSalDefault;
	private double adjustMinus;
	private double adjustPlus;
	private double reward;
	private double bhatta;
	private double other1;
	private double leaveEncashAmt;
	
	private List<SalAllownceCal> payrollAllownceList;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDepartName() {
		return departName;
	}

	public void setDepartName(String departName) {
		this.departName = departName;
	}

	public int getDepartId() {
		return departId;
	}

	public void setDepartId(int departId) {
		this.departId = departId;
	}

	public int getCalcMonth() {
		return calcMonth;
	}

	public void setCalcMonth(int calcMonth) {
		this.calcMonth = calcMonth;
	}

	public int getCalcYear() {
		return calcYear;
	}

	public void setCalcYear(int calcYear) {
		this.calcYear = calcYear;
	}

	public int getSalTypeId() {
		return salTypeId;
	}

	public void setSalTypeId(int salTypeId) {
		this.salTypeId = salTypeId;
	}

	public double getBasicCal() {
		return basicCal;
	}

	public void setBasicCal(double basicCal) {
		this.basicCal = basicCal;
	}

	public double getPerformanceBonus() {
		return performanceBonus;
	}

	public void setPerformanceBonus(double performanceBonus) {
		this.performanceBonus = performanceBonus;
	}

	public double getOtWages() {
		return otWages;
	}

	public void setOtWages(double otWages) {
		this.otWages = otWages;
	}

	public double getMiscExpAdd() {
		return miscExpAdd;
	}

	public void setMiscExpAdd(double miscExpAdd) {
		this.miscExpAdd = miscExpAdd;
	}

	public double getBonusCal() {
		return bonusCal;
	}

	public void setBonusCal(double bonusCal) {
		this.bonusCal = bonusCal;
	}

	public double getExgretiaCal() {
		return exgretiaCal;
	}

	public void setExgretiaCal(double exgretiaCal) {
		this.exgretiaCal = exgretiaCal;
	}

	public double getDaArreasCal() {
		return daArreasCal;
	}

	public void setDaArreasCal(double daArreasCal) {
		this.daArreasCal = daArreasCal;
	}

	public double getIncrementArreasCal() {
		return incrementArreasCal;
	}

	public void setIncrementArreasCal(double incrementArreasCal) {
		this.incrementArreasCal = incrementArreasCal;
	}

	public double getEpfWages() {
		return epfWages;
	}

	public void setEpfWages(double epfWages) {
		this.epfWages = epfWages;
	}

	public double getEpfWagesEmployer() {
		return epfWagesEmployer;
	}

	public void setEpfWagesEmployer(double epfWagesEmployer) {
		this.epfWagesEmployer = epfWagesEmployer;
	}

	public double getEsicWagesCal() {
		return esicWagesCal;
	}

	public void setEsicWagesCal(double esicWagesCal) {
		this.esicWagesCal = esicWagesCal;
	}

	public double getGrossSalary() {
		return grossSalary;
	}

	public void setGrossSalary(double grossSalary) {
		this.grossSalary = grossSalary;
	}

	public double getEpsWages() {
		return epsWages;
	}

	public void setEpsWages(double epsWages) {
		this.epsWages = epsWages;
	}

	public double getEsicWagesDec() {
		return esicWagesDec;
	}

	public void setEsicWagesDec(double esicWagesDec) {
		this.esicWagesDec = esicWagesDec;
	}

	public float getEmployeePf() {
		return employeePf;
	}

	public void setEmployeePf(float employeePf) {
		this.employeePf = employeePf;
	}

	public double getEmployerEps() {
		return employerEps;
	}

	public void setEmployerEps(double employerEps) {
		this.employerEps = employerEps;
	}

	public double getEmployerPf() {
		return employerPf;
	}

	public void setEmployerPf(double employerPf) {
		this.employerPf = employerPf;
	}

	public float getEsic() {
		return esic;
	}

	public void setEsic(float esic) {
		this.esic = esic;
	}

	public double getEmployerEsic() {
		return employerEsic;
	}

	public void setEmployerEsic(double employerEsic) {
		this.employerEsic = employerEsic;
	}

	public double getMlwf() {
		return mlwf;
	}

	public void setMlwf(double mlwf) {
		this.mlwf = mlwf;
	}

	public double getTds() {
		return tds;
	}

	public void setTds(double tds) {
		this.tds = tds;
	}

	public double getItded() {
		return itded;
	}

	public void setItded(double itded) {
		this.itded = itded;
	}

	public double getFund() {
		return fund;
	}

	public void setFund(double fund) {
		this.fund = fund;
	}

	public double getTotPfAdminCh() {
		return totPfAdminCh;
	}

	public void setTotPfAdminCh(double totPfAdminCh) {
		this.totPfAdminCh = totPfAdminCh;
	}

	public double getTotEdliCh() {
		return totEdliCh;
	}

	public void setTotEdliCh(double totEdliCh) {
		this.totEdliCh = totEdliCh;
	}

	public double getTotEdliAdminCh() {
		return totEdliAdminCh;
	}

	public void setTotEdliAdminCh(double totEdliAdminCh) {
		this.totEdliAdminCh = totEdliAdminCh;
	}

	public int getNcpDays() {
		return ncpDays;
	}

	public void setNcpDays(int ncpDays) {
		this.ncpDays = ncpDays;
	}

	public double getPtDed() {
		return ptDed;
	}

	public void setPtDed(double ptDed) {
		this.ptDed = ptDed;
	}

	public double getAdvanceDed() {
		return advanceDed;
	}

	public void setAdvanceDed(double advanceDed) {
		this.advanceDed = advanceDed;
	}

	public double getLoanDed() {
		return loanDed;
	}

	public void setLoanDed(double loanDed) {
		this.loanDed = loanDed;
	}

	public double getMiscExpDed() {
		return miscExpDed;
	}

	public void setMiscExpDed(double miscExpDed) {
		this.miscExpDed = miscExpDed;
	}

	public int getMiscExpDedDeduct() {
		return miscExpDedDeduct;
	}

	public void setMiscExpDedDeduct(int miscExpDedDeduct) {
		this.miscExpDedDeduct = miscExpDedDeduct;
	}

	public double getNetSalary() {
		return netSalary;
	}

	public void setNetSalary(double netSalary) {
		this.netSalary = netSalary;
	}

	public double getPayDed() {
		return payDed;
	}

	public void setPayDed(double payDed) {
		this.payDed = payDed;
	}

	public double getSocietyContribution() {
		return societyContribution;
	}

	public void setSocietyContribution(double societyContribution) {
		this.societyContribution = societyContribution;
	}

	public double getBasicDefault() {
		return basicDefault;
	}

	public void setBasicDefault(double basicDefault) {
		this.basicDefault = basicDefault;
	}

	public double getAbDeduction() {
		return abDeduction;
	}

	public void setAbDeduction(double abDeduction) {
		this.abDeduction = abDeduction;
	}

	public double getProductionInsentive() {
		return productionInsentive;
	}

	public void setProductionInsentive(double productionInsentive) {
		this.productionInsentive = productionInsentive;
	}

	public double getPresentInsentive() {
		return presentInsentive;
	}

	public void setPresentInsentive(double presentInsentive) {
		this.presentInsentive = presentInsentive;
	}

	public double getNightAllow() {
		return nightAllow;
	}

	public void setNightAllow(double nightAllow) {
		this.nightAllow = nightAllow;
	}

	public double getGrossSalDefault() {
		return grossSalDefault;
	}

	public void setGrossSalDefault(double grossSalDefault) {
		this.grossSalDefault = grossSalDefault;
	}

	public double getAdjustMinus() {
		return adjustMinus;
	}

	public void setAdjustMinus(double adjustMinus) {
		this.adjustMinus = adjustMinus;
	}

	public double getAdjustPlus() {
		return adjustPlus;
	}

	public void setAdjustPlus(double adjustPlus) {
		this.adjustPlus = adjustPlus;
	}

	public double getReward() {
		return reward;
	}

	public void setReward(double reward) {
		this.reward = reward;
	}

	public double getBhatta() {
		return bhatta;
	}

	public void setBhatta(double bhatta) {
		this.bhatta = bhatta;
	}

	public double getOther1() {
		return other1;
	}

	public void setOther1(double other1) {
		this.other1 = other1;
	}

	public List<SalAllownceCal> getPayrollAllownceList() {
		return payrollAllownceList;
	}

	public void setPayrollAllownceList(List<SalAllownceCal> payrollAllownceList) {
		this.payrollAllownceList = payrollAllownceList;
	}

	public double getLeaveEncashAmt() {
		return leaveEncashAmt;
	}

	public void setLeaveEncashAmt(double leaveEncashAmt) {
		this.leaveEncashAmt = leaveEncashAmt;
	}

	@Override
	public String toString() {
		return "GetDeptPayReport [id=" + id + ", departName=" + departName + ", departId=" + departId + ", calcMonth="
				+ calcMonth + ", calcYear=" + calcYear + ", salTypeId=" + salTypeId + ", basicCal=" + basicCal
				+ ", performanceBonus=" + performanceBonus + ", otWages=" + otWages + ", miscExpAdd=" + miscExpAdd
				+ ", bonusCal=" + bonusCal + ", exgretiaCal=" + exgretiaCal + ", daArreasCal=" + daArreasCal
				+ ", incrementArreasCal=" + incrementArreasCal + ", epfWages=" + epfWages + ", epfWagesEmployer="
				+ epfWagesEmployer + ", esicWagesCal=" + esicWagesCal + ", grossSalary=" + grossSalary + ", epsWages="
				+ epsWages + ", esicWagesDec=" + esicWagesDec + ", employeePf=" + employeePf + ", employerEps="
				+ employerEps + ", employerPf=" + employerPf + ", esic=" + esic + ", employerEsic=" + employerEsic
				+ ", mlwf=" + mlwf + ", tds=" + tds + ", itded=" + itded + ", fund=" + fund + ", totPfAdminCh="
				+ totPfAdminCh + ", totEdliCh=" + totEdliCh + ", totEdliAdminCh=" + totEdliAdminCh + ", ncpDays="
				+ ncpDays + ", ptDed=" + ptDed + ", advanceDed=" + advanceDed + ", loanDed=" + loanDed + ", miscExpDed="
				+ miscExpDed + ", miscExpDedDeduct=" + miscExpDedDeduct + ", netSalary=" + netSalary + ", payDed="
				+ payDed + ", societyContribution=" + societyContribution + ", basicDefault=" + basicDefault
				+ ", abDeduction=" + abDeduction + ", productionInsentive=" + productionInsentive
				+ ", presentInsentive=" + presentInsentive + ", nightAllow=" + nightAllow + ", grossSalDefault="
				+ grossSalDefault + ", adjustMinus=" + adjustMinus + ", adjustPlus=" + adjustPlus + ", reward=" + reward
				+ ", bhatta=" + bhatta + ", other1=" + other1 + ", leaveEncashAmt=" + leaveEncashAmt
				+ ", payrollAllownceList=" + payrollAllownceList + "]";
	}
	
	

}

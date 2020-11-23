package com.ats.hreasy.model;

import java.util.List;
 
public class GetPayrollGeneratedListForArear {

	private int id;
	private int cmpId;
	private int empId;
	private String empCode;
	private int empType;
	private int contractorId;
	private int departId;
	private int designationId;
	private int locationId;
	private int calcMonth;
	private int calcYear;
	private int salTypeId;
	private int attSumId;
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
	private int esicStatus;
	private int pfStatus;
	private double mlwf;
	private double tds;
	private double itded;
	private double fund;
	private double totPfAdminCh;
	private double totEdliCh;
	private double totEdliAdminCh;
	private int ncpDays;
	private int status;
	private double ptDed;
	private double advanceDed;
	private double loanDed;
	private double miscExpDed;
	private int miscExpDedDeduct;
	private double netSalary;
	private String isLocked;
	private String loginName;
	private String loginTime;
	private String mlwfApplicable;
	private String ptApplicable;
	private double payDed;
	private String commentsForItBonus;
	private double societyContribution;
	private String empCategory;
	private double basicDefault;
	private double abDeduction;
	private double epfPercentage;
	private double epsEmployeePercentage;
	private double productionInsentive;
	private double epfEmployerPercentage;
	private double epsEmployerPercentage;
	private double presentInsentive;
	private double nightAllow;
	private double epsDefault;
	private double epmloyerEpfDefault;
	private double epmloyerEpfExtra;
	private double pfAdminChPercentage;
	private double edliPercentage;
	private double edliAdminPercentage;
	private double employerEsicPercentage;
	private double employeeEsicPercentage;
	private double employerMlwf;
	private double grossSalDefault;
	private double adjustMinus;
	private double adjustPlus;
	private double reward;
	private double bhatta;
	private double other1;
	
	private int subCmpId;

	private String name;
	private String empTypeName;
	private String departName;
	private String designName;

	private float payableDays;
	private float presentDays;
	private float weeklyOff;
	private float paidHoliday;
	private float paidLeave;
	private float unpaidLeave;
	private float absentDays;

	private String dailyHr;
	private String monthlyHrTarget;
	private String monthlyMinimumTarget;
	private String monthlyOtHr;
	private int totalDaysInmonth;
	private float workingDays;
	private float totworkingHrs;
	private String email;
	private double grossSalaryDytemp; 
	private double esicArear;
	private double pfArear;
	private double basicCalArear;
	List<SalAllownceCal> payrollAllownceList;
  
	List<AllowanceWithDifferenceForArear> difAlloList;
 
	private double salBasicDiff;
	 
	private double salTotalDiff;
	
	public double getBasicCalArear() {
		return basicCalArear;
	}

	public void setBasicCalArear(double basicCalArear) {
		this.basicCalArear = basicCalArear;
	}
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCmpId() {
		return cmpId;
	}

	public void setCmpId(int cmpId) {
		this.cmpId = cmpId;
	}

	public int getEmpId() {
		return empId;
	}

	public void setEmpId(int empId) {
		this.empId = empId;
	}

	public String getEmpCode() {
		return empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}

	public int getEmpType() {
		return empType;
	}

	public void setEmpType(int empType) {
		this.empType = empType;
	}

	public int getContractorId() {
		return contractorId;
	}

	public void setContractorId(int contractorId) {
		this.contractorId = contractorId;
	}

	public int getDepartId() {
		return departId;
	}

	public void setDepartId(int departId) {
		this.departId = departId;
	}

	public int getDesignationId() {
		return designationId;
	}

	public void setDesignationId(int designationId) {
		this.designationId = designationId;
	}

	public int getLocationId() {
		return locationId;
	}

	public void setLocationId(int locationId) {
		this.locationId = locationId;
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

	public int getAttSumId() {
		return attSumId;
	}

	public void setAttSumId(int attSumId) {
		this.attSumId = attSumId;
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

	public int getEsicStatus() {
		return esicStatus;
	}

	public void setEsicStatus(int esicStatus) {
		this.esicStatus = esicStatus;
	}

	public int getPfStatus() {
		return pfStatus;
	}

	public void setPfStatus(int pfStatus) {
		this.pfStatus = pfStatus;
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

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
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

	public String getIsLocked() {
		return isLocked;
	}

	public void setIsLocked(String isLocked) {
		this.isLocked = isLocked;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getLoginTime() {
		return loginTime;
	}

	public void setLoginTime(String loginTime) {
		this.loginTime = loginTime;
	}

	public String getMlwfApplicable() {
		return mlwfApplicable;
	}

	public void setMlwfApplicable(String mlwfApplicable) {
		this.mlwfApplicable = mlwfApplicable;
	}

	public String getPtApplicable() {
		return ptApplicable;
	}

	public void setPtApplicable(String ptApplicable) {
		this.ptApplicable = ptApplicable;
	}

	public double getPayDed() {
		return payDed;
	}

	public void setPayDed(double payDed) {
		this.payDed = payDed;
	}

	public String getCommentsForItBonus() {
		return commentsForItBonus;
	}

	public void setCommentsForItBonus(String commentsForItBonus) {
		this.commentsForItBonus = commentsForItBonus;
	}

	public double getSocietyContribution() {
		return societyContribution;
	}

	public void setSocietyContribution(double societyContribution) {
		this.societyContribution = societyContribution;
	}

	public String getEmpCategory() {
		return empCategory;
	}

	public void setEmpCategory(String empCategory) {
		this.empCategory = empCategory;
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

	public double getEpfPercentage() {
		return epfPercentage;
	}

	public void setEpfPercentage(double epfPercentage) {
		this.epfPercentage = epfPercentage;
	}

	public double getEpsEmployeePercentage() {
		return epsEmployeePercentage;
	}

	public void setEpsEmployeePercentage(double epsEmployeePercentage) {
		this.epsEmployeePercentage = epsEmployeePercentage;
	}

	public double getProductionInsentive() {
		return productionInsentive;
	}

	public void setProductionInsentive(double productionInsentive) {
		this.productionInsentive = productionInsentive;
	}

	public double getEpfEmployerPercentage() {
		return epfEmployerPercentage;
	}

	public void setEpfEmployerPercentage(double epfEmployerPercentage) {
		this.epfEmployerPercentage = epfEmployerPercentage;
	}

	public double getEpsEmployerPercentage() {
		return epsEmployerPercentage;
	}

	public void setEpsEmployerPercentage(double epsEmployerPercentage) {
		this.epsEmployerPercentage = epsEmployerPercentage;
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

	public double getEpsDefault() {
		return epsDefault;
	}

	public void setEpsDefault(double epsDefault) {
		this.epsDefault = epsDefault;
	}

	public double getEpmloyerEpfDefault() {
		return epmloyerEpfDefault;
	}

	public void setEpmloyerEpfDefault(double epmloyerEpfDefault) {
		this.epmloyerEpfDefault = epmloyerEpfDefault;
	}

	public double getEpmloyerEpfExtra() {
		return epmloyerEpfExtra;
	}

	public void setEpmloyerEpfExtra(double epmloyerEpfExtra) {
		this.epmloyerEpfExtra = epmloyerEpfExtra;
	}

	public double getPfAdminChPercentage() {
		return pfAdminChPercentage;
	}

	public void setPfAdminChPercentage(double pfAdminChPercentage) {
		this.pfAdminChPercentage = pfAdminChPercentage;
	}

	public double getEdliPercentage() {
		return edliPercentage;
	}

	public void setEdliPercentage(double edliPercentage) {
		this.edliPercentage = edliPercentage;
	}

	public double getEdliAdminPercentage() {
		return edliAdminPercentage;
	}

	public void setEdliAdminPercentage(double edliAdminPercentage) {
		this.edliAdminPercentage = edliAdminPercentage;
	}

	public double getEmployerEsicPercentage() {
		return employerEsicPercentage;
	}

	public void setEmployerEsicPercentage(double employerEsicPercentage) {
		this.employerEsicPercentage = employerEsicPercentage;
	}

	public double getEmployeeEsicPercentage() {
		return employeeEsicPercentage;
	}

	public void setEmployeeEsicPercentage(double employeeEsicPercentage) {
		this.employeeEsicPercentage = employeeEsicPercentage;
	}

	public double getEmployerMlwf() {
		return employerMlwf;
	}

	public void setEmployerMlwf(double employerMlwf) {
		this.employerMlwf = employerMlwf;
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

	public int getSubCmpId() {
		return subCmpId;
	}

	public void setSubCmpId(int subCmpId) {
		this.subCmpId = subCmpId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmpTypeName() {
		return empTypeName;
	}

	public void setEmpTypeName(String empTypeName) {
		this.empTypeName = empTypeName;
	}

	public String getDepartName() {
		return departName;
	}

	public void setDepartName(String departName) {
		this.departName = departName;
	}

	public String getDesignName() {
		return designName;
	}

	public void setDesignName(String designName) {
		this.designName = designName;
	}

	public float getPayableDays() {
		return payableDays;
	}

	public void setPayableDays(float payableDays) {
		this.payableDays = payableDays;
	}

	public float getPresentDays() {
		return presentDays;
	}

	public void setPresentDays(float presentDays) {
		this.presentDays = presentDays;
	}

	public float getWeeklyOff() {
		return weeklyOff;
	}

	public void setWeeklyOff(float weeklyOff) {
		this.weeklyOff = weeklyOff;
	}

	public float getPaidHoliday() {
		return paidHoliday;
	}

	public void setPaidHoliday(float paidHoliday) {
		this.paidHoliday = paidHoliday;
	}

	public float getPaidLeave() {
		return paidLeave;
	}

	public void setPaidLeave(float paidLeave) {
		this.paidLeave = paidLeave;
	}

	public float getUnpaidLeave() {
		return unpaidLeave;
	}

	public void setUnpaidLeave(float unpaidLeave) {
		this.unpaidLeave = unpaidLeave;
	}

	public float getAbsentDays() {
		return absentDays;
	}

	public void setAbsentDays(float absentDays) {
		this.absentDays = absentDays;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public List<SalAllownceCal> getPayrollAllownceList() {
		return payrollAllownceList;
	}

	public void setPayrollAllownceList(List<SalAllownceCal> payrollAllownceList) {
		this.payrollAllownceList = payrollAllownceList;
	}

	public List<AllowanceWithDifferenceForArear> getDifAlloList() {
		return difAlloList;
	}

	public void setDifAlloList(List<AllowanceWithDifferenceForArear> difAlloList) {
		this.difAlloList = difAlloList;
	}

	public double getSalBasicDiff() {
		return salBasicDiff;
	}

	public void setSalBasicDiff(double salBasicDiff) {
		this.salBasicDiff = salBasicDiff;
	}

	public double getSalTotalDiff() {
		return salTotalDiff;
	}

	public void setSalTotalDiff(double salTotalDiff) {
		this.salTotalDiff = salTotalDiff;
	}

	public String getDailyHr() {
		return dailyHr;
	}

	public void setDailyHr(String dailyHr) {
		this.dailyHr = dailyHr;
	}

	public String getMonthlyHrTarget() {
		return monthlyHrTarget;
	}

	public void setMonthlyHrTarget(String monthlyHrTarget) {
		this.monthlyHrTarget = monthlyHrTarget;
	}

	public String getMonthlyMinimumTarget() {
		return monthlyMinimumTarget;
	}

	public void setMonthlyMinimumTarget(String monthlyMinimumTarget) {
		this.monthlyMinimumTarget = monthlyMinimumTarget;
	}

	public String getMonthlyOtHr() {
		return monthlyOtHr;
	}

	public void setMonthlyOtHr(String monthlyOtHr) {
		this.monthlyOtHr = monthlyOtHr;
	}

	public int getTotalDaysInmonth() {
		return totalDaysInmonth;
	}

	public void setTotalDaysInmonth(int totalDaysInmonth) {
		this.totalDaysInmonth = totalDaysInmonth;
	}

	public float getWorkingDays() {
		return workingDays;
	}

	public void setWorkingDays(float workingDays) {
		this.workingDays = workingDays;
	}

	public float getTotworkingHrs() {
		return totworkingHrs;
	}

	public void setTotworkingHrs(float totworkingHrs) {
		this.totworkingHrs = totworkingHrs;
	}

	public double getGrossSalaryDytemp() {
		return grossSalaryDytemp;
	}

	public void setGrossSalaryDytemp(double grossSalaryDytemp) {
		this.grossSalaryDytemp = grossSalaryDytemp;
	}
 
	public double getEsicArear() {
		return esicArear;
	}

	public void setEsicArear(double esicArear) {
		this.esicArear = esicArear;
	}

	public double getPfArear() {
		return pfArear;
	}

	public void setPfArear(double pfArear) {
		this.pfArear = pfArear;
	}

	@Override
	public String toString() {
		return "GetPayrollGeneratedListForArear [id=" + id + ", cmpId=" + cmpId + ", empId=" + empId + ", empCode="
				+ empCode + ", empType=" + empType + ", contractorId=" + contractorId + ", departId=" + departId
				+ ", designationId=" + designationId + ", locationId=" + locationId + ", calcMonth=" + calcMonth
				+ ", calcYear=" + calcYear + ", salTypeId=" + salTypeId + ", attSumId=" + attSumId + ", basicCal="
				+ basicCal + ", performanceBonus=" + performanceBonus + ", otWages=" + otWages + ", miscExpAdd="
				+ miscExpAdd + ", bonusCal=" + bonusCal + ", exgretiaCal=" + exgretiaCal + ", daArreasCal="
				+ daArreasCal + ", incrementArreasCal=" + incrementArreasCal + ", epfWages=" + epfWages
				+ ", epfWagesEmployer=" + epfWagesEmployer + ", esicWagesCal=" + esicWagesCal + ", grossSalary="
				+ grossSalary + ", epsWages=" + epsWages + ", esicWagesDec=" + esicWagesDec + ", employeePf="
				+ employeePf + ", employerEps=" + employerEps + ", employerPf=" + employerPf + ", esic=" + esic
				+ ", employerEsic=" + employerEsic + ", esicStatus=" + esicStatus + ", pfStatus=" + pfStatus + ", mlwf="
				+ mlwf + ", tds=" + tds + ", itded=" + itded + ", fund=" + fund + ", totPfAdminCh=" + totPfAdminCh
				+ ", totEdliCh=" + totEdliCh + ", totEdliAdminCh=" + totEdliAdminCh + ", ncpDays=" + ncpDays
				+ ", status=" + status + ", ptDed=" + ptDed + ", advanceDed=" + advanceDed + ", loanDed=" + loanDed
				+ ", miscExpDed=" + miscExpDed + ", miscExpDedDeduct=" + miscExpDedDeduct + ", netSalary=" + netSalary
				+ ", isLocked=" + isLocked + ", loginName=" + loginName + ", loginTime=" + loginTime
				+ ", mlwfApplicable=" + mlwfApplicable + ", ptApplicable=" + ptApplicable + ", payDed=" + payDed
				+ ", commentsForItBonus=" + commentsForItBonus + ", societyContribution=" + societyContribution
				+ ", empCategory=" + empCategory + ", basicDefault=" + basicDefault + ", abDeduction=" + abDeduction
				+ ", epfPercentage=" + epfPercentage + ", epsEmployeePercentage=" + epsEmployeePercentage
				+ ", productionInsentive=" + productionInsentive + ", epfEmployerPercentage=" + epfEmployerPercentage
				+ ", epsEmployerPercentage=" + epsEmployerPercentage + ", presentInsentive=" + presentInsentive
				+ ", nightAllow=" + nightAllow + ", epsDefault=" + epsDefault + ", epmloyerEpfDefault="
				+ epmloyerEpfDefault + ", epmloyerEpfExtra=" + epmloyerEpfExtra + ", pfAdminChPercentage="
				+ pfAdminChPercentage + ", edliPercentage=" + edliPercentage + ", edliAdminPercentage="
				+ edliAdminPercentage + ", employerEsicPercentage=" + employerEsicPercentage
				+ ", employeeEsicPercentage=" + employeeEsicPercentage + ", employerMlwf=" + employerMlwf
				+ ", grossSalDefault=" + grossSalDefault + ", adjustMinus=" + adjustMinus + ", adjustPlus=" + adjustPlus
				+ ", reward=" + reward + ", bhatta=" + bhatta + ", other1=" + other1 + ", subCmpId=" + subCmpId
				+ ", name=" + name + ", empTypeName=" + empTypeName + ", departName=" + departName + ", designName="
				+ designName + ", payableDays=" + payableDays + ", presentDays=" + presentDays + ", weeklyOff="
				+ weeklyOff + ", paidHoliday=" + paidHoliday + ", paidLeave=" + paidLeave + ", unpaidLeave="
				+ unpaidLeave + ", absentDays=" + absentDays + ", dailyHr=" + dailyHr + ", monthlyHrTarget="
				+ monthlyHrTarget + ", monthlyMinimumTarget=" + monthlyMinimumTarget + ", monthlyOtHr=" + monthlyOtHr
				+ ", totalDaysInmonth=" + totalDaysInmonth + ", workingDays=" + workingDays + ", totworkingHrs="
				+ totworkingHrs + ", email=" + email + ", grossSalaryDytemp=" + grossSalaryDytemp + ", esicArear="
				+ esicArear + ", pfArear=" + pfArear + ", basicCalArear=" + basicCalArear + ", payrollAllownceList="
				+ payrollAllownceList + ", difAlloList=" + difAlloList + ", salBasicDiff=" + salBasicDiff
				+ ", salTotalDiff=" + salTotalDiff + "]";
	}
}

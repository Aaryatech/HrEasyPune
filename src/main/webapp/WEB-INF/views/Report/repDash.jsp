<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>


<c:url var="empInfoHistoryList" value="/empInfoHistoryList" />
<style type="text/css">
.dataTables_wrapper {
	margin-left: 15px;
	margin-right: 15px;
}
</style>
<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-datepicker.css"
	type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-datepicker.js"></script>
</head>
<!-- <link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css"> -->
<body>

	<!-- Main navbar -->
	<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
	<!-- /main navbar -->


	<!-- Page content -->
	<div class="page-content">

		<!-- Main sidebar -->
		<jsp:include page="/WEB-INF/views/include/left.jsp"></jsp:include>
		<!-- /main sidebar -->


		<!-- Main content -->
		<div class="content-wrapper">

			<!-- Page header -->
			<!-- <div class="page-header page-header-light">


				<div
					class="breadcrumb-line breadcrumb-line-light header-elements-md-inline">
					<div class="d-flex">
						<div class="breadcrumb">
							<a href="index.html" class="breadcrumb-item"><i
								class="icon-home2 mr-2"></i> Home</a> <span
								class="breadcrumb-item active">Dashboard</span>
						</div>

						<a href="javascript:void(0)" class="header-elements-toggle text-default d-md-none"><i
							class="icon-more"></i></a>
					</div>
				</div>
			</div> -->
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">


				<!-- Highlighting rows and columns -->
				<div class="card">
					<div class="card-body">
						<div class="card-header header-elements-inline">
							<h3 class="pageTitle">
								<i class="icon-list-unordered"></i> Report
							</h3>
						</div>



						<!-- Extra large table -->

						<!-- <div class="card-header header-elements-inline">
							<h5 class="card-title">Reports</h5>
							<div class="header-elements">
								<div class="list-icons"></div>
							</div>
						</div>
 -->




						<div class="card-body">

							<form method="post" id="reportForm">

								<div class="form-group row">

									<div class="col-md-6">
										<label class="col-form-label text-info col-lg-5 float"
											for="date">Select Date(F1) <span style="color: red">*
										</span> :
										</label>
										<div class="col-md-7 float">
											<input type="text" class="form-control datepicker"
												placeholder="Select Date " id="datepicker" name="date"
												value="${date}" autocomplete="off"> <span
												class="validation-invalid-label" id="error_datepicker"
												style="display: none;">Please Select Date. </span>
										</div>
									</div>
									<div class="col-md-6">
										<label class="col-form-label text-info col-lg-5 float ">Date
											Range(F2)<span style="color: red">* </span>:
										</label>
										<div class="col-lg-7 float">
											<input type="text" class="form-control daterange-basic_new "
												name="leaveDateRange" data-placeholder="Select Date"
												id="leaveDateRange"> <span
												class="validation-invalid-label" id="error_DateRange"
												style="display: none;">Please Select Date.</span>

										</div>




									</div>

								</div>


								<div class="form-group row">
									<div class="col-md-6">
										<label class="col-form-label col-lg-5 float" for="date">Select
											Company(F3): </label>
										<div class="col-md-7 float">
											<select name="subCmpId" data-placeholder="Select Sub Company"
												id="subCmpId" class="form-control form-control-select2 ">
												<option value="">Select Company</option>
												<c:forEach items="${companySubList}" var="companySubList">
													<option value="${companySubList.companyId}">${companySubList.companyName}</option>

												</c:forEach>
											</select> <span class="validation-invalid-label" id="error_company"
												style="display: none;">Please Select Company.</span>
										</div>
									</div>
									<div class="col-md-6">
										<label class="col-form-label col-lg-5 float" for="date">Select
											Date(F4): </label>
										<div class="col-md-7 float">
											<input type="text" class="form-control datepickerclass"
												name="singleDateRange" data-placeholder="Select Date"
												id="singleDateRange"> <span
												class="validation-invalid-label" id="error_SingleDate"
												style="display: none;">Please Select Date.</span>
										</div>
									</div>
								</div>



								<div class="row">

									<div class="col-sm-12 col-md-6">
										<div class="card">
											<div
												class="card-header bg-primary text-white header-elements-inline">
												<h6 class="box_title" style="margin: 0;">Advance
													Reports</h6>
												<div class="header-elements"></div>
											</div>

											<div class="advance_bx">
												<ul>
													<li>Employee Advance Payment (F1) <span> <a
															href="javascript:void(0)"
															onclick="getProgReport('f1',0,'showAdvancePaymentRep')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f1',1,'showAdvancePaymentRep')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger  text-danger    "
																style="color: black;"></i></a>
													</span></li>
													<li>Employee Advance Deduct Report (F1) <span>
															<a href="javascript:void(0)"
															onclick="getProgReport('f1',0,'showAdvanceDeudctionReport')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f1',1,'showAdvanceDeudctionReport')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger  text-danger    "
																style="color: black;"></i></a>
													</span></li>
													<li>Yearly Advance Amount(F1) <span> <a
															href="javascript:void(0)"
															onclick="getProgReport('f1',0,'showAdvancePaymentYearlyRep')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f1',1,'showAdvancePaymentYearlyRep')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger  text-danger   "
																style="color: black;"></i></a>
													</span>
													</li>

													<li>Employee Advance Skip Report (F1) <span> <a
															href="javascript:void(0)"
															onclick="getProgReport('f1',0,'showAdvanceSkipRep')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f1',1,'showAdvanceSkipRep')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger  text-danger  "
																style="color: black;"></i></a>
													</span></li>

												</ul>
											</div>


										</div>
									</div>

									<div class="col-sm-12 col-md-6">
										<div class="card">
											<div
												class="card-header bg-primary text-white header-elements-inline">
												<h6 class="box_title" style="margin: 0;">Attendance
													Reports</h6>
												<div class="header-elements"></div>
											</div>

											<div class="advance_bx">
												<ul>
													<li>Attendance Register(F1) <span><a
															href="javascript:void(0)"
															onclick="getProgReport('f1',0,'showEmpAttendRegisterRep')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f1',1,'showEmpAttendRegisterRep')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger  text-danger   "
																style="color: black;"></i></a></span>
													</li>

													<li>Monthly Attendance Summary(F2) <span><a
															href="javascript:void(0)"
															onclick="getProgReport('f2',0,'showMonthlyAttndanceSummary')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f2',1,'showMonthlyAttndanceSummary')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger    "
																style="color: black;"></i></a></span>
													</li>

													<li>Daily Attendance Summary(F4) <span><a
															href="javascript:void(0)"
															onclick="getProgReport('f4',0,'showEmpAttendanceRep')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f4',1,'showEmpAttendanceRep')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger  text-danger    "
																style="color: black;"></i></a></span>
													</li>

													<li>Employee Production Incentive(F2) <span><a
															href="javascript:void(0)"
															onclick="getProgReport('f2',0,'showEmpOtReg')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f2',1,'showEmpOtReg')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger    "
																style="color: black;"></i></a></span>
													</li>

													<li>Employee Production Incentive Details(F2) <span><a
															href="javascript:void(0)"
															onclick="getProgReport('f2',0,'showEmpOtRegDetail')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f2',1,'showEmpOtRegDetail')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger    "
																style="color: black;"></i></a></span>
													</li>

													<li>Employee Late Mark Summary(F2) <span><a
															href="javascript:void(0)"
															onclick="getProgReport('f2',0,'showEmpLateMark')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f2',1,'showEmpLateMark')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger    "
																style="color: black;"></i></a></span>
													</li>

													<li>Employee Late Mark Detail(F2) <span><a
															href="javascript:void(0)"
															onclick="getProgReport('f2',0,'showEmpLateMarkDetail')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f2',1,'showEmpLateMarkDetail')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger    "
																style="color: black;"></i></a></span>
													</li>
												</ul>
											</div>

										</div>
									</div>




									<div class="col-sm-12 col-md-6">
										<div class="card">
											<div
												class="card-header bg-primary text-white header-elements-inline">
												<h6 class="box_title" style="margin: 0;">Loan Reports</h6>
												<div class="header-elements"></div>
											</div>

											<div class="advance_bx">
												<ul>
													<li>Loan Deduction Report(F1) <span><a
															href="javascript:void(0)"
															onclick="getProgReport('f1',0,'showLoanDedRep')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f1',1,'showLoanDedRep')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger    "
																style="color: black;"></i></a></span>
													</li>
													<li>Loan Ledger Report(F2) <span><a
															href="javascript:void(0)"
															onclick="getProgReport('f2',0,'showLoanLedgerReort')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f2',1,'showLoanLedgerReort')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger    "
																style="color: black;"></i></a></span>
													</li>
													<li>Pending Loan Details <span><a
															href="javascript:void(0)"
															onclick="getProgReport('f2',0,'showPendingLoanRep')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f2',1,'showPendingLoanRep')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger    "
																style="color: black;"></i></a></span>
													</li>




												</ul>
											</div>
										</div>
									</div>


									<div class="col-sm-12 col-md-6">
										<div class="card">
											<div
												class="card-header bg-primary text-white header-elements-inline">
												<h6 class="box_title" style="margin: 0;">PF Statement</h6>
												<div class="header-elements"></div>
											</div>

											<div class="advance_bx">
												<ul>
													<li>Employee PF Statement(F2,F3) <span><a
															href="javascript:void(0)"
															onclick="getProgReport('f3',0,'showEmpPfRep')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f3',1,'showEmpPfRep')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger    "
																style="color: black;"></i></a></span>
													</li>

													<li>Employer PF Statement(F2,F3) <span><a
															href="javascript:void(0)"
															onclick="getProgReport('f3',0,'showEmployerPfRep')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f3',1,'showEmployerPfRep')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger    "
																style="color: black;"></i></a></span>
													</li>

													<li>Employee Employer PF Statement(F2,F3) <span><a
															href="javascript:void(0)"
															onclick="getProgReport('f3',0,'showEmployeeEmployerPfRep')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f3',1,'showEmployeeEmployerPfRep')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger    "
																style="color: black;"></i></a></span>
													</li>


												</ul>
											</div>
										</div>
									</div>



									<div class="col-sm-12 col-md-6">
										<div class="card">
											<div
												class="card-header bg-primary text-white header-elements-inline">
												<h6 class="box_title" style="margin: 0;">PT Reports</h6>
												<div class="header-elements"></div>
											</div>

											<div class="advance_bx">
												<ul>
													<li>PT Challen Statement (F2,F3) <span><a
															href="javascript:void(0)"
															onclick="getProgReport('f3',0,'getPtChallanRep')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f3',1,'getPtChallanRep')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger    "
																style="color: black;"></i></a></span>
													</li>

													<!-- <li>Professional Tax Statement(F2,F3) <span><a
															href="javascript:void(0)"
															onclick="getProgReport('f3',0,'showEmpPTStatRep')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f3',1,'showEmpPTStatRep')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger    "
																style="color: black;"></i></a></span>
													</li>

													<li>MLWF Statement(F2,F3) <span><a href="javascript:void(0)"
															onclick="getProgReport('f3',0,'showMlwfStatRep')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f3',1,'showMlwfStatRep')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger    "
																style="color: black;"></i></a></span>
													</li> -->
												</ul>
											</div>


										</div>
									</div>


									<div class="col-sm-12 col-md-6">
										<div class="card">
											<div
												class="card-header bg-primary text-white header-elements-inline">
												<h6 class="box_title" style="margin: 0;">ESIC Reports</h6>
												<div class="header-elements"></div>
											</div>

											<div class="advance_bx">
												<ul>
													<li>Statutory ESIC Statement (F2,F3) <span><a
															href="javascript:void(0)"
															onclick="getProgReport('f3',0,'showStatutoryEsicRep')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f3',1,'showStatutoryEsicRep')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger    "
																style="color: black;"></i></a></span>
													</li>

													<li>Professional Tax Statement (F2,F3) <span><a
															href="javascript:void(0)"
															onclick="getProgReport('f3',0,'showEmpPTStatRep')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f3',1,'showEmpPTStatRep')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger    "
																style="color: black;"></i></a></span>
													</li>

													<li>MLWF Statement (F2,F3) <span><a
															href="javascript:void(0)"
															onclick="getProgReport('f3',0,'showMlwfStatRep')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f3',1,'showMlwfStatRep')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger    "
																style="color: black;"></i></a></span>
													</li>

													<li>ESIC Statement(F2,F3) <span><a
															href="javascript:void(0)"
															onclick="getProgReport('f3',0,'showEsiSummaryRep')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f3',1,'showEsiSummaryRep')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger    "
																style="color: black;"></i></a></span>
													</li>

													<li>Employee Payment Deduction(F2) <span><a
															href="javascript:void(0)"
															onclick="getProgReport('f2',0,'showEmpDedRepAll')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f2',1,'showEmpDedRepAll')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger    "
																style="color: black;"></i></a></span>
													</li>
												</ul>
											</div>

										</div>
									</div>



									<div class="col-sm-12 col-md-6">
										<div class="card">
											<div
												class="card-header bg-primary text-white header-elements-inline">
												<h6 class="box_title" style="margin: 0;">Bonus &
													Exgratia Reports</h6>
												<div class="header-elements"></div>
											</div>

											<div class="advance_bx">
												<ul>
													<li style="border-bottom: none;">

														<div class="divid_2">
															<div class="divid_2_l">
																<label class="col-form-label text-info" for="bonusId">Bonus(F4):
																</label>
															</div>
															<div class="divid_2_r">
																<select name="bonusId" data-placeholder="Select Bonus"
																	id="bonusId" class="form-control form-control-select2 ">
																	<option value="">Select Bonus</option>
																	<c:forEach items="${bonusList}" var="bonusList">
																		<option value="${bonusList.bonusId}">${bonusList.fyTitle}</option>

																	</c:forEach>
																</select>
															</div>

															<div class="clr"></div>
														</div>

													</li>

													<li>Employee Bonus Details(F4) <span><a
															href="javascript:void(0)"
															onclick="getProgReport('f4',0,'showBonusRep')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f4',1,'showBonusRep')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger    "
																style="color: black;"></i></a></span>
													</li>

													<li>Employee Exgratia Details(F4) <span><a
															href="javascript:void(0)"
															onclick="getProgReport('f4',0,'showExgratiaRep')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f4',1,'showExgratiaRep')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger    "
																style="color: black;"></i></a></span>
													</li>


												</ul>
											</div>


										</div>
									</div>


									<div class="col-sm-12 col-md-6">
										<div class="card">
											<div
												class="card-header bg-primary text-white header-elements-inline">
												<h6 class="box_title" style="margin: 0;">Leave Reports</h6>
												<div class="header-elements"></div>
											</div>
											<div class="advance_bx">
												<ul>
													<li style="border-bottom: none;">

														<div class="divid_2">
															<div class="divid_2_l">
																<label class="col-form-label text-info" for="calYrId">Select
																	Year(F5): </label>
															</div>
															<div class="divid_2_r">
																<select name="calYrId"
																	data-placeholder="Select Calender Year" id="calYrId"
																	class="form-control form-control-select2 ">
																	<option value="">Select</option>
																	<c:forEach items="${calYearList}" var="calYear">
																		<option value="${calYear.calYrId}">${calYear.calYrFromDate}
																			to ${calYear.calYrToDate}</option>
																	</c:forEach>
																</select>
															</div>
															<input type="hidden" id="empId1" name="empId1" value="-1">

															<div class="clr"></div>
														</div>

													</li>

													<li>Leave History (F5) <span><a
															href="javascript:void(0)"
															onclick="getProgReport('f5',0,'showEmpLeaveHistoryRepNew')"
															title="excel"><i
																class="icon-file-spreadsheet text-success text-success"
																style="color: black;"></i></a> <a href="javascript:void(0)"
															onclick="getProgReport('f5',1,'showEmpLeaveHistoryRepNew')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger  text-danger  "
																style="color: black;"></i></a></span>
													</li>

												</ul>
											</div>

										</div>
									</div>


								</div>
								<input type="hidden" id="cal_yr" name="cal_yr" value="0">

								<input type="hidden" id="p" name="p" value="0"> <input
									type="hidden" id="emp_name" name="emp_name" value="0">
							</form>
						</div>


						<!-- /extra large table -->





					</div>

				</div>
				<!-- /highlighting rows and columns -->

			</div>
			<!-- /content area -->


			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
			<!-- /footer -->

		</div>
		<!-- /main content -->

	</div>



	<script type="text/javascript">
		//use this function for all reports just get mapping form action name dynamically as like of prm from every report pdf,excel function	
		function getProgReport(filteroption, prm, mapping) {
			var error = false;

			if (filteroption == "f1") {
				var x = document.getElementById("datepicker").value;
				if (x.length == 0) {
					error = true;
					$("#error_datepicker").show();

				} else {
					//	alert(0);
					$("#error_datepicker").hide();
				}
			}
			if (filteroption == "f2") {
				var x = document.getElementById("leaveDateRange").value;
				if (x.length == 0) {
					error = true;
					$("#error_DateRange").show();

				} else {
					//	alert(0);
					$("#error_DateRange").hide();
				}
			}
			if (filteroption == "f3") {
				var x = document.getElementById("subCmpId").value;
				if (x.length == 0) {
					error = true;
					$("#error_company").show();

				} else {
					//	alert(0);
					$("#error_company").hide();
				}
			}
			if (filteroption == "f4") {
				var x = document.getElementById("singleDateRange").value;
				if (x.length == 0) {
					error = true;
					$("#error_SingleDate").show();

				} else {
					//	alert(0);
					$("#error_SingleDate").hide();
				}
			}
			if (error) {
				return false
			}
			//alert(x);
			if (prm == 1) {

				document.getElementById("p").value = "1";
			}

			if ($("#calYrId").length > 0) {
				var elm = document.getElementById('calYrId');
				var text = elm.options[elm.selectedIndex].innerHTML;
				document.getElementById("cal_yr").value = text;
			}

			var form = document.getElementById("reportForm");

			form.setAttribute("target", "_blank");
			form.setAttribute("method", "get");
			form.action = ("${pageContext.request.contextPath}/" + mapping + "/");
			form.submit();
			document.getElementById("p").value = "0";

		}
	</script>

	<script type="text/javascript">
		// Single picker
		/* $("#datepicker").datepicker({
			changeMonth : true,
			changeYear : true,
			yearRange : "-50:+50",
			dateFormat : "mm-yy"
		}); */

		$(document).ready(function() {
			// month selector
			$('#datepicker').datepicker({
				autoclose : true,
				format : "mm-yyyy",
				viewMode : "months",
				minViewMode : "months"

			});

		});
	</script>
	<script type="text/javascript">
		$('.daterange-basic_new').daterangepicker({
			applyClass : 'bg-slate-600',

			cancelClass : 'btn-light',
			locale : {
				format : 'DD-MM-YYYY',
				separator : ' to '
			}
		});
	</script>
	<script>
		//Single picker
		$('.datepickerclass').daterangepicker({
			singleDatePicker : true,
			selectMonths : true,
			selectYears : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});
	</script>



</body>
</html>
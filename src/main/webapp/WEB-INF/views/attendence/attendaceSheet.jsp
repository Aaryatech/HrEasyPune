<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-datepicker.css"
	type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-datepicker.js"></script>

</head>

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
			<div class="page-header page-header-light"></div>
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">


				<!-- Highlighting rows and columns -->
				<div class="card">
					<div class="card-header header-elements-inline">
						<h5 class="pageTitle">
							<i class="icon-list-unordered"></i> Attendance Sheet
						</h5>
						<!-- <div class="header-elements">
							<div class="list-icons">
								<a class="list-icons-item" data-action="collapse"></a>
							</div> 
						</div>-->
					</div>

					<div class="card-body">

						<form action="${pageContext.request.contextPath}/attendaceSheet"
							id="submitInsertLeave" method="get">
							<div class="form-group row">
								<label
									class="col-form-label text-info font-weight-bold col-lg-2"
									for="date">Select Date <span style="color: red">*
								</span> :
								</label>
								<div class="col-md-2">
									<input type="text" class="form-control "
										placeholder="Select Date " id="datepicker" name="date"
										value="${date}" autocomplete="off">
								</div>



								<button type="submit" class="btn blue_btn" id="submtbtn">
									Search <i class="icon-paperplane ml-2"></i>
								</button>

								<!-- <button type="button" class="btn bg-blue ml-3 legitRipple"
									id="submtbtn"
									onclick="getProgReport(0,'exelForEmployeeTypeWiseClaim')">
									Excel <i class="icon-paperplane ml-2"></i>
								</button> -->

							</div>
						</form>
						<div id="loader" style="display: none;">
							<img
								src="${pageContext.request.contextPath}/resources/assets/images/giphy.gif"
								width="150px" height="150px"
								style="display: block; margin-left: auto; margin-right: auto">
						</div>
						<ul class="nav nav-tabs nav-tabs-highlight nav-justified1">
							<li class="nav-item"><a href="#highlighted-justified-tab1"
								class="nav-link active" data-toggle="tab">View Monthly
									Attendance</a></li>
							<li class="nav-item"><a href="#highlighted-justified-tab2"
								class="nav-link" data-toggle="tab">View Summary Attendance </a></li>

						</ul>

						<div class="tab-content">
							<div class="tab-pane fade show active"
								id="highlighted-justified-tab1">
								<div class="table-responsive">
									<!-- <table
										class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
										id="bootstrap-data-table"> -->
									<table class="table datatable-fixed-left_custom" width="100%"
										id="printtable1">
										<thead>
											<tr class="bg-blue">
												<th width="10%" style="text-align: center;">Sr.no</th>
												<th style="text-align: center;">EMP Code</th>
												<th style="text-align: center;">EMP Name</th>
												<th style="text-align: center;">Month</th>
												<th style="text-align: center;">Year</th>
												<c:forEach items="${attendanceSheetData.dateAndDayList}"
													var="dates" varStatus="count">
													<th style="text-align: center;">${count.index+1}<br>${dates.day}</th>
												</c:forEach>
												<th style="text-align: center;">Edit</th>
											</tr>
										</thead>

										<tbody>
											<c:forEach items="${attendanceSheetData.infomationList}"
												var="infomationList" varStatus="count">
												<tr>
													<td>${count.index+1}</td>
													<td style="text-align: center;">${infomationList.empCode}</td>
													<td>${infomationList.empName}</td>
													<td style="text-align: right;">${month}</td>
													<td style="text-align: right;">${year}</td>
													<c:forEach items="${infomationList.sttsList}"
														var="sttsList">
														<td style="text-align: center;"><p
																title="In Time - ${sttsList.inTime}, Out Time - ${sttsList.outTime}, Wotking Hrs - ${sttsList.workingMin}, Production Incentive Min - ${sttsList.otMin}, Late Min - ${sttsList.lateMin}">${sttsList.statusShwo}</p></td>
													</c:forEach>
													<td class="text-center"><c:if
															test="${editAccess == 0}">
															<a
																href="${pageContext.request.contextPath}/attendanceEditEmpMonth?month=${month}&year=${year}&empId=${infomationList.empId}"
																class="list-icons-item text-primary-600"
																data-popup="tooltip" title="" data-original-title="Edit"><i
																class="icon-pencil7"></i></a>
														</c:if></td>
												</tr>
											</c:forEach>

										</tbody>
									</table>
								</div>
							</div>
							<div class="tab-pane fade" id="highlighted-justified-tab2">

								<div class="table-responsive">
									<table
										class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
										id="bootstrap-data-table1">
										<thead>
											<tr class="bg-blue">
												<th width="5%" class="text-center">Sr.no</th>
												<th class="text-center">EMP Code</th>
												<th class="text-center">EMP Name</th>
												<th class="text-center">Working Days</th>
												<th class="text-center">Present Days</th>
												<th class="text-center">Absent Days</th>
												<th class="text-center">Weekly Off</th>
												<th class="text-center">Paid Holiday</th>
												<th class="text-center">Paid Leave</th>
												<th class="text-center">Unpaid Holiday</th>
												<!-- <th class="text-center">Unpaid Leave</th> -->
												<th class="text-center">Late Min</th>
												<th class="text-center">Late Days</th>
												<th class="text-center">Payable Days</th>
												<!-- <th class="text-center">NCP Days</th> -->
												<th class="text-center">Total Hrs</th>
												<th class="text-center">Production Incentive <br>Hrs
												</th>
												<th class="text-center">Attendance Type</th>
											</tr>
										</thead>

										<tbody>
											<c:forEach items="${summrylist}" var="summrylist"
												varStatus="count">
												<tr>
													<td>${count.index+1}</td>
													<td>${summrylist.empCode}</td>
													<td>${summrylist.empName}</td>
													<td class="text-right">${summrylist.workingDays}</td>
													<td class="text-right">${summrylist.presentDays}</td>
													<td class="text-right">${summrylist.absentDays+summrylist.unpaidLeave}</td>
													<td class="text-right">${summrylist.weeklyOff}</td>
													<td class="text-right">${summrylist.paidHoliday}</td>
													<td class="text-right">${summrylist.paidLeave}</td>
													<td class="text-right">${summrylist.unpaidHoliday}</td>
													<%-- <td class="text-right">${summrylist.unpaidLeave}</td> --%>
													<td class="text-right">${summrylist.totlateMins}</td>
													<td class="text-right">${summrylist.totLate}</td>
													<td class="text-right">${summrylist.payableDays}</td>
													<%-- <td class="text-right">${summrylist.ncpDays}</td> --%>
													<td class="text-right">${summrylist.totworkingHrs}</td>
													<td class="text-right">${summrylist.totOthr}</td>
													<td class="text-center">${summrylist.salBasis}</td>
												</tr>
											</c:forEach>

										</tbody>
									</table>
								</div>
							</div>
						</div>

					</div>

				</div>
				<!-- /highlighting rows and columns -->

			</div>
			<!-- /content area -->
			<!-- Content area -->
			<!-- <div class="content">
				Highlighting rows and columns
				<div class="card">
					<div class="card-header header-elements-inline">
						<h5 class="card-title">Attendance Update</h5>

					</div>

					<div class="card-body">

						<div class="form-group row">
							<label class="col-form-label col-lg-2" for="selectUpdateBy">
								Update By : </label>
							<div class="col-lg-2">
								<input type="radio" name="selectUpdateBy" id="byStatus"
									value="1" checked onclick1="openHideDiv(1)">By Status <input
									type="radio" name="selectUpdateBy" id="byIntime" value="2"
									onclick1="openHideDiv(2)">Add Leave

							</div>

						</div>
						<div class="form-group row">
							<label class="col-form-label col-lg-2" for="selectUpdateBy">
								Addddddddd Leave : </label>
							<div class="col-lg-10">
								<div class="">




									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="lvsName">
											Employee Code : </label>
										<div class="col-lg-10">
											<input type="text" class="form-control"
												placeholder="Enter Leave Structure Name" id="empCode"
												value="AD001" name="lvsName" autocomplete="off"
												onchange="trim(this)" readonly="">

										</div>
									</div>
									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="lvsName">
											Employee Name : </label>
										<div class="col-lg-10">
											<input type="text" class="form-control"
												placeholder="Enter Leave Structure Name" id="empName"
												value="AKSHAY MADHUKAR RAOANDORE   " name="lvsName"
												autocomplete="off" onchange="trim(this)" readonly="">

										</div>
									</div>
									<hr>
									<div class="table-responsive">
										<table
											class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
											id="printtable1">


											<thead>
												<tr class="bg-blue" style="text-align: center;">

													<th>Leave Type</th>
													<th>Opening Leave</th>
													<th>Earned</th>
													<th>Approved</th>
													<th>Applied</th>
													<th>Balanced</th>


												</tr>
											</thead>
											<tbody>






												<tr>
													<td>Comp Off</td>
													<td style="text-align: right;">0.0</td>
													<td style="text-align: right;">0.0</td>
													<td style="text-align: right;">0.0</td>
													<td style="text-align: right;">0.0</td>
													<td style="text-align: right;">0.0</td>

												</tr>













												<tr>
													<td>Leave Without Pay</td>
													<td style="text-align: right;">0.0</td>
													<td style="text-align: right;">0.0</td>
													<td style="text-align: right;">0.0</td>
													<td style="text-align: right;">0.0</td>
													<td style="text-align: right;">0.0</td>

												</tr>










												<tr>
													<td>Privilege Leave (Annual Leave)</td>
													<td style="text-align: right;">15.0</td>
													<td style="text-align: right;">17.0</td>
													<td style="text-align: right;">0.0</td>
													<td style="text-align: right;">0.0</td>
													<td style="text-align: right;">32.0</td>

												</tr>










												<tr>
													<td>Sick Leave</td>
													<td style="text-align: right;">0.0</td>
													<td style="text-align: right;">5.0</td>
													<td style="text-align: right;">0.0</td>
													<td style="text-align: right;">0.0</td>
													<td style="text-align: right;">5.0</td>

												</tr>










												<tr>
													<td>Casual Leave</td>
													<td style="text-align: right;">0.0</td>
													<td style="text-align: right;">6.0</td>
													<td style="text-align: right;">0.0</td>
													<td style="text-align: right;">0.0</td>
													<td style="text-align: right;">6.0</td>

												</tr>









											</tbody>
										</table>
									</div>
									<br>
									<form action="/hreasy/insertLeave" id="submitInsertLeave"
										method="post" enctype="multipart/form-data">



										<div class="form-group row">
											<label
												class="col-form-label text-info font-weight-bold col-lg-2"
												for="leaveTypeId">Select Leave Type <span
												style="color: red">* </span>:
											</label>
											<div class="col-lg-4">
												<input type="hidden" name="dayTypeName" value="1"> <select
													name="leaveTypeId" data-placeholder="Select Leave Type"
													id="leaveTypeId"
													class="form-control form-con1trol-select2 select2-1hidden-accessible"
													data-fouc="" aria-hidden="true"
													onchange="checkUnique();checkDatesRange()" tabindex="-1">
													<option></option>





													<option value="1" data-leavestrname="Comp Off">Comp
														Off</option>






												</select><span
													class="select2 select2-container select2-container--default"
													dir="ltr" style="width: 100%;"><span
													class="selection"><span
														class="select2-selection select2-selection--single"
														role="combobox" aria-haspopup="true" aria-expanded="false"
														tabindex="0"
														aria-labelledby="select2-leaveTypeId-container"><span
															class="select2-selection__rendered"
															id="select2-leaveTypeId-container"><span
																class="select2-selection__placeholder">Select
																	Leave Type</span></span><span class="select2-selection__arrow"
															role="presentation"><b role="presentation"></b></span></span></span><span
													class="dropdown-wrapper" aria-hidden="true"></span></span> <span
													class="validation-invalid-label" id="error_leaveTypeId"
													style="display: none;">This field is required.</span>
											</div>



											<div class="col-lg-2">
												<span
													class="select2 select2-container select2-container--default"
													dir="ltr" style="width: 100%;"><span
													class="selection"><span
														class="select2-selection select2-selection--single"
														role="combobox" aria-haspopup="true" aria-expanded="false"
														tabindex="0"
														aria-labelledby="select2-dayTypeName-container"><span
															class="select2-selection__rendered"
															id="select2-dayTypeName-container" title="Full Day">Full
																Day</span><span class="select2-selection__arrow"
															role="presentation"><b role="presentation"></b></span></span></span><span
													class="dropdown-wrapper" aria-hidden="true"></span></span><span
													class="validation-invalid-label" id="error_dayType"
													style="display: none;">This field is required.</span>
											</div>
										</div>






										<div class="form-group row">
											<label
												class="col-form-label text-info font-weight-bold col-lg-2"
												for="lvngReson">Remark<span style="color: red">*
											</span> :
											</label>
											<div class="col-lg-10">
												<textarea rows="3" cols="3" class="form-control"
													placeholder="Remark" onchange="trim(this)" id="leaveRemark"
													name="leaveRemark"> </textarea>
												<span class="validation-invalid-label"
													id="error_leaveRemark" style="display: none;">This
													field is required.</span><span class="validation-invalid-label"
													id="error_leaveRepeatValidation" style="display: none;"></span>
											</div>
										</div>
										<input type="hidden" class="form-control numbersOnly"
											id="empId" value="1" name="empId"> <input
											type="hidden" class="form-control numbersOnly"
											id="tempNoDays" name="tempNoDays" value="0"> <input
											type="hidden" class="form-control numbersOnly" id="lvsId"
											value="1" name="lvsId"> <input type="hidden"
											class="form-control numbersOnly" id="auth" value="1"
											name="auth"> <input type="hidden" id="leaveLimit"
											value="1"> <input type="hidden" id="yearFinalDate"
											value="31-03-2021"> <input type="hidden"
											class="form-control" id="leaveCanApply" value="0"
											name="leaveCanApply"> <input type="hidden"
											class="form-control numbersOnly" id="fileRequired"
											name="fileRequired" value="0"> <input type="hidden"
											class="form-control" id="compoffleavecount" value="0"
											name="compoffleavecount">
										<div class="col-md-12" style="text-align: center;">




											<button type="submit" class="btn bg-blue ml-3 legitRipple"
												id="submtbtn">
												Submit <i class="icon-paperplane ml-2"></i>
											</button>





										</div>
									</form>
								</div>

							</div>

						</div>
						<div id="byStatusDive">
							<div class="form-group row">
								<label class="col-form-label col-lg-2" for="selectStatus">
									Select Status : </label>
								<div class="col-lg-2">
									<select name="selectStatus"
										data-placeholder="Select Leave Type" id="selectStatus"
										class="form-control form-control-select21 select2-hidden-accessible1">
										<option value="0">Select Status</option>


										<option value="22">AB</option>



										<option value="5">P</option>



										<option value="12">WO</option>



										<option value="9">LO</option>



										<option value="7">Compoff</option>



										<option value="8">LS</option>


									</select>
								</div>
								<div class="col-lg-1"></div>
								<label class="col-form-label col-lg-2" for="lateMark">
									Late Mark : </label>
								<div class="col-lg-2">
									<input type="checkbox" class="chk" name="lateMark"
										id="lateMark">
								</div>

							</div>

						</div>

					</div>

				</div>
			</div> -->
			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
			<!-- /footer -->


			<!-- /main content -->

		</div>
		<!-- /page content -->
		<script type="text/javascript">
			// Single picker
			/* $("#datepicker").datepicker({
				changeMonth : true,
				changeYear : true,
				yearRange : "-50:+50",
				dateFormat : "mm-yy"
			}); */

			//daterange-basic_new
			// Basic initialization
			$('.daterange-basic_new').daterangepicker({
				applyClass : 'bg-slate-600',

				cancelClass : 'btn-light',
				locale : {
					format : 'DD-MM-YYYY',
					separator : ' to '
				}
			});
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
			$('.datatable-fixed-left_custom').DataTable({

				columnDefs : [ {

					orderable : false,
					targets : [ 2 ]
				}, {
					width : "50px",
					targets : [ 2 ]
				}, {
					width : "100px",
					targets : [ 0 ]
				}, {
					width : "700px",
					targets : [ 1 ]
				} ],
				scrollX : true,
				//scrollY : '600px',
				scrollCollapse : true,
				paging : false,

				fixedColumns : {
					leftColumns : 3
				}

			});
		</script>
</body>
</html>
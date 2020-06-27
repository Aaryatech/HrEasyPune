<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"
	import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
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

				<!-- Form validation -->
				<div class="row">
					<div class="col-md-12">
						<!-- Title -->
						<!-- <div class="mb-3">
							<h6 class="mb-0 font-weight-semibold">Hidden labels</h6>
							<span class="text-muted d-block">Inputs with empty values</span>
						</div> -->
						<!-- /title -->


						<div class="card">


							<div class="card-header header-elements-inline">
								<h5 class="pageTitle">
									<i class="icon-list-unordered"></i> Assign Route
								</h5>
							</div>

							<div class="card-body">

								<%
									if (session.getAttribute("errorMsg") != null) {
								%>
								<div
									class="alert bg-danger text-white alert-styled-left alert-dismissible">
									<button type="button" class="close" data-dismiss="alert">
										<span>×</span>
									</button>
									<span class="font-weight-semibold">Oh snap!</span>
									<%
										out.println(session.getAttribute("errorMsg"));
									%>
								</div>

								<%
									session.removeAttribute("errorMsg");
									}
								%>
								<%
									if (session.getAttribute("successMsg") != null) {
								%>
								<div
									class="alert bg-success text-white alert-styled-left alert-dismissible">
									<button type="button" class="close" data-dismiss="alert">
										<span>×</span>
									</button>
									<span class="font-weight-semibold">Well done!</span>
									<%
										out.println(session.getAttribute("successMsg"));
									%>
								</div>
								<%
									session.removeAttribute("successMsg");
									}
								%>

								<div class="form-group row">
									<label
										class="col-form-label text-info font-weight-bold col-lg-2"
										for="date">Planning Date <span style="color: red">*
									</span> :
									</label>
									<div class="col-md-2">
										<input type="text" class="form-control datepickerclass"
											placeholder="Select Date " id="datepicker1" name="date"
											value="${date}" autocomplete="off">
									</div>

								</div>
								<hr>

								<div class="form-group row">
									<label class="col-form-label   col-lg-2" for="date">From
										Date : </label>
									<div class="col-md-2">
										<input type="text" class="form-control datepickerclass"
											placeholder="Select Date " id="datepicker1" name="date"
											value="${date}" autocomplete="off">
									</div>
									<label class="col-form-label   col-lg-2" for="date">To
										Date : </label>
									<div class="col-md-2">
										<input type="text" class="form-control datepickerclass"
											placeholder="Select Date " id="datepicker1" name="date"
											value="${date}" autocomplete="off">
									</div>

								</div>

								<div class="form-group row">
									<label class="col-form-label col-lg-2"> Employee Name :
									</label> <label class="col-form-label col-lg-2">Akshay Kasar</label> <label
										class="col-form-label col-lg-1"> Long Route : </label> <label
										class="col-form-label col-lg-1">1</label> <label
										class="col-form-label col-lg-1"> Short Route : </label> <label
										class="col-form-label col-lg-1">0</label> <label
										class="col-form-label col-lg-1"> Off Days : </label> <label
										class="col-form-label col-lg-1">0</label>

								</div>

							</div>
							<hr>


							<div class="card-body">

								<div class="row">
									<div class="col-md-6">


										<div class="table-responsive">
											<!-- <table class="table datatable-scroll-y" width="100%"
											id="printtable1"> -->
											<table
												class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
												width="100%" id="printtable1">
												<thead>
													<tr class="bg-blue">
														<th class="text-center">Driver Name</th>
														<th class="text-center">Select Route</th>
														<th class="text-center">Off Day</th>
													</tr>
												</thead>
												<tbody>

													<tr>
														<td>Akshay Kasar</td>
														<td><select
															name="shiftId${tempFistDayAssignListList.id}"
															data-placeholder="Select Shift"
															id="shiftId${tempFistDayAssignListList.id}"
															class="form-control">

																<option value="1" selected>Aurangabad-Nashik</option>


														</select></td>
														<td class="text-center"><input type="checkbox"></td>
													</tr>
													<tr>
														<td>Sachin Handage</td>
														<td><select
															name="shiftId${tempFistDayAssignListList.id}"
															data-placeholder="Select Route"
															id="shiftId${tempFistDayAssignListList.id}"
															class="form-control">

																<option value="0" selected>Select Route</option>


														</select></td>
														<td class="text-center"><input type="checkbox"></td>
													</tr>


												</tbody>
											</table>
										</div>
										<span class="validation-invalid-label" id="error_table1"
											style="display: none;">Please select one employee.</span>
									</div>

									<div class="col-md-6">

										<div class="table-responsive">
											<!-- <table class="table datatable-scroll-y" width="100%"
											id="printtable2"> -->
											<table
												class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
												width="100%" id="printtable2">
												<thead>
													<tr class="bg-blue">

														<th class="text-center">Date</th>
														<th class="text-center">Route</th>
														<th class="text-center">KM</th>
														<th class="text-center">Incentive</th>
													</tr>
												</thead>
												<tbody>

													<tr>

														<td class="text-center">25-06-2020</td>
														<td class="text-left">Aurangabad-Nashik</td>
														<td class="text-left">200</td>
														<td class="text-left">1000</td>
													</tr>
													<tr>

														<td class="text-center">26-06-2020</td>
														<td class="text-left">Aurangabad-Nashik</td>
														<td class="text-left">200</td>
														<td class="text-left">1000</td>
													</tr>

												</tbody>
											</table>
										</div>
									</div>
								</div>
								<div class="form-group text-center ">
									<input type="submit" class="btn blue_btn" value="Submit"
										id="btnassignstuct">

								</div>
							</div>
						</div>


					</div>
				</div>

			</div>
			<!-- /content area -->
			<!-- Info modal -->
			<div id="modal_step1" class="modal fade " data-backdrop="false"
				tabindex="-1">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header bg-info">
							<h6 class="modal-title">Updating Attendance</h6>
							<!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
						</div>

						<div class="modal-body">
							<h6 class="font-weight-semibold text-center">
								<h6>Please wait.....</h6>
							</h6>

							<hr>
							<p class="text-center text-info">If it is taking time please
								reload the page</p>
						</div>

						<div class="modal-footer">
							<!--   <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button> -->

						</div>
					</div>
				</div>
			</div>

			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
			<!-- /footer -->

		</div>
		<!-- /main content -->

	</div>
	<!-- /page content -->
	<!-- Large modal -->
	<div id="modal_large1" class="modal fade" tabindex="-1">

		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title"></h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<div class="modal-body" id="modalbody">
					<!--  Profile Model -->
					<!--  Profile Model -->
					<!--  Profile Model -->
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
					<!-- <button type="button" class="btn bg-primary">Save changes</button> -->
				</div>
			</div>
		</div>
	</div>
	<!-- /large modal -->
	<script type="text/javascript">
		$('.datepickerclass').daterangepicker({
			singleDatePicker : true,
			selectMonths : true,
			selectYears : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});

		function openHideDiv(value) {

			if (value == 1) {

				document.getElementById("byIntimeDive").style.display = 'none';
				document.getElementById("byStatusDive").style.display = 'block';

			} else {
				document.getElementById("byIntimeDive").style.display = 'block';
				document.getElementById("byStatusDive").style.display = 'none';
			}
		}

		function closeEditDetailTab() {

			document.getElementById("editAttanceDiv").style.display = 'none';
		}

		function editAttendanceDetail(dailyId) {

			var fd = new FormData();
			fd.append('dailyId', dailyId);

			$
					.ajax({
						url : '${pageContext.request.contextPath}/editDailyRecord',
						type : 'post',
						dataType : 'json',
						data : fd,
						contentType : false,
						processData : false,
						success : function(response) {

							document.getElementById("editAttanceDiv").style.display = 'block';
							document.getElementById("byIntimeDive").style.display = 'none';
							document.getElementById("byStatusDive").style.display = 'block';
							document.getElementById("byStatus").checked = true;
							document.getElementById("dailyId").value = response.id;
							document.getElementById("attDate").value = response.attDate;
							document.getElementById("attStatus").value = response.attsSdShow;
							document.getElementById("selectShift").value = response.currentShiftid;

							if (response.otHr.length == 4) {
								document.getElementById("otHours").value = 0 + response.otHr;
							} else {
								document.getElementById("otHours").value = response.otHr;
							}

							document.getElementById("inTime").value = response.inTime
									.substr(0, 5);
							document.getElementById("outTime").value = response.outTime
									.substr(0, 5);

							if (response.lateMark == 1) {
								document.getElementById("lateMark").checked = true;
							} else {
								document.getElementById("lateMark").checked = false;
							}
							document.getElementById("lateMin").value = response.lateMin;
						},
					});

		}

		function markAsCompOff(dailyId, sts) {

			//alert(sts);

			var fd = new FormData();
			fd.append('dailyId', dailyId);
			fd.append('sts', sts);
			$('#modal_step1').modal('show');

			$.ajax({
				url : '${pageContext.request.contextPath}/markAsCompOff',
				type : 'post',
				dataType : 'json',
				data : fd,
				contentType : false,
				processData : false,
				success : function(response) {

					location.reload(true);

				},
			});

		}

		function saveAttendanceDetail() {

			var selectStatus = document.getElementById("selectStatus").value;
			var selectStatusText = $("#newSts" + selectStatus).data("namesd");

			var namesd = $("#selectStatus option:selected").text();
			var otHours = document.getElementById("otHours").value;
			var dailyId = document.getElementById("dailyId").value;
			var inTime = document.getElementById("inTime").value;
			var outTime = document.getElementById("outTime").value;
			var selectShift = document.getElementById("selectShift").value;

			var byStatus = 1;
			var lateMark = 0;
			var month = document.getElementById("month").value;
			var year = document.getElementById("year").value;
			var otApproval = document.getElementById("otApproval").value;

			if (document.getElementById("byIntime").checked == true) {
				byStatus = 2;
			}
			if (document.getElementById("lateMark").checked == true) {
				lateMark = 1;
			}
			var lateMin = document.getElementById("lateMin").value;
			if (lateMin == "") {
				lateMin = 0;
			}

			$('#modal_step1').modal('show');

			var fd = new FormData();
			fd.append('dailyId', dailyId);
			fd.append('otHours', otHours);
			fd.append('selectStatus', selectStatus);
			fd.append('byStatus', byStatus);
			fd.append('lateMark', lateMark);
			fd.append('inTime', inTime);
			fd.append('outTime', outTime);
			fd.append('selectStatusText', selectStatusText);
			fd.append('month', month);
			fd.append('year', year);
			fd.append('selectShift', selectShift);
			fd.append('otApproval', otApproval);
			fd.append('namesd', namesd);
			fd.append('lateMin', lateMin);
			$
					.ajax({
						url : '${pageContext.request.contextPath}/submitAttendanceDetail',
						type : 'post',
						dataType : 'json',
						data : fd,
						contentType : false,
						processData : false,
						success : function(response) {

							location.reload(true);
						},
					});

		}
	</script>
	<script>
		// Custom bootbox dialog
		$('.bootbox_custom')
				.on(
						'click',
						function() {
							var dailyId = $(this).data("dailyid")
							var sts = $(this).data("attstatus") // will return the number 123

							bootbox
									.confirm({
										title : 'Confirm ',
										message : 'Are you sure you want to Mark as Compoff ? you Can not edit attendance again',
										buttons : {
											confirm : {
												label : 'Yes',
												className : 'btn-success'
											},
											cancel : {
												label : 'Cancel',
												className : 'btn-link'
											}
										},
										callback : function(result) {
											if (result) {
												var fd = new FormData();
												fd.append('dailyId', dailyId);
												fd.append('sts', sts);
												$('#modal_step1').modal('show');

												$
														.ajax({
															url : '${pageContext.request.contextPath}/markAsCompOff',
															type : 'post',
															dataType : 'json',
															data : fd,
															contentType : false,
															processData : false,
															success : function(
																	response) {

																location
																		.reload(true);

															},
														});

											}
										}
									});
						});
	</Script>

	<script type="text/javascript">
		function addLeave() {

			var empId = document.getElementById("empId").value;
			var attDate = document.getElementById("attDate").value;
			var month = document.getElementById("month").value;
			var year = document.getElementById("year").value;

			var strhref = "${pageContext.request.contextPath}/addleaveFromAttendance?empId="
					+ empId
					+ "&attDate="
					+ attDate
					+ "&month="
					+ month
					+ "&year=" + year + "&flag=" + 0;
			$("#modalbody").load(strhref);
			$("#modal_large1").modal("show");
			$('#modal_large1').on('hidden.bs.modal', function() {
				$("#modalbody").html("");
			});

			$(document).ready(function() {

			});
		}
	</script>
	<script type="text/javascript">
		$('.datatable-fixed-left_custom').DataTable({

			columnDefs : [ {
				orderable : false,
				targets : [ 0 ]
			} ],
			//scrollX : true,
			scrollX : true,
			scrollY : '65vh',
			scrollCollapse : true,
			paging : false,
			fixedColumns : {
				leftColumns : 0,
				rightColumns : 0
			}

		});
	</script>
</body>
</html>
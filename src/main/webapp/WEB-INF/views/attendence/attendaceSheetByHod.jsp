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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-datepicker.css"
	type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-datepicker.js"></script>
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
									<i class="icon-list-unordered"></i>Employee Attendance Details
									for Security
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
								<form
									action="${pageContext.request.contextPath}/attendaceSheetByHod"
									id="submitInsertLeave" method="get">
									<div class="form-group row">
										<label
											class="col-form-label text-info font-weight-bold col-lg-2"
											for="date">Select Date <span style="color: red">*
										</span> :
										</label>
										<div class="col-md-2">
											<input type="text" class="form-control datepickerclass"
												placeholder="Select Date " id="datepicker1" name="date"
												value="${date}" autocomplete="off">
										</div>



										<button type="submit" class="btn bg-blue ml-3 legitRipple"
											id="submtbtn">
											Search <i class="icon-paperplane ml-2"></i>
										</button>

										<!-- <button type="button" class="btn bg-blue ml-3 legitRipple"
									id="submtbtn"
									onclick="getProgReport(0,'exelForEmployeeTypeWiseClaim')">
									Excel <i class="icon-paperplane ml-2"></i>
								</button> -->

									</div>
								</form>

							</div>


							<div id="editAttanceDiv" style="display: none;">
								<div class="card-header header-elements-inline">
									<h5 class="card-title">Edit Attendance Detail</h5>
								</div>
								<div class="card-body">
									<div class="form-group row">

										<label class="col-form-label col-lg-2" for="attStatus">
											Status : </label>
										<div class="col-lg-2">
											<input type="text" class="form-control" placeholder="Status"
												id="attStatus" name="attStatus" autocomplete="off" disabled>

										</div>
									</div>


									<div id="byStatusDive">
										<div class="form-group row">
											<label class="col-form-label col-lg-1" for="ontime">
												On Time : </label>
											<div class="col-lg-1">
												<input type="checkbox" name="ontime" id="ontime" value="0">
											</div>
											<label class="col-form-label col-lg-1" for="lateMark">
												Late Mark : </label>
											<div class="col-lg-1">
												<input type="checkbox" name="lateMark" id="lateMark">
											</div>



										</div>
										<div id="lateMinDiv" style="display: block;">
											<div class="form-group row">
												<label class="col-form-label col-lg-2" for="lateMin">
													Late Min : </label>
												<div class="col-lg-2">
													<input type="text" class="form-control numbersOnly"
														placeholder="Late Min" id="lateMin" name="lateMin"
														autocomplete="off">

												</div>
											</div>
										</div>
									</div>
									<div id="byIntimeDive" style="display: none;">
										<div class="form-group row">
											<label class="col-form-label col-lg-2" for="inTime">
												In Time : </label>
											<div class="col-lg-2">
												<input type="time" class="form-control"
													placeholder="In Time" id="inTime" name="inTime"
													autocomplete="off">

											</div>
											<div class="col-lg-1"></div>
											<label class="col-form-label col-lg-2" for="outTime">
												Out Time : </label>
											<div class="col-lg-2">
												<input type="time" class="form-control"
													placeholder="Out Time" id="outTime" name="outTime"
													autocomplete="off">

											</div>
										</div>

									</div>



									<div class="col-md-12 text-center">
										<button type="submit" class="btn bg-blue ml-3 legitRipple"
											id="submtbtn" onclick="saveAttendanceDetail()">Save</button>
										<button type="button" class="btn btn-primary"
											onclick="closeEditDetailTab()">Cancel</button>
										<input type="hidden" class="form-control"
											placeholder="Out Time" id="dailyId" name="dailyId"
											autocomplete="off"> <input type="hidden"
											class="form-control" placeholder="Out Time" id="dailyId"
											name="dailyId" autocomplete="off"> <input
											type="hidden" id="year" name="year" value="${year}">
										<input type="hidden" id="month" name="month" value="${month}">
									</div>


								</div>
								<hr>
							</div>
							<div class="card-body">
								<form
									action="${pageContext.request.contextPath}/approveAttendaceBysecurity"
									method="post" id="approveAttendaceBysecurity">
									<div class="table-responsive">


										<table class="table datatable-scroll-y" width="100%"
											id="printtable1">
											<!-- <table
										class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
										id="printtable1"> -->


											<thead>
												<tr class="bg-blue" style="text-align: center;">
													<th width="5%"><input type="checkbox" name="selAll"
														id="selAll" />&nbsp;Sr.no</th>

													<th class="text-center">EMP Code</th>
													<th class="text-center">EMP Name</th>
													<th class="text-center">Department</th>
													<th class="text-center">Status</th>
													<!-- <th class="text-center">In Time</th>
												<th class="text-center">Out Time</th> -->
													<th class="text-center">On Time</th>
													<th class="text-center">Late Mark</th>
													<!-- <th class="text-center">WR. Hrs</th> -->
													<!-- <th class="text-center">OT Hrs</th> -->
													<!-- <th class="text-center">OShift/Loc</th> -->
													<!-- <th class="text-center">Action</th> -->

												</tr>
											</thead>
											<tbody>
												<c:forEach items="${dailyDailyList}" var="dailyrecordList"
													varStatus="count">
													<tr>
														<td><input type="checkbox"
															id="id${dailyrecordList.id}"
															value="${dailyrecordList.id}"
															data-empcode="${dailyrecordList.empCode}"
															data-name="${dailyrecordList.empName}" name="ids"
															class="chk"
															data-statusshow="${dailyrecordList.attStatus}"
															data-showsd="${dailyrecordList.attsSdShow}"
															data-statusidshow="${dailyrecordList.lvSumupId}"
															data-latemarkshow="${dailyrecordList.lateMark}"
															data-lateminshow="${dailyrecordList.lateMin}"
															class="select_all">&nbsp;${count.index+1}</td>

														<td class="text-center">${dailyrecordList.empCode}</td>
														<td>${dailyrecordList.empName}</td>
														<td>${dailyrecordList.empJson}</td>
														<c:choose>
															<c:when
																test="${dailyrecordList.attStatus eq 'WO' || dailyrecordList.attStatus eq 'PH'}">
																<td class="text-center"
																	style="background-color: #FFA8A8">${dailyrecordList.attStatus}</td>
															</c:when>
															<c:otherwise>
																<td class="text-center">${dailyrecordList.attsSdShow}</td>
															</c:otherwise>
														</c:choose>

														<td class="text-center"><input type="checkbox"
															id="ontime${dailyrecordList.id}"
															name="ontime${dailyrecordList.id}" value="0"></td>

														<td class="text-center"><input type="checkbox"
															id="lateMark${dailyrecordList.id}"
															name="lateMark${dailyrecordList.id}"
															onclick="latemindivhideshow(${dailyrecordList.id})"
															value="0"><br>
															<div id="lateMinDiv${dailyrecordList.id}"
																style="display: none;">
																<input type="text" class="form-control numbersOnly"
																	placeholder="Late Min"
																	id="lateMin${dailyrecordList.id}"
																	name="lateMin${dailyrecordList.id}" autocomplete="off">
															</div></td>

													</tr>
												</c:forEach>




											</tbody>
										</table>
										<span class="validation-invalid-label" id="error_table1"
											style="display: none;">Please select one employee.</span> <br>
									</div>
									<div class="form-group text-center ">
										<input type="submit" class="btn blue_btn" value="Approve"
											id="btnassignstuct">

									</div>
								</form>
							</div>

						</div>


					</div>
				</div>

			</div>
			<!-- /content area -->


			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
			<!-- /footer -->

		</div>
		<!-- /main content -->
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
		function openHideDiv(value) {

			if (value == 1) {

				document.getElementById("byIntimeDive").style.display = 'none';
				document.getElementById("byStatusDive").style.display = 'block';

			} else {
				document.getElementById("byIntimeDive").style.display = 'block';
				document.getElementById("byStatusDive").style.display = 'none';
			}
		}
		function latemindivhideshow(value) {

			if (document.getElementById("lateMark"+value).checked == true) {
				document.getElementById("lateMark"+value).value = 1;
				document.getElementById("lateMinDiv"+value).style.display = 'block';
				
				document.getElementById("ontime"+value).checked = false;
				document.getElementById("ontime"+value).value = 0;
				document.getElementById("ontime"+value).disabled = true;

			} else {
				document.getElementById("lateMinDiv"+value).style.display = 'none';
				document.getElementById("lateMark"+value).value = 0;
				
				 
				document.getElementById("ontime"+value).disabled = false;
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

							document.getElementById("attStatus").value = response.attStatus;

							document.getElementById("dailyId").value = response.id;

							if (response.lateMark == 1) {
								document.getElementById("lateMark").checked = true;
								document.getElementById("lateMark").value = 1;
								document.getElementById("lateMinDiv").style.display = 'block';
								document.getElementById("lateMin").value = response.lateMin;
							} else {
								document.getElementById("lateMark").checked = false;
								document.getElementById("lateMark").value = 0;
								document.getElementById("lateMinDiv").style.display = 'none';
								document.getElementById("lateMin").value = 0;
							}

							if (response.lateMark == 0
									&& response.attStatus == "P") {
								document.getElementById("ontime").checked = true;
							} else {
								document.getElementById("ontime").checked = false;
							}

						},
					});

		}

		function saveAttendanceDetail() {

			var dailyId = document.getElementById("dailyId").value;
			var selectStatus = 5;
			var selectStatusText = "P";
			var ontime = 0;
			if (document.getElementById("ontime").checked == true) {
				ontime = 1;
			}

			var lateMark = 0;
			if (document.getElementById("lateMark").checked == true) {
				lateMark = 1;
			}
			var lateMin = document.getElementById("lateMin").value;
			var isError = 0;

			if (lateMark == 1 && lateMin <= 0) {

				alert("Enter Late Min");
				isError = 1;
			}

			if (ontime == 0 && lateMark == 0) {
				selectStatus = 22;
				selectStatusText = "AB";
				lateMin = 0;
			}

			var flag = 0;
			var otHours = 0;

			if (isError == 0) {

				var fd = new FormData();
				fd.append('dailyId', dailyId);
				fd.append('selectStatus', selectStatus);
				fd.append('lateMark', lateMark);
				fd.append('selectStatusText', selectStatusText);
				fd.append('flag', flag);
				fd.append('otHours', otHours);
				fd.append('lateMin', lateMin);
				$('#modal_step1').modal('show');

				$
						.ajax({
							url : '${pageContext.request.contextPath}/submitAttendanceDetailByHod',
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
		}
		$('.datepickerclass').daterangepicker({
			singleDatePicker : true,
			selectMonths : true,
			selectYears : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});
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
		$(document).ready(
				function() {
					//	$('#printtable').DataTable();

					$("#selAll").click(
							function() {
								$('#printtable1 tbody input[type="checkbox"]')
										.prop('checked', this.checked);
							});
				});

		$(document)
				.ready(
						function($) {

							$("#approveAttendaceBysecurity")

									.submit(
											function(e) {

												var table = $('#printtable1')
														.DataTable();
												table.search("").draw();
												var isError = 0;
												$("#error_table1").hide();

												var checkedVals = $(
														'.chk:checkbox:checked')
														.map(function() {
															return this.value;
														}).get();
												checkedVals = checkedVals
														.join(',');

												if (checkedVals == '') {
													$("#error_table1").show();
													return false;
												}

											 

													$("#table_grid1 tbody")
															.empty();
													$("#table_grid2 tbody")
													.empty();
													$("#table_grid3 tbody")
													.empty();
													$("#table_grid4 tbody")
													.empty();
													$("#table_grid5 tbody")
													.empty();
													$("#table_grid6 tbody")
													.empty();
													 

													var onTimeCount=0;
													var lateMarkCount=0;
													var absentNaCount=0;
													var leaveCount=0;
													var weeklyCount=0;
													var paidHolidayCount=0;
													
													$('.chk:checkbox:checked')
															.each(
																	function(i) {
																		var val = $(
																				this)
																				.val();

																		if (val != 'on') {
																			 
																			var name = $(
																					"#id"
																							+ val)
																					.attr(
																							'data-name');
																			var empcode = $(
																					"#id"
																							+ val)
																					.attr(
																							'data-empcode');
																			
																			var selectStatus = 5;
																			var selectStatusText = "P";
																			var showsd = "P";
																			
																			var ontime = 0;
																			if (document.getElementById("ontime"+val).checked == true) {
																				ontime = 1;
																				document.getElementById("ontime"+val).value = 1;
																			}else{
																				document.getElementById("ontime"+val).value = 0;
																			}
																			
																			var lateMark = 0;
																			var latemarkshow ;
																			if (document.getElementById("lateMark"+val).checked == true) {
																				lateMark = 1;
																				document.getElementById("lateMark"+val).value = 1;
																				latemarkshow="Yes";
																			}else{
																				document.getElementById("lateMark"+val).value = 0;
																				latemarkshow="No";
																			}
																			
																			var lateMin = document.getElementById("lateMin"+val).value;
																			

																			if (lateMark == 1 && lateMin <= 0) {

																				alert("Enter Late Min of " + name);
																				isError = 1;
																				return false;
																			}

																			 
																			var isOnTime=0;
																			var isLateMark=0;
																			var isAbsent=0;
																			var isLeave=0;
																			var isWo=0;
																			var isPh=0;
																			
																			if (ontime == 0 && lateMark == 0) {
																				selectStatus = $(
																						"#id"
																						+ val)
																				.attr(
																						'data-statusidshow');
																				selectStatusText = $(
																						"#id"
																						+ val)
																				.attr(
																						'data-statusshow');
																				showsd = $(
																						"#id"
																						+ val)
																				.attr(
																						'data-showsd');
																				lateMin = 0;
																				
																				if(selectStatusText=="AB" || selectStatusText=="NA"){
																					absentNaCount=absentNaCount+1;
																					isAbsent=1;
																				}else if(selectStatusText=="WO"){
																					weeklyCount=weeklyCount+1;
																					isWo=1;
																				}else if(selectStatusText=="PH"){
																					paidHolidayCount=paidHolidayCount+1;
																					isPh=1;
																				}else {
																					leaveCount=leaveCount+1;
																					isLeave=1;
																				} 
																				
																			}else if(ontime==1 && lateMark == 0){
																				onTimeCount=onTimeCount+1;
																				isOnTime=1;
																			}else if(lateMark==1){
																				selectStatus = 5;
																				selectStatusText = "P";
																				showsd = "P";
																				lateMarkCount=lateMarkCount+1;
																				isLateMark=1;
																			} 
																			 
																			 if(isOnTime==1){
																				 var tr_data = '<tr id="tritem' + val + '">'
																					+ '<td id="itemCount' + val + '">'
																					+ empcode
																					+ '</td>'
																					+ '<td  >'
																					+ name
																					+ '</td> </tr>';
																					
																					$(
																							'#table_grid1'
																									+ ' tbody')
																							.append(
																									tr_data);
																			 }else if(lateMark==1){
																				 var tr_data = '<tr id="tritem' + val + '">'
																					+ '<td id="itemCount' + val + '">'
																					+ empcode
																					+ '</td>'
																					+ '<td  >'
																					+ name
																					+ '</td>'
																					+ '<td  >'
																					+ latemarkshow
																					+ '</td>'
																					+ '<td  >'
																					+ lateMin
																					+ '</td> </tr>';
																					
																					$(
																							'#table_grid2'
																									+ ' tbody')
																							.append(
																									tr_data);
																			 }else {
																				 var tr_data = '<tr id="tritem' + val + '">'
																					+ '<td id="itemCount' + val + '">'
																					+ empcode
																					+ '</td>'
																					+ '<td  >'
																					+ name
																					+ '</td>'
																					+ '<td  >'
																					+ showsd
																					+ '</td>  </tr>';
																					 
																					if(isAbsent==1){
																						$(
																								'#table_grid6'
																										+ ' tbody')
																								.append(
																										tr_data);
																					}else if(isWo==1){
																						$(
																								'#table_grid4'
																										+ ' tbody')
																								.append(
																										tr_data);
																					}else if(isPh==1){
																						$(
																								'#table_grid5'
																										+ ' tbody')
																								.append(
																										tr_data);
																					}else if(isLeave==1){
																						$(
																								'#table_grid3'
																										+ ' tbody')
																								.append(
																										tr_data);
																					}
																			 }
																			
																		}
																	});

													var datepicker1 = document
															.getElementById("datepicker1").value;
													$("#dateshow").html(
															datepicker1);
													 
													$("#ontimecount").html(
															"("+onTimeCount+")");
													$("#latemarkcount").html(
															"("+lateMarkCount+")");
													$("#absentcount").html(
															"("+absentNaCount+")");
													$("#leavecount").html(
															"("+leaveCount+")");
													$("#weeklycount").html(
															"("+weeklyCount+")");
													$("#phcount").html(
															"("+paidHolidayCount+")");
													
													     
													
													
													if(isError==0){
														$('#modal_large1').modal(
														'show');
													}
													
													return false;
 
											});
						});
	</script>
	<script>
		function submitForm() {
			$('#modal_large1').modal('hide');
			document.getElementById("btnassignstuct").disabled = true;
			document.getElementById("approveAttendaceBysecurity").submit();

		}
	</script>
	<!-- Scrollable modal -->
	<div id="modal_scrollable" class="modal fade" data-backdrop="false"
		tabindex="-1">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header pb-3">

					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>



				<div class="modal-footer pt-3">
					<button type="button" class="btn btn-link" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn bg-primary" onclick="submitForm()">Submit</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /scrollable modal -->
	<div id="modal_large1" class="modal fade" tabindex="-1">

		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">
						Approve Attendance of <span id="dateshow"></span>
					</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<div class="modal-body" id="modalbody">
					<ul class="nav nav-tabs nav-tabs-highlight nav-justified1">
						<li class="nav-item"><a href="#highlighted-justified-tab1"
							class="nav-link active" data-toggle="tab">On time <span
								id="ontimecount"></span></a></li>
						<li class="nav-item"><a href="#highlighted-justified-tab2"
							class="nav-link" data-toggle="tab">Late Mark <span
								id="latemarkcount"></span></a></li>
						<li class="nav-item"><a href="#highlighted-justified-tab6"
							class="nav-link" data-toggle="tab">Absent/NA <span
								id="absentcount"></span></a></li>
						<li class="nav-item"><a href="#highlighted-justified-tab3"
							class="nav-link" data-toggle="tab">Leave <span
								id="leavecount"></span></a></li>
						<li class="nav-item"><a href="#highlighted-justified-tab4"
							class="nav-link" data-toggle="tab">Weekly Off <span
								id="weeklycount"></span></a></li>
						<li class="nav-item"><a href="#highlighted-justified-tab5"
							class="nav-link" data-toggle="tab">Paid Holiday <span
								id="phcount"></span></a></li>

					</ul>

					<div class="tab-content">
						<div class="tab-pane fade show active"
							id="highlighted-justified-tab1">
							<div class="modal-body py-0">

								<br>
								<table class="table table-bordered table-hover" id="table_grid1">
									<thead>
										<tr class="bgpink">
											<th width="5%">Code</th>
											<th>Employee Name</th>
										</tr>
									</thead>
									<tbody>

									</tbody>

								</table>
							</div>
						</div>
						<div class="tab-pane fade" id="highlighted-justified-tab2">
							<div class="modal-body py-0">

								<br>
								<table class="table table-bordered table-hover" id="table_grid2">
									<thead>
										<tr class="bgpink">
											<th width="5%">Code</th>
											<th>Employee Name</th>
											<th>Late Mark</th>
											<th>Late Min</th>
										</tr>
									</thead>
									<tbody>

									</tbody>

								</table>
							</div>
						</div>
						<div class="tab-pane fade" id="highlighted-justified-tab6">
							<div class="modal-body py-0">

								<br>
								<table class="table table-bordered table-hover" id="table_grid6">
									<thead>
										<tr class="bgpink">
											<th width="5%">Code</th>
											<th>Employee Name</th>
											<th>Status</th>
										</tr>
									</thead>
									<tbody>

									</tbody>

								</table>
							</div>
						</div>
						<div class="tab-pane fade" id="highlighted-justified-tab3">
							<div class="modal-body py-0">

								<br>
								<table class="table table-bordered table-hover" id="table_grid3">
									<thead>
										<tr class="bgpink">
											<th width="5%">Code</th>
											<th>Employee Name</th>
											<th>Status</th>
										</tr>
									</thead>
									<tbody>

									</tbody>

								</table>
							</div>
						</div>
						<div class="tab-pane fade" id="highlighted-justified-tab4">
							<div class="modal-body py-0">

								<br>
								<table class="table table-bordered table-hover" id="table_grid4">
									<thead>
										<tr class="bgpink">
											<th width="5%">Code</th>
											<th>Employee Name</th>
											<th>Status</th>
										</tr>
									</thead>
									<tbody>

									</tbody>

								</table>
							</div>
						</div>
						<div class="tab-pane fade" id="highlighted-justified-tab5">
							<div class="modal-body py-0">

								<br>
								<table class="table table-bordered table-hover" id="table_grid5">
									<thead>
										<tr class="bgpink">
											<th width="5%">Code</th>
											<th>Employee Name</th>
											<th>Status</th>
										</tr>
									</thead>
									<tbody>

									</tbody>

								</table>
							</div>
						</div>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
					<button type="button" class="btn bg-primary" onclick="submitForm()">Submit</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
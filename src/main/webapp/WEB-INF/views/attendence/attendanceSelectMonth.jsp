<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
								
								<div class="form-group row">
									<div class="col-md-6">
										<h6 class="pageTitle">
									<i class="icon-grid52"></i> Attendance process for month <span> ${monthName}
										&nbsp;${year}</span>
								</h6>
									</div>
									<div class="col-md-6">
										<form name="attendanceStep1" id="attendanceStep1"
												action="${pageContext.request.contextPath}/attendenceImportExel"
												method="GET" class="form-inline justify-content-center">

												<input type="hidden" name="mode" id="mode"
													value="submitform">
												<div class="form-group ">
													<label for="staticEmail" class="col-md-12 col-form-label">Month
														: </label>


												</div>
												<div class="input-group mr-3">

													<input type="text" name="selectMonth" id="datepicker"
														class="form-control" required />
													
												</div>

												<button type="submit" class="btn blue_btn  btnActStep1 "
													id="btnActStep1" data-toggle1="modal"
													data-target1="#modal_step1">
													Submit <i class="icon-paperplane ml-2"></i>
												</button>

											</form>
									</div>
								</div>
							
							
								

								<div class="header-elements"></div>
							</div>

							<div class="card-body">
								<c:set value="0" var="flag"></c:set>
								<c:if test="${countSal.empTypeCount>0}">
									<c:set value="1" var="flag"></c:set>
									<div class="form-group row">

										<div class="col-lg-10">
											<span class="validation-invalid-label" id="error_locId">Allocate
												Employee Type to ${countSal.empTypeCount} Employee.</span>
										</div>
									</div>
								</c:if>
								<c:if test="${countSal.shiftCount>0}">
									<c:set value="1" var="flag"></c:set>
									<div class="form-group row">

										<div class="col-lg-10">
											<span class="validation-invalid-label" id="error_locId">Allocate
												Shift to ${countSal.shiftCount} Employee.</span>
										</div>
									</div>
								</c:if>
								<c:if test="${countSal.locationCount>0}">
									<c:set value="1" var="flag"></c:set>
									<div class="form-group row">

										<div class="col-lg-10">
											<span class="validation-invalid-label" id="error_locId">Allocate
												Location to ${countSal.locationCount} Employee.</span>
										</div>
									</div>
								</c:if>
								<c:if test="${countSal.holidayCount>0}">
									<c:set value="1" var="flag"></c:set>
									<div class="form-group row">

										<div class="col-lg-10">
											<span class="validation-invalid-label" id="error_locId">Allocate
												Holiday Category to ${countSal.holidayCount} Employee.</span>
										</div>
									</div>
								</c:if>
								<c:if test="${countSal.weekendCount>0}">
									<c:set value="1" var="flag"></c:set>
									<div class="form-group row">

										<div class="col-lg-10">
											<span class="validation-invalid-label" id="error_locId">Allocate
												Weekly off Category to ${countSal.weekendCount} Employee.</span>
										</div>
									</div>
								</c:if>

								<div class="tab-content">
									<c:if test="${flag==0}">
										<div class="" id="solid-rounded-justified-tab1">

											<div
												class="aaa">
												
				<div class="row">
					<div class="col-md-3">
						<div class="box_one bg_one">
							<i class="icon-users"></i> 
							<h2 class="box_title">Total Employee</h2>							 
							<span class="round_one"
							id="total_emp">${infoForUploadAttendance.totalEmp}</span>
						</div>
					</div>
					<div class="col-md-3">
						<div class="box_one bg_two">
							<i class="icon-grid4"></i> 
							<h2 class="box_title">Total attendance expected</h2> 							
							<span class="round_one"
							id="total_attendce_expected">${(infoForUploadAttendance.dateDiff+1)*infoForUploadAttendance.totalEmp}</span>
						</div>
					</div>
					<div class="col-md-3">
						<div class="box_one bg_three">
							<i class="icon-grid52"></i> 
							<h2 class="box_title">Total added by step1</h2> 							
							<span class="round_one"
							id="total_att_present">${infoForUploadAttendance.updatedByStep1}</span>
						</div>
					</div>
					<div class="col-md-3">
						<div class="box_one bg_four">
							<i class="icon-grid52"></i> 
							<h2 class="box_title">Total attendance uploaded</h2> 							
							<span class="round_one"
							id="by_file_updated">${infoForUploadAttendance.updatedByFile}</span>
						</div>
					</div>
				</div>			

	
												<!-- <div class="card-body p-0">
													<ul class="nav nav-sidebar my-2">
														<li class="nav-item"></li>
														<li class="nav-item"></li>
														<li class="nav-item"></li>
														<li class="nav-item"></li>
													</ul>
												</div> -->

											</div>
											


										</div>
									</c:if>

								</div>
							</div>

						</div>
					</div>
				</div>

			</div>
			<!-- /content area -->

			<!-- Info modal -->
			<div id="myModal_checklist" class="modal fade " data-backdrop="false"
				tabindex="-1">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header bg-info">
							<h6 class="modal-title">Checklist</h6>
							<!-- <button type="button" class="close" data-dismiss="modal">&times;</button>  -->
						</div>

						<div class="modal-body">
							<h6 class="font-weight-semibold text-center">
								*Note : Assign Company, Location,Employee Type, Holiday Category
								and Weeklyoff Category, Shift,Skill Rate to All Employee.<br>
								*Note : Sanction Leaves All Leaves If Pending.
							</h6>


						</div>

						<div class="modal-footer">
							<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>

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
	<script type="text/javascript">
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

	<script>
		/* 	$(document).ready(function() {
				// month selector
				$('.datepicker').datepicker({
					autoclose : true,
					maxViewMode : 0,
					minViewMode : 1,
					format : 'mm',

				});
			}); */
		$(document)
				.ready(
						function($) {

							//btn_go_next_tab
							$(".btn_go_next_tab").click(
									function(e) {
										$('.nav-tabs > .nav-item > .active')
												.parent().next('li').find('a')
												.trigger('click');

									});
							$(".btn_go_prev_tab").click(
									function(e) {
										$('.nav-tabs > .nav-item > .active')
												.parent().prev('li').find('a')
												.trigger('click');

									});

							$("#submitInsertLocaion")
									.submit(
											function(e) {
												var isError = false;
												var errMsg = "";

												if (!$("#locName").val()) {

													isError = true;

													$("#error_locName").show()
													//return false;
												} else {
													$("#error_locName").hide()
												}

												if (!$("#locShortName").val()) {

													isError = true;

													$("#error_locShortName")
															.show()

												} else {
													$("#error_locShortName")
															.hide()
												}

												if (!$("#add").val()) {

													isError = true;

													$("#error_locadd").show()

												} else {
													$("#error_locadd").hide()
												}

												if (!$("#prsnName").val()) {

													isError = true;

													$("#error_prsnName").show()

												} else {
													$("#error_prsnName").hide()
												}

												if (!$("#contactNo").val()
														|| !validateMobile($(
																"#contactNo")
																.val())) {

													isError = true;

													if (!$("#contactNo").val()) {
														document
																.getElementById("error_contactNo").innerHTML = "This field is required.";
													} else {
														document
																.getElementById("error_contactNo").innerHTML = "Enter valid Mobile No.";
													}

													$("#error_contactNo")
															.show()

												} else {
													$("#error_contactNo")
															.hide()
												}

												if (!$("#email").val()
														|| !validateEmail($(
																"#email").val())) {

													isError = true;

													if (!$("#email").val()) {
														document
																.getElementById("error_email").innerHTML = "This field is required.";
													} else {
														document
																.getElementById("error_email").innerHTML = "Enter valid email.";
													}

													$("#error_email").show()

												} else {
													$("#error_email").hide()
												}

												if (!isError) {

													var x = true;
													if (x == true) {

														document
																.getElementById("submtbtn").disabled = true;
														return true;
													}
													//end ajax send this to php page
												}
												return false;
											});
						});
		//
		$(function() {
			$("#datepicker").datepicker({
				changeMonth : true,
				changeYear : true,
				yearRange : "-50:+50",
				dateFormat : "mm-yy"
			});
		});
	</script>

	<script type="text/javascript">
		$(window).on('load', function() {
			$('#myModal_checklist').modal('show');
		});
	</script>

</body>
</html>
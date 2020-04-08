<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
								<h5 class="card-title">
									Assign Shift Record for month <strong>${monthName}
										&nbsp;${year}</strong>
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
								<ul
									class="nav nav-tabs nav-tabs-solid nav-justified rounded border-0">
									<li class="nav-item mr-1"><c:choose>
											<c:when
												test="${((infoForUploadAttendance.dateDiff+1)*infoForUploadAttendance.totalEmp)==infoForUploadAttendance.updatedByStep1}">
												<a href="#solid-rounded-justified-tab1"
													class="nav-link bg-success " id="tabstep1"
													data-toggle="tab">Step 1</a>
											</c:when>
											<c:otherwise>
												<a href="#solid-rounded-justified-tab1"
													class="nav-link active show" id="tabstep1"
													data-toggle="tab">Step 1</a>
											</c:otherwise>
										</c:choose></li>
									<c:if
										test="${((infoForUploadAttendance.dateDiff+1)*infoForUploadAttendance.totalEmp)==infoForUploadAttendance.updatedByStep1}">


										<li class="nav-item mr-1"><a
											href="#solid-rounded-justified-tab2"
											class="nav-link active show" data-toggle="tab">Step 2
												Assign Shift </a></li>


									</c:if>
									<!--  -->
								</ul>
								<c:set value="0" var="step1"></c:set>
								<div class="tab-content">
									<c:choose>
										<c:when
											test="${((infoForUploadAttendance.dateDiff+1)*infoForUploadAttendance.totalEmp)==infoForUploadAttendance.updatedByStep1}">
											<div class="tab-pane fade " id="solid-rounded-justified-tab1">
										</c:when>
										<c:otherwise>
											<div class="tab-pane fade  show active"
												id="solid-rounded-justified-tab1">
										</c:otherwise>
									</c:choose>



									<form name="attendanceStep1" id="attendanceStep1"
										action="http://gfplphp.aaryatechindia.in/index.php/attendance/attendanceprocess"
										class="form-inline justify-content-center">

										<input type="hidden" name="mode" id="mode" value="submitform">
										<input type="hidden" name="month" id="month"
											class="form-control " value="${month}"> <input
											type="hidden" name="year" id="year" class="form-control "
											value="${year}">

										<c:if
											test="${((infoForUploadAttendance.dateDiff+1)*infoForUploadAttendance.totalEmp)!=infoForUploadAttendance.updatedByStep1}">
											<c:set value="1" var="step1"></c:set>
											<button type="button"
												class="mr-3 btn btn-primary   btnActStep1 " id="btnActStep1"
												data-toggle1="modal" data-target1="#modal_step1">
												Start <i class="icon-paperplane ml-2"></i>
											</button>

										</c:if>

									</form>



								</div>
								<c:if test="${step1==0}">
									<div class="tab-pane fade show active"
										id="solid-rounded-justified-tab2">
										<div class="hidedefault alert bg-danger text-white"
											id="error_step2" style="display: none;"></div>


										<form
											action="${pageContext.request.contextPath}/shiftbulkuploadImportExel"
											id="searchEmpShiftList" method="get">

											<input type="hidden" name="selectMonth" id="selectMonth"
												value="${month}-${year}">
											<div class="form-group row">
												<label
													class="col-form-label text-info font-weight-bold col-lg-2"
													for="assignDate"> Select Date <span
													class="text-danger">* </span>:
												</label>
												<div class="col-lg-3">
													<select name="assignDate" data-placeholder="Select Date"
														id="assignDate"
														class="form-control form-control-select2 select2-hidden-accessible"
														data-fouc="" aria-hidden="true">

														<option value="">Select Date</option>
														<c:forEach items="${dates}" var="dates">
															<c:choose>
																<c:when test="${dates eq assignDate}">
																	<option value="${dates}" selected>${dates}</option>
																</c:when>
																<c:otherwise>
																	<option value="${dates}">${dates}</option>
																</c:otherwise>
															</c:choose>

														</c:forEach>

													</select><span class="validation-invalid-label"
														id="error_assignDate" style="display: none;">This
														field is required.</span>
												</div>
												<div class="col-lg-2">
													<input type="submit" class="btn btn-primary" value="Search"
														id="deleteId">
												</div>
											</div>
										</form>

										<form
											action="${pageContext.request.contextPath}/submitEmpShiftList"
											id="submitEmpShiftList" method="post">
											<input type="hidden" name="sm" id="sm" value="${month}">
											<input type="hidden" name="sy" id="sy" value="${year}">
											<div class="form-group row">
												<label
													class="col-form-label text-info font-weight-bold col-lg-2"
													for="locId"> Select Shift To Assign <span
													class="text-danger">* </span>:
												</label>
												<div class="col-lg-3">
													<select name="shiftId" data-placeholder="Select Shift"
														id="shiftId"
														class="form-control form-control-select2 select2-hidden-accessible"
														data-fouc="" aria-hidden="true">

														<option value="">Select Shift</option>

														<c:forEach items="${shiftMaster}" var="shiftList">
															<option value="${shiftList.id}">${shiftList.shiftname}</option>
														</c:forEach>
													</select> <span class="validation-invalid-label" id="error_shiftId"
														style="display: none;">This field is required.</span>
												</div>

											</div>
											<div class="table-responsive">
												<table class="table datatable-scroll-y" width="100%"
													id="printtable1">
													<thead>
														<tr class="bg-blue">

															<th width="10%">Sr.no</th>

															<th><input type="checkbox" name="selAll" id="selAll" /></th>
															<th>Employee Code</th>
															<th>Employee Name</th>
															<th>Emp Type</th>
															<th>Department</th>
															<th>Designation</th>
															<th>Location</th>
															<th>Shift Name</th>


														</tr>
													</thead>
													<tbody>


														<c:forEach items="${empdetList}" var="empdetList"
															varStatus="count">
															<tr>
																<td>${count.index+1}</td>
																<td><input type="checkbox"
																	id="empId${empdetList.empId}"
																	value="${empdetList.empId}" name="empId"
																	class="select_all"></td>
																<td>${empdetList.empCode}</td>
																<td>${empdetList.surname}&nbsp;${empdetList.middleName}&nbsp;${empdetList.firstName}</td>
																<td>${empdetList.empTypeName}</td>
																<td>${empdetList.deptName}</td>
																<td>${empdetList.empDesgn}</td>
																<td>${empdetList.locName}</td>
																<td>${empdetList.shiftname}</td>
															</tr>
														</c:forEach>

													</tbody>
												</table>
											</div>
											<span class="validation-invalid-label" id="error_chk"
												style="display: none;">Please Select the Employee.</span>
											<div style="text-align: center;">

												<button type="submit" class="mr-3 btn btn-primary     "
													id="btnActStep2">
													Assign Shift <i class="icon-paperplane ml-2"></i>
												</button>
											</div>
										</form>
									</div>
								</c:if>
							</div>

							<div
								class="sidebar sidebar-light bg-transparent sidebar-component sidebar-component-right wmin-300 border-0 shadow-0 order-1 order-md-2 sidebar-expand-md card">
								<div class="card-header bg-transparent header-elements-inline">


								</div>

								<div class="card-body p-0">
									<ul class="nav nav-sidebar my-2">
										<li class="nav-item"><i class="icon-users"></i> Total
											Employee <span class="badge bg-info badge-pill ml-auto"
											id="total_emp">${infoForUploadAttendance.totalEmp}</span></li>
										<li class="nav-item"><i class="icon-grid4"></i> Total
											record expected <span
											class="badge bg-info badge-pill ml-auto"
											id="total_attendce_expected">${(infoForUploadAttendance.dateDiff+1)*infoForUploadAttendance.totalEmp}</span></li>
										<li class="nav-item"><i class="icon-grid52"></i> Total
											added by step1 <span
											class="badge bg-success badge-pill ml-auto"
											id="total_att_present">${infoForUploadAttendance.updatedByStep1}</span></li>
										<%-- <li class="nav-item"><i class="icon-grid52"></i> Total
											attendance uploaded <span
											class="badge bg-danger badge-pill ml-auto"
											id="by_file_updated">${infoForUploadAttendance.updatedByFile}</span></li> --%>
									</ul>
								</div>

							</div>

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

	</div>

	<!-- Info modal -->
	<div id="modal_step1" class="modal fade " data-backdrop="false"
		tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header bg-info">
					<h6 class="modal-title">
						Process for month <strong>${monthName} &nbsp;${year}</strong>
					</h6>
					<!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
				</div>

				<div class="modal-body">
					<h6 class="font-weight-semibold text-center">
						<h6>
							Please wait. Processing your request..<br /> It will take approx
							3 to 5 min
						</h6>
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
	<!-- /info modal -->

	<!-- Info modal -->
	<div id="modal_step2_fileupload" class="modal fade "
		data-backdrop="false" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header bg-info">
					<h6 class="modal-title">
						Attendance process for month <strong>${monthName}
							&nbsp;${year}</strong>
					</h6>
					<!-- <button type="button" class="close" data-dismiss="modal">&times;</button>  -->
				</div>

				<div class="modal-body">
					<h6 class="font-weight-semibold text-center">
						<h6>
							Please wait. Processing your request..<br /> It will take few
							mins approx 25 to 30 min only
						</h6>
					</h6>

					<div class="hidedefault" id="msg_progess"></div>
					<div class="progress" id="progress-wrp" style1="margin-top:20px">


						<div
							class="progress-bar progressbar_importcsv progress-bar-striped bg-dark"
							id="progressbar_importcsv" role="progressbar"
							data-transitiongoal-backup="0" data-transitiongoal="0"
							style="width: 0%;" aria-valuenow="0">
							<span class="status">0% Complete</span>
						</div>
					</div>
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
	<!-- /info modal -->
	<!-- /page content -->
	<script type="text/javascript">
		$(document)
				.ready(
						function($) {
							$("#submitEmpShiftList")
									.submit(
											function(e) {

												var isError = false;
												var errMsg = "";
												var shiftId = $("#shiftId")
														.val();
												var assignDate = $(
														"#assignDate").val();

												var checked = $("#submitEmpShiftList input:checked").length > 0;
												$("#error_chk").hide()
												$("#error_shiftId").hide()
												$("#error_assignDate").hide()

												if (!checked) {
													$("#error_chk").show()
													isError = true;
												}
												//alert("checked" +checked);
												if (shiftId == null
														|| shiftId == "") {
													isError = true;
													$("#error_shiftId").show()
												}

												if (assignDate == null
														|| assignDate == "") {
													isError = true;
													$("#error_assignDate")
															.show()
												}

												if (!isError) {

													var x = true;
													if (x == true) {
														var table = $(
																'#printtable1')
																.DataTable();
														table.search("").draw();
														document
																.getElementById("btnActStep2").disabled = true;

														return true;
													}
													//end ajax send this to php page
												}
												return false;
											});
						});

		$(document).ready(function($) {
			$("#searchEmpShiftList").submit(function(e) {

				var isError = false;

				var assignDate = $("#assignDate").val();

				if (assignDate == null || assignDate == "") {
					isError = true;
					$("#error_assignDate").show()
				}

				if (!isError) {

					return true;

					//end ajax send this to php page
				}
				return false;
			});
		});
	</script>
	<script>
		/* $('#block-page').on('click', function() {
			$.blockUI({
				message : '<i class="icon-spinner4 spinner"></i>',
				timeout : 2000, //unblock after 2 seconds
				overlayCSS : {
					backgroundColor : '#1b2024',
					opacity : 0.8,
					cursor : 'wait'
				},
				css : {
					border : 0,
					color : '#fff',
					padding : 0,
					backgroundColor : 'transparent'
				}
			});
		}); */

		$(document).ready(
				function($) {

					//btn_go_next_tab
					$(".btn_go_next_tab").click(
							function(e) {
								$('.nav-tabs > .nav-item > .active').parent()
										.next('li').find('a').trigger('click');

							});
					$(".btn_go_prev_tab").click(
							function(e) {
								$('.nav-tabs > .nav-item > .active').parent()
										.prev('li').find('a').trigger('click');

							});

				});

		$("#btnActStep1")
				.click(
						function(e) {
							// getProgress();
							console.log('startProgress');
							var dataString = $("#attendanceStep1").serialize();
							$
									.ajax({
										type : 'POST',
										dataType : 'json',
										async : true, //IMPORTANT!
										data : dataString, // Data sent to server, a set of key/value pairs (i.e. form fields and values)
										// contentType: false,       // The content type used when sending data to the server.
										// cache: false,             // To unable request pages to be cached
										//  processData:false,        // To send DOMDocument or non processed data file it is set to false
										url : '${pageContext.request.contextPath}/addDefaultRecordinShiftAssign',

										beforeSend : function() {
											/* $.blockUI({
											    message: '<h6>Please wait. Processing your request..<br /> It Will take approx 3 min</h6>'
											});   */

											$('#modal_step1').modal('show');

										},
										oncomplete : function(data, status) {
											console.log(data.responseText);
										},
										success : function(redata) {
											// $.unblockUI();
											//alert(redata.error);
											//$('.modal-body').html(redata);
											if (redata.error == false) {
												location.reload(true);
											} else {

											}

											location.reload(true);
											// $('#modal_step1').modal('hide');
										},
										error : function(xhr, status, error) {
											// console.log(data);
											var err = eval("("
													+ xhr.responseText + ")");
											console.log(error);
											console.log(err);
										}
									});
							return false;
						});

		/* $("#btnActStep2").click(function(e) {

			alert("sf")
		}); */

		$("#btnActStepFinal")
				.click(
						function(e) {
							//
							/* if (timeoutId != -99) {
								clearTimeout(timeoutId);
							} */
							$("#error_step2").html("");
							$("#error_step2").hide();
							$("#msg_progess").hide();
							$('#modal_step2_fileupload').modal('show');

							var month = $("#month").val();
							var year = $("#year").val();

							var fd = new FormData();
							fd.append('month', month);
							fd.append('year', year);

							$
									.ajax({
										url : '${pageContext.request.contextPath}/finalizeAttendaceProcess',
										type : 'post',
										dataType : 'json',
										data : fd,
										contentType : false,
										processData : false,
										success : function(response) {

											if (response.error == false) {
												location.reload(true);
											} else {

											}

											location.reload(true);
										},
									});
							//  alert(file);
							// maby check size or type here with upload.getSize() and upload.getType()
							// execute upload

							//setProgressForCSV();

						});
	</script>

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
	</script>

</body>
</html>
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
								<table width="100%">
									<tr width="100%">
										<td width="60%"><h5 class="pageTitle">
												<i class="icon-list-unordered"></i> Assign Shift Record
												Projection
											</h5></td>
										<td width="40%" align="right"></td>
									</tr>
								</table>
							</div>
							<%-- <div class="card-header header-elements-inline">
								<h5 class="card-title">
									Assign Shift Record for month <strong>${monthName}
										&nbsp;${year}</strong>
								</h5>
							</div> --%>


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

								<c:set value="0" var="step1"></c:set>
								<div class="tab-content">

									<form
										action="${pageContext.request.contextPath}/showShiftProjectionAllocation"
										id="searchEmpShiftList" method="get">

										<div class="form-group row">


											<div class="col-md-6">
												<label
													class="col-form-label text-info font-weight-bold col-lg-5 float"
													for="locId"> Select Department <span
													class="text-danger">* </span>:
												</label>
												<div class="col-lg-7 float">
													<select name="locId" data-placeholder="Select Location"
														id="locId"
														class="form-control form-control-select2 select2-hidden-accessible"
														data-fouc="" aria-hidden="true">

														<option value="0" selected>All</option>

														<c:forEach items="${departmentList}" var="departmentList">

															<c:choose>
																<c:when test="${departmentList.departId==deptId}">
																	<option value="${departmentList.departId}" selected>${departmentList.name}</option>
																</c:when>
																<c:otherwise>
																	<option value="${departmentList.departId}">${departmentList.name}</option>
																</c:otherwise>
															</c:choose>

														</c:forEach>

													</select><span class="validation-invalid-label"
														id="error_assignDate" style="display: none;">This
														field is required.</span>
												</div>

											</div>
											<div class="col-md-6">
												<input type="submit" class="btn btn-primary" value="Search"
													id="deleteId">
											</div>
										</div>


										<c:if test="${firstDate!=null}">
											<div class="form-group row">


												<div class="col-md-6">
													<label class="col-form-label col-lg-5 float"> Date
														Range Projection : </label>
													<div class="col-lg-7 float">${firstDate}&nbsp;To
														&nbsp;${lastDate}</div>

												</div>

											</div>
										</c:if>
									</form>

									<form
										action="${pageContext.request.contextPath}/submitEmpShiftList"
										id="submitEmpShiftList" method="post">
										<input type="hidden" name="sm" id="sm" value="${month}">
										<input type="hidden" name="sy" id="sy" value="${year}">


										<div class="form-group row">


											<div class="col-md-6">
												<label
													class="col-form-label text-info font-weight-bold col-lg-5 float"
													for="daterange">Date Range<span style="color: red">*
												</span>:
												</label>
												<div class="col-lg-7 float">
													<input type="text"
														class="form-control daterange-basic_new " name="daterange"
														data-placeholder="Select Date" id="daterange"> <span
														class="validation-invalid-label" id="error_daterange"
														style="display: none;">This field is required.</span>
												</div>
											</div>

											<div class="col-md-6">
												<label
													class="col-form-label text-info font-weight-bold col-lg-5 float"
													for="shiftId">Select Shift To Assign <span
													style="color: red">* </span>:
												</label>
												<div class="col-lg-7 float">
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

										</div>


										<!-- Left fixed column -->
										<table class="table datatable-fixed-left_custom" width="100%"
											id="printtable1">
											<thead>


												<tr class="bg-blue">

													<th class="text-center;">Emp Code</th>

													<th class="text-center;">Emp Name</th>

													<th class="text-center"><input type="checkbox"
														name="selAll" id="selAll" /></th>
													<c:forEach items="${dateAndDayList}" var="dates"
														varStatus="count">
														<th style="text-align: center;">${dates.date}<br>${dates.day}</th>
													</c:forEach>

												</tr>
											</thead>
											<tbody>

												<c:forEach items="${empList}" var="empList"
													varStatus="count">

													<tr>

														<td class="text-center">${empList.empCode}</td>

														<td>${empList.name}</td>
														<td><input type="checkbox" id="empId${empList.empId}"
															value="${empList.empId}" name="empId" class="select_all"></td>

														<c:forEach items="${empList.shiftallocationDetailList}"
															var="shiftallocationDetailList">
															<c:choose>
																<c:when test="${shiftallocationDetailList.extraType==3}">
																	<td style="background-color: #27bf27;">
																		${shiftallocationDetailList.shiftname}&nbsp;
																		(${shiftallocationDetailList.extra})</td>
																</c:when>
																<c:when test="${shiftallocationDetailList.extraType==2}">
																	<td style="background-color: #FFA8A8;">
																		${shiftallocationDetailList.shiftname}&nbsp;
																		(${shiftallocationDetailList.extra})</td>
																</c:when>
																<c:when test="${shiftallocationDetailList.extraType==1}">
																	<td style="background-color: #FF9;">
																		${shiftallocationDetailList.shiftname} &nbsp;
																		(${shiftallocationDetailList.extra})</td>
																</c:when>
																<c:otherwise>
																	<td>${shiftallocationDetailList.shiftname}</td>
																</c:otherwise>
															</c:choose>

														</c:forEach>
													</tr>

												</c:forEach>


											</tbody>
										</table>
										<span class="validation-invalid-label" id="error_chk"
											style="display: none;">Please Select the Employee.</span><br>
										<!-- /left fixed column -->

										<div style="text-align: center;">

											<button type="submit" class="mr-3 btn btn-primary     "
												id="btnActStep2">
												Assign Shift <i class="icon-paperplane ml-2"></i>
											</button>
										</div>
									</form>









									<c:if test="${step1==0}">
										<div class="tab-pane fade show active"
											id="solid-rounded-justified-tab2">
											<div class="hidedefault alert bg-danger text-white"
												id="error_step2" style="display: none;"></div>



										</div>
									</c:if>
								</div>

								<%-- <div
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
										<li class="nav-item"><i class="icon-grid52"></i> Total
											attendance uploaded <span
											class="badge bg-danger badge-pill ml-auto"
											id="by_file_updated">${infoForUploadAttendance.updatedByFile}</span></li>
									</ul>
								</div>

							</div> --%>

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

												var table = $('#printtable1')
														.DataTable();
												table.search("").draw();

												var isError = false;
												var errMsg = "";
												var shiftId = $("#shiftId")
														.val();
												var daterange = $("#daterange")
														.val();

												var assignDate = $(
														"#assignDate").val();

												var checked = $("#submitEmpShiftList input:checked").length > 0;
												//$('body input[type="checkbox"]').prop('checked', this.checked);
												$("#error_chk").hide()
												$("#error_shiftId").hide()
												$("#error_assignDate").hide()
												$("#error_daterange").hide()
												if (!checked) {
													$("#error_chk").show()
													isError = true;
												}
												if (assignDate == "") {
													$("#error_daterange")
															.show()
													isError = true;
												}
												//alert("checked" +checked);
												if (shiftId == null
														|| shiftId == "") {
													isError = true;
													$("#error_shiftId").show()
												}

												if (!isError) {

													var x = true;
													if (x == true) {

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

				var locId = $("#locId").val();

				if (locId == null || locId == "") {
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
			scrollY : '600px',
			scrollCollapse : true,
			paging : false,

			fixedColumns : {
				leftColumns : 2
			}

		});
		$(document).ready(
				function() {
					//	$('#printtable').DataTable();

					$("#selAll222").click(
							function() {
								$('#printtable1 tbody input[type="checkbox"]')
										.prop('checked', this.checked);
							});
				});

		$('.daterange-basic_new').daterangepicker({
			applyClass : 'bg-slate-600',
			cancelClass : 'btn-light',
			locale : {
				format : 'DD-MM-YYYY',
				separator : ' to '
			}
		});

		$(document).ready(function() {

			$('body').on('click', '#selAll', function() {
				//alert("111111");
				$('body input[type="checkbox"]').prop('checked', this.checked);
				// $(this).toggleClass('allChecked');
			})
		});
	</script>

</body>
</html>

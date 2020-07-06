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
									<i class="icon-list-unordered"></i> Employee Roaster Details
									for ${year}-${month}
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
									<label class="col-form-label col-lg-2"> Driver Code : </label>
									<label class="col-form-label col-lg-2">${headData.empCode}</label>
									<label class="col-form-label col-lg-2"> Driver Name : </label>
									<label class="col-form-label col-lg-2">${headData.firstName}&nbsp;${headData.surname}</label>
								</div>

								<div class="form-group row">
									<label class="col-form-label col-lg-1">Off Day :</label> <label
										class="col-form-label col-lg-1">${headData.offDayCount}</label>
									<label class="col-form-label col-lg-1"> FF : </label> <label
										class="col-form-label col-lg-1">${headData.ffCount}</label> <label
										class="col-form-label col-lg-1"> KM : </label> <label
										class="col-form-label col-lg-1">${headData.km}</label> <label
										class="col-form-label col-lg-1"> Incentive : </label> <label
										class="col-form-label col-lg-1">${headData.incentive}</label><label
										class="col-form-label col-lg-1"> Late Mark: </label> <label
										class="col-form-label col-lg-1">${headData.lateMark}</label> <label
										class="col-form-label col-lg-1"> Late Min : </label> <label
										class="col-form-label col-lg-1">${headData.lateMin}</label>
								</div>

								<div class="form-group row">
									<c:forEach items="${roasterSheetData.routeTypelist}"
										var="routeTypelist">
										<c:set value="0" var="typeCount"></c:set>
										<c:forEach items="${roasterSheetData.typeWiseRoasterList}"
											var="typeWiseRoasterList">
											<c:if
												test="${routeTypelist.typeId==typeWiseRoasterList.typeId }">
												<c:set value="${typeWiseRoasterList.typeCount}"
													var="typeCount"></c:set>
											</c:if>

										</c:forEach>
										<label class="col-form-label col-lg-1">${routeTypelist.typeName}
											: </label>
										<label class="col-form-label col-lg-1"> ${typeCount}</label>
									</c:forEach>


								</div>

							</div>
							<hr>


							<div class="card-body">
								<div class="table-responsive">
									<table
										class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
										id="printtable1">


										<thead>
											<tr class="bg-blue" style="text-align: center;">

												<th class="text-center">Date</th>
												<th class="text-center">Duty</th>
												<th class="text-center">KM</th>
												<th class="text-center">Incentive</th>
												<th class="text-center">Late Mark</th>
												<th class="text-center">Late Min</th>
											</tr>
										</thead>
										<tbody>


											<c:forEach
												items="${roasterSheetData.routePlanDetailWithNamelist}"
												var="routePlanDetailWithNamelist">
												<tr>

													<c:choose>
														<c:when test="${routePlanDetailWithNamelist.extraInt2==1}">
															<td class="text-center"
																style="background-color: #0dbf0d;">${routePlanDetailWithNamelist.surname}</td>
														</c:when>
														<c:otherwise>
															<td class="text-center">${routePlanDetailWithNamelist.surname}</td>
														</c:otherwise>
													</c:choose>

													<td><c:choose>
															<c:when test="${routePlanDetailWithNamelist.routeId!=0}">${routePlanDetailWithNamelist.routeName}</c:when>
															<c:when
																test="${routePlanDetailWithNamelist.isoffdayIsff==1}">Off Day</c:when>
															<c:when
																test="${routePlanDetailWithNamelist.isoffdayIsff==2}">FF</c:when>
															<c:otherwise>NA</c:otherwise>
														</c:choose></td>
													<td class="text-right">${routePlanDetailWithNamelist.km}</td>
													<td class="text-right">${routePlanDetailWithNamelist.incentive}</td>

													<td class="text-center"><c:choose>
															<c:when test="${routePlanDetailWithNamelist.lateMark==1}">Yes</c:when>
															<c:otherwise>No</c:otherwise>
														</c:choose></td>
													<td class="text-right">${routePlanDetailWithNamelist.lateMin}</td>
												</tr>
											</c:forEach>




										</tbody>
									</table>
								</div>


							</div>
							<div class="text-center">
								<a
									href="${pageContext.request.contextPath}/routeassignmonthlysheet?date=${month}-${year}">
									<button type="button" class="btn bg-primary">Back</button>
								</a>
							</div>
							<br>

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
</body>
</html>
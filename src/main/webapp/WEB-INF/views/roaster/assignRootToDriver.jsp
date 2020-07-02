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
								<c:choose>
									<c:when test="${flag==1}">
										<form id="form-login"
											action="${pageContext.request.contextPath}/confirmationRouteByDate"
											method="get">
									</c:when>
									<c:otherwise>
										<form id="form-login"
											action="${pageContext.request.contextPath}/assignRootToDriver"
											method="get">
									</c:otherwise>
								</c:choose>

								<div class="form-group row">
									<label
										class="col-form-label text-info font-weight-bold col-lg-2"
										for="date">Planning Date <span style="color: red">*
									</span> :
									</label>
									<div class="col-md-2">

										<input type="text" class="form-control datepickerclass"
											placeholder="Select Date " id="datepicker1" name="date"
											value="${date}" autocomplete="off" required>

									</div>
									<c:choose>
										<c:when test="${info.error==false}">
											<span class="validation-invalid-label" id="error_name"
												style="display: none;">This field is required.</span>
										</c:when>
										<c:otherwise>
											<span class="validation-invalid-label" id="error_name">${info.msg}</span>
										</c:otherwise>
									</c:choose>
									<button type="submit" class="btn bg-blue ml-3 legitRipple"
										id="submtbtn">Search</button>
								</div>
								</form>
								<hr>

								<div class="form-group row">
									<label class="col-form-label   col-lg-2" for="date">Select
										Date : </label>
									<div class="col-md-2">
										<input type="text" class="form-control daterange-basic_new "
											name="daterange" data-placeholder="Select Date"
											id="daterange">
									</div>

								</div>

								<div class="form-group row">
									<label class="col-form-label col-lg-2"> Employee Name :
									</label> <label class="col-form-label col-lg-2" id="driverName">
										- </label>


								</div>

								<div class="form-group row">
									<label class="col-form-label col-lg-1"> Off Days : </label> <label
										class="col-form-label col-lg-1" id="offDays">0</label><label
										class="col-form-label col-lg-1"> FF : </label> <label
										class="col-form-label col-lg-1" id="ffDays">0</label>

								</div>

								<div class="table-responsive">

									<table class="table table-bordered table-hover"
										id="printtable2">
										<thead>
											<tr class="bg-blue">

												<th class="text-center">Route Type</th>
												<th class="text-center">Count</th>
												<th class="text-center">KM</th>
												<th class="text-center">Incentive</th>
											</tr>
										</thead>
										<tbody>



										</tbody>
									</table>
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
														<th class="text-center">Select</th>
														<c:if test="${flag==1}">
															<th class="text-center">Late Mark</th>
														</c:if>
														<th class="text-center">Detail</th>
													</tr>
												</thead>
												<tbody>

													<c:forEach items="${list}" var="list" varStatus="count">
														<tr>
															<td>${list.firstName}&nbsp;${list.surname}</td>
															<td><select name="routeId${list.planDetailId}"
																data-placeholder="Select Route"
																id="routeId${list.planDetailId}" class="form-control"
																onchange="updateRouteId(${list.planDetailId})"
																onclick="checkDoubleRoute(${list.planDetailId})">
																	<option value="0" selected
																		id="routeId${list.planDetailId}0">NA</option>

																	<c:forEach items="${routeList}" var="routeList">
																		<c:choose>
																			<c:when test="${routeList.routeId==list.routeId}">
																				<option value="${routeList.routeId}" selected
																					id="routeId${list.planDetailId}${routeList.routeId}">${routeList.routeName}</option>
																			</c:when>
																			<c:otherwise>
																				<option value="${routeList.routeId}"
																					id="routeId${list.planDetailId}${routeList.routeId}">${routeList.routeName}</option>
																				<!-- style="background-color: orange;" -->
																			</c:otherwise>
																		</c:choose>

																	</c:forEach>
															</select></td>
															<td class="text-center"><select
																name="isFF${list.planDetailId}"
																data-placeholder="Select Route"
																onchange="updateRouteId(${list.planDetailId})"
																id="isFF${list.planDetailId}" class="form-control">

																	<option value="0" selected>NA</option>
																	<option value="1"
																		${list.isoffdayIsff==1 ? 'selected' : ''}>Off
																		Day</option>
																	<option value="2"
																		${list.isoffdayIsff==2 ? 'selected' : ''}>FF</option>
															</select></td>
															<c:if test="${flag==1}">
																<td class="text-center"><input type="checkbox"
																	id="lateMin${list.planDetailId}"
																	name="lateMin${list.planDetailId}"> <input
																	type="text" class="form-control numbersOnly"
																	placeholder="Late Min" value="0"
																	name="lateMin${list.planDetailId}"
																	id="lateMin${list.planDetailId}"></td>
															</c:if>
															<td class="text-center"><button type="submit"
																	class="btn bg-blue ml-3 legitRipple" id="historybtn"
																	onclick="getPlanHistoryDetailByEmpId(${list.driverId})">Detail</button>
															</td>
														</tr>
													</c:forEach>


												</tbody>
											</table>
										</div>
										<span class="validation-invalid-label" id="error_table1"
											style="display: none;">Please select one employee.</span>
									</div>

									<div class="col-md-6">
										<br> <br> <br>

										<div class="table-responsive">
											<!-- <table class="table datatable-scroll-y" width="100%"
											id="printtable2"> -->
											<!-- <table
												class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
												width="100%" id="printtable2"> -->
											<table class="table table-bordered table-hover"
												id="printtable3">
												<thead>
													<tr class="bg-blue">

														<th class="text-center">Route Name</th>
														<th class="text-center">Count</th>
														<th class="text-center">KM</th>
														<th class="text-center">Incentive</th>
													</tr>
												</thead>
												<tbody>



												</tbody>
											</table>
										</div>
									</div>
								</div>

								<c:if test="${flag==1}">
									<div class="form-group text-center ">
										<input type="button" class="btn blue_btn bootbox_custom"
											value="Confirm" id="btnassignstuct">

									</div>
								</c:if>
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
	<script>
		// Custom bootbox dialog
		$('.bootbox_custom').on(
				'click',
				function() {
					//var uuid = $(this).data("uuid") // will return the number 123
					/* $("#error_emp").hide();
					var list = [];

					$("input:checkbox[name=selectEmp]:checked").each(
							function() {
								list.push($(this).val());
							}); */
					/* if (list.length > 0) { */

					bootbox.confirm({
						title : 'Confirm ',
						message : 'You Want to confirm Route Allocation? ',
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
								document.getElementById(
										'submitFixAttendaceByDateAndEmp')
										.submit();

							}
						}
					});
					/* } else {
						 
						$("#error_emp").show();
					} */
				});
	</Script>
	<script type="text/javascript">
		$('.datepickerclass').daterangepicker({
			singleDatePicker : true,
			selectMonths : true,
			selectYears : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});
		$('.daterange-basic_new').daterangepicker({
			applyClass : 'bg-slate-600',

			cancelClass : 'btn-light',
			locale : {
				format : 'DD-MM-YYYY',
				separator : ' to '
			}
		});
		
		
		function checkDoubleRoute(planDetailId) {
			
			var routeId = document.getElementById("routeId"+planDetailId).value;
			
			if(routeId!=0){
				
			
			$
			.ajax({
				url : '${pageContext.request.contextPath}/getDriverPlanList',
				type : 'post',
				dataType : 'json', 
				contentType : false,
				processData : false,
				success : function(response) {

					
					
					for(var i=0; i<response.driverPlanList.length ;i++){
						
						if(planDetailId!=response.driverPlanList[i].planDetailId){
							var otherrouteId = document.getElementById("routeId"+response.driverPlanList[i].planDetailId).value;
							
							if(routeId==otherrouteId){
								bootbox.confirm({
									title : 'Confirm ',
									message : 'This route already allocate, you want allocate?',
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
											 

										}else{
											document.getElementById("routeId"+planDetailId).value=0;
											updateRouteId(planDetailId);
										}
									}
								});
							}
						}
						 
					}
					 
				},
			});
			}
			
		}
		function updateRouteId(planDetailId) {

			var routeId = document.getElementById("routeId"+planDetailId).value;
			var isFF = document.getElementById("isFF"+planDetailId).value;
			//var selectStatusText = $("#newSts" + selectStatus).data("namesd");

			/* if(routeId==0 && isFF==0){
				document.getElementById("routeId"+planDetailId).disabled=false;
				document.getElementById("isFF"+planDetailId).disabled=false;
			}else{
				if(routeId>0){
					document.getElementById("isFF"+planDetailId).disabled=true;
				}else{
					document.getElementById("routeId"+planDetailId).disabled=true;
				}
			} */
			
			if(routeId==0 && isFF==0){
				document.getElementById("routeId"+planDetailId).disabled=false;
				document.getElementById("isFF"+planDetailId).disabled=false;
			}else{
				if(routeId>0){
					
					document.getElementById("isFF"+planDetailId).value=0;
					document.getElementById("isFF"+planDetailId).disabled=true;
					isFF=0;
				}else{
					document.getElementById("routeId"+planDetailId).disabled=false;
				}
			} 
			
			var fd = new FormData();
			fd.append('planDetailId', planDetailId);
			fd.append('isFF', isFF);
			fd.append('routeId', routeId);
			
			$
					.ajax({
						url : '${pageContext.request.contextPath}/updateRouteId',
						type : 'post',
						dataType : 'json',
						data : fd,
						contentType : false,
						processData : false,
						success : function(response) {

							getDriverPlanList();
						},
					});

		}

		function getDriverPlanList() {
			
			$
			.ajax({
				url : '${pageContext.request.contextPath}/getDriverPlanList',
				type : 'post',
				dataType : 'json', 
				contentType : false,
				processData : false,
				success : function(response) {

					//alert(JSON.stringify(response))
					
					for(var j=0; j<response.driverPlanList.length ;j++){
						
						for(var i=0; i<response.routeList.length ;i++){
							document.getElementById('routeId'+response.driverPlanList[j].planDetailId+''+response.routeList[i].routeId).style.backgroundColor="white";
						}
						 
						
					}
					
					for(var i=0; i<response.driverPlanList.length ;i++){
						
						var routeId = document.getElementById("routeId"+response.driverPlanList[i].planDetailId).value;
						  
						   if(routeId!=0){
							 
						for(var j=0; j<response.driverPlanList.length ;j++){
							
							 
								document.getElementById('routeId'+response.driverPlanList[j].planDetailId+''+routeId).style.backgroundColor="orange";
							 
							
						}
						}  
					}
					 
				},
			});
			
		}
		function getPlanHistoryDetailByEmpId(empId) {

			//alert(sts);
			var daterange = document.getElementById("daterange").value;
			
			var fd = new FormData();
			fd.append('empId', empId); 
			fd.append('date', daterange); 
			
			$('#modal_step1').modal('show');

			$.ajax({
				url : '${pageContext.request.contextPath}/getPlanHistoryDetailByEmpId',
				type : 'post',
				dataType : 'json',
				data : fd,
				contentType : false,
				processData : false,
				success : function(response) {

					$('#modal_step1').modal('hide');
					 // alert(JSON.stringify(response));
					  
					  document.getElementById("driverName").innerHTML = response.empName; 
					  document.getElementById("offDays").innerHTML = response.offdays; 
					  document.getElementById("ffDays").innerHTML = response.ffdays; 
					  /* document.getElementById("totalKm").innerHTML = response.km; 
					  document.getElementById("totalincentive").innerHTML = response.incentive.toFixed(2); */


					   $("#printtable2 tbody").empty();
					  
					   for(var i=0 ; i<response.planwisehistoryList.length ;i++){
						   var tr_data = '<tr  >'
								+ '<td >'
								+ response.planwisehistoryList[i].typeName
								+ '</td>'
								+ '<td  class="text-right">'
								+ response.planwisehistoryList[i].count
								+ '</td><td class="text-right" >'
								+ response.planwisehistoryList[i].km
								+ '</td>'
								+ '<td class="text-right" >'
								+ response.planwisehistoryList[i].incentive.toFixed(2)
								+ '</td> </tr>';
						   $('#printtable2').append(tr_data);
					   }
					   
					  
					   $("#printtable3 tbody").empty();
						  
					   for(var i=0 ; i<response.routewisePlanHistory.length ;i++){
						   var tr_data = '<tr  >'
								+ '<td >'
								+ response.routewisePlanHistory[i].routeName
								+ '</td>'
								+ '<td  class="text-right">'
								+ response.routewisePlanHistory[i].count
								+ '</td><td class="text-right" >'
								+ response.routewisePlanHistory[i].km
								+ '</td>'
								+ '<td class="text-right" >'
								+ response.routewisePlanHistory[i].incentive.toFixed(2)
								+ '</td> </tr>';
						   $('#printtable3').append(tr_data);
					   }
						 
					  
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
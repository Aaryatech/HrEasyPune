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


				<!-- Highlighting rows and columns -->
				<div class="card">
					<div class="card-header header-elements-inline">
						<h5 class="pageTitle">
							<i class="icon-list-unordered"></i> Production Incentive Final
							Approval List (OT)

						</h5>
						<!-- <div class="header-elements">
							<div class="list-icons">
								<a class="list-icons-item" data-action="collapse"></a>
							</div> 
						</div>-->
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

						<div id="loader" style="display: none;">
							<img
								src="${pageContext.request.contextPath}/resources/assets/images/giphy.gif"
								width="150px" height="150px"
								style="display: block; margin-left: auto; margin-right: auto">
						</div>
						<form
							action="${pageContext.request.contextPath}/otFinalApprovalList"
							id="otFinalApprovalList" method="get"
							enctype="multipart/form-data">
							<div class="form-group row">
								<label
									class="col-form-label text-info font-weight-bold col-lg-2"
									for="date">Attendance Date <span style="color: red">*
								</span> :
								</label>
								<div class="col-md-2">
									<input type="text" class="form-control datepickerclass"
										placeholder="Select Date " id="date" name="date"
										value="${date}" autocomplete="off">
								</div>
								<input type="submit" class="btn blue_btn ml-3 legitRipple"
									id="searchbtn" value="Search">
							</div>
						</form>
						<form
							action="${pageContext.request.contextPath}/submitFinalApproveProductionIncentive"
							id="submitApproveProductionIncentive" method="post"
							enctype="multipart/form-data">
							<div class="table-responsive">

								<table class="table datatable-scroll-y" id="printtable1">

									<!-- <table class="table datatable-scroll-y" width="100%"
									id="printtable1"> -->
									<thead>
										<tr class="bg-blue" style="text-align: center;">

											<th class="text-center" style="width: 10%;">Date</th>
											<th class="text-center">Emp Name</th>
											<th class="text-center">Status</th>
											<!-- <th class="text-center">In Time</th>
											<th class="text-center">Out Time</th> -->
											<!-- <th class="text-center">Late Mark</th>
											<th class="text-center">Late MIN</th> -->
											<th class="text-center">WR. Hrs</th>

											<th class="text-center">Production Incentive <br>Hrs
											</th>

											<th class="text-center">Shift</th>
											<!-- <th class="text-center" style="width: 10%;">Action</th> -->

										</tr>
									</thead>
									<tbody>


										<c:forEach items="${dailyrecordList}" var="dailyrecordList">
											<tr>
												<td class="text-center" style="width: 10%;"><input
													type="checkbox" name="selectEmp"
													id="selectEmp${dailyrecordList.id}"
													value="${dailyrecordList.id}">&nbsp;${dailyrecordList.attDate}</td>
												<td class="text-center">${dailyrecordList.empName}</td>
												<td class="text-center">${dailyrecordList.attStatus}</td>

												<%-- <c:choose>
													<c:when test="${dailyrecordList.inTime eq '00:00:00'}">
														<td class="text-center" style="background-color: #FFA8A8">${dailyrecordList.inTime}</td>
													</c:when>
													<c:otherwise>
														<td class="text-center">${dailyrecordList.inTime}</td>
													</c:otherwise>
												</c:choose>

												<c:choose>
													<c:when test="${dailyrecordList.outTime eq '00:00:00'}">
														<td class="text-center" style="background-color: #FFA8A8">${dailyrecordList.outTime}</td>
													</c:when>
													<c:otherwise>
														<td class="text-center">${dailyrecordList.outTime}</td>
													</c:otherwise>
												</c:choose> --%>


												<%-- <c:choose>
													<c:when test="${dailyrecordList.lateMark==1}">
														<td class="text-center" style="background-color: #FF9">Yes</td>
													</c:when>
													<c:otherwise>
														<td class="text-center">No</td>
													</c:otherwise>
												</c:choose>
												<td class="text-right">${dailyrecordList.lateMin}</td> --%>
												<td class="text-right"
													title="In Time : ${dailyrecordList.inTime},Out Time : ${dailyrecordList.outTime}">${dailyrecordList.workingHrs}</td>

												<td class="text-right">${dailyrecordList.otHr}</td>

												<td>${dailyrecordList.currentShiftname}</td>
												<!-- <td class="text-center"></td> -->
											</tr>
										</c:forEach>

									</tbody>
								</table>
							</div>
							<br /> <span class="validation-invalid-label" id="error_chk"
								style="display: none;">Please Select the Employee.</span> <input
								type="hidden" id="stsaprv" value="1" name="stsaprv"> <input
								type="hidden" id="rejectResn" value="" name="rejectResn">

							<c:if test="${dailyrecordList.size()>0}">
								<!-- <div class="form-group row">
									<label
										class="col-form-label text-info font-weight-bold col-lg-2"
										for="date">Remark <span style="color: red">* </span> :
									</label>
									<div class="col-md-2">
										<input type="text" class="form-control  " placeholder="Remark"
											id="remark" name="remark" value="" autocomplete="off"> <span class="validation-invalid-label" id="error_remark"
											style="display: none;">Please Select the Employee.</span>
									</div>
								</div> -->

								<div class="col-md-12 text-center">

									<input type="submit" class="btn blue_btn" value="Approve"
										id="aprvbtn" style="align-content: center;"
										onclick="changeValue(1)">
									<!-- <input type="submit"
										class="btn blue_btn" value="Reject" id="rejectbtn"
										style="align-content: center;" onclick="changeValue(2)"> -->


								</div>
							</c:if>

						</form>

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
	<!-- /page content -->

	<!-- Modal -->
	<script type="text/javascript">
		function changeValue(val) {
			document.getElementById("stsaprv").value = val;
		}
	</script>

	<script type="text/javascript">
		$(document)
				.ready(
						function($) {
							$("#submitApproveProductionIncentive")
									.submit(
											function(e) {

												var table = $('#printtable1')
														.DataTable();
												table.search("").draw();

												var isError = false;
												var stsaprv = $('#stsaprv')
														.val();
												var msg = "want to approve Production Incentive?";
												if (stsaprv == 2) {
													msg = "want to reject Production Incentive?";
												}

												$("#error_chk").hide()
												var checked = $("#submitApproveProductionIncentive input:checked").length > 0;
												if (!checked) {
													$("#error_chk").show()
													isError = true;
												}

												if (!isError) {

													bootbox
															.confirm({
																title : 'Confirm ',
																message : msg,
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
																callback : function(
																		result) {
																	if (result) {
																		document
																				.getElementById("aprvbtn").disabled = true;
																		/* document
																				.getElementById("rejectbtn").disabled = true; */
																		document
																				.getElementById(
																						"submitApproveProductionIncentive")
																				.submit();
																	}
																}
															});

												}
												return false;
											});
						});
	</script>
	<script type="text/javascript">
		// Single picker
		$('.datepickerclass').daterangepicker({
			singleDatePicker : true,
			selectMonths : true,
			selectYears : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});

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
	<script>
		// Custom bootbox dialog
		$('.bootbox_custom').on('click', function() {
			//var uuid = $(this).data("uuid") // will return the number 123

			$("#error_table1").hide();
			var checkedVals = $('.chk1:checkbox:checked').map(function() {
				return this.value;
			}).get();
			checkedVals = checkedVals.join(',');

			if (checkedVals == '') {
				$("#error_table1").show();
				return false;
			}
			bootbox.confirm({
				title : 'Confirm ',
				message : 'Have you paid AMT of Employee?',
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
						document.getElementById('submitinchashamt').submit();

					}
				}
			});
		});
	</Script>
</body>
</html>
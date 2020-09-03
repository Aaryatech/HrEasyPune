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
							<i class="icon-list-unordered"></i> Optional Holiday Approval
							List
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
						<form
							action="${pageContext.request.contextPath}/optinalholidayapprovallist"
							id="submitInsertLeave" method="get">
							<div class="form-group row">
								<label
									class="col-form-label text-info font-weight-bold col-lg-2"
									for="select2">Select Location <span style="color: red">*
								</span> :
								</label>
								<div class="col-md-3">
									<select name="locId" data-placeholder="Select Location"
										id="locId"
										class="form-control form-control-select2 select2-hidden-accessible"
										required>
										<option value="">Select Location</option>
										<c:forEach items="${sessionScope.liveAccesibleLoc}"
											var="liveAccesibleLoc">
											<c:forEach items="${locationList}" var="locationList">
												<c:if test="${locationList.locId==liveAccesibleLoc}">
													<c:choose>
														<c:when test="${locId==locationList.locId}">
															<option value="${locationList.locId}" selected>${locationList.locName}</option>
														</c:when>
														<c:otherwise>
															<option value="${locationList.locId}">${locationList.locName}</option>
														</c:otherwise>
													</c:choose>
												</c:if>
											</c:forEach>
										</c:forEach>
									</select> <span class="validation-invalid-label" id="error_calYrId"
										style="display: none;">This field is required.</span>
								</div>
								<div class="col-lg-1"></div>
								<button type="submit" class="btn blue_btn" id="search">Search</button>

							</div>
						</form>
						<div id="loader" style="display: none;">
							<img
								src="${pageContext.request.contextPath}/resources/assets/images/giphy.gif"
								width="150px" height="150px"
								style="display: block; margin-left: auto; margin-right: auto">
						</div>
						<form
							action="${pageContext.request.contextPath}/approverejectoptionalholiday"
							id="approverejectoptionalholiday" method="post"
							enctype="multipart/form-data">

							<div class="table-responsive">

								<table class="table datatable-scroll-y" id="printtable1">

									<!-- <table class="table datatable-scroll-y" width="100%"
									id="printtable1"> -->
									<thead>
										<tr class="bg-blue">

											<th width="10%">Sr.no</th>
											<th width="5%" style="text-align: center;"><input
												type="checkbox" name="selAll" id="selAll" /></th>
											<th width="10%" style="text-align: center;">Emp Code</th>
											<th style="text-align: center;">Emp Name</th>
											<th style="text-align: center;">Holiday</th>
											<th style="text-align: center;">Remark</th>

										</tr>
									</thead>
									<tbody>


										<c:forEach items="${apprvlList}" var="apprvlList"
											varStatus="count">


											<tr>

												<td>${count.index+1}</td>
												<td><input type="checkbox" id="id${apprvlList.id}"
													value="${apprvlList.id}" name="ids" class="select_all"></td>
												<td>${apprvlList.empCode}</td>
												<td>${apprvlList.empName}</td>
												<td>${apprvlList.holidayName}&nbsp;(${apprvlList.holidate})</td>
												<td>${apprvlList.remark}</td>

											</tr>
										</c:forEach>

									</tbody>
								</table>
							</div>
							<br /> <span class="validation-invalid-label" id="error_chk"
								style="display: none;">Please Select the Employee.</span> <input
								type="hidden" id="stsaprv" value="1" name="stsaprv">
							<div style="text-align: center;">
								<input type="submit" class="btn blue_btn" value="Approve"
									id="aprvbtn" style="align-content: center;"
									onclick="changeValue(1)"> <input type="submit"
									class="btn blue_btn" value="Reject" id="rejectbtn"
									style="align-content: center;" onclick="changeValue(2)">
							</div>
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
							$("#approverejectoptionalholiday")
									.submit(
											function(e) {

												var table = $('#printtable1')
														.DataTable();
												table.search("").draw();

												var isError = false;
												var stsaprv = $('#stsaprv')
														.val();
												var msg = "you want to approve optional holiday?";
												if (stsaprv == 2) {
													msg = "you want to reject optional holiday?";
												}

												$("#error_chk").hide()
												var checked = $("#approverejectoptionalholiday input:checked").length > 0;
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
																		document
																				.getElementById("rejectbtn").disabled = true;
																		document
																				.getElementById(
																						"approverejectoptionalholiday")
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
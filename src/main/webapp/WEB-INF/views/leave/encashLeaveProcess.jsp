<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"
	import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html lang="en">
<head>

<c:url var="addStrDetail" value="/addStrDetail" />
<c:url var="chkNumber" value="/chkNumber" />

<c:url var="getLeaveStructureForEdit" value="/getLeaveStructureForEdit" />
<c:url var="getHolidayAndWeeklyOffList"
	value="/getHolidayAndWeeklyOffList" />
<c:url var="calholidayWebservice" value="/calholidayWebservice" />
<c:url var="checkDatesRange" value="/checkDatesRange" />
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
												<i class="icon-list-unordered"></i> Encash Leave Process
											</h5></td>
										<td width="40%" align="right">
											<%-- <a
									href="${pageContext.request.contextPath}/showApplyForLeave"
									class="breadcrumb-elements-item">
										<button type="button" class="btn btn-primary">Employee List</button>
								</a>  --%>
										</td>
									</tr>
								</table>
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

								<span class="validation-invalid-label" id="error_assign"
									style="display: none;">You Can Not Apply for Leave as
									either Leave Authority or Leave Structure is not Assigned !!</span>


								<div class="form-group row">
									<label class="col-form-label col-lg-2" for="lvsName">
										Employee Code : </label>
									<div class="col-lg-3">
										<input type="text" class="form-control"
											placeholder="Enter Leave Structure Name" id="empCode"
											value="${editEmp.empCode}" name="lvsName" autocomplete="off"
											onchange="trim(this)" readonly>

									</div>
									<label class="col-form-label col-lg-2" for="lvsName">
										Employee Name : </label>
									<div class="col-lg-4">
										<input type="text" class="form-control"
											placeholder="Enter Leave Structure Name" id="empName"
											value="${editEmp.firstName} ${editEmp.middleName} ${editEmp.surname}   "
											name="lvsName" autocomplete="off" onchange="trim(this)"
											readonly>

									</div>
								</div>
								<div class="form-group row">
									<label class="col-form-label col-lg-2" for="perday">
										Per Day : </label>
									<div class="col-lg-10">
										<input type="text" class="form-control" placeholder="Per Day"
											id="perday"
											value="<fmt:formatNumber type="number" maxFractionDigits="2"
														minFractionDigits="2" groupingUsed="false"
														value=" ${((employeeInfo.basic+
																	employeeInfo.allowSum)/day)}" />"
											name="perday" autocomplete="off" onchange="trim(this)"
											readonly>

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
												<th>Encash</th>
												<th>Balanced</th>


											</tr>
										</thead>
										<tbody>
											<c:forEach items="${leaveHistoryList}" var="leaveHistoryList">


												<c:choose>
													<c:when test="${leaveHistoryList.lvTypeId==1}">
														<c:if test="${mstEmpType.whWork eq 'Compoff'}">
															<tr>
																<td>${leaveHistoryList.lvTitle}</td>
																<td style="text-align: right;">${leaveHistoryList.balLeave}</td>
																<td style="text-align: right;">${leaveHistoryList.lvsAllotedLeaves}</td>
																<td style="text-align: right;">${leaveHistoryList.sactionLeave}</td>
																<td style="text-align: right;">${leaveHistoryList.aplliedLeaeve}</td>
																<td style="text-align: right;">${leaveHistoryList.leaveEncashCount}</td>
																<td style="text-align: right;">${leaveHistoryList.balLeave+leaveHistoryList.lvsAllotedLeaves-leaveHistoryList.sactionLeave-leaveHistoryList.aplliedLeaeve}</td>

															</tr>
														</c:if>

													</c:when>
													<c:otherwise>
														<tr>
															<td>${leaveHistoryList.lvTitle}</td>
															<td style="text-align: right;">${leaveHistoryList.balLeave}</td>
															<td style="text-align: right;">${leaveHistoryList.lvsAllotedLeaves}</td>
															<td style="text-align: right;">${leaveHistoryList.sactionLeave}</td>
															<td style="text-align: right;">${leaveHistoryList.aplliedLeaeve}</td>
															<td style="text-align: right;">${leaveHistoryList.leaveEncashCount}</td>
															<td style="text-align: right;">${leaveHistoryList.balLeave+leaveHistoryList.lvsAllotedLeaves-leaveHistoryList.sactionLeave-leaveHistoryList.aplliedLeaeve-leaveHistoryList.leaveEncashCount}</td>

														</tr>
													</c:otherwise>

												</c:choose>
												<%-- <tr>
													<td>${leaveHistoryList.lvTitle}</td>
													<td style="text-align: right;">${leaveHistoryList.balLeave}</td>
													<td style="text-align: right;">${leaveHistoryList.lvsAllotedLeaves}</td>
													<td style="text-align: right;">${leaveHistoryList.sactionLeave}</td>
													<td style="text-align: right;">${leaveHistoryList.aplliedLeaeve}</td>
													<td style="text-align: right;">${leaveHistoryList.balLeave+leaveHistoryList.lvsAllotedLeaves-leaveHistoryList.sactionLeave-leaveHistoryList.aplliedLeaeve}</td>

												</tr> --%>
											</c:forEach>




										</tbody>
									</table>
								</div>
								<br>
								<form action="${pageContext.request.contextPath}/insertLeave"
									id="submitInsertLeave" method="post">


									<div class="form-group row">
										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="leaveTypeId">Select Leave Type <span
												style="color: red">* </span>:
											</label>
											<div class="col-lg-7 float">
												<select name="leaveTypeId"
													data-placeholder="Select Leave Type" id="leaveTypeId"
													class="form-control form-control-select2 select2-hidden-accessible"
													data-fouc="" aria-hidden="true"
													onchange="checkLeaveLimitAndCalculation()">
													<option></option>
													<c:forEach items="${leaveHistoryList}"
														var="leaveHistoryList">
														<c:if test="${leaveHistoryList.isInCash==1}">
															<option value="${leaveHistoryList.lvTypeId}"
																data-leavestrname="${leaveHistoryList.lvTitle}"
																id="typeId${leaveHistoryList.lvTypeId}"
																data-bal="${leaveHistoryList.balLeave+leaveHistoryList.lvsAllotedLeaves-leaveHistoryList.sactionLeave-leaveHistoryList.aplliedLeaeve-leaveHistoryList.leaveEncashCount}">${leaveHistoryList.lvTitle}</option>
														</c:if>

													</c:forEach>
												</select> <span class="validation-invalid-label"
													id="error_leaveTypeId" style="display: none;">This
													field is required.</span>
											</div>
										</div>
										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="lvngReson">Select Month <span
												style="color: red">* </span>:
											</label>
											<div class="col-lg-7 float">
												<input type="text" class="form-control "
													placeholder="Select Month " id="datepicker" name="date"
													autocomplete="off" onchange="freezeMonthValidation()">
												<span class="validation-invalid-label"
													id="error_Range_freeze" style="display: none;">This
													field is required.</span>
											</div>

										</div>

									</div>



									<div class="form-group row">
										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="noOfDays">Leave Count <span style="color: red">*
											</span> :
											</label>
											<div class="col-lg-7 float">
												<input type="text" class="form-control numbersOnly"
													placeholder="Encash Leave Count" id="noOfDays"
													name="noOfDays" autocomplete="off"
													onchange="checkLeaveLimitAndCalculation()"> <span
													class="validation-invalid-label" id="error_noOfDays"
													style="display: none;">Leave Minimum 1 Day</span> <input
													type="hidden" class="form-control" id="leaveCanEncash"
													value="1" name="leaveCanEncash">
											</div>
										</div>

										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="lvngReson">AMT : </label>
											<div class="col-lg-7 float">
												<input type="text" class="form-control numbersOnly"
													placeholder=" Leave Encash Amount" id="ammount"
													name="ammount" autocomplete="off" disabled="disabled">

											</div>
										</div>
									</div>

									<div class="form-group row">

										<div class="col-md-6">
											<label class="col-form-label   col-lg-5 float"
												for="lvngReson">Remark : </label>
											<div class="col-lg-7 float">
												<textarea rows="3" cols="3" class="form-control"
													placeholder="Remark" onchange="trim(this)" id="leaveRemark"
													name="leaveRemark"> </textarea>

											</div>
										</div>
									</div>




									<input type="hidden" class="form-control numbersOnly"
										id="empId" value="${editEmp.empId}" name="empId">
									<div class="col-md-12" style="text-align: center;">


										<button type="submit" class="btn blue_btn" id="submtbtn">
											Submit</button>

										<a
											href="${pageContext.request.contextPath}/empListForLeaveIncash"><button
												type="button" class="btn btn-light">Back</button></a>
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

	</div>
	<!-- /page content -->

	<script>
		function freezeMonthValidation() {

			var claimDate = $('#datepicker').val();
			var empId = $('#empId').val();
			var fd = new FormData();

			fd.append('fromDate', '01-' + claimDate);
			fd.append('empId', empId);

			$
					.ajax({
						url : '${pageContext.request.contextPath}/validationForFreezeMonth',
						type : 'post',
						dataType : 'json',
						data : fd,
						contentType : false,
						processData : false,
						success : function(data) {

							if (data.error == true) {
								$("#error_Range_freeze").show();
								$("#error_Range_freeze").html(data.msg);
								$("#leaveCanEncash").val(1);
								document.getElementById("submtbtn").disabled = true;
							} else {
								$("#error_Range_freeze").hide();
								document.getElementById("submtbtn").disabled = false;
								$("#leaveCanEncash").val(0);
							}

						},
					});

		}
		$(document)
				.ready(
						function($) {

							$("#submitInsertLeave")
									.submit(
											function(e) {
												var isError = false;
												var errMsg = "";
												$("#error_leaveTypeId").hide();
												$("#error_noOfDays").hide();
												$("#error_Range").hide();
												$("#error_Range_freeze").hide();

												if (!$("#leaveTypeId").val()) {
													isError = true;
													$("#error_leaveTypeId")
															.show()
												}

												if (!$("#noOfDays").val()
														|| parseFloat($(
																"#noOfDays")
																.val()) == 0) {

													isError = true;

													$("#error_noOfDays").show()

												}

												if (!$("#datepicker").val()) {
													isError = true;
													$("#error_Range_freeze")
															.show();
													$("#error_Range_freeze")
															.html(
																	"This field is required.");

												} else {
													if ($("#leaveCanEncash")
															.val() == 1) {

														isError = true;
														$("#error_Range_freeze")
																.show();
													}
												}

												if (!isError) {
													var option = $(
															"#leaveTypeId option:selected")
															.attr(
																	"data-leavestrname");

													$('#lvType').html(option);
													$('#noOfDays1')
															.html(
																	document
																			.getElementById("noOfDays").value);
													$('#empCode1')
															.html(
																	document
																			.getElementById("empCode").value);
													$('#empName1')
															.html(
																	document
																			.getElementById("empName").value);
													var daterange = document
															.getElementById("datepicker").value;

													$('#fromdate1').html(
															daterange);
													$('#modal_scrollable')
															.modal('show');
													//end ajax send this to php page
												}
												return false;
											});
						});
		//
	</script>
	<script>
		function checkLeaveLimitAndCalculation() {

			$("#error_leaveTypeId").hide();
			$("#error_noOfDays").hide();
			var leaveCount = parseFloat($("#noOfDays").val());
			var leaveTypeId = $("#leaveTypeId").val();
			if (leaveTypeId != "") {

				var bal = parseFloat($("#typeId" + leaveTypeId).data("bal"));

				//alert(bal + " " + leaveCount)
				if (leaveCount > bal) {
					$("#error_noOfDays").html(
							"Insuffient leave count for encash.");
					$("#error_noOfDays").show();
					leaveCount = 0;
					$("#noOfDays").val(0);
				}
				var perday = $("#perday").val();
				//alert(perday)
				var amt = (leaveCount * perday).toFixed(2);
				$("#ammount").val(amt);

			} else {
				$("#error_leaveTypeId").show();
				$("#noOfDays").val(0);
				$("#ammount").val(0.00);
			}

		}
		function trim(el) {
			el.value = el.value.replace(/(^\s*)|(\s*$)/gi, ""). // removes leading and trailing spaces
			replace(/[ ]{2,}/gi, " "). // replaces multiple spaces with one space 
			replace(/\n +/, "\n"); // Removes spaces after newlines
			return;
		}
		function submitForm() {
			$('#modal_scrollable').modal('hide');
			$('#modal_step1').modal('show');
			document.getElementById("submtbtn").disabled = true;
			//document.getElementById("submitInsertLeave").submit();

			var fd = new FormData();
			fd.append('leaveTypeId', $("#leaveTypeId").val());
			fd.append('noOfDays', $("#noOfDays").val());
			fd.append('datepicker', $("#datepicker").val());
			fd.append('leaveRemark', $("#leaveRemark").val());

			$
					.ajax({
						url : '${pageContext.request.contextPath}/submitLeaveEncash',
						type : 'post',
						dataType : 'json',
						data : fd,
						contentType : false,
						processData : false,
						success : function(data) {
							$('#modal_step1').modal('hide');
							window.location = "${pageContext.request.contextPath}/empListForLeaveIncash";

						},
					});
		}

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
	<!-- Scrollable modal -->
	<div id="modal_scrollable" class="modal fade" data-backdrop="false"
		tabindex="-1">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header pb-3">

					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<div class="modal-body py-0">
					<h5 class="modal-title">Details</h5>
					<br>

					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="lvType">
							Employee Code : </label> <label class="col-form-label col-lg-2"
							id="empCode1" for="empCode1"> </label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="lvType">
							Employee Name : </label> <label class="col-form-label col-lg-6"
							id="empName1" for="empName1"> </label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="lvType"> Leave
							Type : </label> <label class="col-form-label col-lg-6" id="lvType"
							for="lvType"> </label>

					</div>


					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="fromdate1">
							Month : </label> <label class="col-form-label col-lg-3" id="fromdate1"
							for="noOfDays1"> </label>
					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="noOfDays">Leave
							Count : </label> <label class="col-form-label col-lg-3" id="noOfDays1"
							for="noOfDays1"> </label>
					</div>
				</div>

				<div class="modal-footer pt-3">
					<button type="button" class="btn btn-link" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn bg-primary" onclick="submitForm()">Submit</button>
				</div>
			</div>
		</div>
	</div>

	<div id="modal_step1" class="modal fade " data-backdrop="false"
		tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header bg-info">
					<h6 class="modal-title"></h6>
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
	<!-- /scrollable modal -->
</body>
</html>
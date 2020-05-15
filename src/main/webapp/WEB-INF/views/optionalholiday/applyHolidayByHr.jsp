<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
												<i class="icon-list-unordered"></i> Apply Optional Holiday
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
									<label class="col-form-label col-lg-2" for="empCode">
										Employee Code : </label>
									<div class="col-lg-10">
										<input type="text" class="form-control"
											placeholder="Employee Code" id="empCode"
											value="${empDetail.empCode}" name="empCode"
											autocomplete="off" onchange="trim(this)" readonly>

									</div>
								</div>
								<div class="form-group row">
									<label class="col-form-label col-lg-2" for="empName">
										Employee Name : </label>
									<div class="col-lg-10">
										<input type="text" class="form-control"
											placeholder="Employee Name" id="empName"
											value="${empDetail.empName}" name="empName"
											autocomplete="off" onchange="trim(this)" readonly>

									</div>
								</div>
								<div class="form-group row">
									<label class="col-form-label col-lg-2" for="hoCatName">
										Holiday Category : </label>
									<div class="col-lg-10">
										<input type="text" class="form-control"
											placeholder="Employee Name" id="hoCatName"
											value="${empDetail.hoCatName}" name="hoCatName"
											autocomplete="off" onchange="trim(this)" readonly>

									</div>
								</div>
								<hr>
								<div class="table-responsive">
									<table
										class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
										id="printtable1">


										<thead>
											<tr class="bg-blue" style="text-align: center;">
												<th>Earned</th>
												<th>Apply</th>
												<th>Approved</th>
												<th>Balanced</th>
											</tr>
										</thead>
										<tbody>
											<tr>

												<td style="text-align: right;">${empDetail.optionalHoliday}</td>
												<td style="text-align: right;">${empDetail.applyHo}</td>
												<td style="text-align: right;">${empDetail.usedHo}</td>
												<td style="text-align: right;">${empDetail.optionalHoliday-empDetail.applyHo-empDetail.usedHo}</td>

											</tr>
										</tbody>
									</table>
								</div>
								<br>
								<form
									action="${pageContext.request.contextPath}/submitApplyHolidayByHr"
									id="submitApplyHoliday" method="post"
									enctype="multipart/form-data">

									<input type="hidden" id="balHidden"
										value="${empDetail.optionalHoliday-empDetail.applyHo-empDetail.usedHo}"
										name="balHidden">
									<div class="form-group row">
										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="holidayId">Select Optional Holiday <span
												style="color: red">* </span>:
											</label>
											<div class="col-lg-7 float">
												<select name="holidayId"
													data-placeholder="Select Optional Holiday" id="holidayId"
													class="form-control form-control-select2 select2-hidden-accessible">
													<option value="">Select Optional Holiday</option>
													<c:forEach items="${holidayList}" var="holidayList">
														<option value="${holidayList.holidayId}"
															data-holiname="${holidayList.exVar2}&nbsp;(${holidayList.holidayFromdt})">${holidayList.exVar2}
															&nbsp; (${holidayList.holidayFromdt})</option>
													</c:forEach>
												</select> <span class="validation-invalid-label" id="error_holidayId"
													style="display: none;">This field is required.</span> <span
													class="validation-invalid-label" id="error_balance"
													style="display: none;">You don't have optional
													holiday.</span>
											</div>
										</div>

									</div>


									<div class="form-group row">


										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="remark">Remark<span style="color: red">*
											</span> :
											</label>
											<div class="col-lg-7 float">
												<textarea rows="3" cols="3" class="form-control"
													placeholder="Remark" onchange="trim(this)" id="remark"
													name="remark"> </textarea>
												<span class="validation-invalid-label" id="error_remark"
													style="display: none;">This field is required.</span>
											</div>
										</div>
									</div>


									<div class="col-md-12" style="text-align: center;">

										<button type="submit" class="btn blue_btn" id="submtbtn">
											Submit</button>

										<a
											href="${pageContext.request.contextPath}/empListForApplyOptionalHoliday"><button
												type="button" class="btn btn-light">Back</button></a>
									</div>
								</form>
								<p class="desc text-danger fontsize11">Note : * Fields are
									mandatory.</p>
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

		$('.daterange-basic_new').daterangepicker({
			applyClass : 'bg-slate-600',
			cancelClass : 'btn-light',
			locale : {
				format : 'DD-MM-YYYY',
				separator : ' to '
			}
		});
	</script>

	<script>
		function trim(el) {
			el.value = el.value.replace(/(^\s*)|(\s*$)/gi, ""). // removes leading and trailing spaces
			replace(/[ ]{2,}/gi, " "). // replaces multiple spaces with one space 
			replace(/\n +/, "\n"); // Removes spaces after newlines
			return;
		}

		$(document)
				.ready(
						function($) {

							$("#submitApplyHoliday")
									.submit(
											function(e) {
												var isError = false;
												var errMsg = "";

												$("#error_holidayId").hide()
												$("#error_remark").hide()
												$("#error_balance").hide()
												if (!$("#holidayId").val()) {

													isError = true;

													$("#error_holidayId")
															.show()
													//return false;
												}

												if ($("#balHidden").val() < 1) {

													isError = true;
													$("#error_holidayId")
															.hide()
													$("#error_balance").show()

												}
												if (!$("#remark").val()) {

													isError = true;

													$("#error_remark").show()
													//return false;
												}

												if (!isError) {
													var option = $(
															"#holidayId option:selected")
															.attr(
																	"data-holiname");

													$('#lvType').html(option);

													$('#empCode1')
															.html(
																	document
																			.getElementById("empCode").value);
													$('#empName1')
															.html(
																	document
																			.getElementById("empName").value);

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
		function submitForm() {
			$('#modal_scrollable').modal('hide');
			document.getElementById("submtbtn").disabled = true;
			document.getElementById("submitApplyHoliday").submit();

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
						<label class="col-form-label col-lg-3" for="lvType">
							Holiday Name : </label> <label class="col-form-label col-lg-6"
							id="lvType" for="lvType"> </label>

					</div>




				</div>

				<div class="modal-footer pt-3">
					<button type="button" class="btn btn-link" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn bg-primary" onclick="submitForm()">Submit</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /scrollable modal -->
</body>
</html>
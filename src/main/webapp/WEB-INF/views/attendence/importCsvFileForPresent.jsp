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
									<i class="icon-list-unordered"></i>UPLOAD CSV FILE FOR MARKING
									PRESENT
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
									action="${pageContext.request.contextPath}/importCsvFileForPresent"
									id="importCsvFileForPresent" method="get">
									<div class="rows">
										<div class="col-md-12">
											<div class="row">
												<div class="col-md-12">
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
															id="submtbtn1">
															Search <i class="icon-paperplane ml-2"></i>
														</button>

													</div>
												</div>
											</div>
										</div>
									</div>
								</form>
								<c:if test="${date!=null}">

									<div class="rows">
										<div class="col-md-12">
											<div class="hidedefault alert bg-danger text-white"
												id="error_step2" style="display: none;"></div>
											<div class="row">
												<div class="col-md-12">
													<form action="#" method="POST"
														enctype="multipart/form-data" method="post"
														accept-charset="utf-8"
														class="form-inline1 justify-content-center">

														<div class="form-group row ">

															<label class="col-md-2 col-form-label" for="doc">Attach
																File:</label>
															<div class="col-md-6">
																<input type="file" class="form-control"
																	placeholder="Enter Location Name" id="doc" name="doc"
																	autocomplete="off"> <span
																	class="form-text text-muted">Accepted formats:
																	CSV </span> <span class="validation-invalid-label"
																	id="error_chk">Attendance will be reset after
																	import attendance sheet.</span>
															</div>
															<div class="col-md-4">
																<button type="button" id="btnUploadCSVSubmit"
																	name="btnUploadCSVSubmit" class="btn btn-primary">
																	upload File <i class="icon-paperplane ml-2"></i>
																</button>
															</div>

														</div>
														<div class="col-md-6">
															<div class="table-responsive">
																<table
																	class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
																	id="printtable2">
																	<thead>
																		<tr class="bg-blue">

																			<th class="text-center">Status</th>
																			<th class="text-center">Count</th>


																		</tr>
																	</thead>
																	<tbody>

																		<c:set var="total" value="0"></c:set>
																		<c:forEach items="${list}" var="list"
																			varStatus="count">


																			<tr>

																				<td>${list.attsSdShow}</td>
																				<td class="text-right">${list.cnt}</td>
																				<c:set var="total" value="${total+list.cnt}"></c:set>
																			</tr>

																		</c:forEach>
																		<tr>

																			<th>Total</th>
																			<th class="text-right">${total}</th>

																		</tr>
																	</tbody>
																</table>
															</div>
														</div>

													</form>
												</div>
											</div>

										</div>
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
	<script type="text/javascript">
		$('.datepickerclass').daterangepicker({
			singleDatePicker : true,
			selectMonths : true,
			selectYears : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});

		$("#btnUploadCSVSubmit")
				.click(
						function(e) {

							$("#error_step2").html("");
							$("#error_step2").hide();

							if ($("#doc").val() != "") {

								$('#modal_step1').modal('show');
								var date = $("#datepicker1").val();

								var fd = new FormData();
								var files = $('#doc')[0].files[0];
								fd.append('file', files);
								fd.append('date', date);

								$
										.ajax({
											url : '${pageContext.request.contextPath}/attUploadCSVForPresentStatus',
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

							} else {
								$("#error_step2")
										.html("Please upload csv file");
								$("#error_step2").show();
							}

						});
	</script>

</body>
</html>
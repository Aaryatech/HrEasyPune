<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
			<div class="page-header page-header-light">


				<%-- <div
					class="breadcrumb-line breadcrumb-line-light header-elements-md-inline">
					<div class="d-flex">
						<div class="breadcrumb">
							<a href="index.html" class="breadcrumb-item"><i
								class="icon-home2 mr-2"></i> Home</a> <span
								class="breadcrumb-item active">Dashboard</span>
						</div>

						<a href="#" class="header-elements-toggle text-default d-md-none"><i
							class="icon-more"></i></a>
					</div>

					<div class="breadcrumb justify-content-center">
						<a href="${pageContext.request.contextPath}/showHolidayList"
							class="breadcrumb-elements-item"> Holiday List</a>

					</div>


				</div> --%>
			</div>
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">

				<!-- Form validation -->
				<div class="row">
					<div class="col-md-12">


						<div class="card">


							<div class="card-header header-elements-inline">
								<h5 class="pageTitle">
									<i class="icon-list-unordered"></i> Edit Holiday
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
									action="${pageContext.request.contextPath}/submitEditHolidayList"
									id="fianlsubmitInsertHoli" method="post">
									<div class="table-responsive">
										<table
											class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
											id="printtable1">


											<thead>
												<tr class="bg-blue" style="text-align: center;">

													<th>Holiday Caption</th>
													<th>Date</th>
													<th>Type</th>
													<th>Remark</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${editHolidayList}" var="holiList"
													varStatus="count">
													<tr>

														<td><input type="text" class="form-control"
															placeholder="Holiday Caption Name"
															id="capName${holiList.holidayId}"
															name="capName${holiList.holidayId}" autocomplete="off"
															onchange="trim(this)" value="${holiList.exVar2}"></td>
														<td><input type="text"
															class="form-control datepickerclass"
															placeholder="Select Date" id="date${holiList.holidayId}"
															name="date${holiList.holidayId}" autocomplete="off"
															value="${holiList.holidayFromdt}"></td>
														<td><select name="typeId${holiList.holidayId}"
															id="typeId${holiList.holidayId}" class="form-control">
																<option value="0"
																	${holiList.exInt3==0 ? 'selected' : ''}>NA</option>
																<option value="1"
																	${holiList.exInt3==1 ? 'selected' : ''}>Fixed</option>
																<option value="2"
																	${holiList.exInt3==2 ? 'selected' : ''}>Optional</option>
														</select></td>
														<td><input type="text" class="form-control  "
															placeholder="Remark"
															id="holidayRemark${holiList.holidayId}"
															name="holidayRemark${holiList.holidayId}"
															autocomplete="off" onchange="trim(this)"
															value="${holiList.holidayRemark}"></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>

										<span class="validation-invalid-label" id="error_notallow"
											style="display: none;">Already Holiday is define of
											selected year for selected category</span>


									</div>
									<br>
									<div class="form-group row mb-0">
										<div style="margin: 0 auto;">

											<button type="submit" class="btn bg-blue ml-3 legitRipple"
												id="submtbtn">
												Submit <i class="icon-paperplane ml-2"></i>
											</button>

											<a href="${pageContext.request.contextPath}/showHolidayList"><button
													type="button" class="btn btn-light">Back</button></a>
										</div>
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
		function trim(el) {
			el.value = el.value.replace(/(^\s*)|(\s*$)/gi, ""). // removes leading and trailing spaces
			replace(/[ ]{2,}/gi, " "). // replaces multiple spaces with one space 
			replace(/\n +/, "\n"); // Removes spaces after newlines
			return;
		}

		function validateEmail(email) {

			var eml = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;

			if (eml.test($.trim(email)) == false) {

				return false;

			}

			return true;

		}
		function validateMobile(mobile) {
			var mob = /^[1-9]{1}[0-9]{9}$/;

			if (mob.test($.trim(mobile)) == false) {

				//alert("Please enter a valid email address .");
				return false;

			}
			return true;

		}
		$(document)
				.ready(
						function($) {

							$("#submitInsertHoliday")
									.submit(
											function(e) {
												var isError = false;
												var errMsg = "";

												if (!$("#holidayTitle").val()) {

													isError = true;

													$("#error_holidayTitle")
															.show()

												} else {
													$("#error_holidayTitle")
															.hide()
												}

												if ($("#locId").val() == "") {

													isError = true;

													$("#error_locId").show()

												} else {
													$("#error_locId").hide()
												}

												if (!$("#dateRange").val()) {

													isError = true;

													$("#error_Range").show()

												} else {
													$("#error_Range").hide()
												}

												if (!$("#hoCatId").val()
														|| parseInt($(
																"#hoCatId")
																.val()) == 0) {

													isError = true;

													$("#error_hoCatId").show()

												} else {
													$("#error_hoCatId").hide()
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

		//daterange-basic_new
		// Basic initialization
		$('.daterange-basic_new').daterangepicker({
			applyClass : 'bg-slate-600',

			cancelClass : 'btn-light',
			locale : {
				format : 'DD-MM-YYYY',
				separator : ' to '
			}
		});
	</script>

</body>
</html>
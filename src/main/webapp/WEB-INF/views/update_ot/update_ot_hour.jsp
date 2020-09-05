<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-datepicker.css"
	type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-datepicker.js"></script>

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
						<div class="card">
							<div class="card-header header-elements-inline">
								<table width="100%">
									<tr width="100%">
										<td width="60%"><h5 class="pageTitle">
												<i class="icon-list-unordered"></i> Manage OT Hours
											</h5></td>
										<td width="40%" align="right"></td>
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

								<c:set value="0" var="step1"></c:set>
								<div class="tab-content">

									<form
										action="${pageContext.request.contextPath}/searchEmpOTDataForm"
										id="searchEmpOTDataForm" method="get">
										<div class="form-group row">

											<div class="col-md-6">
												<label
													class="col-form-label text-info font-weight-bold col-lg-5 float"
													for="locId"> Select Employee <span
													class="text-danger">* </span>:
												</label>
												<div class="col-lg-7 float">
													<select name="empId" data-placeholder="Select Employee"
														id="empId"
														class="form-control form-control-select2 select2-hidden-accessible"
														data-fouc="" aria-hidden="true">

														<option selected disabled value="">Select
															Employee</option>

														<c:forEach items="${empList}" var="emp">
															<c:choose>
																<c:when test="${emp.empId eq empId}">
																	<option value="${emp.exVar1}" selected>${emp.firstName}
																		${emp.surname} ${emp.empCode}</option>
																</c:when>
																<c:otherwise>
																	<option value="${emp.exVar1}">${emp.firstName}
																		${emp.surname} ${emp.empCode}</option>
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</select><span class="validation-invalid-label"
														id="error_assignDate" style="display: none;">This
														field is required.</span>
												</div>

											</div>
											<div class="col-md-2">
												<!-- <label for="staticEmail" class="col-md-1 col-form-label">Month
														: </label> -->


												<input type="text" placeholder="Select Month"
													name="selectMonth" id="datepicker" class="form-control"
													value="${month}" required />

											</div>

											<div class="col-md-4">
												<input type="submit" class="btn btn-primary" value="Search"
													id="search_btn" onclick="getEmpOtdata1()">
											</div>
										</div>
									</form>

									<form
										action="${pageContext.request.contextPath}/submitEmpOtUpdt"
										id="submitEmpShiftList" method="post">

										<div class="form-group row"></div>

										<!-- Left fixed column -->
										<div class="table-responsive">
											<table
												class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
												width="100%" id="printtable1">
												<thead>
													<tr class="bg-blue">
														<th class="text-center;">Date</th>
														<th class="text-center;">Day</th>
														<th class="text-center">OT Hours</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${dailyList}" var="daily"
														varStatus="count">
														<tr>
															<c:set var="d1" value="${daily.attDate}" />

															<td>${daily.attDate}</td>
															<td>${daily.dayName}</td>
															<td><input type="text" data-mask="99:99"
																class="form-control" id="ot_hr${daily.id}"
																value="${daily.otHr}" name="ot_hr${daily.id}"></td>
														</tr>
													</c:forEach>

												</tbody>
											</table>
										</div>
										<span class="validation-invalid-label" id="error_chk"
											style="display: none;">Please Select the Employee.</span><br>
										<!-- /left fixed column -->

										<c:if test="${isAdd==1}">
											<div style="text-align: center;">

												<button type="submit" class="mr-3 btn btn-primary     "
													id="btnActStep2">
													Update OT <i class="icon-paperplane ml-2"></i>
												</button>
											</div>
										</c:if>
									</form>


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


	<!-- /page content -->

	<script type="text/javascript">
		$('.datatable-fixed-left_custom').DataTable({

			columnDefs : [ {
				orderable : false,
				targets : [ 0 ]
			} ],
			//scrollX : true,
			scrollX : true,
			scrollY : '50vh',
			scrollCollapse : true,
			paging : false,
			fixedColumns : {
				leftColumns : 1,
				rightColumns : 0
			}

		});

		function getEmpOtdata() {

			var form = document.getElementById("searchEmpOTDataForm");
			var month = "OCT";
			var empId = "Pppp";
			form.action = "searchEmpOTDataForm?month=" + month + "&empId="
					+ empId;
			form.submit();
		}//end of function getEmpOtdata()
	</script>
	<script type="text/javascript">
		$(document).ready(function($) {
			$("#submitEmpShiftList").submit(function(e) {

				var table = $('#printtable1').DataTable();
				table.search("").draw();
				var isError = false;
				var errMsg = "";
				/* var shiftId = $("#shiftId")
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
				} */

				if (!isError) {

					var x = true;
					if (x == true) {

						document.getElementById("btnActStep2").disabled = true;

						return true;
					}
					//end ajax send this to php page
				}
				return false;
			});
		});
	</script>

	<script type="text/javascript">
		/* $('.datatable-fixed-left_custom').DataTable({

			columnDefs : [ {
				orderable : false,
				targets : [ 1 ]
			}, {
				width : "50px",
				targets : [ 2 ]
			}, {
				width : "50px",
				targets : [ 0 ]
			}, {
				width : "400px",
				targets : [ 1 ]
			} ],
			scrollX : true,
			//scrollY : '600px',
			scrollCollapse : true,
			paging : false,

			fixedColumns : {
				leftColumns : 1
			}

		}); */

		$('.daterange-basic_new').daterangepicker({
			applyClass : 'bg-slate-600',
			cancelClass : 'btn-light',
			locale : {
				format : 'DD-MM-YYYY',
				separator : ' to '
			}
		});

		$(document).ready(function() {
			// month selector
			$('#datepicker').datepicker({
				autoclose : true,
				format : "mm-yyyy",
				viewMode : "months",
				minViewMode : "months"

			});
		});

		$(function() {
			$("#datepicker").datepicker({
				changeMonth : true,
				changeYear : true,
				yearRange : "-50:+50",
				dateFormat : "mm-yy"
			});
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
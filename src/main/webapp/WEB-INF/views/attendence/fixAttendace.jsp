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
						<h5 class="card-title">Freeze Attendance</h5>
						<!-- <div class="header-elements">
							<div class="list-icons">
								<a class="list-icons-item" data-action="collapse"></a>
							</div> 
						</div>-->
					</div>

					<div class="card-body">

						<form
							action="${pageContext.request.contextPath}/submitFixAttendaceByDateAndEmp"
							id="submitFixAttendaceByDateAndEmp" method="post">
							<div class="form-group row">
								<label
									class="col-form-label text-info font-weight-bold col-lg-2"
									for="date">From Date <span style="color: red">*
								</span> :
								</label>
								<div class="col-md-2">
									<input type="text" class="form-control datepickerclass"
										placeholder="Select Date " id="fromDate" name="fromDate"
										value="" autocomplete="off">
								</div>
								<div class="col-lg-1"></div>
								<label
									class="col-form-label text-info font-weight-bold col-lg-2"
									for="date">To Date <span style="color: red">* </span> :
								</label>
								<div class="col-md-2">
									<input type="text" class="form-control datepickerclass"
										placeholder="Select Date " id="toDate" name="toDate" value=""
										autocomplete="off">
								</div>

								<button type="button"
									class="btn bg-blue ml-3 legitRipple bootbox_custom"
									id="submtbtn">
									Submit <i class="icon-paperplane ml-2"></i>
								</button>

							</div>
							<div id="loader" style="display: none;">
								<img
									src="${pageContext.request.contextPath}/resources/assets/images/giphy.gif"
									width="150px" height="150px"
									style="display: block; margin-left: auto; margin-right: auto">
							</div>

							<div class="table-responsive">
								<table
									class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
									id="bootstrap-data-table1">
									<thead>
										<tr class="bg-blue">
											<th width="5%" class="text-center">Sr.no</th>
											<th width="5%" class="text-center">All <input
												type="checkbox" name="selectAll" id="selectAll"></th>
											<th width="10%" class="text-center">EMP Code</th>
											<th class="text-center">EMP Name</th>
										</tr>
									</thead>

									<tbody>
										<c:forEach items="${empList}" var="empList" varStatus="count">
											<tr>
												<td>${count.index+1}</td>
												<td><input type="checkbox" name="selectEmp"
													id="selectEmp${empList.empId}" value="${empList.empId}"></td>
												<td class="text-center">${empList.empCode}</td>
												<td>${empList.firstName}&nbsp;${empList.surname}</td>

											</tr>
										</c:forEach>

									</tbody>
								</table>
							</div>
							<span class="validation-invalid-label" id="error_emp"
								style="display: none;">Select Minimum one employee.</span>
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
	<!-- Info modal -->
	<div id="myModal_checklist" class="modal fade " data-backdrop="false"
		tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header bg-info">
					<h6 class="modal-title">Checklist</h6>
					<!-- <button type="button" class="close" data-dismiss="modal">&times;</button>  -->
				</div>

				<div class="modal-body">
					<h6 class="font-weight-semibold text-center">*Note : Upload
						All Attendance Between Date You Want to Fix.</h6>


				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>

				</div>
			</div>
		</div>
	</div>
	<!-- /info modal -->


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

		$('#selectAll').click(function(event) {
			if (this.checked) {
				// Iterate each checkbox
				$(':checkbox').each(function() {
					this.checked = true;
				});
			} else {
				$(':checkbox').each(function() {
					this.checked = false;
				});
			}
		});
	</script>
	<script type="text/javascript">
		$(window).on('load', function() {
			$('#myModal_checklist').modal('show');
		});
	</script>

	<script>
		// Custom bootbox dialog
		$('.bootbox_custom')
				.on(
						'click',
						function() {
							//var uuid = $(this).data("uuid") // will return the number 123
							$("#error_emp").hide();
							var list = [];

							$("input:checkbox[name=selectEmp]:checked").each(
									function() {
										list.push($(this).val());
									});
							if (list.length > 0) {

								bootbox
										.confirm({
											title : 'Confirm ',
											message : 'Are you sure want to Freeze Attendace? Once it Fixed you will not able to edit any records.',
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
													document
															.getElementById(
																	'submitFixAttendaceByDateAndEmp')
															.submit();

												}
											}
										});
							} else {
								//alert("Select Minimum one employee")
								$("#error_emp").show();
							}
						});
	</Script>
</body>
</html>
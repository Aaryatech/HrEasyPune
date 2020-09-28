<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

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


				<!-- Highlighting rows and columns -->
				<div class="card">
					<div class="card-header header-elements-inline">
						<h5 class="pageTitle">
							<i class="icon-list-unordered"></i> Freeze Attendance
						</h5>
						<!-- <div class="header-elements">
							<div class="list-icons">
								<a class="list-icons-item" data-action="collapse"></a>
							</div> 
						</div>-->
					</div>

					<div class="card-body">

						<%-- <form
							action="${pageContext.request.contextPath}/submitFixAttendaceByDateAndEmp"
							id="submitFixAttendaceByDateAndEmp" method="post"> --%>
						<form
							action="${pageContext.request.contextPath}/fixAttendaceByDateAndEmp"
							id="fixAttendaceByDateAndEmp" method="get">

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
								<label
									class="col-form-label text-info font-weight-bold col-lg-2"
									for="datepicker"> Select Month <span style="color: red">*
								</span> :
								</label>
								<div class="col-md-2">
									<input type="text" name="selectMonth" id="datepicker"
										class="form-control" value="${selectMonth}" required />
								</div>

								<button type="submit" class="btn blue_btn" id="submtbtn">
									Search <i class="icon-paperplane ml-2"></i>
								</button>

							</div>
						</form>
						<div id="loader" style="display: none;">
							<img
								src="${pageContext.request.contextPath}/resources/assets/images/giphy.gif"
								width="150px" height="150px"
								style="display: block; margin-left: auto; margin-right: auto">
						</div>
						<form
							action="${pageContext.request.contextPath}/submitFixAttendaceByDateAndEmp"
							id="submitFixAttendaceByDateAndEmp" method="post">
							<div class="table-responsive">
								<table
									class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
									width="100%" id="printtable1">
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
												<td>${empList.empName}</td>

											</tr>
										</c:forEach>

									</tbody>
								</table>
							</div>
							<span class="validation-invalid-label" id="error_emp"
								style="display: none;">Select Minimum one employee.</span>

							<c:if test="${selectMonth!=null && empList.size()>0}">
								<br>
								<div class="text-center">
									<button type="button"
										class="btn blue_btn ml-3 legitRipple bootbox_custom"
										id="submtbtn">
										Freeze <i class="icon-paperplane ml-2"></i>
									</button>

								</div>
							</c:if>
						</form>
						<p class="desc text-danger fontsize11">Note : * Fields are
							mandatory.</p>
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
	<!-- <script type="text/javascript">
		$(window).on('load', function() {
			$('#myModal_checklist').modal('show');
		});
	</script> -->

	<script>
		// Custom bootbox dialog
		$('.bootbox_custom')
				.on(
						'click',
						function() {
							//var uuid = $(this).data("uuid") // will return the number 123
							var table = $('#printtable1').DataTable();
							table.search("").draw();
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
											message : 'Have you upload attendance of the selected month of employee?',
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
	<script type="text/javascript">
		$('.datatable-fixed-left_custom').DataTable({

			columnDefs : [ {
				orderable : false,
				targets : [ 0 ]
			} ],
			"order" : [],
			//scrollX : true,
			scrollX : true,
			scrollY : '65vh',
			scrollCollapse : true,
			paging : false,
			fixedColumns : {
				leftColumns : 1,
				rightColumns : 0
			}

		});
	</script>
</body>
</html>
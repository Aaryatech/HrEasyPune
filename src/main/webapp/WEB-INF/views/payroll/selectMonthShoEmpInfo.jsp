<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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


				<!-- Highlighting rows and columns -->
				<div class="card">
					<div class="card-header header-elements-inline">
						<h5 class="pageTitle">
							<i class="icon-list-unordered"></i> Employee Salary Information
							For Payroll process
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
							action="${pageContext.request.contextPath}/selectMonthForPayRoll"
							id="selectMonthForPayRoll" method="get">
							<div class="form-group row">
								<label
									class="col-form-label text-info font-weight-bold col-lg-2"
									for="datepicker"> Select Month <span style="color: red">*
								</span> :
								</label>
								<div class="col-md-2">
									<input type="text" name="selectMonth" id="datepicker"
										class="form-control" value="${date}" required />
								</div>

								<button type="submit" class="btn blue_btn ml-3 legitRipple"
									id="submtbtn">
									Search <i class="icon-paperplane ml-2"></i>
								</button>

							</div>
						</form>
						<form action="${pageContext.request.contextPath}/viewDynamicValue"
							id="viewDynamicValue" method="post">

							<input type="hidden" name="searchDate" id="searchDate"
								value="${date}" />
							<div id="loader" style="display: none;">
								<img
									src="${pageContext.request.contextPath}/resources/assets/images/giphy.gif"
									width="150px" height="150px"
									style="display: block; margin-left: auto; margin-right: auto">
							</div>

							<div class="table-responsive">
								<table
									class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
									width="100%" id="printtable1">
									<thead>
										<tr class="bg-blue">
											<th class="text-center">EMP Name</th>
											<th width="5%" class="text-center">All <input
												type="checkbox" name="selectAll" id="selectAll"></th>
											<th class="text-center">EMP Type</th>
											<th class="text-center">Salary STR.</th>
											<th class="text-center">Department</th>
											<th class="text-center">Designation</th>
											<th class="text-center">Location</th>
											<th class="text-center">Salary Basis</th>
											<th class="text-center">Gross Sal</th>
											<th class="text-center">Basic</th>
											<!-- <th class="text-center">PT</th>
											<th class="text-center">PF</th>
											<th class="text-center">ESIC</th>
											<th class="text-center">MLWF</th>
											<th class="text-center">Basic</th>
											<th class="text-center">DA</th>
											<th class="text-center">HRA</th>
											<th class="text-center">CONV</th>
											<th class="text-center">PER</th>
											<th class="text-center">Tel</th>
											<th class="text-center">Med</th>
											<th class="text-center">Edu</th>
											<th class="text-center">Veh</th>
											<th class="text-center">Oth1</th>
											<th class="text-center">Oth2</th>
											<th class="text-center">Gross Salary</th> -->

											<c:forEach items="${allownceList}" var="allownceList">
												<th class="text-center" title="${allownceList.name}">${allownceList.name}</th>
											</c:forEach>

										</tr>


									</thead>

									<tbody>
										<c:forEach items="${empList}" var="empList" varStatus="count">
											<tr>
												<td>${empList.empName}&nbsp;(${empList.empCode})<c:if
														test="${empList.canGenerateSal==0}">
														<br>(Can not generate salary for selected month. Clear previous salary.)
													</c:if></td>
												<td><c:if test="${empList.canGenerateSal==1}">
														<input type="checkbox" name="selectEmp"
															id="selectEmp${empList.empId}" value="${empList.empId}">
													</c:if></td>
												<td>${empList.empTypeName}</td>
												<td>${empList.salTypeName}</td>
												<td>${empList.deptName}</td>
												<td>${empList.designation}</td>
												<td>${empList.locName}</td>
												<td>${empList.salBasis}</td>
												<td class="text-right">${empList.grossSalary}</td>
												<td class="text-right">${empList.basic}</td>
												<%-- <td>${empList.pfType}</td>
												<td>${empList.pfApplicable}</td>
												<td>${empList.esicApplicable}</td>
												<td>${empList.mlwfApplicable}</td>
												<td>${empList.basic}</td>
												<td>${empList.da}</td>
												<td>${empList.hra}</td>
												<td>${empList.empCode}</td>
												<td>${empList.empCode}</td>
												<td>${empList.empCode}</td>
												<td>${empList.empCode}</td>
												<td>${empList.empCode}</td>
												<td>${empList.empCode}</td>
												<td>${empList.empCode}</td>
												<td>${empList.empCode}</td>
												<td>${empList.empCode}</td> --%>
												<c:forEach items="${allownceList}" var="allownceList">
													<td class="text-right"><c:forEach
															items="${empList.empAllowanceList}"
															var="empAllowanceList">
															<c:if
																test="${allownceList.allowanceId==empAllowanceList.allowanceId}">
															${empAllowanceList.value}
														</c:if>
														</c:forEach></td>
												</c:forEach>
											</tr>
										</c:forEach>

									</tbody>
								</table>
							</div>
							<span class="validation-invalid-label" id="error_emp"
								style="display: none;">Select Minimum one employee.</span>
							<c:if test="${date!=null && empList.size()>0}">
								<br>
								<div class="text-center">

									<button type="button" class="btn blue_btn ml-3 legitRipple"
										id="submtbtn" onclick="submitForm()">
										Submit <i class="icon-paperplane ml-2"></i>
									</button>

								</div>
							</c:if>
						</form>
					</div>

				</div>
				<!-- /highlighting rows and columns -->

			</div>
			<!-- /content area -->

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
							<h6 class="font-weight-semibold text-center">
								*Note : Confirm Salary Structure of employee.<br>*Note :
								Assign Skill Rate Of Employee.
							</h6>


						</div>

						<div class="modal-footer">
							<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>

						</div>
					</div>
				</div>
			</div>
			<!-- /info modal -->
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
			}, {
				orderable : false,
				targets : [ 1 ]
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
	<script type="text/javascript">
		// Single picker
		/* $(function() {
			$("#datepicker").datepicker({
				changeMonth : true,
				changeYear : true,
				yearRange : "-50:+50",
				dateFormat : "mm-yy"
			});
		}); */

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
		/* $(window).on('load', function() {
			$('#myModal_checklist').modal('show');
		}); */
		function submitForm() {

			var table = $('#printtable1').DataTable();
			table.search("").draw();
			$("#error_emp").hide();
			var list = [];

			$("input:checkbox[name=selectEmp]:checked").each(function() {
				list.push($(this).val());
			});
			if (list.length > 0) {
				document.getElementById('viewDynamicValue').submit();
			} else {
				//alert("Select Minimum one employee")
				$("#error_emp").show();
			}
		}
	</script>
	<script type="text/javascript">
		// Single picker
		/* $("#datepicker").datepicker({
			changeMonth : true,
			changeYear : true,
			yearRange : "-50:+50",
			dateFormat : "mm-yy"
		}); */

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
</body>
</html>
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
						<h5 class="pageTitle"><i class="icon-list-unordered"></i> Leave Cash Paid List</h5>
						<!-- <div class="header-elements">
							<div class="list-icons">
								<a class="list-icons-item" data-action="collapse"></a>
							</div> 
						</div>-->
					</div>

					<div class="card-body">

						<form
							action="${pageContext.request.contextPath}/getPaidListOfleaveCash"
							id="submitInsertLeave" method="get">
							<div class="form-group row">
								<label
									class="col-form-label text-info font-weight-bold col-lg-2"
									for="select2">Select Year <span style="color: red">*
								</span> :
								</label>
								<div class="col-md-2">
									<select name="calYrId" data-placeholder="Select Year"
										id="calYrId"
										class="form-control form-control-select2 select2-hidden-accessible"
										tabindex="-1" aria-hidden="true" required>
										<option value="">Select Calendar Year</option>
										<c:forEach items="${calYearList}" var="calYear">

											<c:choose>
												<c:when test="${yearId==calYear.calYrId}">
													<option value="${calYear.calYrId}" selected>${calYear.calYrFromDate}
														to ${calYear.calYrToDate}</option>
												</c:when>
												<c:otherwise>
													<option value="${calYear.calYrId}">${calYear.calYrFromDate}
														to ${calYear.calYrToDate}</option>
												</c:otherwise>
											</c:choose>

										</c:forEach>
									</select> <span class="validation-invalid-label" id="error_calYrId"
										style="display: none;">This field is required.</span>
								</div>
								<div class="col-lg-1"></div>
								<button type="submit" class="btn blue_btn"
									id="search">Search</button>

							</div>
						</form>
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

										<th width="10%" class="text-center">EMP Code</th>
										<th class="text-center">EMP Name</th>
										<th width="10%" class="text-center">Leave Count</th>
										<th width="10%" class="text-center">Cash</th>
										<th width="10%" class="text-center">Paid Date</th>
									</tr>
								</thead>

								<tbody>
									<c:forEach items="${list}" var="empList" varStatus="count">
										<tr>
											<td>${count.index+1}</td>

											<td class="text-center">${empList.empCode}</td>
											<td>${empList.firstName}&nbsp;${empList.surname}</td>
											<td class="text-right">${empList.leaveCount}</td>
											<td class="text-right">${empList.cash}</td>
											<td class="text-center">${empList.paidDate}</td>
										</tr>
									</c:forEach>

								</tbody>
							</table>

						</div>
						<br>



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
		// Single picker
		$('.datepickerclass').daterangepicker({
			singleDatePicker : true,
			selectMonths : true,
			selectYears : true,
			locale : {
				format : 'DD-MM-YYYY'
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

</body>
</html>
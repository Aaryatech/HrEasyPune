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
<style type="text/css">
.clr {
	clear: both;
}
</style>
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
							<i class="icon-list-unordered"></i> Monthly Roaster Sheet
						</h5>
						<!-- <div class="header-elements">
							<div class="list-icons">
								<a class="list-icons-item" data-action="collapse"></a>
							</div> 
						</div>-->
					</div>

					<div class="card-body">

						<form
							action="${pageContext.request.contextPath}/routeassignmonthlysheet"
							id="submitInsertLeave" method="get">
							<div class="form-group row">
								<label
									class="col-form-label text-info font-weight-bold col-lg-2"
									for="date">Select Month <span style="color: red">*
								</span> :
								</label>
								<div class="col-md-2">
									<input type="text" class="form-control "
										placeholder="Select Date " id="datepicker" name="date"
										value="06-2020" autocomplete="off">
								</div>



								<button type="submit" class="btn blue_btn" id="submtbtn">
									Search <i class="icon-paperplane ml-2"></i>
								</button>

								<!-- <button type="button" class="btn bg-blue ml-3 legitRipple"
									id="submtbtn"
									onclick="getProgReport(0,'exelForEmployeeTypeWiseClaim')">
									Excel <i class="icon-paperplane ml-2"></i>
								</button> -->

							</div>
						</form>
						<div id="loader" style="display: none;">
							<img
								src="${pageContext.request.contextPath}/resources/assets/images/giphy.gif"
								width="150px" height="150px"
								style="display: block; margin-left: auto; margin-right: auto">
						</div>
						<ul class="nav nav-tabs nav-tabs-highlight nav-justified1">
							<li class="nav-item"><a href="#highlighted-justified-tab1"
								class="nav-link active" data-toggle="tab">View Monthly </a></li>
							<li class="nav-item"><a href="#highlighted-justified-tab2"
								class="nav-link" data-toggle="tab">View Summary </a></li>

						</ul>

						<div class="tab-content">
							<div class="tab-pane fade show active"
								id="highlighted-justified-tab1">
								<div class="table-responsive">
									<!-- <table
										class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
										id="bootstrap-data-table"> -->
									<table class="table datatable-fixed-left_custom" width="100%"
										id="printtable1">
										<!-- <table
										class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
										width="100%" id="printtable1"> -->
										<thead>
											<tr class="bg-blue">
												<!-- <th style="text-align: center;">Sr.no</th> -->
												<th style="text-align: center;">Driver Code</th>
												<th style="text-align: center;">Driver Name</th>
												<th style="text-align: center;">Month</th>
												<th style="text-align: center;">Year</th>
												<c:forEach items="${roasterSheetData.dateAndDayList}"
													var="dates" varStatus="count">
													<th style="text-align: center;">${count.index+1}<br>${dates.day}</th>
												</c:forEach>
												<th style="text-align: center;">Edit</th>
											</tr>

										</thead>

										<tbody>
											<c:forEach items="${roasterSheetData.infomationList}"
												var="infomationList" varStatus="count">
												<tr>
													<td>${count.index+1}</td>
													<td style="text-align: center;">${infomationList.empCode}</td>
													<td>${infomationList.empName}</td>
													<td style="text-align: right;">${month}</td>
													<td style="text-align: right;">${year}</td>
													<c:forEach items="${infomationList.sttsList}"
														var="sttsList">
														<td style="text-align: center;">
															${sttsList.routeName}</td>
													</c:forEach>
													<td class="text-center"><c:if
															test="${editAccess == 0}">
															<a
																href="${pageContext.request.contextPath}/attendanceEditEmpMonth?month=${month}&year=${year}&empId=${infomationList.driverId}"
																class="list-icons-item text-primary-600"
																data-popup="tooltip" title="" data-original-title="Edit"><i
																class="icon-pencil7"></i></a>
														</c:if></td>
												</tr>
											</c:forEach>


										</tbody>
									</table>
								</div>
							</div>
							<div class="tab-pane fade" id="highlighted-justified-tab2">


								<div class="table-responsive">
									<table
										class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
										id="bootstrap-data-table1">
									<!-- <table class="table  table-bordered  table-hover table-striped"
										width="100%" id="printtable2"> -->
										<thead>
											<tr class="bg-blue">
												<th width="5%" class="text-center">Sr.no</th>
												<th class="text-center">Driver Code</th>
												<th class="text-center">Driver Name</th>
												<th class="text-center">Long Route</th>
												<th class="text-center">Short Route</th>
												<th class="text-center">FF/Off Days</th>
												<th class="text-center">Late Mark</th>
												<th class="text-center">Late Min</th>
												<th class="text-center">Incentive</th>
											</tr>
										</thead>

										<tbody>

											<tr>
												<td>1</td>
												<td>AD001</td>
												<td>Akshay Kasar</td>
												<td class="text-right">1</td>
												<td class="text-right">0</td>
												<td class="text-right">1/0</td>
												<td class="text-right">0</td>
												<td class="text-right">0</td>
												<td class="text-right">2000</td>
											</tr>
											<c:forEach items="${summrylist}" var="summrylist"
												varStatus="count">
												<tr>
													<td>${count.index+1}</td>
													<td>${summrylist.empCode}</td>
													<td>${summrylist.empName}</td>
													<td class="text-right">${summrylist.workingDays}</td>
													<td class="text-right">${summrylist.presentDays}</td>
													<td class="text-right">${summrylist.absentDays+summrylist.unpaidLeave}</td>
													<td class="text-right">${summrylist.weeklyOff}</td>
													<td class="text-right">${summrylist.paidHoliday}</td>
													<td class="text-right">${summrylist.paidLeave}</td>
													<td class="text-right">${summrylist.unpaidHoliday}</td>
													<%-- <td class="text-right">${summrylist.unpaidLeave}</td> --%>
													<td class="text-right">${summrylist.totlateMins}</td>
													<td class="text-right">${summrylist.totLate}</td>
													<td class="text-right">${summrylist.payableDays}</td>
													<%-- <td class="text-right">${summrylist.ncpDays}</td> --%>
													<td class="text-right">${summrylist.totworkingHrs}</td>
													<td class="text-right">${summrylist.totOthr}</td>
													<td class="text-center">${summrylist.salBasis}</td>
												</tr>
											</c:forEach>

										</tbody>
									</table>

									<div class="clr"></div>
								</div>
							</div>
						</div>

					</div>

				</div>
				<!-- /highlighting rows and columns -->

			</div>
			<!-- /content area -->
			<!-- Content area -->

			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>

			<!-- /footer -->


			<!-- /main content -->

		</div>
		<!-- /page content -->
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

		<script type="text/javascript">
			$('.datatable-fixed-left_custom').DataTable({

				columnDefs : [ {
					orderable : false,
					targets : [ 0 ]
				} ],
				//scrollX : true,
				scrollX : true,
				scrollY : '65vh',
				scrollCollapse : true,
				paging : false,
				fixedColumns : {
					leftColumns : 2,
					rightColumns : 1
				}

			});
		</script>
</body>
</html>
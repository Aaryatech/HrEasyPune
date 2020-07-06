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
										value="${date}" autocomplete="off">
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
									<!-- <table class="table datatable-fixed-left_custom" width="100%"
										id="printtable1"> -->
									<table
										class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
										width="100%" id="printtable1">
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
												<th style="text-align: center;">View</th>
											</tr>

										</thead>

										<tbody>
											<c:forEach items="${roasterSheetData.infomationList}"
												var="infomationList" varStatus="count">
												<tr>

													<td style="text-align: center;">${infomationList.empCode}</td>
													<td>${infomationList.empName}</td>
													<td style="text-align: right;">${month}</td>
													<td style="text-align: right;">${year}</td>
													<c:forEach items="${infomationList.sttsList}"
														var="sttsList">
														<td style="text-align: center;"><c:choose>
																<c:when test="${sttsList.routeId!=0}">${sttsList.routeName}</c:when>
																<c:when test="${sttsList.isoffdayIsff==1}">Off Day</c:when>
																<c:when test="${sttsList.isoffdayIsff==2}">FF</c:when>
																<c:otherwise>NA</c:otherwise>
															</c:choose></td>
													</c:forEach>
													<td class="text-center"><a
														href="${pageContext.request.contextPath}/showRosterdatewise?month=${month}&year=${year}&empId=${infomationList.empId}"
														class="list-icons-item text-primary-600"
														data-popup="tooltip" title="" data-original-title="View"><i
															class="icon-list"></i></a></td>
												</tr>
											</c:forEach>


										</tbody>
									</table>
								</div>
							</div>
							<div class="tab-pane fade" id="highlighted-justified-tab2">


								<div class="table-responsive">
									<!-- <table
										class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
										id="bootstrap-data-table1"> -->
									<table class="table  table-bordered  table-hover table-striped"
										width="100%" id="printtable2">
										<thead>
											<tr class="bg-blue">

												<th class="text-center">Driver Code</th>
												<th class="text-center">Driver Name</th>
												<c:forEach items="${roasterSheetData.routeTypelist}"
													var="routeTypelist">
													<th style="text-align: center;">${routeTypelist.typeName}</th>
												</c:forEach>
												<th class="text-center">FF/Off Days</th>
												<th class="text-center">Late Mark</th>
												<th class="text-center">Late Min</th>
												<th class="text-center">Incentive</th>
											</tr>
										</thead>

										<tbody>

											<!-- <tr>
												<td>1</td>
												<td>AD001</td>
												<td>Akshay Kasar</td>
												<td class="text-right">1</td>
												<td class="text-right">0</td>
												<td class="text-right">1/0</td>
												<td class="text-right">0</td>
												<td class="text-right">0</td>
												<td class="text-right">2000</td>
											</tr> -->
											<c:forEach
												items="${roasterSheetData.roasterSummeryDetailList}"
												var="roasterSummeryDetailList" varStatus="count">
												<tr>


													<td>${roasterSummeryDetailList.empCode}</td>
													<td>${roasterSummeryDetailList.firstName}&nbsp;${roasterSummeryDetailList.surname}</td>
													<c:forEach items="${roasterSheetData.routeTypelist}"
														var="routeTypelist">
														<c:set value="0" var="typeCount"></c:set>
														<c:forEach items="${roasterSheetData.typeWiseRoasterList}"
															var="typeWiseRoasterList">


															<c:if
																test="${routeTypelist.typeId==typeWiseRoasterList.typeId && roasterSummeryDetailList.empId==typeWiseRoasterList.driverId}">
																<c:set value="${typeWiseRoasterList.typeCount}"
																	var="typeCount"></c:set>
															</c:if>

														</c:forEach>
														<td class="text-right">${typeCount}</td>
													</c:forEach>

													<td class="text-right">${roasterSummeryDetailList.ffCount}/${roasterSummeryDetailList.offDayCount}</td>
													<td class="text-right">${roasterSummeryDetailList.lateMark}</td>
													<td class="text-right">${roasterSummeryDetailList.lateMin}</td>
													<td class="text-right">${roasterSummeryDetailList.incentive}</td>
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
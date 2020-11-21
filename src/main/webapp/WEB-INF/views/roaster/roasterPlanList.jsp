<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
						<h5 class="pageTitle">
							<i class="icon-list-unordered"></i>Roaster Plan List
						</h5>

						<c:if test="${addAccess == 0}">
							<a href="${pageContext.request.contextPath}/synchronizeRoute"
								class="breadcrumb-elements-item">
								<button type="button" class="btn blue_btn">Synchronize
									Route</button>
							</a>
						</c:if>
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
						%><form
							action="${pageContext.request.contextPath}/getRoasterPlanList"
							id="attendaceSheetForHrDateWise" method="get">
							<div class="form-group row">
								<label
									class="col-form-label text-info font-weight-bold col-lg-2"
									for="date">Select Date <span style="color: red">*
								</span> :
								</label>
								<div class="col-md-2">
									<input type="text" class="form-control datepickerclass"
										placeholder="Select Date " id="date" name="date"
										value="${date}" autocomplete="off">
								</div>



								<button type="submit" class="btn bg-blue ml-3 legitRipple"
									id="submtbtn1">
									Search <i class="icon-paperplane ml-2"></i>
								</button>

							</div>
						</form>
						<!-- <table
							class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
							id="printtable1"> -->
						<table
							class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
							width="100%" id="printtable1">
							<thead>
								<tr class="bg-blue">

									<th class="text-center" width="10%">Sr. No.</th>
									<th class="text-center" width="10%">Date</th>
									<th class="text-center">Driver Name</th>
									<th class="text-center">Duty</th>
								</tr>
							</thead>
							<tbody>


								<c:forEach items="${list}" var="list" varStatus="count">
									<tr>
										<td class="text-left">${count.index+1}</td>
										<td class="text-center">${date}</td>
										<td class="text-left">${list.firstName}&nbsp;${list.surname}</td>
										<td class="text-left"><c:choose>
												<c:when test="${list.routeId!=0}">${list.routeName}</c:when>
												<c:when test="${list.isoffdayIsff==1}">Off Day</c:when>
												<c:when test="${list.isoffdayIsff==2}">FF</c:when>
												<c:when test="${list.isoffdayIsff==3}">Night Shift</c:when>
												<c:otherwise>NA</c:otherwise>
											</c:choose></td>
									</tr>
								</c:forEach>


							</tbody>
						</table>
						<c:if test="${list.size()>0}">


							<div class="text-center">

								<button type="button" class="btn blue_btn ml-3 legitRipple"
									id="excel" onclick="commonPdf()">PDF</button>
								<button type="button" class="btn blue_btn ml-3 legitRipple"
									id="excel"
									onclick="getProgReport(0,'excelForRoutePlanList')">
									Excel</button>
							</div>

						</c:if>
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
	<script type="text/javascript">
		//use this function for all reports just get mapping form action name dynamically as like of prm from every report pdf,excel function	
		function getProgReport(prm, mapping) {

			var date = document.getElementById("date").value;

			window.open("${pageContext.request.contextPath}/" + mapping + "/"
					+ date + "/", "_blank");

		}
	</script>

	<script type="text/javascript">
		function commonPdf() {

			var date = document.getElementById("date").value;
			 
				window.open('pdfForReport?url=/pdf/generatedRoutePlanPdf/' + date);
		 

		}
	</script>
	<script type="text/javascript">
		$('.datatable-fixed-left_custom').DataTable({

			columnDefs : [ {
				orderable : false,
				targets : [ 1 ]
			} ],
			//scrollX : true,
			scrollX : true,
			scrollY : '65vh',
			scrollCollapse : true,
			paging : false,
			fixedColumns : {
				leftColumns : 0,
				rightColumns : 0
			}

		});
	</script>
	<script>
		$('.datepickerclass').daterangepicker({
			singleDatePicker : true,
			selectMonths : true,
			selectYears : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});
		// Custom bootbox dialog
		$('.bootbox_custom')
				.on(
						'click',
						function() {
							var uuid = $(this).data("uuid") // will return the number 123
							bootbox
									.confirm({
										title : 'Confirm ',
										message : 'Are you sure you want to delete selected records ?',
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
												location.href = "${pageContext.request.contextPath}/deleteLocation?locId="
														+ uuid;

											}
										}
									});
						});
	</Script>
</body>
</html>
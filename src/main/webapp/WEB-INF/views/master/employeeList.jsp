<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>

<body>
	<%-- <c:url var="getEmployeeProfile" value="/getEmployeeProfile"></c:url> --%>
	<c:url var="showEmployeeProfile" value="/showEmployeeProfile"></c:url>
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
						<table width="100%">
							<tr width="100%">
								<td width="40%"><h5 class="pageTitle">
										<i class="icon-list-unordered"></i> Employee List
									</h5></td>
								<td width="60%" align="right"><c:if test="${addAccess==0}">
										<a href="${pageContext.request.contextPath}/showEmpFileUpload"
											class="">
											<button type="button"
												class="btn blue_btn legitRipple legitRipple-empty">Import
												Emp Excel</button>
										</a>
										<a href="${pageContext.request.contextPath}/showEmpSalUpload"
											class="">
											<button type="button"
												class="btn blue_btn legitRipple legitRipple-empty">Upload
												Salary Data</button>
										</a>
										<a href="${pageContext.request.contextPath}/employeeAdd"
											class="">
											<button type="button"
												class="btn blue_btn legitRipple legitRipple-empty">Add
												Employee</button>
										</a>
									</c:if></td>
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
						<table
							class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
							id="printtable1">
							<thead>
								<tr class="bg-blue">

									<th class="text-center" width="10%">Sr. No.</th>
									<th class="text-center">Emp Code</th>
									<th class="text-center">Name</th>
									<th class="text-center">Emp Type</th>
									<th class="text-center">Dept.</th>
									<th class="text-center">Desig</th>
									<th class="text-center">Location</th>
									<th width="10%" class="text-center">Actions</th>
								</tr>
							</thead>
							<tbody>


								<c:forEach items="${empList}" var="empList" varStatus="count">
									<tr>
										<td>${count.index+1}</td>
										<td>${empList.empCode}</td>

										<td><a href="#" onclick="getEmpData('${empList.exVar1}')"
											class="breadcrumb-elements-item">
												${empList.firstName}&nbsp;${empList.middleName}&nbsp;${empList.surname}</a>
										</td>
										<!--  data-toggle="modal" data-target="#modal_large" -->
										<td>${empList.empTypeName}</td>
										<td>${empList.deptName}</td>
										<td>${empList.empDesgn}</td>
										<td>${empList.locName}</td>
										<%-- <td>${empList.micrCode}</td>
										<td>${empList.ifscCode}</td>  --%>


										<td class="text-center"><a
											href="${pageContext.request.contextPath}/getProfilenormal?empId=${empList.exVar1}"
											class="list-icons-item text-primary-600" data-popup="tooltip"
											title="" data-original-title="View Employee"><i
												class="icon-list"></i></a> <c:if test="${editAccess == 0}">
												<a
													href="${pageContext.request.contextPath}/employeeEdit?empId=${empList.exVar1}"
													class="list-icons-item text-primary-600"
													data-popup="tooltip" title="" data-original-title="Edit"><i
													class="icon-pencil7"></i></a>
											</c:if> <c:if test="${deleteAccess == 0}">

												<a href="javascript:void(0)"
													class="list-icons-item text-danger-600 bootbox_custom"
													data-uuid="${empList.exVar1}" data-popup="tooltip" title=""
													data-original-title="Delete"><i class="icon-trash"></i></a>
											</c:if> <a
											href="${pageContext.request.contextPath}/showEmpGraphs?empId=${empList.exVar1}"
											class="list-icons-item text-primary-600" data-popup="tooltip"
											title="" data-original-title="Graphs & Reports"><i
												class="icon-history" style="color: black;"></i></a> <a
											href="${pageContext.request.contextPath}/generateLetters?empId=${empList.exVar1}"
											class="list-icons-item text-primary-600" data-popup="tooltip"
											title="" data-original-title="Generate Letters"><i
												class="fa fa-print" aria-hidden="true"></i> </a></td>
									</tr>
								</c:forEach>

							</tbody>
						</table>
						<div class="text-center">
							<c:if test="${editAccess==0}">
								<a href="#" class=""
									onclick="getProgReport(0,'exportSalaryDetailExcel',<%out.println((int) session.getAttribute("liveLocationId"));%>)">
									<button type="button"
										class="btn blue_btn legitRipple legitRipple-empty">Export
										Salary Detail Excel</button>
								</a>
								<a
									href="${pageContext.request.contextPath}/pdf/exportSalaryDetailPdf/<%out.println((int) session.getAttribute("liveLocationId"));%>"
									target="_blank">
									<button type="button"
										class="btn blue_btn legitRipple legitRipple-empty">Export
										Salary Detail Print</button>
								</a>
							</c:if>
						</div>
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
	<!-- Large modal -->
	<div id="modal_large1" class="modal fade" tabindex="-1">

		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Employee Details</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<div class="modal-body" id="modalbody">
					<!--  Profile Model -->
					<!--  Profile Model -->
					<!--  Profile Model -->
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
					<!-- <button type="button" class="btn bg-primary">Save changes</button> -->
				</div>
			</div>
		</div>
	</div>
	<!-- /large modal -->
	<!-- /page content -->
	<script>
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
												location.href = "${pageContext.request.contextPath}/deleteEmp?empId="
														+ uuid;

											}
										}
									});
						});
	</Script>
	<script type="text/javascript">
		$('#block-page').on('click', function() {
			$.blockUI({
				message : '<i class="icon-spinner4 spinner"></i>',
				timeout : 2000, //unblock after 2 seconds
				overlayCSS : {
					backgroundColor : '#1b2024',
					opacity : 0.8,
					cursor : 'wait'
				},
				css : {
					border : 0,
					color : '#fff',
					padding : 0,
					backgroundColor : 'transparent'
				}
			});
		});
	</script>
	<script type="text/javascript">
		function getEmpData(empId) {
			//alert(empId)

			//alert(var1+':'+var2);

			var strhref = "${pageContext.request.contextPath}/getProfile?empId="
					+ empId;
			$("#modalbody").load(strhref);
			$("#modal_large1").modal("show");
			$('#modal_large1').on('hidden.bs.modal', function() {
				$("#modalbody").html("");
			});

		}
	</script>
	<script type="text/javascript">
		//use this function for all reports just get mapping form action name dynamically as like of prm from every report pdf,excel function	
		function getProgReport(prm, mapping, loc) {

			window.open("${pageContext.request.contextPath}/" + mapping + "/"
					+ loc + "/", "_blank");

		}
	</script>
</body>
</html>
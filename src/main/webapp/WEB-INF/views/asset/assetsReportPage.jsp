<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>


<c:url var="empInfoHistoryList" value="/empInfoHistoryList" />
<style type="text/css">
.dataTables_wrapper {
	margin-left: 15px;
	margin-right: 15px;
}
</style>
<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-datepicker.css"
	type="text/css" />

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-datepicker.js"></script>
<style type="text/css">
.select2-selection--multiple .select2-selection__rendered {
	border-bottom: 1px solid #ddd;
}
</style>
</head>
<!-- <link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css"> -->
<body>

	<c:url value="/getAssetsListofLocation" var="getAssetsListofLocation"></c:url>
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


				<div
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
				</div>
			</div>
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">


				<!-- Highlighting rows and columns -->
				<div class="card">
					<div class="card-body">
						<div class="card-header header-elements-inline">
							<h3 class="pageTitle">
								<i class="icon-list-unordered"></i>Assets Report
							</h3>
						</div>



						<!-- Extra large table -->

						<!-- <div class="card-header header-elements-inline">
							<h5 class="card-title">Reports</h5>
							<div class="header-elements">
								<div class="list-icons"></div>
							</div>
						</div>
 -->




						<div class="card-body">

							<form method="post" id="reportForm">

								<div class="form-group row">
									<div class="col-md-6">
										<label
											class="col-form-label text-info font-weight-bold col-lg-5 float"
											for="assetCatId">Accessible Location(F1)<span
											class="text-danger">*</span>:
										</label>
										<div class="col-lg-6 float">
											<select name="locId" data-placeholder="Select Location"
												id="locId" onchange="getAssets(this.value)"
												class="form-control form-control-select2 select2-hidden-accessible">
												<option value="0">All</option>
												<c:forEach items="${locationList}" var="locationList">
													<option value="${locationList.locId}">${locationList.locName}</option>
												</c:forEach>
											</select>
										</div>
										<span class="validation-invalid-label" id="error_locId"
											style="display: none;">Please Select Location. </span>

									</div>

									<div class="col-md-6">
										<label
											class="col-form-label text-info font-weight-bold col-lg-5 float"
											for="vendors">Vendor(F2)<span class="text-danger">*</span>:
										</label>
										<div class="col-lg-6 float">
											<select name="vendorsId" id="vendorsId"
												class="form-control form-control-select2 select2-hidden-accessible">
												<option value="0">All</option>
												<c:forEach items="${assetVendorList}" var="assetVendorList">
													<option value="${assetVendorList.vendorId}">${assetVendorList.compName}</option>
												</c:forEach>
											</select>
										</div>
										<span class="validation-invalid-label" id="error_vendor"
											style="display: none;">Please Select Date. </span>
									</div>
								</div>


								<div class="form-group row">
									<div class="col-md-6">
										<label
											class="col-form-label text-info font-weight-bold col-lg-5  float"
											for="purchaseDate">Purchase Date(F3) <span
											class="text-danger">*</span>:
										</label>
										<div class="col-lg-7 float">
											<input type="text" class="form-control daterange-basic_new "
												name="dateRange" data-placeholder="Select Date"
												id="dateRange"> <span
												class="validation-invalid-label" id="error_DateRange"
												style="display: none;">Please Select Date.</span>
										</div>
									</div>

									<!-- <div class="col-md-6">
										<label
											class="col-form-label text-info font-weight-bold col-lg-5 float"
											for="assetCatId">Assets(F4)<span class="text-danger">*</span>:
										</label>
										<div class="col-lg-6 float">
											<select name="assetId" data-placeholder="Select Asset"
												id="assetId" onchange="getAssets(this.value)"
												class="form-control form-control-select2 select2-hidden-accessible">
												<option value="0">All</option>
											</select>
										</div>
										<span class="validation-invalid-label" id="error_locId"
											style="display: none;">Please Select Location. </span>

									</div> -->
								</div>



								<div class="row">

									<div class="col-sm-12 col-md-6">
										<div class="card">
											<div
												class="card-header bg-primary text-white header-elements-inline">
												<h6 class="box_title" style="margin: 0;">Assets
													Management Reports</h6>
												<div class="header-elements"></div>
											</div>

											<div class="advance_bx">
												<ul>
													<li>Assets(F1, F2, F3) <span> <a href="#"
															onclick="getProgReport('f3',0,'getAllAssetsDetails')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="#"
															onclick="getProgReport('f3',1,'getAllAssetsDetails')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger  text-danger    "
																style="color: black;"></i></a>
													</span></li>
													<li>AMC Expired Asset's Report(F1) <span> <a
															href="#"
															onclick="getProgReport('f1',0,'getAssetsAMCExpiryReport')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="#"
															onclick="getProgReport('f1',1,'getAssetsAMCExpiryReport')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger  text-danger   "
																style="color: black;"></i></a>
													</span>
													</li>

													<li>Categorywise Total Assets Report(F1) <span>
															<a href="#"
															onclick="getProgReport('f1',0,'getCatWiseTotalAssetsReport')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="#"
															onclick="getProgReport('f1',1,'getCatWiseTotalAssetsReport')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger  text-danger   "
																style="color: black;"></i></a>
													</span>
													</li>

													<li>Asset Categorywise Summary <span> <a
															href="#"
															onclick="getProgReport('f1',0,'getAssetCateWiseSummaryReport')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="#"
															onclick="getProgReport('f1',1,'getAssetCateWiseSummaryReport')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger  text-danger   "
																style="color: black;"></i></a>
													</span>
													</li>

													<li>Employee Wise Assets Report(F1)<span> <a
															href="#"
															onclick="getProgReport('f1',0,'getEmpWiseAssetsReport')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="#"
															onclick="getProgReport('f1',1,'getEmpWiseAssetsReport')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger  text-danger   "
																style="color: black;"></i></a>
													</span>
													</li>


												</ul>
											</div>


										</div>
									</div>

									<div class="col-sm-12 col-md-6">
										<div class="card">
											<div
												class="card-header bg-primary text-white header-elements-inline">
												<h6 class="box_title" style="margin: 0;">Assets Management
													Reports</h6>
												<div class="header-elements"></div>
											</div>

											<div class="advance_bx">
												<ul>
													<li>Asset Return Pending(F1)<span> <a href="#"
															onclick="getProgReport('f1',0,'getAssetsReturnPendingReport')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="#"
															onclick="getProgReport('f1',1,'getAssetsReturnPendingReport')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger  text-danger   "
																style="color: black;"></i></a>
													</span>
													</li>

													<li>Scrap Assets Report(F1)<span> <a href="#"
															onclick="getProgReport('f1',0,'getScrappedAssetsReprt')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="#"
															onclick="getProgReport('f1',1,'getScrappedAssetsReprt')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger  text-danger   "
																style="color: black;"></i></a>
													</span>
													</li>

													<li>Vendor Wise Total Asset Report<span> <a
															href="#"
															onclick="getProgReport('f1',0,'getVendorWiseTotalAssetReport')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="#"
															onclick="getProgReport('f1',1,'getVendorWiseTotalAssetReport')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger  text-danger   "
																style="color: black;"></i></a>
													</span>
													</li>

													<li>Location Wise Total Asset Report(F1)<span>
															<a href="#"
															onclick="getProgReport('f1',0,'getLocationWiseTtlAssetsReprt')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="#"
															onclick="getProgReport('f1',1,'getLocationWiseTtlAssetsReprt')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger  text-danger   "
																style="color: black;"></i></a>
													</span>
													</li>

													<!-- <li>Asset Log Report(F1, F4)<span> <a href="#"
															onclick="getProgReport('f1',0,'getAssetLogReprt')"
															title="excel"><i
																class="icon-file-spreadsheet text-success  "
																style="color: black;"></i></a> <a href="#"
															onclick="getProgReport('f1',1,'getAssetLogReprt')"
															title="PDF"><i
																class="icon-file-pdf icon-1x text-danger  text-danger   "
																style="color: black;"></i></a>
													</span>
													</li> -->
												</ul>
											</div>

										</div>
									</div>



								</div>
								<input type="hidden" id="cal_yr" name="cal_yr" value="0">

								<input type="hidden" id="p" name="p" value="0"> <input
									type="hidden" id="emp_name" name="emp_name" value="0">
							</form>
						</div>


						<!-- /extra large table -->





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



	<script type="text/javascript">
		//use this function for all reports just get mapping form action name dynamically as like of prm from every report pdf,excel function	
		function getProgReport(filteroption, prm, mapping) {
			var error = false;
			
			if (prm == 1) {

				document.getElementById("p").value = "1";
			}

			if (filteroption == "f3") {
				var x = document.getElementById("dateRange").value;
				if (x.length == 0) {
					error = true;
					$("#error_DateRange").show();

				} else {
					//	alert(0);
					$("#error_DateRange").hide();
				}
			}

			if (filteroption == "f1") {
				var x = document.getElementById("locId").value;
				if (x.length == 0) {
					error = true;
					$("#error_locId").show();

				} else {
					//	alert(0);
					$("#error_locId").hide();
				}
			}
			
			if (filteroption == "f2") {
				var x = document.getElementById("vendorsId").value;
				if (x.length == 0) {
					error = true;
					$("#error_vendor").show();

				} else {
					//	alert(0);
					$("#error_vendor").hide();
				}
			}
			if (error) {
				return false
			}

			var form = document.getElementById("reportForm");

			form.setAttribute("target", "_blank");
			form.setAttribute("method", "get");
			form.action = ("${pageContext.request.contextPath}/" + mapping + "/");
			form.submit();
			document.getElementById("p").value = "0";

		}
	</script>
	<script>

	function getAssets(locId) {
		//alert("locId " + locId);
		
			$.getJSON('${getAssetsListofLocation}', {
				locId : locId,
				ajax : 'true'
			}, function(data) {

				var len = data.length; 

				$('#assetId').find('option').remove().end()
				$("#assetId").append($("<option value='0'>All</option>"));
				for (var i = 0; i < len; i++) {
					$("#assetId").append(
							$("<option selected ></option>").attr("value",
									data[i].assetId).text(data[i].assetCode+' - '+data[i].assetName));
				}
				$("#assetId").trigger("chosen:updated");
			});
		
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
		$('.daterange-basic_new').daterangepicker({
			applyClass : 'bg-slate-600',

			cancelClass : 'btn-light',
			locale : {
				format : 'DD-MM-YYYY',
				separator : ' to '
			}
		});
	</script>
	<script>
		//Single picker
		$('.datepickerclass').daterangepicker({
			singleDatePicker : true,
			selectMonths : true,
			selectYears : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});
	</script>



</body>
</html>
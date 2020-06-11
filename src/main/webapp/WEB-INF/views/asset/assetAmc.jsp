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
						<table width="100%">
							<tr width="100%">
								<td width="60%"><h5 class="pageTitle"><i class="icon-list-unordered"></i> Asset AMC
								 </h5></td>
								<td width="40%" align="right"><c:if test="${addAccess==0}">
										<a href="${pageContext.request.contextPath}/addAssetAmc"
											class="breadcrumb-elements-item">
											<button type="button" class="btn blue_btn legitRipple">Add
												Asset AMC</button>
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
							<div class="form-group row">									
										<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCode">Asset
													Name <span class="text-danger"></span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"  readonly="readonly" 
													autocomplete="off" onchange="trim(this)" value="ASST001-Laptop">
													<span class="validation-invalid-label" id="error_assetCode"
														style="display: none;">This field is required.</span>
												</div>
											</div>
											
											<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetName">Purchase
												Vendor <span class="text-danger"></span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control"  readonly="readonly" 
												autocomplete="off" onchange="trim(this)" value="Dells Gallery">
												<span class="validation-invalid-label" id="error_assetName"
													style="display: none;">This field is required.</span>
											</div>
										</div>											
									</div>	
									
									<div class="form-group row">									
										<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCode">Category
													<span class="text-danger"></span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"  readonly="readonly" 
													autocomplete="off" onchange="trim(this)" value="Computer">
													<span class="validation-invalid-label" id="error_assetCode"
														style="display: none;">This field is required.</span>
												</div>
											</div>
											
											<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCode">Asset
													Purchase Date<span class="text-danger"></span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"  readonly="readonly" 
													autocomplete="off" onchange="trim(this)" value="10-04-2020">
													<span class="validation-invalid-label" id="error_assetCode"
														style="display: none;">This field is required.</span>
												</div>
											</div>						
									</div>	
									<div class="form-group row">									
										<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCode">Model
													<span class="text-danger"></span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"  readonly="readonly" 
													autocomplete="off" onchange="trim(this)" value="Dell Inspiron">
													<span class="validation-invalid-label" id="error_assetCode"
														style="display: none;">This field is required.</span>
												</div>
											</div>
											
											<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetName">Serial
												No. <span class="text-danger"></span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control"  readonly="readonly" 
												autocomplete="off" onchange="trim(this)" value="D32A145">
												<span class="validation-invalid-label" id="error_assetName"
													style="display: none;">This field is required.</span>
											</div>
										</div>											
									</div>	
						<table
							class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
							id="printtable1">
							<thead>
								<tr class="bg-blue">

									<th width="10%">Sr. No.</th>
									<th>AMC Vendor</th>
									<th>AMC Period</th>
									<th>Amt</th>																
									<th width="10%" class="text-center">Actions</th>
								</tr>
							</thead>
							<tbody>
							
							
								<tr>
										 <td>1</td>
										<td>AMC Vendor1</td>
										<td>01-05-2020 to 10-05-2020</td>
										<td>5400</td>	
										<td class="text-center">
												<a
													href="${pageContext.request.contextPath}/editAssetAmc?assetCatId="
													class="list-icons-item text-primary-600" data-popup="tooltip"  data-original-title="Edit"><i class="icon-pencil7"
													 ></i></a>
													 												 
											<a href="javascript:void(0)"
													class="list-icons-item text-danger-600 bootbox_custom"
													data-uuid="" data-popup="tooltip"
													title="" data-original-title="Terminate"><i
													class="icon-trash"></i></a>
													
											<a href="${pageContext.request.contextPath}/addAssetAmc?assetCatId="
													class="list-icons-item text-primary-600 bootbox_custom"
													data-uuid="" data-popup="tooltip"
													title="" data-original-title="Renew"><i
													class="icon-history"></i></a>
											</td>
									</tr>


								<%-- <c:forEach items="${assetList}" var="assetList"
									varStatus="count">
									<tr>
										 <td>${count.index+1}</td>
										<td>${assetList.catName}</td>
										<td>${assetList.catName}</td>
										<td>${assetList.catName}</td>										
										<td>${assetList.catName}</td>
										<td class="text-center"><c:if test="${editAccess == 0}">
												<a
													href="${pageContext.request.contextPath}/editAssetCategory?assetCatId=${assetList.exVar1}"
													class="list-icons-item text-primary-600" data-popup="tooltip"  data-original-title="Edit"><i class="icon-pencil7"
													 ></i></a>
											</c:if> <c:if test="${deleteAccess == 0}">
												 
												 
											<a href="javascript:void(0)"
													class="list-icons-item text-danger-600 bootbox_custom"
													data-uuid="${assetList.exVar1}" data-popup="tooltip"
													title="" data-original-title="Delete"><i
													class="icon-trash"></i></a>
											</c:if></td>
									</tr>
								</c:forEach> --%>

							</tbody>
						</table>

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
<script>
		// Custom bootbox dialog
		$('.bootbox_custom')
				.on(
						'click',
						function() {
							var uuid = $(this).data("uuid") // will return the number 123
										bootbox.confirm({
										title : 'Confirm ',
										message : 'Are you sure you want to terminate selected asset ?',
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
												location.href = "${pageContext.request.contextPath}/terminateAsset?assetId="
														+ uuid;

											}
										}
									});
						});
	</Script>
</body>
</html>
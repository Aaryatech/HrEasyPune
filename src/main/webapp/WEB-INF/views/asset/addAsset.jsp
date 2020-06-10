<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>
<style type="text/css">
.select2-selection--multiple .select2-selection__rendered {
	border-bottom: 1px solid #ddd;
}
</style>
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
			<div class="page-header page-header-light">

 
			</div>
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">

				<!-- Form validation -->
				<div class="row">
					<div class="col-md-12">
						<!-- Title -->
						<!-- <div class="mb-3">
							<h6 class="mb-0 font-weight-semibold">Hidden labels</h6>
							<span class="text-muted d-block">Inputs with empty values</span>
						</div> -->
						<!-- /title -->


				<div class="card">							 
					<div class="card-header header-elements-inline">
 						<table width="100%">
							<tr width="100%">
								<td width="60%"><h5 class="pageTitle"><i class="icon-list-unordered"></i>${title}</h5></td>
								<td width="40%" align="right">
							  
								 <%-- <a
									href="${pageContext.request.contextPath}/showAddKra?empId=${editKra.exVar3}&finYrId=${editKra.exVar2}"
									class="breadcrumb-elements-item">
										<button type="button" class="btn btn-primary">KRA List </button>
								</a>  --%></td>
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

								<form
									action="${pageContext.request.contextPath}/submitInsertAsset"
									id="submitInsertAsset" method="post">
									
									<div class="form-group row">									
										<div class="col-md-6">	
												<div class="col-lg-7  float">
													<input type="hidden" class="form-control" id="assetId"
														name="assetId" value="${asset.assetId}">													
												</div>
											</div>
										</div>
									
									<div class="form-group row">									
										<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCode">Asset
													Code <span class="text-danger">* </span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"
														placeholder="Enter Asset Code" id="assetCode" readonly="readonly"
														name="assetCode" autocomplete="off" onchange="trim(this)" value="${asset.assetCode}">
													<span class="validation-invalid-label" id="error_assetCode"
														style="display: none;">This field is required.</span>
												</div>
											</div>
											
											<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetName">Asset
												Name <span class="text-danger">*</span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control" placeholder="Enter Asset Name" id="assetName"
												name="assetName" autocomplete="off" onchange="trim(this)" value="${asset.assetName}">
												<span class="validation-invalid-label" id="error_assetName"
													style="display: none;">This field is required.</span>
											</div>
										</div>											
									</div>
									

									<div class="form-group row">
										<div class="col-md-6">		
											<label class="col-form-label col-lg-5 float" for="assetDesc">Description
												<span class="text-danger"></span>:</label>
											<div class="col-lg-7 float">
												<input type="text" class="form-control"
													placeholder="Enter Description" onchange="trim(this)"
													id="assetDesc" name="assetDesc" value="${asset.assetDesc}">
												<!-- <span class="validation-invalid-label" id="error_assetDesc"
													style="display: none;">This field is required.</span> -->
											</div>
										</div>
										
										<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCatId">Category 
											<span class="text-danger">* </span>:</label>
												<div class="col-lg-7 float">
													<select name="assetCatId" data-placeholder="Select Asset Category"
														id="assetCatId"
														class="form-control form-control-select2 select2-hidden-accessible">

														<option value="">Select Asset Category</option>
														<c:forEach items="${assetCatList}" var="assetCatList">
															<c:choose>
																<c:when test="${assetCatList.assetCatId==asset.assetCatId}">
																	<option selected="selected"
																		value="${assetCatList.assetCatId}">${assetCatList.catName}</option>
																</c:when>
																<c:otherwise>
																	<option value="${assetCatList.assetCatId}">${assetCatList.catName}</option>
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</select>
													 <span
														class="validation-invalid-label" id="error_assetCatId"
														style="display: none;">This field is required.</span>
																										
												</div>
											</div>	
									</div>
									
									<div class="form-group row">
										<div class="col-md-6">	
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetMake">Asset 
												Make <span class="text-danger">* </span>:</label>
											<div class="col-lg-7 float">
												<input type="text" class="form-control"
													placeholder="Enter Asset Make" id="assetMake" value="${asset.assetMake}"
													name="assetMake" autocomplete="off" onchange="trim(this)">
												<span class="validation-invalid-label" id="error_assetMake"
													style="display: none;">This field is required.</span>
											</div>
										</div>
									
										<div class="col-md-6">
											<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetModel">Asset
												Model<span class="text-danger">*</span>:</label>
											<div class="col-lg-7 float">
												<input type="text" class="form-control" value="${asset.assetModel}"
													placeholder="Enter Asset Model" id="assetModel"
													name="assetModel" autocomplete="off" onchange="trim(this)"> <span
													class="validation-invalid-label" id="error_assetModel"
													style="display: none;">This field is required.</span>
											</div>
										</div>
										
										
									</div>


									<div class="form-group row">
										<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetSrno">Asset 
												Serial No.<span class="text-danger">* </span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control" value="${asset.assetSrno}"
													placeholder="Enter Asset Serial No." id="assetSrno"
													name="assetSrno" autocomplete="off">
												<span class="validation-invalid-label" id="error_assetSrno"
													style="display: none;">This field is required.</span>
											</div>
										</div>
										
										<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5  float" for="website">Purchase Date
												 <span class="text-danger">*</span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control datepickerclass" value="${asset.assetPurDate}"
													placeholder="Enter Purchase Date" id="assetPurDate"
													name="assetPurDate" autocomplete="off" onchange="trim(this)">
												<span class="validation-invalid-label" id="error_assetPurDate"
													style="display: none;">This field is required.</span>
											</div>
										</div>
									</div>
									
									
									<div class="form-group row">
										<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="vendor">Vendor
												Name <span class="text-danger">* </span>:</label>
												<div class="col-lg-7 float">
												<select name="assetVendorId" data-placeholder="Select Asset Vendor"
														id="assetVendorId"
														class="form-control form-control-select2 select2-hidden-accessible">

														<option value="">Select Asset Vendor</option>
														<c:forEach items="${assetVendorList}" var="assetVendorList">
															<c:choose>
																<c:when test="${assetVendorList.vendorId==asset.vendorId}">
																	<option selected="selected"
																		value="${assetVendorList.vendorId}">${assetVendorList.compName}</option>
																</c:when>
																<c:otherwise>
																	<option value="${assetVendorList.vendorId}">${assetVendorList.compName}</option>
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</select>
												<span class="validation-invalid-label" id="error_assetVendorId"
													style="display: none;">This field is required.</span>
											</div>
										</div>
										
										
										<div class="col-md-6">
											<label class="col-form-label col-lg-5 float" for="remark">Remark
												: </label>
												<div class="col-lg-7 float">
												<textarea rows="3" cols="3" class="form-control"
													placeholder="Any Remark" onchange="trim(this)" id="remark"
													name="remark">${asset.assetRemark}</textarea>
	
											</div>
										</div>
									</div>

									<div class="form-group row mb-0">
									<div  style="margin: 0 auto;"><!--  class="col-lg-10 ml-lg-auto" -->
										
											<button type="submit" class="btn blue_btn"
												id="submtbtn">
												Submit <i class="icon-paperplane ml-2"></i>
											</button>
											<a href="${pageContext.request.contextPath}/showAllAssets"><button id="cnclbtn"
										type="button" class="btn btn-light"><i class="${sessionScope.cancelIcon}" aria-hidden="true"></i>&nbsp;&nbsp; Back</button></a>
										</div>
									</div>
								</form>
									<p class="desc text-danger fontsize11">Note : * Fields are
									mandatory.</p>
							</div>
						</div>


					</div>
				</div>

			</div>
			<!-- /content area -->


			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
			<!-- /footer -->

		</div>
		<!-- /main content -->

	</div>
	<!-- /page content -->
<script
		src="${pageContext.request.contextPath}/resources/global_assets/js/footercommonjs.js"></script>
 <script type="text/javascript">
 $('#assetPurDate').on('input', function() {
	 this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');
 });
 
 $(document)
	.ready(
			function($) {

				$("#submitInsertAsset")
						.submit(
								function(e) {
									var isError = false;
									var errMsg = "";
									
									
									if (!$("#assetCode").val()) {

										isError = true;

										$("#error_assetCode").show()

									} else {
										$("#error_assetCode").hide()
									}

									if (!$("#assetName").val()) {

										isError = true;

										$("#error_assetName").show()

									} else {
										$("#error_assetName").hide()
									}
									
									if (!$("#assetCatId").val()) {

										isError = true;

										$("#error_assetCatId").show()

									} else {
										$("#error_assetCatId").hide()
									}
								
									/* if (!$("#assetDesc").val()) {

										isError = true;

										$("#error_assetDesc").show()

									} else {
										$("#error_assetDesc").hide()
									} */
									
									if (!$("#assetMake").val()) {

										isError = true;

										$("#error_assetMake").show()

									} else {
										$("#error_assetMake").hide()
									}
									
									if (!$("#assetModel").val()) {

										isError = true;

										$("#error_assetModel").show()

									} else {
										$("#error_assetModel").hide()
									}
									
									if (!$("#assetSrno").val()) {

										isError = true;

										$("#error_assetSrno").show()

									} else {
										$("#error_assetSrno").hide()
									}
									
									
									if (!$("#assetPurDate").val()) {

										isError = true;

										$("#error_assetPurDate").show()

									} else {
										$("#error_assetPurDate").hide()
									}
									
									if (!$("#assetVendorId").val()) {

										isError = true;

										$("#error_assetVendorId").show()

									} else {
										$("#error_assetVendorId").hide()
									}
									if (!isError) {

										var x = true;
										if (x == true) {

											document.getElementById("submtbtn").disabled = true;
											document.getElementById("cnclbtn").disabled = true;
											
											return true;
										}
										
									}
									return false;
								});
			});
</script>
	<script type="text/javascript">
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
	</script>


</body>
</html>
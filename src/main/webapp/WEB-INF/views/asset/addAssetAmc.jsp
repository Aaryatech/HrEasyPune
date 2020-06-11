<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
<style type="text/css">
.daterangepicker{width: 100%;}
.daterangepicker.show-calendar .calendar{display: inline--block;}
.daterangepicker .calendar, .daterangepicker .ranges{float: right;}
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
								<td width="60%"><h5 class="pageTitle"><i class="icon-list-unordered"></i>Assets
								 Details</h5></td>
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

								<div class="form-group row">									
										<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCode">Asset
													Name <span class="text-danger"></span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"  readonly="readonly" 
													value="ASST001-Laptop">
													<span class="validation-invalid-label" id="error_assetCode"
														style="display: none;">This field is required.</span>
												</div>
											</div>
											
											<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetName">Purchase
												Vendor <span class="text-danger"></span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control"  readonly="readonly" 
												value="Dells Gallery">
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
													value="Computer">
													<span class="validation-invalid-label" id="error_assetCode"
														style="display: none;">This field is required.</span>
												</div>
											</div>
											
											<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCode">Asset
													Purchase Date<span class="text-danger"></span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"  readonly="readonly" 
													value="10-04-2020">
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
													value="Dell Inspiron">
													<span class="validation-invalid-label" id="error_assetCode"
														style="display: none;">This field is required.</span>
												</div>
											</div>
											
											<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetName">Serial
												No. <span class="text-danger"></span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control"  readonly="readonly" 
												value="D32A145">
												<span class="validation-invalid-label" id="error_assetName"
													style="display: none;">This field is required.</span>
											</div>
										</div>											
									</div>	
									<hr>
									<!-- ************************************************************ -->
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
								<form
									action="${pageContext.request.contextPath}/submitInsertAssetAmc"
									id="submitInsertAssetAmc" method="post">
									
									<div class="form-group row">									
										<div class="col-md-6">	
												<div class="col-lg-7  float">
													<input type="hidden" class="form-control" id="vendorId"
														name="vendorId">													
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
														<option value="${assetVendorList.vendorId}">${assetVendorList.compName}</option>
															<%-- <c:choose>
																<c:when test="${assetVendorList.vendorId==asset.vendorId}">
																	<option selected="selected"
																		value="${assetVendorList.vendorId}">${assetVendorList.compName}</option>
																</c:when>
																<c:otherwise>
																	<option value="${assetVendorList.vendorId}">${assetVendorList.compName}</option>
																</c:otherwise>
															</c:choose> --%>
														</c:forEach>
													</select>
												<span class="validation-invalid-label" id="error_assetVendorId"
													style="display: none;">This field is required.</span>
											</div>
										</div>
											
											<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="amcperiod">AMC Period
												 <span class="text-danger"></span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control daterange-basic_new"
													placeholder="Enter AMC Period" id="amcperiod"
													name="amcperiod" autocomplete="off">
												<span class="validation-invalid-label" id="error_amcperiod"
													style="display: none;">This field is required.</span>
											</div>
										</div>											
									</div>
									
									<div class="form-group row">
										<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="amcamt">AMC 
												Amt<span class="text-danger">* </span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control"
													placeholder="Enter AMC Amt." id="amcamt"
													name="amcamt" autocomplete="off">
												<span class="validation-invalid-label" id="error_amcamt"
													style="display: none;">This field is required.</span>
											</div>
										</div>
										
										<div class="col-md-6">
												<label class="col-form-label col-lg-5  float" for="terms">Terms &
												Conditions <span class="text-danger"></span>:</label>
												<div class="col-lg-7 float">
												<textarea rows="3" cols="3" class="form-control"
													placeholder="Enter Terms & Conditions"id="terms"
													name="terms"></textarea>
												<span class="validation-invalid-label" id="error_terms"
													style="display: none;">This field is required.</span>
											</div>
										</div>
									</div>
									
									<div class="form-group row">
										<div class="col-md-6">
												<label class="col-form-label col-lg-5 float" for="positiveremark">Positive 
												Remark<span class="text-danger"></span>:</label>
												<div class="col-lg-7 float">
												<textarea rows="3" cols="3" class="form-control"
													placeholder="Enter Positive Remark" id="positiveremark"
													name="positiveremark"></textarea>
												<span class="validation-invalid-label" id="error_positiveremark"
													style="display: none;">This field is required.</span>
											</div>
										</div>
										
										<div class="col-md-6">
												<label class="col-form-label col-lg-5  float" for="terms">Negative
												Remark <span class="text-danger"></span>:</label>
												<div class="col-lg-7 float">
												<textarea rows="3" cols="3" class="form-control"
													placeholder="Enter Negative Remark" id="negtiveremark"
													name="negtiveremark"></textarea>
												<span class="validation-invalid-label" id="error_negtiveremark"
													style="display: none;">This field is required.</span>
											</div>
										</div>
									</div>
									
									<div class="form-group row">
										<div class="col-md-6">
												<label class="col-form-label col-lg-5 float" for="amcamt">AMC 
												Document File<span class="text-danger"></span>:</label>
												<div class="col-lg-7 float">
												<img id="output" width="150"/>
												<input type="file" accept="image/*" name="image" id="file" onchange="loadFile(event)"> 
												<span class="validation-invalid-label" id="error_amcdoc"
													style="display: none;">This field is required.</span>
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
<script>
$('#assetPurDate').on('input', function() {
	 this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');
});

$(document)
	.ready(
			function($) {

				$("#submitInsertAssetAmc")
						.submit(
								function(e) {
									var isError = false;
									var errMsg = "";
									
									
									if (!$("#amcperiod").val()) {

										isError = true;

										$("#error_amcperiod").show()

									} else {
										$("#error_amcperiod").hide()
									}

									if (!$("#amcamt").val()) {

										isError = true;

										$("#error_amcamt").show()

									} else {
										$("#error_amcamt").hide()
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
var loadFile = function(event) {
	try {
		var image = document.getElementById('output');
		image.src = URL.createObjectURL(event.target.files[0]);
	} catch(err) {
		 console.log(err);
		}
	
};
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
<!-- <style type="text/css">
.daterangepicker{width: 100%;}
.daterangepicker.show-calendar .calendar{display: inline--block;}
.daterangepicker .calendar, .daterangepicker .ranges{float: right;}
</style> -->
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
													value="${asset.assetName}">													
												</div>
											</div>
											
											<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetName">Purchase
												Vendor <span class="text-danger"></span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control"  readonly="readonly" 
												value="${asset.vendor}">
											</div>
										</div>											
									</div>	
									
									<div class="form-group row">									
										<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCode">Category
													<span class="text-danger"></span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"  readonly="readonly" 
													value="${asset.catName}">
												</div>
											</div>
											
											<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCode">Asset
													Purchase Date<span class="text-danger"></span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"  readonly="readonly" 
													value="${asset.assetPurDate}">
												</div>
											</div>						
									</div>	
									<div class="form-group row">									
										<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCode">Model
													<span class="text-danger"></span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"  readonly="readonly" 
													value="${asset.assetModel}">
												</div>
											</div>
											
											<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetName">Serial
												No. <span class="text-danger"></span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control"  readonly="readonly" 
												value="${asset.assetSrno}">
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
									action="${pageContext.request.contextPath}/submitSaveAssetServicing"
									id="submitSaveAssetServicing" method="post" enctype="multipart/form-data">
									
									<div class="form-group row">
									
										<div class="col-md-6">	
												<div class="col-lg-7  float">
													<input type="hidden" class="form-control" id="serviceId"
														name="serviceId" value="0">													
												</div>
											</div>
																		
										<div class="col-md-6">	
												<div class="col-lg-7  float">
													<input type="text" class="form-control" id="assetId"
														name="assetId" value="${asset.assetId}">													
												</div>
											</div>
										</div>
									
									<div class="form-group row">									
										<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="vendor">Vendor
												Name <span class="text-danger">* </span>:</label>
												<div class="col-lg-7 float">
												
												<select name="serviceVendorId" data-placeholder="Select Service Vendor"
														id="serviceVendorId"
														class="form-control form-control-select2 select2-hidden-accessible">

														<option value="">Select Service Vendor</option>
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
												<span class="validation-invalid-label" id="error_serviceVendorId"
													style="display: none;">This field is required.</span>
											</div>
										</div>
										
										<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="serv_type">Servicing Type 
												<span class="text-danger">* </span>:</label>
												<div class="col-lg-7 float">
											<select name="serv_type" data-placeholder="Select Service Type"
														id="serv_type"
														class="form-control form-control-select2 select2-hidden-accessible">

														<option value="0">Regular</option>
														<option value="1">Breakdown</option>														
														
														</select>
												<span class="validation-invalid-label" id="error_serv_type"
													style="display: none;">This field is required.</span>
											</div>
										</div>				
										
																
									</div>
									
									<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="serv_date">
												 Service Date<span class="text-danger">*</span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control datepickerclass"
													placeholder="Enter Servicing Date" id="serv_date"
													name="serv_date" autocomplete="off">
												<span class="validation-invalid-label" id="error_serv_date"
													style="display: none;">This field is required.</span>
											</div>
										</div>		
										
										<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="serv_desc">Service Description
												<span class="text-danger">*</span>:</label>
												<div class="col-lg-7 float">
												<textarea rows="3" cols="3" class="form-control"
													placeholder="Service Description" id="serv_desc"
													name="serv_desc"></textarea>
												<span class="validation-invalid-label" id="error_serv_desc"
													style="display: none;">This field is required.</span>
											</div>
										</div>		
									</div>
									
									<div class="form-group row">
										<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="serv_bill_amt">Billed Amount<span class="text-danger"></span><span class="text-danger">*</span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control"
													placeholder="Enter Service Bill Amount" maxlength="8" id="serv_bill_amt"
													name="serv_bill_amt">
												<span class="validation-invalid-label" id="error_serv_bill_amt"
													style="display: none;">This field is required.</span>
											</div>
										</div>
										
										<div class="col-md-6">
												<label class="col-form-label col-lg-5  float" for="serv_remark">Service
												Remark <span class="text-danger"></span><span class="text-danger"></span>:</label>
												<div class="col-lg-7 float">
												<textarea rows="3" cols="3" class="form-control"
													placeholder="Enter Remark" id="serv_remark"
													name="serv_remark"></textarea>
												<span class="validation-invalid-label" id="error_negtiveremark"
													style="display: none;">This field is required.</span>
											</div>
										</div>
									</div>
									
									<div class="form-group row">
										<div class="col-md-6">
												<label class="col-form-label col-lg-5 float" for="serv_bill_doc">Bill 
												Document File<span class="text-danger"></span>:</label>
												<div class="col-lg-7 float">
												<img id="output" width="150"/>
												<input type="file" accept="image/*" name="doc" id="serv_bill_doc" onchange="loadFile(event)"> 
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
											<a href="${pageContext.request.contextPath}/showAssetForServicing"><button id="cnclbtn"
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
$('#amcperiod').on('input', function() {
	 this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');
});
$('#serv_bill_amt').on('input', function() {
	  this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
	});

$(document)
	.ready(
			function($) {

				$("#submitSaveAssetServicing")
						.submit(
								function(e) {
									var isError = false;
									var errMsg = "";
									
									
									if (!$("#serv_type").val()) {

										isError = true;

										$("#error_serv_type").show()

									} else {
										$("#error_serv_type").hide()
									}
									
									if (!$("#serv_date").val()) {

										isError = true;

										$("#error_serv_date").show()

									} else {
										$("#error_serv_date").hide()
									}

									if (!$("#serv_desc").val()) {

										isError = true;

										$("#error_serv_desc").show()

									} else {
										$("#error_serv_desc").hide()
									}
																		
									if (!$("#serviceVendorId").val()) {

										isError = true;

										$("#error_serviceVendorId").show()

									} else {
										$("#error_serviceVendorId").hide()
									}
									
									if (!$("#serv_bill_amt").val()) {

										isError = true;

										$("#error_serv_bill_amt").show()

									} else {
										$("#error_serv_bill_amt").hide()
									}
									
									
									/* var from_date = document.getElementById("amcperiodfrom").value;
				      				var to_date = document.getElementById("amcperiodto").value;
				      				
				      				var fromdate = from_date.split('-');
			         		        from_date = new Date();
			         		        from_date.setFullYear(fromdate[2],fromdate[1]-1,fromdate[0]);
			         		        var todate = to_date.split('-');
			         		        to_date = new Date();
			         		        to_date.setFullYear(todate[2],todate[1]-1,todate[0]);
			         		        if (from_date > to_date ) 
			         		        {
			         		           /// alert("Invalid Date Range!\nStart Date cannot be after End Date!")
										$("#error_fromDate").show();
			    					 	$("#error_toDate").show();
			    					 	
			         		            return false;
			         		           
			         		        }else {
			         					$("#error_fromDate").hide();
			         					$("#error_toDate").hide();
			         				}
			         		         */
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
$('.datepickerclass').daterangepicker({
	singleDatePicker : true,
	selectMonths : true,
	selectYears : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});
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
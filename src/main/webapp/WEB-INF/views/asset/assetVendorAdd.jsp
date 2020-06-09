<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
									action="${pageContext.request.contextPath}/submitInsertAssetVendor"
									id="submitInsertAssetVendor" method="post">
									
									<div class="form-group row">									
										<div class="col-md-6">	
												<div class="col-lg-7  float">
													<input type="hidden" class="form-control" id="vendorId"
														name="vendorId" value="${assetVendor.vendorId}">
													<span class="validation-invalid-label" id="error_compName"
														style="display: none;">This field is required.</span>
												</div>
											</div>
										</div>
									
									<div class="form-group row">									
										<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="locName">Company
													Name <span class="text-danger">* </span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"
														placeholder="Enter Company Name" id="compName"
														name="compName" autocomplete="off" onchange="trim(this)" value="${assetVendor.compName}">
													<span class="validation-invalid-label" id="error_compName"
														style="display: none;">This field is required.</span>
												</div>
											</div>
											
											<div class="col-md-6">
												<label class="col-form-label col-lg-5 float" for="gstin">GSTIN <span class="text-danger"></span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control"
													placeholder="Enter GSTIN" id="gstin"
													name="gstin" autocomplete="off" onchange="trim(this)" value="${assetVendor.gstin}">
												<span class="validation-invalid-label" id="error_email"
													style="display: none;">This field is required.</span>
											</div>
										</div>											
									</div>
									

									<div class="form-group row">
										<div class="col-md-6">		
											<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="vendorCity">Vendor
												City<span class="text-danger">* </span>:</label>
											<div class="col-lg-7 float">
												<input type="text" class="form-control"
													placeholder="Enter Vendor City" onchange="trim(this)"
													id="vendorCity" name="vendorCity" value="${assetVendor.vendorCity}">
												<span class="validation-invalid-label" id="error_vendorCity"
													style="display: none;">This field is required.</span>
											</div>
										</div>
										
										<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="compAddress">Company 
											Address<span class="text-danger">* </span>:</label>
												<div class="col-lg-7 float">
													<input type="text" class="form-control" value="${assetVendor.compAddress}"
														placeholder="Enter Company Address" id="compAddress"
														name="compAddress" autocomplete="off" onchange="trim(this)"> <span
														class="validation-invalid-label" id="error_compAddress"
														style="display: none;">This field is required.</span>
																										
												</div>
											</div>	
									</div>
									
									<div class="form-group row">
										<div class="col-md-6">	
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="contact1">Contact
												No.1 <span class="text-danger">* </span>:</label>
											<div class="col-lg-7 float">
												<input type="text" class="form-control" maxlength="10"
													placeholder="Enter Contact No.1" id="contact1" value="${assetVendor.contactNo1}"
													name="contact1" autocomplete="off" onchange="trim(this)">
												<span class="validation-invalid-label" id="error_contact1"
													style="display: none;">This field is required.</span>
											</div>
										</div>
									
										<div class="col-md-6">
											<label class="col-form-label col-lg-5 float" for="contactNo2">Contact
												No.2 <span class="text-danger"></span>:</label>
											<div class="col-lg-7 float">
												<input type="text" class="form-control" value="${assetVendor.contactNo2}"
													placeholder="Enter Contact No.2" id="contact2"
													name="contact2" autocomplete="off" onchange="trim(this)"
													  maxlength="10"> <span
													class="validation-invalid-label" id="error_contact2"
													style="display: none;">This field is required.</span>
											</div>
										</div>
										
										
									</div>


									<div class="form-group row">
										<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="vendorEmail">Email 
												<span class="text-danger">* </span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control" value="${assetVendor.vendorEmail}"
													placeholder="Enter Vendor Email" id="vendorEmail"
													name="vendorEmail" autocomplete="off">
												<span class="validation-invalid-label" id="error_vendorEmail"
													style="display: none;">This field is required.</span>
											</div>
										</div>
										
										<div class="col-md-6">
												<label class="col-form-label col-lg-5 float" for="website">Website <span class="text-danger"> </span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control" value="${assetVendor.website}"
													placeholder="Enter Website" id="website"
													name="website" autocomplete="off" onchange="trim(this)">
												<span class="validation-invalid-label" id="error_website"
													style="display: none;">This field is required.</span>
											</div>
										</div>
									</div>
									
									
									<div class="form-group row">
										<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="contactPersonName">Contact Person
												Name <span class="text-danger">* </span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control" value="${assetVendor.conatctPersonName}"
													placeholder="Enter Contact Person Name" id="contactPersonName"
													name="contactPersonName" autocomplete="off" onchange="trim(this)">
												<span class="validation-invalid-label" id="error_contactPersonName"
													style="display: none;">This field is required.</span>
											</div>
										</div>
										
										<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="contactPersonNo">Contact Person
												No. <span class="text-danger">* </span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control" value="${assetVendor.contactPersonNo}"
													placeholder="Enter Contact Person No." id="contactPersonNo" maxlength="10"
													name="contactPersonNo" autocomplete="off" onchange="trim(this)">
												<span class="validation-invalid-label" id="error_contactPersonNo"
													style="display: none;">This field is required.</span>
											</div>
										</div>
										
									</div>
									
									<div class="form-group row">
									<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="contactPersonEmail">Contact Person
												Email <span class="text-danger">* </span>:</label>
												<div class="col-lg-7 float">
												<input type="email" class="form-control" value="${assetVendor.contactPersonEmail}"
													placeholder="Enter Contact Person Email" id="contactPersonEmail"
													name="contactPersonEmail" autocomplete="off" onchange="trim(this)">
												<span class="validation-invalid-label" id="error_contactPersonEmail"
													style="display: none;">This field is required.</span>
											</div>
										</div>
										
										<div class="col-md-6">
											<label class="col-form-label col-lg-5 float" for="remark">Remark
												: </label>
												<div class="col-lg-7 float">
												<textarea rows="3" cols="3" class="form-control"
													placeholder="Any Remark" onchange="trim(this)" id="remark"
													name="remark">${assetVendor.remark}</textarea>
	
											</div>
										</div>
									</div>

									<div class="form-group row mb-0">
									<div  style="margin: 0 auto;"><!--  class="col-lg-10 ml-lg-auto" -->
										
											<button type="submit" class="btn blue_btn"
												id="submtbtn">
												Submit <i class="icon-paperplane ml-2"></i>
											</button>
											<a href="${pageContext.request.contextPath}/showAssetVendor"><button id="cnclbtn"
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
	
	function checkSame(){
		x=document.getElementById("locName").value;
		y=document.getElementById("locShortName").value;
		//alert(x);
		
		if(x!== '' && y!== ''){
			if(x==y){
				$("#error_sameName").show()
				document.getElementById("locShortName").value="";
			}
			else{
				$("#error_sameName").hide()
			}
	}
		
	}
		function trim(el) {
			el.value = el.value.replace(/(^\s*)|(\s*$)/gi, ""). // removes leading and trailing spaces
			replace(/[ ]{2,}/gi, " "). // replaces multiple spaces with one space 
			replace(/\n +/, "\n"); // Removes spaces after newlines
			checkSame();
			return;
		}

		function validateEmail(email) {

			var eml = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;

			if (eml.test($.trim(email)) == false) {

				return false;

			}

			return true;

		}
		function validateMobile(mobile) {
			var mob = /^[1-9]{1}[0-9]{9}$/;

			if (mob.test($.trim(mobile)) == false) {

				//alert("Please enter a valid email address .");
				return false;

			}
			return true;

		}
		$(document)
				.ready(
						function($) {

							$("#submitInsertAssetVendor")
									.submit(
											function(e) {
												var isError = false;
												var errMsg = "";

												if (!$("#compName").val()) {

													isError = true;

													$("#error_compName").show()
													//return false;
												} else {
													$("#error_compName").hide()
												}

												if (!$("#compAddress").val()) {

													isError = true;

													$("#error_compAddress")
															.show()

												} else {
													$("#error_compAddress")
															.hide()
												}

												if (!$("#vendorCity").val()) {

													isError = true;

													$("#error_vendorCity").show()

												} else {
													$("#error_vendorCity").hide()
												}

												if (!$("#contact1").val()) {

													isError = true;

													$("#error_contact1").show()

												} else {
													$("#error_contact1").hide()
												}

												if (!$("#contact1").val()
														|| !validateMobile($(
																"#contact1")
																.val())) {

													isError = true;

													if (!$("#contact1").val()) {
														document
																.getElementById("error_contact1").innerHTML = "This field is required.";
													} else {
														document
																.getElementById("error_contact1").innerHTML = "Enter valid Mobile No.";
													}

													$("#error_contact1")
															.show()

												} else {
													$("#error_contact1")
															.hide()
												}
												
												/* if (!$("#contact2").val()) {

													isError = true;

													$("#error_contact2").show()

												} else {
													$("#error_contact2").hide()
												}

												if (!$("#contact2").val()
														|| !validateMobile($(
																"#contact2")
																.val())) {

													isError = true;

													if (!$("#contact2").val()) {
														document
																.getElementById("error_contact2").innerHTML = "This field is required.";
													} else {
														document
																.getElementById("error_contact2").innerHTML = "Enter valid Mobile No.";
													}

													$("#error_contact2")
															.show()

												} else {
													$("#error_contact2")
															.hide()
												} */

												if (!$("#vendorEmail").val()
														|| !validateEmail($(
																"#vendorEmail").val())) {

													isError = true;

													if (!$("#vendorEmail").val()) {
														document
																.getElementById("error_vendorEmail").innerHTML = "This field is required.";
													} else {
														document
																.getElementById("error_vendorEmail").innerHTML = "Enter valid email.";
													}

													$("#error_vendorEmail").show()

												} else {
													$("#error_vendorEmail").hide()
												}
												
												if (!$("#contactPersonName").val()) {

													isError = true;

													$("#error_contactPersonName").show()

												} else {
													$("#error_contactPersonName").hide()
												}
												
												if (!$("#contactPersonNo").val()) {

													isError = true;

													$("#error_contactPersonNo").show()

												} else {
													$("#error_contactPersonNo").hide()
												}
												
												
												if (!$("#contactPersonEmail").val()) {

													isError = true;

													$("#error_contactPersonEmail").show()

												} else {
													$("#error_contactPersonEmail").hide()
												}
												
												if (!isError) {

													var x = true;
													if (x == true) {

														document
																.getElementById("submtbtn").disabled = true;
														
														document
															.getElementById("cnclbtn").disabled = true;
														
														return true;
													}
													//end ajax send this to php page
												}
												return false;
											});
						});
		//
	</script>
	
	<!-- <script type="text/javascript">
	$('#submtbtn').on('click', function() {
        swalInit({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            type: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes, delete it!',
            cancelButtonText: 'No, cancel!',
            confirmButtonClass: 'btn btn-success',
            cancelButtonClass: 'btn btn-danger',
            buttonsStyling: false
        }).then(function(result) {
            if(result.value) {
                swalInit(
                    'Deleted!',
                    'Your file has been deleted.',
                    'success'
                );
            }
            else if(result.dismiss === swal.DismissReason.cancel) {
                swalInit(
                    'Cancelled',
                    'Your imaginary file is safe :)',
                    'error'
                );
            }
        });
    });
	
	</script> -->

</body>
</html>
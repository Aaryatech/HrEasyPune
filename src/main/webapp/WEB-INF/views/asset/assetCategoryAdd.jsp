<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>

<body>
<c:url value="/getAssetCategoryInfo" var="getAssetCategoryInfo"></c:url>

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
								<td width="60%"><h5 class="pageTitle"><i class="icon-list-unordered"></i> ${title}</h5></td>
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
									action="${pageContext.request.contextPath}/submitInsertAssetCat"
									id="submitInsertLocaion" method="post">
									
									<div class="form-group row">									
										<div class="col-md-6">
											<input type="hidden" class="form-control" placeholder="Enter Asset Category" id="assetCatId"
											name="assetCatId" autocomplete="off" onchange="trim(this)" value="${asset.assetCatId}">
										</div>
									</div>				
									<div class="form-group row">									
										<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="locName">Asset 
													Category <span class="text-danger">* </span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"
														placeholder="Enter Asset Category" id="assetCat" value="${asset.catName}"
														name="assetCat" autocomplete="off" onchange="trim(this)">
													<span class="validation-invalid-label" id="error_assetCat"
														style="display: none;">This field is required.</span>
												</div>
											</div>	
											
												<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="returnNotifctnDate">Asset Return
													Notification Date <span class="text-danger">* </span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"
														placeholder="Enter Return Notification Date" id="returnNotifctnDate" value="${asset.returnNotifctnDate}"
														name="returnNotifctnDate" autocomplete="off" onchange="trim(this)">
													<span class="validation-invalid-label" id="error_returnNotifctnDate"
														style="display: none;">This field is required.</span>
												</div>
											</div>										
									</div>


									<div class="form-group row">
									
									<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="amcNotifctnDate">Asset AMC
													Notification Date <span class="text-danger">* </span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"
														placeholder="Enter AMC Notification Date" id="amcNotifctnDate" value="${asset.amcNotifctnDate}"
														name="amcNotifctnDate" autocomplete="off" onchange="trim(this)">
													<span class="validation-invalid-label" id="error_amcNotifctnDate"
														style="display: none;">This field is required.</span>
												</div>
											</div>	
									
										<div class="col-md-6">
											<label class="col-form-label col-lg-5 float" for="remark">Remark
												: </label>
												<div class="col-lg-7 float">
												<textarea rows="3" cols="3" class="form-control" 
													placeholder="Any Remark" onchange="trim(this)" id="remark"
													name="remark">${asset.catRemark}</textarea>
	
											</div>
										</div>
									</div>

									<div class="form-group row mb-0">
									<div  style="margin: 0 auto;"><!--  class="col-lg-10 ml-lg-auto" -->
										
											<button type="submit" class="btn blue_btn"
												id="submtbtn">
												Submit <i class="icon-paperplane ml-2"></i>
											</button>
											<a href="${pageContext.request.contextPath}/showAssetCategory"><button id="cnslbtn"
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

<!-- <script>
	$("#assetCat").change(function(){  
    var cat = $("#assetCat").val();
    alert(cat)
    

			$
					.getJSON(
							'${getAssetCategoryInfo}',
							{
								cat : cat,
								ajax : 'true',

							},
							function(data) {
								//alert("data" + data);

								alert("Data  " +JSON.stringify(data));
								if (data.facultyId > 0) {
									
								} else {} 

							});
	});
</script> -->
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

							$("#submitInsertLocaion")
									.submit(
											function(e) {
												var isError = false;
												var errMsg = "";

												if (!$("#assetCat").val()) {

													isError = true;

													$("#error_assetCat").show()
													//return false;
												} else {
													$("#error_assetCat").hide()
												}
												
												if (!$("#returnNotifctnDate").val() && $("#returnNotifctnDate").val()==0) {

													isError = true;

													$("#error_returnNotifctnDate").show()
													//return false;
												} else {
													$("#error_returnNotifctnDate").hide()
												}
												if (!$("#amcNotifctnDate").val()) {

													isError = true;

													$("#error_amcNotifctnDate").show()
													
												} else {
													$("#error_amcNotifctnDate").hide()
												}

												if (!isError) {

													var x = true;
													if (x == true) {

														document
															.getElementById("submtbtn").disabled = true;
														document
															.getElementById("cnslbtn").disabled = true;
														
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
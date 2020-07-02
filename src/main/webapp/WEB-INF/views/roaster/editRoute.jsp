<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
								<h5 class="pageTitle">
									<i class="icon-list-unordered"></i> Edit Route
								</h5>
							</div>

							<div class="card-body">

								<form
									action="${pageContext.request.contextPath}/submitEditRoute"
									id="submitInsertLocaion" method="post">
									<div class="form-group row">
										<div class="col-md-6">
											<label class="col-form-label   col-lg-5 float"
												for="routeName">Route Name : </label>
											<div class="col-lg-7  float">${route.routeName }</div>
										</div>

										<div class="col-md-6">
											<label class="col-form-label  col-lg-5 float" for="frName">Franchisee
												Name : </label>
											<div class="col-lg-7  float">
												<%-- <input type="text" class="form-control"
													placeholder="Franchisee Name" id="locShortName"
													value="${editLocation.locNameShort}" name="locShortName"
													autocomplete="off" onchange="trim(this)" maxlength="5"> --%>
												${route.frName}


											</div>
										</div>
									</div>



									<div class="form-group row">
										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="starttime">Start Time <span class="text-danger">*
											</span>:
											</label>
											<div class="col-lg-7  float">
												<%-- <textarea rows="3" cols="3" class="form-control"
													placeholder="Location Short Address" onchange="trim(this)"
													id="add" name="add">  ${editLocation.locShortAddress} </textarea> --%>
												<input type="time" class="form-control"
													placeholder="Start Time" id="starttime" name="starttime"
													autocomplete="off" onchange="trim(this)"
													value="${route.startTime}"> <span
													class="validation-invalid-label" id="error_starttime"
													style="display: none;">This field is required.</span>
											</div>
										</div>

										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="km">KM <span class="text-danger">* </span>:
											</label>
											<div class="col-lg-7  float">
												<input type="text" class="form-control numbersOnly"
													placeholder="KM" id="km" name="km" autocomplete="off"
													onchange="trim(this)" value="${route.km}"> <span
													class="validation-invalid-label" id="error_km"
													style="display: none;">This field is required.</span>
											</div>
										</div>
									</div>


									<div class="form-group row">
										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="incetive">Incentive <span class="text-danger">*
											</span>:
											</label>
											<div class="col-lg-7 float">
												<input type="text" class="form-control numbersOnly"
													placeholder="Incentive" id="incetive" name="incetive"
													autocomplete="off" onchange="trim(this)"
													value="${route.incentive}" maxlength="10"> <span
													class="validation-invalid-label" id="error_incetive"
													style="display: none;">This field is required.</span>
											</div>
										</div>

										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="typeId">Select Route Type <span
												class="text-danger">* </span>:
											</label>
											<div class="col-lg-7 float">
												<select name="typeId" data-placeholder="Select Route"
													id="typeId" class="form-control">
													<option value="" selected>Select</option>
													<c:forEach items="${routeTypeList}" var="routeTypeList">
														<c:choose>
															<c:when test="${routeTypeList.typeId==route.typeId}">
																<option value="${routeTypeList.typeId}" selected>${routeTypeList.typeName}</option>
															</c:when>
															<c:otherwise>
																<option value="${routeTypeList.typeId}">${routeTypeList.typeName}</option>
															</c:otherwise>
														</c:choose>

													</c:forEach>
												</select> <span class="validation-invalid-label" id="error_typeId"
													style="display: none;">This field is required.</span>
											</div>
										</div>
									</div>


									<%-- <div class="form-group row">
										<div class="col-md-6">
											<label class="col-form-label col-lg-5 float" for="remark">Remark
												: </label>
											<div class="col-lg-7 float">
												<textarea rows="3" cols="3" class="form-control"
													placeholder="Any Remark" onchange="trim(this)" id="remark"
													name="remark"> ${editLocation.locRemarks} </textarea>

											</div>
										</div>
									</div> --%>

									<div class="form-group row mb-0">
										<div style="margin: 0 auto;">
											<button type="submit" class="btn blue_btn ml-3 legitRipple"
												id="submtbtn">
												Submit <i class="icon-paperplane ml-2"></i>
											</button>
											<a href="${pageContext.request.contextPath}/rouetMasterList"><button
													type="button" class="btn btn-light">
													<i class="${sessionScope.cancelIcon}" aria-hidden="true"></i>&nbsp;&nbsp;
													Back
												</button></a>
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
		function checkSame() {
			x = document.getElementById("locName").value;
			y = document.getElementById("locShortName").value;
			//alert(x);

			if (x !== '' && y !== '') {
				if (x == y) {
					$("#error_sameName").show()
					document.getElementById("locShortName").value = "";
				} else {
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
		$(document).ready(function($) {

			$("#submitInsertLocaion").submit(function(e) {
				var isError = false;
				var errMsg = "";

				$("#error_starttime").hide()
				$("#error_km").hide()
				$("#error_typeId").hide()
				$("#error_incetive").hide()

				if (!$("#starttime").val()) {

					isError = true;

					$("#error_starttime").show()
					//return false;
				}

				if (!$("#km").val()) {

					isError = true;

					$("#error_km").show()

				}

				if (!$("#typeId").val()) {

					isError = true;

					$("#error_typeId").show()

				}

				if (!$("#incetive").val()) {

					isError = true;

					$("#error_incetive").show()

				}

				if (!isError) {

					document.getElementById("submtbtn").disabled = true;
					return true;

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
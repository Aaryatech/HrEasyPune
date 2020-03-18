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

				<div class="card"></div>
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
								<h5 class="card-title">Profile</h5>
							</div>

							<div class="card-body fixed_height">
								<div class="row">
									<div class="col-md-3 prof_pic">
										<img
											src="https://buffer.com/library/wp-content/uploads/2015/03/adjust-tie-1024x683.jpeg"
											alt="" width="100%">
									</div>
									<div class="col-md-8">

										<!-- basic information -->
										<div class="basic_info">
											<h3 class="info_title">Basic Information</h3>

											<div class="row">
												<div class="col-md-4">
													<div class="profile_one">
														Emp Code : <span id="emp_code">${empinfo.empCode}</span>
													</div>
												</div>
												<div class="col-md-4">&nbsp;</div>
												<div class="col-md-4">&nbsp;</div>
												<div class="col-md-4">
													<div class="profile_one">
														First Name : <span id="emp_fname">${empinfo.firstName}</span>
													</div>
												</div>
												<div class="col-md-4">
													<div class="profile_one">
														Middle Name : <span id="emp_mname">${empinfo.middleName}</span>
													</div>
												</div>
												<div class="col-md-4">
													<div class="profile_one">
														Last Name : <span id="emp_lname">${empinfo.surname}</span>
													</div>
												</div>

												<!-- <div class="col-md-4">
													<div class="profile_one">
														Location : <span id="emp_loc"> </span>
													</div>
												</div>
												<div class="col-md-4">
													<div class="profile_one">
														Designation : <span id="emp_desig"> </span>
													</div>
												</div>
												<div class="col-md-4">
													<div class="profile_one">
														Department : <span id="emp_depart"></span>
													</div>
												</div> -->

												<div class="col-md-4">
													<div class="profile_one">
														Contact No. : <span id="emp_mob1">${empinfo.mobileNo1}</span>
													</div>
												</div>


											</div>
										</div>
									</div>
								</div>
								<div class="card-header header-elements-inline">
									<h5 class="card-title">Full And Final Process</h5>
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
										action="${pageContext.request.contextPath}/fullnfinalprocess"
										id="fullnfinalprocess" method="post">


										<div class="form-group row">
											<label
												class="col-form-label text-info font-weight-bold col-lg-2"
												for="leaveDate">Leaving Date <span
												class="text-danger">* </span>:
											</label>
											<div class="col-lg-4">
												<input type="text" class="form-control datepickerclass"
													value="${empSalInfo.cmpLeavingDate}"
													placeholder="Leaving Date" id="leaveDate" name="leaveDate"
													autocomplete="off"> <span
													class="validation-invalid-label" id="error_leaveDate"
													style="display: none;">This field is required.</span>
											</div>

											<label
												class="col-form-label text-info font-weight-bold  col-lg-2"
												for="leaveReason">Leaving Reason <span
												class="text-danger">* </span>:
											</label>
											<div class="col-lg-4">
												<input type="text" class="form-control"
													placeholder="Leaving Reason" id="leaveReason"
													name="leaveReason" autocomplete="off" onchange="trim(this)"
													value="${empSalInfo.leavingReason}"> <span
													class="validation-invalid-label" id="error_leaveReason"
													style="display: none;">This field is required.</span>
											</div>
										</div>

										<div class="form-group row">
											<label
												class="col-form-label text-info font-weight-bold  col-lg-2"
												for="lrEsic">LR For ESIC <span class="text-danger">*
											</span> :
											</label>
											<div class="col-lg-4">
												<select name="lrEsic" data-placeholder="Select Uniform Size"
													id="lrEsic"
													class="form-control form-control-select2 select2-hidden-accessible">
													<option value="-1"
														${empSalInfo.leavingReasonEsic == '-1' ? 'selected' : ''}>Please
														Select</option>
													<option value="0"
														${empSalInfo.leavingReasonEsic=='0' ? 'selected' : ''}>0-Without
														Reason</option>
													<option value="1"
														${empSalInfo.leavingReasonEsic=='1' ? 'selected' : ''}>1-On
														Leave</option>
													<option value="2"
														${empSalInfo.leavingReasonEsic=='2' ? 'selected' : ''}>2-Self
														Service</option>
													<option value="3"
														${empSalInfo.leavingReasonEsic=='3' ? 'selected' : ''}>3-Retired</option>
													<option value="4"
														${empSalInfo.leavingReasonEsic=='4' ? 'selected' : ''}>4-Out
														of coverage</option>

													<option value="5"
														${empSalInfo.leavingReasonEsic=='5' ? 'selected' : ''}>5-Expired</option>
													<option value="6"
														${empSalInfo.leavingReasonEsic=='6' ? 'selected' : ''}>6-Non
														Implemented Area</option>
													<option value="7"
														${empSalInfo.leavingReasonEsic=='7' ? 'selected' : ''}>7-Compliance
														by immediate Employer</option>
													<option value="8"
														${empSalInfo.leavingReasonEsic=='8' ? 'selected' : ''}>8-Suspension
														of work</option>
													<option value="9"
														${empSalInfo.leavingReasonEsic=='9' ? 'selected' : ''}>9-Strike/Lockout</option>

													<option value="10"
														${empSalInfo.leavingReasonEsic=='10' ? 'selected' : ''}>10-Retrenchment</option>
													<option value="11"
														${empSalInfo.leavingReasonEsic=='11' ? 'selected' : ''}>11-No
														Work</option>
													<option value="12"
														${empSalInfo.leavingReasonEsic=='12' ? 'selected' : ''}>12-Does
														not belong to this Employer</option>


												</select> <span class="validation-invalid-label" id="error_lrEsic"
													style="display: none;">This field is required.</span>
											</div>


											<label
												class="col-form-label text-info font-weight-bold  col-lg-2"
												for="lrForPF">LR For PF <span class="text-danger">*
											</span>:
											</label>

											<div class="col-lg-4">
												<select name="lrForPF"
													data-placeholder="Select Uniform Size" id="lrForPF"
													class="form-control form-control-select2 select2-hidden-accessible">
													<option value="0"
														${empSalInfo.leavingReasonPf == '0' ? 'selected' : ''}>Please
														Select</option>

													<option value="1"
														${empSalInfo.leavingReasonPf=='1' ? 'selected' : ''}>C-Cessation</option>
													<option value="2"
														${empSalInfo.leavingReasonPf=='2' ? 'selected' : ''}>S-Superannuation</option>
													<option value="3"
														${empSalInfo.leavingReasonPf=='3' ? 'selected' : ''}>R-Retirement</option>
													<option value="4"
														${empSalInfo.leavingReasonPf=='4' ? 'selected' : ''}>D-Death
														in Service</option>
													<option value="5"
														${empSalInfo.leavingReasonPf=='5' ? 'selected' : ''}>P-Permanent
														Disablement</option>

												</select> <span class="validation-invalid-label" id="error_lrForPF"
													style="display: none;">This field is required.</span>
											</div>

										</div>



										<div class="form-group text-center">
											<div class="col-lg-12">
												<!-- <button type="reset" class="btn btn-light legitRipple">Reset</button> -->
												<button type="submit" class="btn bg-blue ml-3 legitRipple"
													id="submtbtn">Full And Final Process</button>
												<a
													href="${pageContext.request.contextPath}/showEmpListForFullnfinal"><button
														type="button" class="btn btn-light">Back</button></a>

											</div>
										</div>
									</form>
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
	</div>
	<script>
		function trim(el) {
			el.value = el.value.replace(/(^\s*)|(\s*$)/gi, ""). // removes leading and trailing spaces
			replace(/[ ]{2,}/gi, " "). // replaces multiple spaces with one space 
			replace(/\n +/, "\n"); // Removes spaces after newlines
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

			$("#fullnfinalprocess").submit(function(e) {

				var isError = false;
				var errMsg = "";
				$("#error_leaveDate").hide();
				$("#error_leaveReason").hide();
				$("#error_lrEsic").hide();
				$("#error_lrForPF").hide();

				if (!$("#leaveDate").val()) {
					isError = true;
					$("#error_leaveDate").show()
				}
				if (!$("#leaveReason").val()) {
					isError = true;
					$("#error_leaveReason").show()
				}
				if ($("#lrEsic").val() == -1 || !$("#lrEsic").val()) {
					isError = true;
					$("#error_lrEsic").show()
				}
				if ($("#lrForPF").val() == 0 || !$("#lrForPF").val()) {
					isError = true;
					$("#error_lrForPF").show()
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

	<script type="text/javascript">
		// Single picker
		$('.datepickerclass').daterangepicker({
			"autoUpdateInput" : false,
			singleDatePicker : true,
			selectMonths : true,
			selectYears : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		}, function(start_date) {
			$(this.element).val(start_date.format('DD-MM-YYYY'));
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
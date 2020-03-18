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
									<h5 class="card-title">Amount Deduction</h5>
								</div>
								<div class="card-body">


									<form
										action="${pageContext.request.contextPath}/fullnfinalprocess"
										id="fullnfinalprocess" method="post">


										<div class="form-group row">
											<label
												class="col-form-label text-info font-weight-bold col-lg-2"
												for="advanceamt">Advance AMT <span
												class="text-danger">* </span>:
											</label>
											<div class="col-lg-4">
												<input type="text" class="form-control numbersOnly"
													value="0" placeholder="Advance Amount" id="advanceamt"
													name="advanceamt" autocomplete="off">
											</div>
										</div>

										<div class="form-group row">
											<label
												class="col-form-label text-info font-weight-bold col-lg-2"
												for="loanamt">Loan AMT <span class="text-danger">*
											</span>:
											</label>
											<div class="col-lg-4">
												<input type="text" class="form-control numbersOnly"
													value="0" placeholder="Loan Amount" id="loanamt"
													name="loanamt" autocomplete="off">
											</div>
										</div>

										<div class="form-group row">
											<label
												class="col-form-label text-info font-weight-bold col-lg-2"
												for="paydeductamt">Loan AMT <span
												class="text-danger">* </span>:
											</label>
											<div class="col-lg-4">
												<input type="text" class="form-control numbersOnly"
													value="0" placeholder="Loan Amount" id="paydeductamt"
													name="paydeductamt" autocomplete="off">
											</div>
										</div>

									</form>

								</div>
								<div class="card-header header-elements-inline">
									<h5 class="card-title">
										Leave Cash AMT <input type="checkbox" id="isleavecash"
											name="isleavecash" value="0" onchange="isLeavecashChange()">
									</h5>

								</div>
								<div class="card-body">
									<div id="incashmentDiv" style="display: none;">
										<div class="table-responsive">
											<table
												class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
												id="printtable1">


												<thead>
													<tr class="bg-blue" style="text-align: center;">

														<th width="20%">Leave Type</th>
														<th width="10%">Previous Year Opening Bal</th>
														<th width="10%">Previous Year Earned</th>
														<th width="10%">Previous Year Approved</th>
														<th width="10%">Previous Year Applied</th>
														<th width="10%">Previous Year Balanced</th>
													</tr>
												</thead>


												<tbody>
													<c:forEach items="${previousleavehistorylist}"
														var="previousleavehistorylist" varStatus="count">
														<tr>

															<td>${previousleavehistorylist.lvTitle}</td>
															<td>${previousleavehistorylist.balLeave}</td>
															<td>${previousleavehistorylist.lvsAllotedLeaves}</td>
															<td>${previousleavehistorylist.sactionLeave}</td>
															<td>${previousleavehistorylist.aplliedLeaeve}</td>
															<td>${ballv}</td>

														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</div>
								</div>

								<div class="card-header header-elements-inline">
									<h5 class="card-title">Amount Add</h5>

								</div>
								<div class="card-body">
									<!-- <div class="form-group row">
										<label
											class="col-form-label text-info font-weight-bold col-lg-2"
											for="rewardamt">Reward <span class="text-danger">*
										</span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control numbersOnly" value="0"
												placeholder="Reward Amount" id="rewardamt" name="rewardamt"
												autocomplete="off">
										</div>
									</div> -->
									<div class="form-group row">
										<label
											class="col-form-label text-info font-weight-bold col-lg-2"
											for="claimamt">Claim <span class="text-danger">*
										</span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control numbersOnly" value="0"
												placeholder="Claim Amount" id="claimamt" name="claimamt"
												autocomplete="off">
										</div>
									</div>
									<div class="form-group row">
										<label
											class="col-form-label text-info font-weight-bold col-lg-2"
											for="gratuityamt">Gratuity <span class="text-danger">*
										</span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control numbersOnly" value="0"
												placeholder="Gratuity Amount" id="gratuityamt"
												name="gratuityamt" autocomplete="off">
										</div>
									</div>
									<div class="form-group row">
										<label
											class="col-form-label text-info font-weight-bold col-lg-2"
											for="payrollamt">Payroll for Remaining AMT <span
											class="text-danger">* </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control numbersOnly" value="0"
												placeholder="Payroll for Remaining Amount" id="payrollamt"
												name="payrollamt" autocomplete="off">
										</div>
									</div>
									<div class="form-group row">
										<label
											class="col-form-label text-info font-weight-bold col-lg-2"
											for="bonusamt">Bonus & Exgratia<span
											class="text-danger">* </span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control numbersOnly" value="0"
												placeholder="Bonus & Exgratia Amount" id="bonusamt"
												name="bonusamt" autocomplete="off">
										</div>
									</div>
								</div>

								<div class="card-header header-elements-inline">
									<h5 class="card-title">Adjust Amount</h5>

								</div>
								<div class="card-body">
									<div class="form-group row">
										<label
											class="col-form-label text-info font-weight-bold col-lg-2"
											for="plusamt">Plus <span class="text-danger">*
										</span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control numbersOnly" value="0"
												placeholder="Plus Amount" id="plusamt" name="plusamt"
												autocomplete="off">
										</div>
									</div>
									<div class="form-group row">
										<label
											class="col-form-label text-info font-weight-bold col-lg-2"
											for="minusamt">Minus <span class="text-danger">*
										</span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control numbersOnly" value="0"
												placeholder="Minus  Amount" id="minusamt" name="minusamt"
												autocomplete="off">
										</div>
									</div>



								</div>

								<div class="form-group text-center">
									<div class="col-lg-12">
										<!-- <button type="reset" class="btn btn-light legitRipple">Reset</button> -->
										<button type="submit" class="btn bg-blue ml-3 legitRipple"
											id="submtbtn">Submit</button>
										<a
											href="${pageContext.request.contextPath}/showEmpListForFullnfinal"><button
												type="button" class="btn btn-light">Back</button></a>

									</div>
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

		function isLeavecashChange() {

			if (document.getElementById("isleavecash").checked == true) {
				$("#incashmentDiv").show();
				document.getElementById("isleavecash").value = 1;
			} else {
				$("#incashmentDiv").hide();
				document.getElementById("isleavecash").value = 0;
			}
		}
	</script>
</body>
</html>
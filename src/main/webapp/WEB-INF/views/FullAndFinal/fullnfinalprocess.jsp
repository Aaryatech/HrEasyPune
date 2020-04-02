<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-datepicker.css"
	type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-datepicker.js"></script>
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

												<div class="col-md-4">
													<div class="profile_one">
														Contact No. : <span id="emp_mob1">${empinfo.mobileNo1}</span>
													</div>
												</div>
												<div class="col-md-4">
													<div class="profile_one">
														Gross Salary : <span id="grossSalary">${empSalInfo.grossSalary}</span>
													</div>
												</div>


											</div>
										</div>

									</div>
								</div>

								<form
									action="${pageContext.request.contextPath}/submitFullandFinal"
									id="submitFullandfinal" method="post">
									<div class="card-header header-elements-inline">
										<h5 class="card-title">FILL INFORMATION</h5>
									</div>
									<div class="card-body">

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
											<label class="col-form-label col-lg-2" for="lrEsic">LR
												For ESIC : </label>
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


											<label class="col-form-label col-lg-2" for="lrForPF">LR
												For PF : </label>

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


									</div>
									<div class="card-header header-elements-inline">
										<h5 class="card-title">Amount Deduction</h5>
									</div>
									<div class="card-body">




										<div class="form-group row">
											<label
												class="col-form-label text-info font-weight-bold col-lg-2"
												for="advanceamt">Advance AMT <span
												class="text-danger">* </span>:
											</label>
											<div class="col-lg-4">
												<input type="text" class="form-control numbersOnly"
													value="${advanceAndLoanInfo.advanceAmt}"
													placeholder="Advance Amount" id="advanceamt"
													name="advanceamt" autocomplete="off"
													onchange="finalcalculation()">
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
													value="${advanceAndLoanInfo.loanAmt}"
													placeholder="Loan Amount" id="loanamt" name="loanamt"
													autocomplete="off" onchange="finalcalculation()">
											</div>
										</div>




									</div>
									<div class="card-header header-elements-inline">
										<h5 class="card-title">
											Leave Cash AMT <input type="checkbox" id="isleavecash"
												name="isleavecash" value="0" onchange="isLeavecashChange()">
										</h5>

									</div>
									<div class="card-body">
										<div id="incashmentDiv" style="display: none;">
											<div class="form-group row">
												<label class="col-form-label col-lg-2">Rate Per Day:
												</label> <label
													class="col-form-label col-lg-2 text-info font-weight-bold"
													for="locId"> <fmt:formatNumber type="number"
														maxFractionDigits="2" minFractionDigits="2"
														groupingUsed="false"
														value="${((empBasicAllownceForLeaveInCash.basic+
																	empBasicAllownceForLeaveInCash.allowanceValue)/day)}" />
												</label> <input type="hidden" class=" numbersOnly"
													value="${((empBasicAllownceForLeaveInCash.basic+
																	empBasicAllownceForLeaveInCash.allowanceValue)/day)}"
													id="ratePerDay" name="ratePerDay" autocomplete="off">
											</div>
											<div class="form-group row">
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
																	<c:set
																		value="${previousleavehistorylist.balLeave+previousleavehistorylist.lvsAllotedLeaves-previousleavehistorylist.sactionLeave-previousleavehistorylist.aplliedLeaeve}"
																		var="ballv"></c:set>
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
											<div class="form-group row">
												<label
													class="col-form-label text-info font-weight-bold col-lg-2"
													for="leaveincash">Leave In Cash <span
													class="text-danger">* </span>:
												</label>
												<div class="col-lg-4">
													<input type="text" class="form-control numbersOnly"
														value="0" placeholder="Leave In Cash" id="leaveincash"
														name="leaveincash" autocomplete="off"
														onchange="calCashAmt()">
												</div>
											</div>
											<div class="form-group row">
												<label
													class="col-form-label text-info font-weight-bold col-lg-2"
													for="leavecashamt">Leave Cash AMT<span
													class="text-danger">* </span>:
												</label>
												<div class="col-lg-4">
													<input type="text" class="form-control numbersOnly"
														value="0" placeholder="Leave Cash Amount"
														id="leavecashamt" name="leavecashamt" autocomplete="off"
														readonly>
												</div>
											</div>
										</div>

									</div>

									<div class="card-header header-elements-inline">
										<h5 class="card-title">Amount Add</h5>

									</div>
									<div class="card-body">

										<c:set value="0" var="graduatyCalAmt"></c:set>
										<c:choose>
											<c:when test="${getDetailForGraduaty.service>5}">
												<c:set
													value="${((getDetailForGraduaty.basic+getDetailForGraduaty.allowanceValue)/26)*15*getDetailForGraduaty.service}"
													var="graduatyCalAmt"></c:set>
											</c:when>
										</c:choose>
										<div class="form-group row">
											<label
												class="col-form-label text-info font-weight-bold col-lg-2"
												for="gratuityamt">Gratuity <span class="text-danger">*
											</span>:
											</label>
											<div class="col-lg-4">
												<input type="text" class="form-control numbersOnly"
													value="<fmt:formatNumber type="number"
													maxFractionDigits="2" minFractionDigits="2"
													groupingUsed="false"
													value="${graduatyCalAmt}" />"
													placeholder="Gratuity Amount" id="gratuityamt"
													name="gratuityamt" autocomplete="off"
													onchange="finalcalculation()">
											</div>
										</div>
										<div class="form-group row"></div>
										<div class="form-group row">
											<label class="col-form-label  col-lg-2" for="bonusamt">Bonus
												<input type="checkbox" id="isbonusApp" name="isbonusApp"
												value="0" onchange="isbonusAppChange()">
											</label>

										</div>
										<div id="bonusDiv">
											<div class="form-group row">
												<label
													class="col-form-label text-info font-weight-bold col-lg-2"
													for="fromMonth"> From Month <span
													style="color: red">* </span> :
												</label>
												<div class="col-md-2">
													<input type="text" name="fromMonth" id="fromMonth"
														class="form-control datepicker" />
												</div>
											</div>

											<div class="form-group row">
												<label
													class="col-form-label text-info font-weight-bold col-lg-2"
													for="toMonth"> To Month <span style="color: red">*
												</span> :
												</label>
												<div class="col-md-2">
													<input type="text" name="toMonth" id="toMonth"
														class="form-control datepicker" />
												</div>

												<button type="submit" class="btn bg-blue ml-3 legitRipple"
													id="calculatebtn" onclick="bonuscalculation()">Calculate</button>
											</div>
											<div class="form-group row">
												<label class="col-form-label   col-lg-2" for="gratuityamt">Working
													Day : </label>
												<div class="col-lg-4">
													<input type="text" class="form-control numbersOnly"
														value="0" placeholder="Working Day" id="workingday"
														name="workingday" autocomplete="off" readonly>
												</div>
											</div>
											<div class="form-group row">
												<label
													class="col-form-label text-info font-weight-bold col-lg-2"
													for="gratuityamt">Bonus AMT <span
													class="text-danger">* </span>:
												</label>
												<div class="col-lg-4">
													<input type="text" class="form-control numbersOnly"
														value="0" placeholder="Bonus Amount" id="bonusAmt"
														name="bonusAmt" autocomplete="off">
												</div>
											</div>
										</div>


									</div>

									<div class="card-header header-elements-inline">
										<h5 class="card-title">Adjust Amount</h5>

									</div>
									<div class="card-body">
										<div class="form-group row">
											<label class="col-form-label  col-lg-2" for="plusamt">Plus
												: </label>
											<div class="col-lg-4">
												<input type="text" class="form-control numbersOnly"
													value="0" placeholder="Plus Amount" id="plusamt"
													name="plusamt" autocomplete="off"
													onchange="finalcalculation()">
											</div>
										</div>
										<div class="form-group row">
											<label class="col-form-label  col-lg-2" for="minusamt">Minus
												: </label>
											<div class="col-lg-4">
												<input type="text" class="form-control numbersOnly"
													value="0" placeholder="Minus  Amount" id="minusamt"
													name="minusamt" autocomplete="off"
													onchange="finalcalculation()">
											</div>
										</div>

										<div class="form-group row">
											<label
												class="col-form-label text-info font-weight-bold col-lg-2"
												for="netamt">Net AMT <span class="text-danger">*
											</span>:
											</label>
											<div class="col-lg-4">
												<input type="text" class="form-control numbersOnly"
													value="0" placeholder="Net  Amount" id="netamt"
													name="netamt" autocomplete="off" readonly>
											</div>
											<!-- <button type="submit" class="btn bg-blue ml-3 legitRipple"
											id="calculatfinalebtn" onclick="finalcalculation()">Calculate</button> -->
										</div>

										<div class="form-group row">
											<label class="col-form-label col-lg-2" for="remark">Remark
												: </label>
											<div class="col-lg-10">
												<textarea rows="3" cols="3" class="form-control"
													placeholder="Any Remark" onchange="trim(this)" id="remark"
													name="remark" autocomplete="off"></textarea>

											</div>
										</div>

									</div>

									<div class="form-group text-center">
										<div class="col-lg-12">
											<!-- <button type="reset" class="btn btn-light legitRipple">Reset</button> -->
											<button type="button"
												class="btn bg-blue ml-3 legitRipple bootbox_custom"
												id="submtbtn">Submit</button>
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
			//document.getElementById("leavecashamt").value = 0;

			document.getElementById("leaveincash").value = 0;
			document.getElementById("leavecashamt").value = 0;

			if (document.getElementById("isleavecash").checked == true) {
				$("#incashmentDiv").show();
				document.getElementById("isleavecash").value = 1;
			} else {
				$("#incashmentDiv").hide();
				document.getElementById("isleavecash").value = 0;
			}
			finalcalculation();
		}
		function calCashAmt() {
			var ratePerDay = parseFloat(document.getElementById("ratePerDay").value);
			var leaveincash = parseFloat(document.getElementById("leaveincash").value);
			document.getElementById("leavecashamt").value = (ratePerDay * leaveincash)
					.toFixed(2);
			finalcalculation();
		}
		$(document).ready(function() {
			// month selector
			$('.datepicker').datepicker({
				autoclose : true,
				format : "mm-yyyy",
				viewMode : "months",
				minViewMode : "months"

			});

		});
		function isbonusAppChange() {
			//document.getElementById("leavecashamt").value = 0;

			document.getElementById("bonusAmt").value = 0;
			document.getElementById("workingday").value = 0;
			document.getElementById("fromMonth").value = "";
			document.getElementById("toMonth").value = "";

			if (document.getElementById("isbonusApp").checked == true) {
				$("#bonusDiv").show();
				document.getElementById("isbonusApp").value = 1;
			} else {
				$("#bonusDiv").hide();
				document.getElementById("isbonusApp").value = 0;
			}
			finalcalculation();
		}
		function finalcalculation() {
			var advanceamt = parseFloat($("#advanceamt").val());
			var loanamt = parseFloat($("#loanamt").val());
			var leavecashamt = parseFloat($("#leavecashamt").val());
			var gratuityamt = parseFloat($("#gratuityamt").val());
			var bonusAmt = parseFloat($("#bonusAmt").val());
			var plusamt = parseFloat($("#plusamt").val());
			var minusamt = parseFloat($("#minusamt").val());

			var netAmt = advanceamt + loanamt + leavecashamt + gratuityamt
					+ bonusAmt + plusamt - minusamt;
			document.getElementById("netamt").value = netAmt.toFixed(2);
		}
		function bonuscalculation() {
			var fromMonth = $("#fromMonth").val();
			var toMonth = $("#toMonth").val();

			if (fromMonth != "" && toMonth != "") {

				var fd = new FormData();
				fd.append('fromMonth', fromMonth);
				fd.append('toMonth', toMonth);

				$
						.ajax({
							url : '${pageContext.request.contextPath}/calculateBonusAmt',
							type : 'post',
							dataType : 'json',
							data : fd,
							contentType : false,
							processData : false,
							success : function(response) {
								//alert(response);
								var presentDays = response.presentdays
										+ response.weeklyoff + response.holiday;
								document.getElementById("workingday").value = presentDays;
								var amt = (((response.basic + response.allowanceValue) * 12) / 365)
										* presentDays * response.bonusPer;
								document.getElementById("bonusAmt").value = amt
										.toFixed(2);
								finalcalculation();
							},
						});
			} else {
				if (fromMonth == "") {
					alert("Select From Month ");
				} else if (toMonth == "") {
					alert("Select To Month ");
				}

			}

		}
	</script>
	<script>
		// Custom bootbox dialog
		$('.bootbox_custom').on('click', function() {
			//var uuid = $(this).data("uuid") // will return the number 123
			bootbox.confirm({
				title : 'Confirm ',
				message : 'Are you sure want to Submit ? ',
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
						document.getElementById('submitFullandfinal').submit();

					}
				}
			});
		});
	</Script>
</body>
</html>
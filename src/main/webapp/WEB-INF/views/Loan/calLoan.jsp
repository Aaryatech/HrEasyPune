<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>
<c:url value="/loanCalculation" var="loanCalculation"></c:url>
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
								<table width="100%">
									<tr width="100%">
										<td width="60%"><h5 class="pageTitle">
												<i class="icon-list-unordered"></i> Add Loan
											</h5></td>
										<td width="40%" align="right">
											<%-- <a
									href="${pageContext.request.contextPath}/showAddKra?empId=${editKra.exVar3}&finYrId=${editKra.exVar2}"
									class="breadcrumb-elements-item">
										<button type="button" class="btn btn-primary">KRA List </button>
								</a>  --%>
										</td>
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
									action="${pageContext.request.contextPath}/submitInsertLoan"
									id="submitInsertLocaion" method="post">
									<input type="hidden" value="${empPersInfo.empId}" id="empId"
										name="empId">
									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="empName">Employee
											Name : </label>
										<div class="col-lg-10">
											<input type="text" class="form-control"
												value="${empPersInfoString}" id="empName"
												readonly="readonly" name="empName" autocomplete="off"
												onchange="trim(this)">

										</div>
									</div>

									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="grossSal">
											Gross Salary : </label>
										<div class="col-lg-10">
											<input type="text" class="form-control" id="grossSal"
												value="${empPersInfo.grossSalary}" readonly="readonly"
												name="grossSal" autocomplete="off" onchange="trim(this)">
										</div>
									</div>

									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="grossSal">
											Previous Loan Unpaid Amount : </label>
										<div class="col-lg-10">
											<input type="text" class="form-control" id="grossSal"
												readonly="readonly" name="grossSal"
												value="${prevLoan.currentOutstanding}" autocomplete="off"
												onchange="trim(this)">
										</div>
									</div>

									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="grossSal">
											Loan EMI Per Month : </label>
										<div class="col-lg-10">
											<input type="text" class="form-control" id="grossSal"
												readonly="readonly" name="grossSal"
												value="${prevLoan.loanEmi}" autocomplete="off"
												onchange="trim(this)">
										</div>
									</div>

									<hr>

									<div class="form-group row">
										<div class="col-md-6">
											<label class="col-form-label col-lg-5 float" for="voucherNo">Loan
												Application No. <span style="color: red"></span>:
											</label>
											<div class="col-lg-7 float">
												<input type="text" class="form-control" readonly="readonly"
													id="appNo" value="${appNo}" name="appNo" autocomplete="off">

											</div>
										</div>

										<div class="col-md-6">
											<label class="col-form-label col-lg-5 float" for="voucherNo">
												Today : </label> <label class="col-form-label col-lg-7 float"
												for="voucherNo"> ${todaysDate} </label>
										</div>
									</div>



									<div class="form-group row">
										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="advanceAmt">Loan Amount (Rs) <span
												style="color: red"> *</span>:
											</label>
											<div class="col-lg-7 float">
												<input type="text" class="form-control numbersOnly"
													placeholder="Enter Loan Amount" id="loanAmt" name="loanAmt"
													value="0" autocomplete="off" onchange="calAmt()"> <input
													type="hidden" class="form-control" id="roi" name="roi"
													value="0" autocomplete="off"> <span
													class="validation-invalid-label" id="error_loanAmt"
													style="display: none;">This field is required.</span>
											</div>
										</div>

										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="month">Loan Tenure In Month <span
												style="color: red"> *</span>:
											</label>
											<div class="col-lg-7 float">
												<input type="text" class="form-control" id="tenure"
													value="1" name="tenure" autocomplete="off"
													readonly="readonly"> <span
													class="validation-invalid-label" id="error_tenure"
													style="display: none;">This field is required.</span>
											</div>
										</div>
									</div>


									<!-- <div class="form-group row">
										<label class="col-form-label text-info font-weight-bold col-lg-2" for="month">Rate
											of Interest (%)<span style="color: red"> *</span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control" id="roi" name="roi"
												value="0" autocomplete="off" onchange="calAmt()"> <span
												class="validation-invalid-label" id="error_roi"
												style="display: none;">This field is required.</span>
										</div>
									</div> -->
									<div class="form-group row">
										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="month">Loan EMI <span style="color: red">
													*</span>:
											</label>
											<div class="col-lg-7 float">
												<input type="text" class="form-control" id="emi" name="emi"
													autocomplete="off" onchange="calAmt()" value="0"> <span
													class="validation-invalid-label" id="error_emi"
													style="display: none;">This field is required.</span>
											</div>
										</div>

										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="month">Total Repay Amount <span
												style="color: red"> *</span>:
											</label>
											<div class="col-lg-7 float">
												<input type="text" class="form-control" id="repayAmt"
													readonly="readonly" name="repayAmt" autocomplete="off"
													onchange="trim(this)" readonly="readonly"> <span
													class="validation-invalid-label" id="error_repayAmt"
													style="display: none;">This field is required.</span>
											</div>
										</div>
									</div>


									<div class="form-group row">
										<div class="col-md-6">


											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="startDate"> Start Date of Cutting <span
												style="color: red"> *</span>:
											</label>
											<div class="col-lg-7 float">
												<input type="text" class="form-control datepickerclass "
													onchange="calAmt()" name="startDate" id="startDate"
													placeholder="Joining Date"><span
													class="validation-invalid-label" id="error_startDate"
													style="display: none;">This field is required.</span><span
													class="validation-invalid-label" id="error_Range_freeze"
													style="display: none;">This field is required.</span>
											</div>
										</div>

										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="joiningDate"> End Date of Cutting<span
												style="color: red"> *</span>:
											</label>
											<div class="col-lg-7 float">
												<input type="text" class="form-control datepickerclass1 "
													name="endDate" id="endDate" placeholder="Joining Date"
													readonly="readonly"><span
													class="validation-invalid-label" id="error_endDate"
													style="display: none;">This field is required.</span>
											</div>
										</div>

									</div>


									<div class="form-group row">
										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="remark"> Remark <span style="color: red">
													*</span>:
											</label>
											<div class="col-lg-7 float">
												<textarea class="form-control"
													placeholder="Enter Reason / Remark" id="remark"
													name="remark" autocomplete="off" onchange="trim(this)"></textarea>
												<span class="validation-invalid-label" id="error_remark"
													style="display: none;">This field is required.</span>
											</div>
										</div>
									</div>


									<div class="form-group row mb-0">
										<div style="margin: 0 auto;">

											<button type="submit" class="btn blue_btn ml-3 legitRipple"
												id="submtbtn">
												Submit <i class="icon-paperplane ml-2"></i>
											</button>
											<a
												href="${pageContext.request.contextPath}/showEmpListToAddLoan"><button
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
	<div id="modal_scrollable" class="modal fade" data-backdrop="false"
		tabindex="-1">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header pb-3">

					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<div class="modal-body py-0">
					<h5 class="modal-title">Are you want to apply loan ?</h5>
					<br>

				</div>

				<div class="modal-footer pt-3">
					<button type="button" class="btn btn-link" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn bg-primary" onclick="submitForm()">Submit</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function calAmt() {
			var tenure = 0
			var loanAmt = 0;
			var emi = 0;
			var roi = 0;
			var empId = $('#empId').val();
			emi = document.getElementById("emi").value;
			loanAmt = document.getElementById("loanAmt").value;
			var startDate = document.getElementById("startDate").value;

			if (loanAmt > 0 && emi > 0) {
				tenure = parseFloat(loanAmt) / parseFloat(emi);
			}

			var fd = new FormData();

			fd.append('fromDate', startDate);
			fd.append('empId', empId);

			$
					.ajax({
						url : '${pageContext.request.contextPath}/validationForFreezeMonth',
						type : 'post',
						dataType : 'json',
						data : fd,
						contentType : false,
						processData : false,
						success : function(data) {

							if (data.error == true) {
								$("#error_Range_freeze").show();
								$("#error_Range_freeze").html(data.msg);
								document.getElementById("submtbtn").disabled = true;
							} else {
								$("#error_Range_freeze").hide();
								document.getElementById("submtbtn").disabled = false;

								$
										.getJSON(
												'${loanCalculation}',
												{
													roi : roi,
													tenure : tenure,
													loanAmt : loanAmt,
													startDate : startDate,
													ajax : 'true',
												},

												function(data1) {

													document
															.getElementById("repayAmt").value = data1.repayAmt;

													document
															.getElementById("tenure").value = tenure;

													document
															.getElementById("endDate").value = data1.calDate;

												});
							}

						},
					});

		}
	</script>


	<script>
		function trim(el) {
			el.value = el.value.replace(/(^\s*)|(\s*$)/gi, ""). // removes leading and trailing spaces
			replace(/[ ]{2,}/gi, " "). // replaces multiple spaces with one space 
			replace(/\n +/, "\n"); // Removes spaces after newlines
			checkSame();
			return;
		}

		$(document).ready(function($) {

			$("#submitInsertLocaion").submit(function(e) {

				var isError = false;
				var errMsg = "";
				$("#error_startDate").hide();
				$("#error_endDate").hide();
				
				if (!$("#emi").val()) {

					isError = true;

					$("#error_emi").show()
					//return false;
				} else {
					$("#error_emi").hide()
				}

				if (!$("#repayAmt").val()) {

					isError = true;

					$("#error_repayAmt").show()

				} else {
					$("#error_repayAmt").hide()
				}
				if (!$("#remark").val()) {

					isError = true;

					$("#error_remark").show()

				} else {
					$("#error_remark").hide()
				}
				if (!$("#tenure").val() || $("#tenure").val() <= 0) {

					isError = true;

					$("#error_tenure").show()

				} else {
					$("#error_tenure").hide()
				}

				if (!$("#roi").val()) {

					isError = true;

					$("#error_roi").show()

				} else {
					$("#error_roi").hide()
				}

				if (!$("#loanAmt").val() || $("#loanAmt").val() <= 0) {

					isError = true;

					$("#error_loanAmt").show()

				} else {
					$("#error_loanAmt").hide()
				}

				if (!$("#remark").val()) {

					isError = true;

					$("#error_remark").show()

				} else {
					$("#error_remark").hide()
				}

				if (!$("#endDate").val()) {

					isError = true;

					$("#error_endDate").show()

				}
				if (!$("#startDate").val()) {

					isError = true;
					$("#error_startDate").show()
				}

				if (!isError) {

					var x = true;
					if (x == true) {

						//document.getElementById("submtbtn").disabled = true;
						$('#modal_scrollable').modal('show');
						return false;
					}
					//end ajax send this to php page
				}
				return false;
			});
		});
		//
	</script>
	<script>
		function submitForm() {
			$('#modal_scrollable').modal('hide');
			document.getElementById("submtbtn").disabled = true;
			document.getElementById("submitInsertLocaion").submit();

		}
	</script>
	<script type="text/javascript">
		// Single picker
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
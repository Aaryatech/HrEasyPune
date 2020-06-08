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
										<td width="60%"><h5 class="pageTitle"><i class="icon-list-unordered"></i> Add Loan</h5></td>
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
									action="${pageContext.request.contextPath}/submitInsertLoanNew"
									id="submitInsertLocaion" method="post"  enctype="multipart/form-data">
									<input type="hidden" value="${empPersInfo.empId}" id="empId"
										name="empId">
										<input type="hidden" value="0" id="repayAmt1"
										name="repayAmt1">
										<input type="hidden" value="0" id="emi1"
										name="emi1">
										
										<input type="hidden" value="${empdetList[0].empId}" id="g11"
										name="g11">
										<input type="hidden" value="${empdetList[1].empId}" id="g22"
										name="g22">
										
									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="empName">Employee
											Name : </label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												value="${empPersInfoString}" id="empName"
												readonly="readonly" name="empName" autocomplete="off"
												onchange="trim(this)">

										</div>
											
										<label class="col-form-label col-lg-2" for="voucherNo1">
											Today : </label> <label class="col-form-label col-lg-4"
											for="voucherNo1"> ${todaysDate} </label>
									
									</div>
									<div class="form-group row">
									
										<label class="col-form-label col-lg-2" for="voucherNo">Loan
											Application No. <span style="color: red"></span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control" readonly="readonly"
												id="appNo" value="${appNo}" name="appNo" autocomplete="off">

										</div>
									
										<label class="col-form-label col-lg-2" for="grossSal">
											Gross Salary : </label>
										<div class="col-lg-4">
											<input type="text" class="form-control" id="grossSal"
												value="${empPersInfo.grossSalary}" readonly="readonly"
												name="grossSal" autocomplete="off" onchange="trim(this)">
										</div>
									</div>
									
									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="empName">Guarantor
											1 : </label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												value="${empdetList[0].empCode}-${empdetList[0].firstName} ${empdetList[0].surname}" id="g1"
												readonly="readonly" name="g1" autocomplete="off"
												onchange="trim(this)">
										</div>
										<label class="col-form-label col-lg-2" for="empName">Guarantor
											2 : </label>
										<div class="col-lg-4">
											<input type="text" class="form-control"
												value="${empdetList[1].empCode}-${empdetList[1].firstName} ${empdetList[1].surname}" id="g2"
												readonly="readonly" name="g2" autocomplete="off"
												onchange="trim(this)">
										</div>
										
										
										
										
									</div>

									<%-- <div class="form-group row">
										<label class="col-form-label col-lg-2 float" for="grossSal">
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
									</div> --%>

									<hr>

									<div class="form-group row">
										<label
											class="col-form-label text-info font-weight-bold col-lg-3"
											for="advanceAmt">Loan Amount (Rs) <span
											style="color: red"> *</span>:
										</label>
										<div class="col-lg-3">
											<input type="text" class="form-control numbersOnly"
												placeholder="Enter Loan Amount" id="loanAmt" name="loanAmt"
												value="0" autocomplete="off" onchange="calAmt()">  <span
												class="validation-invalid-label" id="error_loanAmt"
												style="display: none;">This field is required.</span>
										</div>
										<label
											class="col-form-label text-info font-weight-bold col-lg-2 float"
											for="month">Total Repay Amount <span
											style="color: red"> *</span>:
										</label>
										<div class="col-lg-4">
											<label class="form-control" id="repayAmt"
												 name="repayAmt" autocomplete="off"
												> </label> <span
												class="validation-invalid-label" id="error_repayAmt"
												style="display: none;">This field is required.</span>
										</div>
										
										</div>
										
										<div class="form-group row">
										
										<label
											class="col-form-label text-info font-weight-bold col-lg-3"
											for="advanceAmt">Interest Rate (%) <span
											style="color: red"> *</span>:
										</label>
										<div class="col-lg-3">
											<input type="text" class="form-control" id="roi" name="roi"
												value="0" autocomplete="off" onchange="calAmt()"> <span
												class="validation-invalid-label" id="error_roi"
												style="display: none;">This field is required.</span>
										</div>
										<label
											class="col-form-label text-info font-weight-bold col-lg-2"
											for="month">Loan EMI <span style="color: red">
												*</span>:
										</label>
										<div class="col-lg-4">
											<label class="form-control" id="emi" name="emi"
												autocomplete="off"  value="0"> </label> <span
												class="validation-invalid-label" id="error_emi"
												style="display: none;">This field is required.</span>
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
									<label
											class="col-form-label text-info font-weight-bold col-lg-3"
											for="month">Loan Tenure In Month <span
											style="color: red"> *</span>:
										</label>
										<div class="col-lg-3">
											<input type="text"  onchange="calAmt()" class="form-control" id="tenure"
												name="tenure" autocomplete="off" >
											<span class="validation-invalid-label" id="error_tenure"
												style="display: none;">This field is required.</span>
										</div>
										
										
										<label
											class="col-form-label text-info font-weight-bold col-lg-2"
											for="joiningDate"> End Date of Cutting<span
											style="color: red"> *</span>:
										</label>
										<div class="col-lg-4">
											<input type="text" class="form-control datepickerclass1 "
												name="endDate" id="endDate" placeholder="Cutting End Date"
												readonly="readonly">
										</div>
										</div>
										<div class="form-group row">
										<label
											class="col-form-label text-info font-weight-bold col-lg-3 float"
											for="startDate">Cutting Start Date<span
											style="color: red"> *</span>:
										</label>
										<div class="col-lg-3">
											<input type="text" class="form-control datepickerclass "
												onchange="calAmt()" name="startDate" id="startDate"
												placeholder="Joining Date">
										</div>
										
										<div class="col-md-6">
										
										</div>
									</div>


									<div class="form-group row">
										<label
											class="col-form-label text-info font-weight-bold col-lg-3 float"
											for="remark"> Remark <span style="color: red">
												*</span>:
										</label>
										<div class="col-lg-3 float">
											<textarea class="form-control"
												placeholder="Enter Reason / Remark" id="remark"
												name="remark" autocomplete="off" onchange="trim(this)"></textarea>
											<span class="validation-invalid-label" id="error_remark"
												style="display: none;">This field is required.</span>
										</div>
										
										<label
											class="col-form-label text-info font-weight-bold col-lg-3 float"
											for="remark">Attach Agreement Document
										</label>
										<div class="col-lg-3 float">
											<input type="file" id="ag_doc" name="doc" value="0">
										</div>
										
									</div>


									<div class="form-group row mb-0">
										<div  style="margin: 0 auto;">

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

	<script type="text/javascript">
		function calAmt() {
			document.getElementById("repayAmt1").value=0;
			document.getElementById("emi1").value=0;

			var tenure = 0
			var loanAmt = 0;
			var emi = 0;
			var roi = 0;

			//emi = document.getElementById("emi").value;
			loanAmt = document.getElementById("loanAmt").value;
			var startDate = document.getElementById("startDate").value;
			
			tenure=document.getElementById("tenure").value;
			roi=document.getElementById("roi").value;
			//alert(roi);
			/* if (loanAmt > 0 && emi > 0) {
				tenure = parseFloat(loanAmt) / parseFloat(emi);
			} */

			$.getJSON('${loanCalculation}', {
				roi : roi,
				tenure : tenure,
				loanAmt : loanAmt,
				startDate : startDate,
				ajax : 'true',
			},

			function(data) {
				
				document.getElementById("repayAmt").innerHTML= data.repayAmt;
				document.getElementById("repayAmt1").value= data.repayAmt;
				document.getElementById("emi1").value=data.emiAmt;

				//document.getElementById("tenure").innerHTML = tenure;

				document.getElementById("endDate").value = data.calDate;
				document.getElementById("emi").innerHTML=data.emiAmt;

			});

		}
		$('#tenure').on('input', function() {
			 this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');
			});
		$('#loanAmt').on('input', function() {
			 this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');
			});
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

			/* 	if (!$("#emi").val()) {

					isError = true;

					$("#error_emi").show()
					//return false;
				} else {
					$("#error_emi").hide()
				} */

				/* if (!$("#repayAmt").val()) {

					isError = true;

					$("#error_repayAmt").show()

				} else {
					$("#error_repayAmt").hide()
				} */
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

				if (!isError) {

					var x = true;
					if (x == true) {

						document.getElementById("submtbtn").disabled = true;
						return true;
					}
					//end ajax send this to php page
				}
				return false;
			});
		});
		//
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
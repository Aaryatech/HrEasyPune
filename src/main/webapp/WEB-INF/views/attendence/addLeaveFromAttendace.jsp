<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"
	import="java.text.SimpleDateFormat"%>


<c:url var="addStrDetail" value="/addStrDetail" />


<c:url var="chkNumber" value="/chkNumber" />

<c:url var="getLeaveStructureForEdit" value="/getLeaveStructureForEdit" />
<c:url var="getHolidayAndWeeklyOffList"
	value="/getHolidayAndWeeklyOffList" />
<c:url var="calholidayWebservice" value="/calholidayWebservice" />
<c:url var="checkDatesRange" value="/checkDatesRange" />






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
					<h5 class="card-title">Apply Leave</h5>
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

					<span class="validation-invalid-label" id="error_assign"
						style="display: none;">You Can Not Apply for Leave as
						either Leave Authority or Leave Structure is not Assigned !!</span>


					<div class="form-group row">
						<label class="col-form-label col-lg-2" for="lvsName">
							Employee Code : </label>
						<div class="col-lg-10">
							<input type="text" class="form-control"
								placeholder="Enter Leave Structure Name" id="empCode"
								value="${editEmp.empCode}" name="lvsName" autocomplete="off"
								onchange="trim(this)" readonly>

						</div>
					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-2" for="lvsName">
							Employee Name : </label>
						<div class="col-lg-10">
							<input type="text" class="form-control"
								placeholder="Enter Leave Structure Name" id="empName"
								value="${editEmp.firstName} ${editEmp.middleName} ${editEmp.surname}   "
								name="lvsName" autocomplete="off" onchange="trim(this)" readonly>

						</div>
					</div>
					<hr>
					<div class="table-responsive">
						<table
							class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
							id="printtable1">


							<thead>
								<tr class="bg-blue" style="text-align: center;">

									<th>Leave Type</th>
									<th>Opening Leave</th>
									<th>Earned</th>
									<th>Approved</th>
									<th>Applied</th>
									<th>Balanced</th>


								</tr>
							</thead>
							<tbody>
								<c:forEach items="${leaveHistoryList}" var="leaveHistoryList">


									<c:choose>
										<c:when test="${leaveHistoryList.lvTypeId==1}">
											<c:if test="${mstEmpType.whWork eq 'Compoff'}">
												<tr>
													<td>${leaveHistoryList.lvTitle}</td>
													<td style="text-align: right;">${leaveHistoryList.balLeave}</td>
													<td style="text-align: right;">${leaveHistoryList.lvsAllotedLeaves}</td>
													<td style="text-align: right;">${leaveHistoryList.sactionLeave}</td>
													<td style="text-align: right;">${leaveHistoryList.aplliedLeaeve}</td>
													<td style="text-align: right;">${leaveHistoryList.balLeave+leaveHistoryList.lvsAllotedLeaves-leaveHistoryList.sactionLeave-leaveHistoryList.aplliedLeaeve}</td>

												</tr>
											</c:if>

										</c:when>
										<c:otherwise>
											<tr>
												<td>${leaveHistoryList.lvTitle}</td>
												<td style="text-align: right;">${leaveHistoryList.balLeave}</td>
												<td style="text-align: right;">${leaveHistoryList.lvsAllotedLeaves}</td>
												<td style="text-align: right;">${leaveHistoryList.sactionLeave}</td>
												<td style="text-align: right;">${leaveHistoryList.aplliedLeaeve}</td>
												<td style="text-align: right;">${leaveHistoryList.balLeave+leaveHistoryList.lvsAllotedLeaves-leaveHistoryList.sactionLeave-leaveHistoryList.aplliedLeaeve}</td>

											</tr>
										</c:otherwise>

									</c:choose>

								</c:forEach>




							</tbody>
						</table>
					</div>
					<br>
					<form
						action="${pageContext.request.contextPath}/insertLeaveFromEditAttendance"
						id="submitInsertLeave" method="post" enctype="multipart/form-data">



						<div class="form-group row">
							<label class="col-form-label text-info font-weight-bold col-lg-2"
								for="leaveTypeId">Select Leave Type <span
								style="color: red">* </span>:
							</label>
							
							<div class="col-lg-4">
								<select name="leaveTypeId" data-placeholder="Select Leave Type"
									id="leaveTypeId" class="form-control"
									onchange="checkUnique();checkDatesRange()">

									<c:forEach items="${leaveHistoryList}" var="leaveHistoryList">

										<c:choose>
											<c:when test="${leaveHistoryList.lvTypeId==1}">
												<%-- <c:if test="${mstEmpType.whWork eq 'Compoff'}">
													<option value="${leaveHistoryList.lvTypeId}"
														data-leavestrname="${leaveHistoryList.lvTitle}">${leaveHistoryList.lvTitle}</option>
												</c:if> --%>
											</c:when>
											<c:otherwise>
												<option value="${leaveHistoryList.lvTypeId}"
													data-leavestrname="${leaveHistoryList.lvTitle}">${leaveHistoryList.lvTitle}</option>
											</c:otherwise>
										</c:choose>
										<%-- <%-- <option value="${leaveHistoryList.lvTypeId}"
														data-leavestrname="${leaveHistoryList.lvTitle}">${leaveHistoryList.lvTitle}</option> --%> --%>


												</c:forEach>
								</select> <span class="validation-invalid-label" id="error_leaveTypeId"
									style="display: none;">This field is required.</span>
							</div>

							<!-- <input type="hidden" class="numbersOnly" id="dayTypeName"
								name="dayTypeName" autocomplete="off" value="1"> -->


						</div>
						<div class="form-group row">
							<label class="col-form-label  col-lg-2">Date : </label>
							<div class="col-lg-10">
								<input type="text" class="form-control" name="leaveDateRange"
									data-placeholder="Select Date" id="leaveDateRange" readonly
									value="${attDate} to ${attDate}"> <span
									class="validation-invalid-label" id="error_Range"
									style="display: none;">This field is required.</span> <span
									class="validation-invalid-label" id="error_insuf"
									style="display: none;">Insufficient Leaves.</span> <span
									id="error_compoffinformation"
									style="display: none; color: red;">Insufficient Leaves.</span>

							</div>
						</div>
						<div class="form-group row">
							<c:choose>
								<c:when test="${HALF_DAY_LEAVE_SHOW.value==1}">
									<label class="col-form-label  col-lg-2" for="dayTypeName">Select<span
										style="color: red">* </span> :
									</label>
									<div class="col-lg-4">
										<select data-placeholder="Select a Day Type" id="dayTypeName"
											name="dayTypeName" class="form-control"
											onchange="calholidayWebservice()">
											<option selected value="1">Full Day</option>
											<option value="2">1st Half</option>
											<option value="3">2nd Half</option>


										</select><span class="validation-invalid-label" id="error_dayType"
											style="display: none;">This field is required.</span>
									</div>
								</c:when>
								<c:otherwise>
									<input type="hidden" class="numbersOnly" id="dayTypeName"
										name="dayTypeName" autocomplete="off" value="1">
								</c:otherwise>
							</c:choose>
							<label class="col-form-label  col-lg-2" for="dayTypeName">No.
								of Days : </label>
							<div class="col-lg-4">
								<input type="text" class="form-control numbersOnly"
									placeholder="No. of Days " id="noOfDays" name="noOfDays"
									autocomplete="off" readonly value="1">
							</div>
						</div>


						<!-- <input type="hidden" class=" numbersOnly" id="noOfDays"
							name="noOfDays" autocomplete="off" value="1"> -->
						<input type="hidden" class=" numbersOnly" id="noOfDaysExclude"
							name="noOfDaysExclude" autocomplete="off" value="0">


						<div id="fileDive" style="display: none;">
							<div class="form-group row">
								<label
									class="col-form-label text-info font-weight-bold col-lg-2"
									for="documentFile"> Fitness Certificate </label>
								<div class="col-lg-5">

									<input type="file" class="form-control" id="documentFile"
										name="documentFile" accept=".jpg,.png,.gif,.doc,.xls,.pdf">
									<span class="form-text text-muted">Only .jpg,.png,.gif</span> <span
										class="validation-invalid-label" id="error_documentFile"
										style="display: none;">This field is required.</span>
								</div>

							</div>
						</div>

						<div class="form-group row">
							<label class="col-form-label  col-lg-2" for="lvngReson">Remark
								: </label>
							<div class="col-lg-10">
								<textarea rows="3" cols="3" class="form-control"
									placeholder="Remark" onchange="trim(this)" id="leaveRemark"
									name="leaveRemark"> </textarea>
								<span class="validation-invalid-label" id="error_leaveRemark"
									style="display: none;">This field is required.</span><span
									class="validation-invalid-label"
									id="error_leaveRepeatValidation" style="display: none;">You
									Have Already Apply Leave on this Date.</span>
							</div>
						</div>
						<input type="hidden" class="form-control numbersOnly" id="empId"
							value="${empId}" name="empId"> <input type="hidden"
							class="form-control numbersOnly" id="tempNoDays"
							name="tempNoDays"> <input type="hidden"
							class="form-control numbersOnly" id="lvsId" value="${lvsId}"
							name="lvsId"> <input type="hidden"
							class="form-control numbersOnly" id="auth" value="${authId}"
							name="auth"> <input type="hidden" id="leaveLimit"
							value="${setlimit.value}"> <input type="hidden"
							id="yearFinalDate" value="${currYr.calYrToDate}"> <input
							type="hidden" class="form-control" id="leaveCanApply" value="0"
							name="leaveCanApply"> <input type="hidden"
							class="form-control numbersOnly" id="fileRequired"
							name="fileRequired" value="0"> <input type="hidden"
							class="form-control" id="compoffleavecount" value="0"
							name="compoffleavecount"> <input type="hidden"
							class="form-control numbersOnly" id="month" value="${month}"
							name="month"><input type="hidden"
							class="form-control numbersOnly" id="year" value="${year}"
							name="year"><input type="hidden"
							class="form-control numbersOnly" id="flag" value="${flag}"
							name="flag">
						<div class="col-md-12" style="text-align: center;">

							<c:choose>
								<c:when
									test="${lvsId==0 || authorityInformation.leaveInitialAuth=='0'}">

								</c:when>
								<c:otherwise>
									<button type="submit" class="btn bg-blue ml-3 legitRipple"
										id="submtbtn">
										Submit <i class="icon-paperplane ml-2"></i>
									</button>
								</c:otherwise>
							</c:choose>



						</div>
					</form>
				</div>
			</div>


		</div>
	</div>

</div>
<!-- /content area -->



<!-- /page content -->



<script type="text/javascript">
	function checkUnique() {
		var inputValue = document.getElementById("leaveTypeId").value;

		var lvsId = document.getElementById("lvsId").value;
		//alert(lvsId);
		var valid = false;
		/* 
		 if (inputValue != null) {
		 valid == true;
		 }
		 if (valid == true) */
		$.getJSON('${chkNumber}', {

			inputValue : inputValue,
			lvsId : lvsId,
			ajax : 'true',

		}, function(data) {
			//alert(data.balLeave);

			var res = data.msg.split(",");
			document.getElementById("tempNoDays").value = parseFloat(res[0]);

			if (res[1] == 1) {
				document.getElementById("fileRequired").value = 1;
				$("#fileDive").show();
			} else {
				document.getElementById("fileRequired").value = 0;
				$("#fileDive").hide();
			}

		});
	}
	function checkDatesRange() {
		var daterange = document.getElementById("leaveDateRange").value;
		var empId = document.getElementById("empId").value;
		var res = daterange.split(" to ");
		var inputValue = document.getElementById("leaveTypeId").value;
		var noOfDays = document.getElementById("noOfDays").value;
		document.getElementById("submtbtn").disabled = true;
		$("#error_compoffinformation").hide();

		$
				.getJSON(
						'${checkDatesRange}',
						{

							fromDate : res[0],
							toDate : res[1],
							empId : empId,
							typeId : inputValue,
							noOfDays : noOfDays,
							ajax : 'true',

						},
						function(data) {
							//alert(data.balLeave);

							if (data.error == true) {
								document.getElementById("leaveCanApply").value = 1;
							} else {
								document.getElementById("leaveCanApply").value = 0;
								$("#error_leaveRepeatValidation").hide();
							}

							document
									.getElementById("error_leaveRepeatValidation").innerHTML = data.msg;
							if (inputValue == 1) {
								document
										.getElementById("error_compoffinformation").innerHTML = "Your compoff pending "
										+ data.dailyrecordlistforcompoff.length;
								document.getElementById("tempNoDays").value = parseFloat(data.dailyrecordlistforcompoff.length);
								$("#error_compoffinformation").show();
							}

							document.getElementById("submtbtn").disabled = false;
						});
	}
</script>

<script type="text/javascript">
	function checkDays(x2) {
		//alert(x2);
		var x1 = parseFloat(document.getElementById("tempNoDays").value);
		//var x2=	document.getElementById("noOfDaysExclude").value;
		//alert("x1 is " + x1);
		//alert("x2 is " + x2);

		if (parseInt(x2, 10) > parseInt(x1, 10)) {
			/* alert("Insufficient Leaves");
			document.getElementById("noOfDaysExclude").value = "";
			document.getElementById("noOfDays").value = ""; */
			return true;
		} else {
			return false;
		}

	}
</script>
<script type="text/javascript">
	function chkAssign() {

		var auth = document.getElementById("auth").value;
		var lvsId = document.getElementById("lvsId").value;

		if (auth == 0 || lvsId == 0) {

			$("#error_assign").show();
			document.getElementById("submtbtn").disabled = true;

		} else {

			$("#error_assign").hide();
			document.getElementById("submtbtn").disabled = false;
		}
	}
</script>
<script type="text/javascript">
	function formatDate(date) {
		var d = new Date(date), month = '' + (d.getMonth() + 1), day = ''
				+ d.getDate(), year = d.getFullYear();

		if (month.length < 2)
			month = '0' + month;
		if (day.length < 2)
			day = '0' + day;

		return [ year, month, day ].join('-');
	}
	function difffun(date1, date2) {

		const diffTime = Math.abs(date2.getTime() - date1.getTime());
		const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
		//document.getElementById("noOfDays").value = diffDays + 1;

		//document.getElementById("noOfDaysExclude").value = diffDays + 1;

		return (diffDays + 1);
	}

	function evenodd(date1, date2, holfrstdt, holseconddt, day) {

		//alert("date1 " + date1 + "date2 " + date2 + "holfrstdt " + holfrstdt + "holseconddt " + holseconddt + "day" +day)

		var totalcount = 0;
		var tempcomndate = [];

		for (var m = holfrstdt; m <= holseconddt;) {

			if (m >= date1 && m <= date2) {

				for (var j = m; j <= date2;) {

					if (j.getDay() == day && m >= holfrstdt && m <= holseconddt) {

						//alert(j+"matched 1st");

						formatDate(m);
						tempcomndate.push(formatDate(m));
						totalcount++;
					}
					j.setTime(j.getTime() + 1000 * 60 * 60 * 24);

				}

			}
			m.setTime(m.getTime() + 1000 * 60 * 60 * 24);
		}
		tempcomndate.push(totalcount);
		return tempcomndate;
	}
</script>

<script type="text/javascript">
	function calculateDiff() {

		var daterange = document.getElementById("leaveDateRange").value;
		var res = daterange.split(" to ");

		var date1res = res[0].split("-");
		var date2res = res[1].split("-");

		var date1 = new Date(date1res[2], date1res[1] - 1, date1res[0])//converts string to date object

		var date2 = new Date(date2res[2], date2res[1] - 1, date2res[0])

		const diffTime = Math.abs(date2.getTime() - date1.getTime());
		const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
		document.getElementById("noOfDays").value = diffDays + 1;

		//document.getElementById("noOfDaysExclude").value = diffDays + 1;

		return (diffDays + 1);
	}
</script>
<script type="text/javascript">
	// Single picker
	/* $('.datepickerclass').daterangepicker({
		singleDatePicker : true,
		selectMonths : true,
		selectYears : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	}); */

	/* var today = new Date();
	var last = new Date(today.getTime() - (7 * 24 * 60 * 60 * 1000));

	var daterange = document.getElementById("yearFinalDate").value;

	var date1res = daterange.split("-");
	var lastdate = new Date(date1res[0], date1res[1] - 1, date1res[2]);

	//alert(lastdate);
	$('.daterange-basic_new').daterangepicker({
		applyClass : 'bg-slate-600',
		minDate : last,
		maxDate : lastdate,
		cancelClass : 'btn-light',
		locale : {
			format : 'DD-MM-YYYY',
			separator : ' to '
		}
	}); */

	$('.daterange-basic_new').daterangepicker({
		applyClass : 'bg-slate-600',
		cancelClass : 'btn-light',
		locale : {
			format : 'DD-MM-YYYY',
			separator : ' to '
		}
	});
</script>

<script>
	function calholidayWebservice() {

		var dayTypeName = document.getElementById("dayTypeName").value;
		if (dayTypeName == "" || dayTypeName == 1) {
			document.getElementById("noOfDays").value = 1;
		} else {
			document.getElementById("noOfDays").value = 1 / 2;
		}

		/*var daterange = document.getElementById("leaveDateRange").value;
		var dayTypeName = document.getElementById("dayTypeName").value;
		var res = daterange.split(" to ");
		var empId = document.getElementById("empId").value;
		document.getElementById("submtbtn").disabled = true;
		$
			.getJSON(
					'${calholidayWebservice}',
					{

						fromDate : res[0],
						toDate : res[1],
						empId : empId,
						ajax : 'true',

					},
					function(data) {

						document.getElementById("noOfDaysExclude").value = data.holidaycount;

						if (dayTypeName == "" || dayTypeName == 1) {
							document.getElementById("noOfDays").value = data.leavecount;
						} else {
							document.getElementById("noOfDays").value = data.leavecount / 2;
						}

						//checkDays(data.leavecount);
						checkDatesRange();
					});*/

	}

	function trim(el) {
		el.value = el.value.replace(/(^\s*)|(\s*$)/gi, ""). // removes leading and trailing spaces
		replace(/[ ]{2,}/gi, " "). // replaces multiple spaces with one space 
		replace(/\n +/, "\n"); // Removes spaces after newlines
		return;
	}

	$(document)
			.ready(
					function($) {

						$("#submitInsertLeave")
								.submit(
										function(e) {
											var isError = false;
											var errMsg = "";

											if (!$("#leaveTypeId").val()) {

												isError = true;

												$("#error_leaveTypeId").show()
												//return false;
											} else {
												$("#error_leaveTypeId").hide()
											}

											if (!$("#leaveDateRange").val()) {

												isError = true;

												$("#error_Range").show()

											} else {
												$("#error_Range").hide()
											}

											if (!$("#noOfDays").val()
													|| parseFloat($("#noOfDays")
															.val()) == 0) {

												isError = true;

												$("#error_noOfDays").show()

											} else {
												$("#error_noOfDays").hide()
											}

											if ($("#leaveLimit").val() == 1
													&& $("#leaveTypeId").val() != 2) {
												//alert("Hii..");
												if (checkDays(parseFloat($(
														"#noOfDays").val())) == true) {

													isError = true;

													$("#error_insuf").show()

												} else {
													$("#error_insuf").hide()
												}
											} else {

												$("#error_insuf").hide()

											}

											if ($("#leaveRemark").val() == "") {

												isError = true;

												$("#error_leaveRemark").show()
												//return false;
											} else {
												$("#error_leaveRemark").hide()
											}

											if ($("#leaveCanApply").val() == 1) {

												isError = true;
												$(
														"#error_leaveRepeatValidation")
														.show();
											} else {
												$(
														"#error_leaveRepeatValidation")
														.hide();
											}

											if (!$("#documentFile").val()
													&& $("#fileRequired").val() == 1) {

												isError = true;

												$("#error_documentFile").show()
												//return false;
											} else {
												$("#error_documentFile").hide()
											}

											if (!isError) {
												var option = $(
														"#leaveTypeId option:selected")
														.attr(
																"data-leavestrname");

												$('#lvType').html(option);
												$('#noOfDays1')
														.html(
																document
																		.getElementById("noOfDays").value);
												$('#empCode1')
														.html(
																document
																		.getElementById("empCode").value);
												$('#empName1')
														.html(
																document
																		.getElementById("empName").value);
												var daterange = document
														.getElementById("leaveDateRange").value;

												var res = daterange
														.split(" to ");

												$('#fromdate1').html(res[0]);
												$('#todate1').html(res[1]);

												$('#modal_scrollable').modal(
														'show');
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
		document.getElementById("submitInsertLeave").submit();

	}
</script>
<!-- Scrollable modal -->
<div id="modal_scrollable" class="modal fade" data-backdrop="false"
	tabindex="-1">
	<div class="modal-dialog modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header pb-3">

				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<div class="modal-body py-0">
				<h5 class="modal-title">Leave Details</h5>
				<br>

				<div class="form-group row">
					<label class="col-form-label col-lg-3" for="lvType">
						Employee Code : </label> <label class="col-form-label col-lg-2"
						id="empCode1" for="empCode1"> </label>

				</div>
				<div class="form-group row">
					<label class="col-form-label col-lg-3" for="lvType">
						Employee Name : </label> <label class="col-form-label col-lg-6"
						id="empName1" for="empName1"> </label>

				</div>
				<div class="form-group row">
					<label class="col-form-label col-lg-3" for="lvType"> Leave
						Type : </label> <label class="col-form-label col-lg-6" id="lvType"
						for="lvType"> </label>

				</div>


				<div class="form-group row">
					<label class="col-form-label col-lg-3" for="fromdate1">
						From Date : </label> <label class="col-form-label col-lg-3" id="fromdate1"
						for="noOfDays1"> </label> <label class="col-form-label col-lg-3"
						for="todate1"> To Date : </label> <label
						class="col-form-label col-lg-2" id="todate1" for="noOfDays1">
					</label>

				</div>
				<div class="form-group row">
					<label class="col-form-label col-lg-3" for="noOfDays"> No.
						of Days : </label> <label class="col-form-label col-lg-3" id="noOfDays1"
						for="noOfDays1"> </label>

				</div>
			</div>

			<div class="modal-footer pt-3">
				<button type="button" class="btn btn-link" data-dismiss="modal">Cancel</button>
				<button type="button" class="btn bg-primary" onclick="submitForm()">Submit</button>
			</div>
		</div>
	</div>
</div>
<!-- /scrollable modal -->


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>


<c:url var="addClaimDetailProcess" value="/addClaimDetailProcess" />

<c:url var="getClaimForEdit" value="/getClaimForEdit" />

<c:url var="getLeaveStructureForEdit" value="/getLeaveStructureForEdit" />
<c:url var="addStrDetail" value="/addStrDetail" />
<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>

<body onload="chkAssign()">
	<c:url value="/getClaimTypeById" var="getClaimTypeById"></c:url>

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

				<%-- 
				<div
					class="breadcrumb-line breadcrumb-line-light header-elements-md-inline">
					<div class="d-flex">
						<div class="breadcrumb">
							<a href="index.html" class="breadcrumb-item"><i
								class="icon-home2 mr-2"></i> Home</a> <span
								class="breadcrumb-item active">Dashboard</span>
						</div>

						<a href="#" class="header-elements-toggle text-default d-md-none"><i
							class="icon-more"></i></a>
					</div>

					<div class="breadcrumb justify-content-center">
						<a href="${pageContext.request.contextPath}/showApplyForClaim"
							class="breadcrumb-elements-item"> Employee List</a>

					</div>


				</div> --%>
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
										<td width="60%"><h5 class="pageTitle">
												<i class="icon-list-unordered"></i> Add Claim
											</h5></td>
										<td width="40%" align="right">
											<%--  <a
									href="${pageContext.request.contextPath}/showApplyForClaim"
									class="breadcrumb-elements-item">
										<button type="button" class="btn btn-primary"> Employee List </button>
								</a> --%>
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
								<span class="validation-invalid-label" id="error_assign"
									style="display: none;">Sorry You Can Not Apply for Claim
									as Claim Authorities Are not Assigned !!</span>


								<div class="form-group row">

									<div class="col-md-6">
										<label class="col-form-label col-lg-5 float" for="lvsName">
											Employee Code : </label>
										<div class="col-lg-7 float">
											<input type="text" class="form-control"
												placeholder="Enter Leave Structure Name" id="empCode"
												value="${editEmp.empCode}" name="lvsName" autocomplete="off"
												onchange="trim(this)" readonly>

										</div>
									</div>

									<div class="col-md-6">
										<label class="col-form-label col-lg-5 float" for="lvsName">
											Employee Name : </label>
										<div class="col-lg-7 float">
											<input type="text" class="form-control"
												placeholder="Enter Leave Structure Name" id="empName"
												value="${editEmp.firstName} ${editEmp.middleName} ${editEmp.surname}   "
												name="lvsName" autocomplete="off" onchange="trim(this)"
												readonly>

										</div>
									</div>


								</div>





								<%-- <form action="${pageContext.request.contextPath}/showClaimProof"
									id="submitInsertLeave" method="post"> --%>
								<form
									action="${pageContext.request.contextPath}/uploadClaimProof"
									id="submitInsertLeave" method="post">

									<%-- 
									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="projectTypeId">Select
											Project <span style="color: red">* </span>:
										</label>
										<div class="col-lg-4">
											<select name="projectTypeId"
												data-placeholder="Select Project" id="projectTypeId"
												class="form-control form-control-select2 select2-hidden-accessible"
												data-fouc="" aria-hidden="true">
												<option></option>
												<c:forEach items="${projectTypeList}" var="proTypeList">
													<option value="${proTypeList.projectId}"
														data-prostrname="${proTypeList.projectTitle}">${proTypeList.projectTitle}</option>
												</c:forEach>
											</select> <span class="validation-invalid-label"
												id="error_projectTypeId" style="display: none;">This
												field is required.</span>
										</div>

									</div> --%>

									<div class="form-group row">
										<div class="col-md-6">
											<label class="col-form-label col-lg-5 float" for="lvsName">
												Claim Title <span style="color: red">* </span>:
											</label>
											<div class="col-lg-7 float">
												<input type="text" class="form-control"
													placeholder="Claim Title" id="claim_title"
													name="claim_title" autocomplete="off" onchange="trim(this)">
												<span class="validation-invalid-label"
													id="error_claim_title" style="display: none;">This
													field is required.</span>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-form-label col-lg-5 float">Date <span
												style="color: red">* </span>:
											</label>
											<div class="col-lg-7 float">
												<input type="text" class="form-control datepickerclass "
													name="claimDate" data-placeholder="Select Date"
													id="claimDate" onchange="freezeMonthValidation()">
												<span class="validation-invalid-label" id="error_Range"
													style="display: none;">This field is required.</span><span
													class="validation-invalid-label" id="error_Range_freeze"
													style="display: none;">This field is required.</span>

											</div>
										</div>


									</div>



									<hr>
									<div class="form-group row">

										<div class="col-md-6">
											<label class="col-form-label col-lg-5 float"
												for="claimTypeId">Select Claim Type <span
												style="color: red">* </span>:
											</label>
											<div class="col-lg-7 float">
												<select name="claimTypeId"
													data-placeholder="Select Claim Type" id="claimTypeId"
													class="form-control form-control-select2 select2-hidden-accessible"
													data-fouc="" aria-hidden="true" onchange="setAmt()">
													<option></option>
													<c:forEach items="${claimTypeList}" var="claimTypeList">

														<option value="${claimTypeList.clmTypeId}"
															data-clstrname="${claimTypeList.claimTypeTitle}">${claimTypeList.claimTypeTitle}</option>

													</c:forEach>
												</select> <span class="validation-invalid-label"
													id="error_claimTypeId" style="display: none;">This
													field is required.</span>
											</div>
										</div>
										<div class="col-md-6">
											<label class="col-form-label col-lg-5 float" for="claimAmt">
												Claim Amount <span style="color: red">* </span>:
											</label>
											<div class="col-lg-7 float">
												<input type="text" class="form-control numbersOnly"
													placeholder="Amount of Claim in Rs. " id="claimAmt"
													name="claimAmt" autocomplete="off"> <span
													class="validation-invalid-label" id="error_claim_amt"
													style="display: none;">This field is required.</span>
											</div>
										</div>


									</div>


									<div class="form-group row">

										<div class="col-md-6">
											<label class="col-form-label col-lg-5 float" for="lvngReson">Remark
												<span style="color: red">* </span>:
											</label>
											<div class="col-lg-7 float">
												<textarea rows="3" cols="3" class="form-control"
													placeholder="Remark" onchange="trim(this)" id="claimRemark"
													name="claimRemark"> </textarea>
												<span class="validation-invalid-label"
													id="error_claimRemark" style="display: none;">This
													field is required.</span>
											</div>
										</div>

									</div>

									<div class="form-group row">


										<div class="col-md-6">
											<label class="col-form-label col-lg-5 float" for="doc">Attach
												File:</label>
											<div class="col-lg-7 float">
												<input type="file" class="form-control"
													placeholder="Enter Location Name" id="doc" name="doc"
													autocomplete="off"
													accept=".gif,.jpg,.jpeg,.png,.doc,.docx,.pdf"
													multiple="multiple"> <span
													class="form-text text-muted">Accepted formats:
													.gif,.jpg,.jpeg,.png,.doc,.docx,.pdf </span>
											</div>
										</div>
									</div>


									<div class="form-group row"></div>
									<input type="hidden" id="isDelete" name="isDelete" value="0">
									<input type="hidden" name="isEdit" id="isEdit" value="0">
									<input type="hidden" name="index" id="index" value="0">
									<input type="hidden" name="tempAmt" id="tempAmt" value="0">
									<input type="hidden" name="tempAmtX" id="tempAmtX" value="0">
									<input type="hidden" name="imageShowUrl" id="imageShowUrl"
										value="${imageShowUrl}">
									<div class="form-group row mb-0">
										<div
											style="display: inline-block; width: 100%; text-align: center;">
											<input type="button" value="Add" class="btn blue_btn"
												style="align-content: center; width: 113px;" onclick="add()" />

										</div>
									</div>
									<br />

									<table
										class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
										id="printtable1">
										<thead>
											<tr class="bg-blue">
												<th width="10%">Sr.no</th>
												<th>Claim Type</th>
												<th>Amount</th>
												<th>Remark</th>
												<th>Files</th>
												<th class="text-center" width="10%">Actions</th>
											</tr>
										</thead>
										<tbody>
									</table>

									<br />


									<!-- 		Final Submit		 -->

									<input type="hidden" class="form-control numbersOnly"
										id="dataLen" value="0" name="dataLen"> <input
										type="hidden" class="form-control numbersOnly"
										value="${editEmp.empId}" id="empId" name="empId"
										autocomplete="off" readonly> <input type="hidden"
										class="form-control numbersOnly" id="auth"
										value="${authorityInformation.claimInitialAuth}" name="auth">

									<span class="validation-invalid-label" id="error_tbl"
										style="display: none;">Please Fill Claim Details
										Properly. </span>


									<div class="form-group row mb-0">
										<div
											style="display: inline-block; width: 100%; text-align: center;">
											<!--  class="col-lg-10 ml-lg-auto" -->

											<button type="submit" class="btn blue_btn ml-3 legitRipple"
												id="submtbtn">
												Submit <i class="icon-paperplane ml-2"></i>
											</button>

											<a
												href="${pageContext.request.contextPath}/showApplyForClaim"><button
													type="button" class="btn btn-light">
													<i class="${sessionScope.cancelIcon}" aria-hidden="true"></i>
													Cancel
												</button></a>
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

	<script type="text/javascript">
		function setAmt() {

			var claimTypeId = document.getElementById("claimTypeId").value;

			var empId = document.getElementById("empId").value;
			//alert("hii"+claimTypeId+empId);

			$.getJSON('${getClaimTypeById}', {
				claimTypeId : claimTypeId,
				empId : empId,
				ajax : 'true',
			},

			function(data) {

				document.getElementById("tempAmtX").value = data.clmAmt;

			});

		}
	</script>
	http://localhost:8088/hradmin/showClaimApply?empId=MQ==




	<script type="text/javascript">
		function add() {

			var valid = true;
			var claimTypeId = document.getElementById("claimTypeId").value;

			var claimAmt = document.getElementById("claimAmt").value;
			var claimRemark = document.getElementById("claimRemark").value;
			//	alert("hii" + claimTypeId + claimAmt);

			//	alert("final amt::" + y);

			$("#error_claimTypeId").hide();
			$("#error_claim_amt").hide();
			$("#error_claimRemark").hide();

			if (claimTypeId == "") {

				$("#error_claimTypeId").show()

			}
			if (claimAmt == 0) {

				$("#error_claim_amt").show()

			}
			if (claimRemark == "") {

				$("#error_claimRemark").show()

			}

			if (claimTypeId == "" || claimAmt == 0 || claimRemark == "") {
				valid = false;

			} else {
				valid = true;

				var tempAmt = document.getElementById("tempAmtX").value;
				var claimAmt = document.getElementById("claimAmt").value;

				$('#lmAmtNew').html(document.getElementById("tempAmtX").value);
				if (parseFloat(claimAmt) > parseFloat(tempAmt)) {

					//	alert("Amonut Entered Exceeds the Limit Amount");
					$('#modal_scrollable1').modal('show');
				}

				else {
					var imageShowUrl = document.getElementById('imageShowUrl').value;
					var valid = true;
					var files = $('#doc')[0].files[0];
					var el = document.getElementById('claimTypeId');
					var lvTypeName = el.options[el.selectedIndex].innerHTML;
					//	alert("lvTypeName  " + lvTypeName);

					var daterange = document.getElementById("claimDate").value;
					var res = daterange.split(" to ");

					var isEdit = document.getElementById("isEdit").value;
					var isDelete = document.getElementById("isDelete").value;
					var index = document.getElementById("index").value;
					if (valid == true) {

						var fd = new FormData();

						fd.append('file', files);
						fd.append('isDelete', isDelete);
						fd.append('isEdit', isEdit);
						fd.append('index', index);
						fd.append('claimAmt', claimAmt);
						fd.append('claimRemark', claimRemark);
						fd.append('lvTypeName', lvTypeName);
						fd.append('claimTypeId', claimTypeId);

						$
								.ajax({
									url : '${pageContext.request.contextPath}/addClaimDetailProcess',
									type : 'post',
									dataType : 'json',
									data : fd,
									async : false,
									contentType : false,
									processData : false,
									success : function(data) {
										 
										var tempAmt = 0;

										document.getElementById("dataLen").value = data.length;

										$("#printtable1 tbody").empty();
										$("#loader").hide();

										for (var i = 0; i < data.length; i++) {

											var filespath = "";

											if (data[i].proofList.length == 0) {
												filespath = "-"
											} else {

												for (var j = 0; j < data[i].proofList.length; j++) {
													filespath = filespath
															+ '<a href="'+imageShowUrl+data[i].proofList[j].cpDocPath+'" target="_blank" class="action_btn"  style="color:black" title="'+data[i].proofList[j].cpDocPath+'" ><i class="fa fa-file"></i></a>'
												}
											}
											var str = '<a href="#" class="action_btn" onclick="callDelete('
													+ data[i].claimDetailId
													+ ','
													+ i
													+ ')" style="color:black"><i class="fa fa-trash"></i></a>'
											var tr_data = '<tr>' + '<td>'
													+ (i + 1) + '</td>'
													+ '<td>'
													+ data[i].lvTypeName
													+ '</td>' + '<td>'
													+ data[i].claimAmount
													+ '</td>' + '<td>'
													+ data[i].remark
													+ '</td><td>' + filespath
													+ '</td><td>' + str
													+ '</td>' + '</tr>';
											$('#printtable1' + ' tbody')
													.append(tr_data);
											tempAmt = tempAmt
													+ data[i].claimAmount;

										}
										$('#modal_scrollable1').modal('hide');
										document.getElementById("tempAmt").value = tempAmt;
									},
								});
						//alert("outer");
						document.getElementById("doc").value = "";
						document.getElementById("claimRemark").value = "";
						document.getElementById("claimAmt").value = 0;

						document.getElementById("isDelete").value = 0;
						document.getElementById("isEdit").value = 0;
						document.getElementById("index").value = 0;
					}

				}
			}

		}

		function finalAdd() {
			var valid = true;

			var claimTypeId = document.getElementById("claimTypeId").value;

			var claimAmt = document.getElementById("claimAmt").value;
			var claimRemark = document.getElementById("claimRemark").value;

			var el = document.getElementById('claimTypeId');
			var lvTypeName = el.options[el.selectedIndex].innerHTML;
			//	alert("lvTypeName  " + lvTypeName);

			var daterange = document.getElementById("claimDate").value;
			var res = daterange.split(" to ");
			var files = $('#doc')[0].files[0];
			var isEdit = document.getElementById("isEdit").value;
			var isDelete = document.getElementById("isDelete").value;
			var index = document.getElementById("index").value;
			if (valid == true) {

				// alert("hii");

				var fd = new FormData();

				fd.append('file', files);
				fd.append('isDelete', isDelete);
				fd.append('isEdit', isEdit);
				fd.append('index', index);
				fd.append('claimAmt', claimAmt);
				fd.append('claimRemark', claimRemark);
				fd.append('lvTypeName', lvTypeName);
				fd.append('claimTypeId', claimTypeId);

				$
						.ajax({
							url : '${pageContext.request.contextPath}/addClaimDetailProcess',
							type : 'post',
							dataType : 'json',
							data : fd,
							contentType : false,
							processData : false,
							success : function(data) {

								var tempAmt = 0;

								document.getElementById("dataLen").value = data.length;
								var imageShowUrl = document
										.getElementById('imageShowUrl').value;
								$("#printtable1 tbody").empty();
								$("#loader").hide();

								for (var i = 0; i < data.length; i++) {

									var filespath = "";

									if (data[i].proofList.length == 0) {
										filespath = "-"
									} else {

										for (var j = 0; j < data[i].proofList.length; j++) {
											filespath = filespath
													+ '<a href="'+imageShowUrl+data[i].proofList[j].cpDocPath+'" target="_blank" class="action_btn"  style="color:black" title="'+data[i].proofList[j].cpDocPath+'" ><i class="fa fa-file"></i></a>'
										}
									}

									var str = '<a href="#" class="action_btn" onclick="callDelete('
											+ data[i].claimDetailId
											+ ','
											+ i
											+ ')" style="color:black"><i class="fa fa-trash"></i></a>'
									var tr_data = '<tr>' + '<td>' + (i + 1)
											+ '</td>' + '<td>'
											+ data[i].lvTypeName + '</td>'
											+ '<td>' + data[i].claimAmount
											+ '</td>' + '<td>' + data[i].remark
											+ '</td><td>' + filespath
											+ '</td><td>' + str + '</td>'
											+ '</tr>';
									$('#printtable1' + ' tbody')
											.append(tr_data);
									tempAmt = tempAmt + data[i].claimAmount;

								}
								$('#modal_scrollable1').modal('hide');
								document.getElementById("tempAmt").value = tempAmt;
							},
						});
				document.getElementById("doc").value = "";
				document.getElementById("claimRemark").value = "";
				document.getElementById("claimAmt").value = 0;

				document.getElementById("isDelete").value = 0;
				document.getElementById("isEdit").value = 0;
				document.getElementById("index").value = 0;
			}
		}
	</script>

	<script type="text/javascript">
		function callEdit(claimDetailId, index) {

			document.getElementById("isEdit").value = "1";
			$.getJSON('${getClaimForEdit}', {
				claimDetailId : claimDetailId,
				index : index,
				ajax : 'true',

			}, function(data) {

				document.getElementById("index").value = index;

				document.getElementById("claimRemark").value = data.remark;
				document.getElementById("claimAmt").value = data.claimAmount;

				document.getElementById("claimTypeId").value = data.lvTypeName;

			});

		}
	</script>
	<script type="text/javascript">
		function callDelete(termDetailId, index) {

			//alert("hii");
			//document.getElementById("isEdit").value = 0;
			//alert("index" + index);
			var files = $('#doc')[0].files[0];
			var fd = new FormData();

			fd.append('file', files);
			fd.append('isDelete', 1);
			fd.append('isEdit', 0);
			fd.append('key', index);

			$
					.ajax({
						url : '${pageContext.request.contextPath}/addClaimDetailProcess',
						type : 'post',
						dataType : 'json',
						data : fd,
						contentType : false,
						processData : false,
						success : function(data) {

							var imageShowUrl = document
									.getElementById('imageShowUrl').value;
							$("#printtable1 tbody").empty();
							$("#loader").hide();
							var tempAmt = 0;

							for (var i = 0; i < data.length; i++) {

								var filespath = "";

								if (data[i].proofList.length == 0) {
									filespath = "-"
								} else {

									for (var j = 0; j < data[i].proofList.length; j++) {
										filespath = filespath
												+ '<a href="'+imageShowUrl+data[i].proofList[j].cpDocPath+'" target="_blank" class="action_btn"  style="color:black" title="'+data[i].proofList[j].cpDocPath+'" ><i class="fa fa-file"></i></a>'
									}
								}
								var str = '<a href="#" class="action_btn" onclick="callDelete('
										+ data[i].claimDetailId
										+ ','
										+ i
										+ ')" style="color:black"><i class="fa fa-trash"></i></a>'
								var tr_data = '<tr><td>' + (i + 1)
										+ '</td><td>' + data[i].lvTypeName
										+ '</td><td>' + data[i].claimAmount
										+ '</td><td>' + data[i].remark
										+ '</td><td>' + filespath + '</td><td>'
										+ str + '</td>' + '</tr>';
								$('#printtable1' + ' tbody').append(tr_data);
								tempAmt = tempAmt + data[i].claimAmount;

							}
							document.getElementById("tempAmt").value = tempAmt;
						},
					});

			/* $
					.getJSON(
							'${addClaimDetailProcess}',
							{
								isDelete : 1,
								isEdit : 0,
								key : index,
								ajax : 'true',

							},

							function(data) {

								$("#printtable1 tbody").empty();
								$("#loader").hide();

								for (var i = 0; i < data.length; i++) {

									var str = '<a href="#" class="action_btn" onclick="callDelete('
											+ data[i].claimDetailId
											+ ','
											+ i
											+ ')" style="color:black"><i class="fa fa-trash"></i></a>'
									var tr_data = '<tr>' + '<td>' + (i + 1)
											+ '</td>' + '<td>'
											+ data[i].lvTypeName + '</td>'
											+ '<td>' + data[i].claimAmount
											+ '</td>' + '<td>' + data[i].remark
											+ '</td><td>' + str + '</td>'
											+ '</tr>';
									$('#printtable1' + ' tbody')
											.append(tr_data);

								}

							}); */

		}

		function freezeMonthValidation() {

			//alert("hii");
			//document.getElementById("isEdit").value = 0;
			//alert("index" + index);
			var claimDate = $('#claimDate').val();
			var empId = $('#empId').val();
			var fd = new FormData();

			fd.append('fromDate', claimDate);
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
							}

						},
					});

		}
	</script>

	<script type="text/javascript">
		function validate(s) {
			var rgx = /^[0-9]*\.?[0-9]*$/;
			return s.match(rgx);
		}
		function callAlert(msg) {
			alert(msg);
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

	<script>
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

												/* if (!$("#projectTypeId").val()) {

													isError = true;

													$("#error_projectTypeId")
															.show()

												} else {
													$("#error_projectTypeId")
															.hide()
												}
												 */
												if (!$("#claimDate").val()) {

													isError = true;

													$("#error_Range").show()

												} else {
													$("#error_Range").hide()
												}

												if (!$("#claim_title").val()) {

													isError = true;

													$("#error_claim_title")
															.show()

												} else {
													$("#error_claim_title")
															.hide()
												}

												if ($("#dataLen").val() == 0) {
													isError = true;
													$("#error_tbl").show()
												} else {
													$("#error_tbl").hide()
												}
												if (!isError) {

													/* 	var option1 = $(
																"#projectTypeId option:selected")
																.attr(
																		"data-prostrname");

														$('#proName').html(option1) */

													$('#claimAmt1')
															.html(
																	document
																			.getElementById("tempAmt").value);
													$('#empCode1')
															.html(
																	document
																			.getElementById("empCode").value);
													$('#empName1')
															.html(
																	document
																			.getElementById("empName").value);

													$('#claimDate1')
															.html(
																	document
																			.getElementById("claimDate").value);

													$('#modal_scrollable')
															.modal('show');

													//end ajax send this to php page
												}
												return false;
											});
						});
	</script>



	<script type="text/javascript">
		function chkAssign() {

			var auth = document.getElementById("auth").value;

			//alert("hii"+auth);
			if (auth == 0) {
				document.getElementById("submtbtn").disabled = true;

				$("#error_assign").show()
			} else {
				document.getElementById("submtbtn").disabled = false;
			}
		}
	</script>
	<script>
		function submitForm() {
			$('#modal_scrollable').modal('hide');
			document.getElementById("submtbtn").disabled = true;
			document.getElementById("submitInsertLeave").submit();

		}
	</script>
	<script type="text/javascript">
		function checkAmt() {

			//alert("hii");

		}
	</script>

	<div id="modal_scrollable1" class="modal fade" data-backdrop="false"
		tabindex="-1">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header pb-3">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body py-0">
					<h5 class="modal-title">Amount Entered Exceeds the Limit
						Amount</h5>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="asd"> Limit
							Amount : </label> <label class="col-form-label col-lg-2" id="lmAmtNew"
							for="lmAmt"> </label>

					</div>
				</div>
				<div class="modal-footer pt-3">
					<button type="button" class="btn btn-link" onclick="finalAdd()">Ok</button>
				</div>
			</div>
		</div>
	</div>


	<!-- Scrollable modal -->
	<div id="modal_scrollable" class="modal fade" data-backdrop="false"
		tabindex="-1">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header pb-3">

					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<div class="modal-body py-0">
					<h5 class="modal-title">Claim Details</h5>
					<br>

					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="empCode1">
							Employee Code : </label> <label class="col-form-label col-lg-2"
							id="empCode1" for="empCode1"> </label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="empName1">
							Employee Name : </label> <label class="col-form-label col-lg-6"
							id="empName1" for="empName1"> </label>

					</div>

					<!-- 	<div class="form-group row">
						<label class="col-form-label col-lg-3" for="proName">
							Project Name : </label> <label class="col-form-label col-lg-6"
							id="proName" for="proName"> </label>

					</div> -->


					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="noOfDays">
							Claim Amount : </label> <label class="col-form-label col-lg-3"
							id="claimAmt1" for="claimAmt1"> </label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="claimDate1">
							Claim Date : </label> <label class="col-form-label col-lg-7"
							id="claimDate1" for="claimDate1"> </label>

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



</body>
</html>
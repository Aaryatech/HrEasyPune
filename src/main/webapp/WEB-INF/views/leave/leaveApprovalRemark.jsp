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
												<i class="icon-list-unordered"></i> Leave Details
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
										session.removeAttribute("errorMsg");
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
										session.removeAttribute("successMsg");
									%>
								</div>
								<%
									session.removeAttribute("successMsg");
									}
								%>


								<div class="form-group row">
									<label class="col-form-label col-lg-2" for="compName">Employee
										Code : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control"
											Value="${lvEmp.empCode}" id="empCode" autocomplete="off"
											readonly>

									</div>
								</div>
								<div class="form-group row">
									<label class="col-form-label col-lg-2" for="compName">Employee
										Name : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control"
											Value="${lvEmp.empName}" id="empName" autocomplete="off"
											readonly>

									</div>
								</div>
								<div class="form-group row">
									<label class="col-form-label col-lg-2" for="compName">Leave
										Type : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control"
											Value="${lvEmp.leaveTitle}" id="lvType" autocomplete="off"
											readonly>

									</div>
								</div>

								<div class="form-group row">
									<label class="col-form-label col-lg-2" for="compName">Type
										: </label>
									<div class="col-lg-6">
										<c:set var="type" value="-"></c:set>
										<c:if test="${lvEmp.leaveDuration==1}">
											<c:set var="type" value="Full Day"></c:set>
										</c:if>
										<c:if test="${lvEmp.leaveDuration==2}">
											<c:set var="type" value="1st Half"></c:set>
										</c:if>
										<c:if test="${lvEmp.leaveDuration==3}">
											<c:set var="type" value="2nd Half"></c:set>
										</c:if>
										<input type="text" class="form-control" Value="${type}"
											name="compName" autocomplete="off" readonly>

									</div>
								</div>

								<div class="form-group row">
									<label class="col-form-label col-lg-2" for="compName">From
										date : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control"
											Value="${lvEmp.leaveFromdt}" id="frmDate" autocomplete="off"
											readonly>

									</div>
								</div>
								<div class="form-group row">
									<label class="col-form-label col-lg-2" for="compName">To
										Date : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control"
											Value="${lvEmp.leaveTodt}" id="toDate" autocomplete="off"
											readonly>

									</div>
								</div>

								<div class="form-group row">
									<label class="col-form-label col-lg-2" for="compName">No.
										of Days : </label>
									<div class="col-lg-6">
										<input type="text" class="form-control"
											Value="${lvEmp.leaveNumDays}" id="noOfDays"
											autocomplete="off" readonly>

									</div>
								</div>
								<c:if test="${lvEmp.empPhoto != '-'}">
									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="certificate">Fitness
											Certificate</label>
										<div class="col-lg-6">
											<a href="${imageUrl}${lvEmp.empPhoto}" target="_blank">Download
												File</a>

										</div>
									</div>
								</c:if>


								<div class="form-group row">
									<label class="col-form-label col-lg-2" for="compName">Remark
										: </label>
									<div class="col-lg-6">
										<input type="text" class="form-control"
											Value="${lvEmp.leaveEmpReason}" id="remark2"
											autocomplete="off" readonly>

									</div>
								</div>

								<h6 class="pageTitle">
									<i class="icon-list-unordered"></i> Leave Trail History
								</h6>

								<table
									class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
									id="printtable1">
									<thead>
										<tr class="bg-blue">
											<th class="text-center" width="10%">Sr.no</th>
											<!-- <th>Name</th> -->
											<th class="text-center">Action By</th>
											<th class="text-center">Remark</th>
											<th class="text-center">Date</th>

											<th class="text-center">Leave Status</th>


										</tr>
									</thead>
									<tbody>


										<c:forEach items="${employeeList}" var="empTrailList"
											varStatus="count">
											<tr>
												<td>${count.index+1}</td>
												<%-- 	<td>${empTrailList.empSname}${empTrailList.empFname}</td> --%>

												<td>${empTrailList.userName}</td>
												<c:choose>
													<c:when
														test="${empTrailList.empRemarks=='null' || empty empTrailList.empRemarks}">
														<td>-</td>
													</c:when>
													<c:otherwise>
														<td>${empTrailList.empRemarks}</td>
													</c:otherwise>
												</c:choose>
												<td>${empTrailList.makerEnterDatetime}</td>

												<c:if test="${empTrailList.leaveStatus==1}">
													<td><span class="badge badge-info"> Applied</span></td>
												</c:if>
												<c:if test="${empTrailList.leaveStatus==2}">
													<td><span class="badge badge-secondary">Initial
															Approved</span></td>
												</c:if>
												<c:if test="${empTrailList.leaveStatus==3}">
													<td><span class="badge badge-success"> Final
															Approved</span></td>
												</c:if>
												<c:if test="${empTrailList.leaveStatus==7}">
													<td><span class="badge badge-danger"> Cancelled</span></td>
												</c:if>
												<c:if test="${empTrailList.leaveStatus==8}">
													<td><span class="badge badge-danger">Initial
															Rejected</span></td>
												</c:if>
												<c:if test="${empTrailList.leaveStatus==9}">
													<td><span class="badge badge-danger"> Final
															Rejected</span></td>
												</c:if>

											</tr>
										</c:forEach>

									</tbody>
								</table>

								<form
									action="${pageContext.request.contextPath}/approveLeaveByInitialAuth1"
									id="submitInsertCompany" method="post">


									<%-- <div class="form-group row">
										<div class="col-md-6">
											<label
												class="${stat==7 || stat==8 || stat==9 ? 'col-form-label text-info font-weight-bold col-lg-5 float' : 'col-form-label col-lg-5 float'}"
												for="remark">Any Remark:<c:choose>
													<c:when test="${stat==7 || stat==8 || stat==9 }">
														<span class="text-danger">*</span>
													</c:when>
												</c:choose>
											</label>
											<div class="col-lg-7 float">
												<textarea rows="3" cols="3" class="form-control"
													placeholder="Any Remark" onchange="trim(this)" id="remark"
													name="remark"></textarea>
												<span class="validation-invalid-label" id="error_remark"
													style="display: none;">This field is required.</span>
											</div>
										</div>
									</div> --%>

									<div class="form-group row">
										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="remark">Any Remark: <span class="text-danger">*</span>

											</label>
											<div class="col-lg-7 float">
												<textarea rows="3" cols="3" class="form-control"
													placeholder="Any Remark" onchange="trim(this)" id="remark"
													name="remark"></textarea>
												<span class="validation-invalid-label" id="error_remark"
													style="display: none;">This field is required.</span>
											</div>
										</div>
									</div>


									<input type="hidden" id="empId" name="empId" value="${empId}">
									<input type="hidden" id="leaveId" name="leaveId"
										value="${leaveId}"> <input type="hidden" id="stat"
										name="stat" value="${stat}"> <input type="hidden"
										id="stat2" name="stat2" value="${stat2}"> <input
										type="hidden" id="selectedSts" name="selectedSts"
										value="${stat}">


									<div class="form-group row mb-0">
										<div style="margin: 0 auto;">
											<!-- 											<button type="reset" class="btn btn-light legitRipple">Reset</button>
 -->
											<c:choose>
												<c:when test="${stat==7}">
													<button type="submit" class="btn blue_btn" id="submtbtn"
														onclick="changeOrinalSts(${stat})">Cancel Leave</button>
													<a
														href="${pageContext.request.contextPath}/showLeaveHistList?empId=${encryptEmpId}"><button
															type="button" class="btn btn-light">
															<i class="${sessionScope.cancelIcon}" aria-hidden="true"></i>
															Back
														</button></a>

												</c:when>
												<c:otherwise>
													<button type="submit" class="btn blue_btn" id="submtbtn"
														onclick="changeOrinalSts(${stat})">Approve Leave</button>
													<button type="submit" class="btn blue_btn" id="submtbtn"
														onclick="changeOrinalSts(${stat2})">Reject Leave</button>
													<a
														href="${pageContext.request.contextPath}/showLeaveApprovalByAuthority"><button
															type="button" class="btn btn-light">
															<i class="${sessionScope.cancelIcon}" aria-hidden="true"></i>
															Back
														</button></a>
												</c:otherwise>
											</c:choose>

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
	
	
	function changeOrinalSts(sts) {
		document
		.getElementById("selectedSts").value=sts;
	}
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
		$(document)
				.ready(
						function($) {

							$("#submitInsertCompany")
									.submit(
											function(e) {
												var isError = false;
												var errMsg = "";
												 
													if (!$("#remark").val()) {

														isError = true;

														$("#error_remark")
																.show()

													} else {
														$("#error_remark")
																.hide()
													}

												 

												if (!isError) {
													var sts =document
													.getElementById("selectedSts").value;
													 
													if(sts==8 ||sts==9 ){
														$('#headingpoup')
														.html('Reject Leave');
														 
													}else if(sts==2 ||sts==3){
														$('#headingpoup')
														.html('Approve Leave');
														 
													}else if(sts==7){
														$('#headingpoup')
														.html('Cancel Leave');
														 
													}else{
														
														$('#headingpoup')
														.html('Leave Detail'); 
													}
													
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
													$('#lvType1')
															.html(
																	document
																			.getElementById("lvType").value);

													$('#fromdate1')
															.html(
																	document
																			.getElementById("frmDate").value);
													$('#todate1')
															.html(
																	document
																			.getElementById("toDate").value);
													$('#remark1')
															.html(
																	document
																			.getElementById("remark").value);
													$('#modal_scrollable')
															.modal('show');

													//end ajax send this to php page
												}
												return false;
											});
						});
	</script>
	<script>
		function submitForm() {
			$('#modal_scrollable').modal('hide');
			document.getElementById("submtbtn").disabled = true;
			document.getElementById("submitInsertCompany").submit();

		}
	</script>
	<div id="modal_scrollable" class="modal fade" data-backdrop="false"
		tabindex="-1">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header pb-3">

					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<div class="modal-body py-0">
					<h5 class="modal-title">
						<label id="headingpoup">Leave Details</label>
					</h5>



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
						<label class="col-form-label col-lg-3" for="lvType1">
							Leave Type : </label> <label class="col-form-label col-lg-6" id="lvType1"
							for="lvType1"> </label>

					</div>


					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="fromdate1">
							From Date : </label> <label class="col-form-label col-lg-3"
							id="fromdate1" for="noOfDays1"> </label> <label
							class="col-form-label col-lg-3" for="todate1"> To Date :
						</label> <label class="col-form-label col-lg-2" id="todate1"
							for="noOfDays1"> </label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="noOfDays"> No.
							of Days : </label> <label class="col-form-label col-lg-3" id="noOfDays1"
							for="noOfDays1"> </label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="remark1">
							Remark : </label> <label class="col-form-label col-lg-3" id="remark1"
							for="remark1"> </label>

					</div>
				</div>

				<div class="modal-footer pt-3">
					<button type="button" class="btn btn-link" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn bg-primary" onclick="submitForm()">Submit</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"
	import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html lang="en">
<head>

<c:url var="addStrDetail" value="/addStrDetail" />


<c:url var="chkNumber" value="/chkNumber" />

<c:url var="getLeaveStructureForEdit" value="/getLeaveStructureForEdit" />
<c:url var="getHolidayAndWeeklyOffList"
	value="/getHolidayAndWeeklyOffList" />
<c:url var="calholidayWebservice" value="/calholidayWebservice" />
<c:url var="checkDatesRange" value="/checkDatesRange" />
<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>

<body onload="chkAssign()">


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
									<i class="icon-list-unordered"></i> Edit Leave Structure
								</h5>
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
									action="${pageContext.request.contextPath}/submitEditLeaveStructure"
									id="submitEditLeaveStructure" method="post">



									<div class="form-group row">

										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="lvsName">Employee Name : </label>
											<div class="col-lg-7 float">
												<input type="text" class="form-control"
													placeholder="Enter Leave Structure Name" id="empCode"
													value="${leavesAllotment.exVar3}" name="lvsName"
													autocomplete="off" readonly>
											</div>
										</div>
										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="leaveTypeId">Select Leave Structure <span
												style="color: red">* </span>:
											</label>
											<div class="col-lg-7 float">
												<select name="lvsId" data-placeholder="Select Structure"
													id="lvsId"
													class="form-control form-control-select2 select2-hidden-accessible"
													data-fouc="" aria-hidden="true">
													<c:forEach items="${lStrList}" var="str">

														<c:choose>
															<c:when test="${str.lvsId==leavesAllotment.lvsId}">
																<option value="${str.lvsId}" selected>${str.lvsName}</option>
															</c:when>
															<c:otherwise>
																<option value="${str.lvsId}">${str.lvsName}</option>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</select> <span class="validation-invalid-label" id="error_lvsId"
													style="display: none;">This field is required.</span>
											</div>
										</div>


									</div>

									<div class="col-md-12" style="text-align: center;">

										<button type="button" class="btn blue_btn bootbox_custom"
											id="submtbtn">
											Submit <i class="icon-paperplane ml-2"></i>
										</button>

										<a
											href="${pageContext.request.contextPath}/leaveStructureAllotment"><button
												type="button" class="btn btn-light">
												<i class="${sessionScope.cancelIcon}" aria-hidden="true"></i>&nbsp;&nbsp;
												Back
											</button></a>
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

	<script>
		$('.bootbox_custom')
				.on(
						'click',
						function() {
							//var lvsId = $("#lvsId").val() // will return the number 123
							bootbox
									.confirm({
										title : 'Confirm ',
										message : 'Are you sure to assign structure ?',
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
												document
														.getElementById("submtbtn").disabled = true;
												document
														.getElementById(
																"submitEditLeaveStructure")
														.submit();

											}
										}
									});
						});
	</script>


</body>
</html>
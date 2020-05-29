<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

			<!-- /page header -->


			<!-- Content area -->
			<div class="content">


				<!-- Highlighting rows and columns -->
				<div class="card">





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

						<form action="${pageContext.request.contextPath}/otApprovalList"
							id="otApprovalList" method="get" enctype="multipart/form-data">
							<div class="form-group row">
								<label
									class="col-form-label text-info font-weight-bold col-lg-2"
									for="date">Attendance Date <span style="color: red">*
								</span> :
								</label>
								<div class="col-md-2">
									<input type="text" class="form-control datepickerclass"
										placeholder="Select Date " id="date" name="date"
										value="${date}" autocomplete="off">
								</div>
								<input type="submit" class="btn blue_btn ml-3 legitRipple"
									id="searchbtn" value="Search">
							</div>
						</form>
						<ul class="nav nav-tabs nav-tabs-highlight nav-justified1">
							<li class="nav-item"><a href="#highlighted-justified-tab1"
								class="nav-link active" data-toggle="tab">Initial Approval </a></li>
							<li class="nav-item"><a href="#highlighted-justified-tab2"
								class="nav-link" data-toggle="tab">Final Approval </a></li>

						</ul>

						<div class="tab-content">
							<div class="tab-pane fade show active"
								id="highlighted-justified-tab1">
								<div class="card-header header-elements-inline">
									<table width="100%">
										<tr width="100%">
											<td width="60%"><h5 class="pageTitle">
													<i class="icon-list-unordered"></i> Production Incentive
													Initial Approval List (OT)
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

								<form
									action="${pageContext.request.contextPath}/submitApproveProductionIncentive"
									id="submitApproveProductionIncentive" method="post"
									enctype="multipart/form-data">
									<div class="table-responsive">

										<table class="table datatable-scroll-y" id="printtable1">

											<!-- <table class="table datatable-scroll-y" width="100%"
									id="printtable1"> -->
											<thead>
												<tr class="bg-blue" style="text-align: center;">

													<th class="text-center" style="width: 10%;">Date</th>
													<th class="text-center">Emp Name</th>
													<th class="text-center">Status</th>
													<!-- <th class="text-center">In Time</th>
											<th class="text-center">Out Time</th> -->
													<!-- <th class="text-center">Late Mark</th>
											<th class="text-center">Late MIN</th> -->
													<th class="text-center">WR. Hrs</th>

													<th class="text-center">Production Incentive <br>Hrs
													</th>

													<th class="text-center">OShift/Loc</th>
													<!-- <th class="text-center" style="width: 10%;">Action</th> -->

												</tr>
											</thead>
											<tbody>


												<c:forEach items="${dailyrecordList}" var="dailyrecordList">
													<tr>
														<td class="text-center" style="width: 10%;"><input
															type="checkbox" name="selectEmp"
															id="selectEmp${dailyrecordList.id}"
															value="${dailyrecordList.id}">&nbsp;${dailyrecordList.attDate}</td>
														<td class="text-center">${dailyrecordList.empName}</td>
														<td class="text-center">${dailyrecordList.attStatus}</td>

														<%-- <c:choose>
													<c:when test="${dailyrecordList.inTime eq '00:00:00'}">
														<td class="text-center" style="background-color: #FFA8A8">${dailyrecordList.inTime}</td>
													</c:when>
													<c:otherwise>
														<td class="text-center">${dailyrecordList.inTime}</td>
													</c:otherwise>
												</c:choose>

												<c:choose>
													<c:when test="${dailyrecordList.outTime eq '00:00:00'}">
														<td class="text-center" style="background-color: #FFA8A8">${dailyrecordList.outTime}</td>
													</c:when>
													<c:otherwise>
														<td class="text-center">${dailyrecordList.outTime}</td>
													</c:otherwise>
												</c:choose> --%>


														<%-- <c:choose>
													<c:when test="${dailyrecordList.lateMark==1}">
														<td class="text-center" style="background-color: #FF9">Yes</td>
													</c:when>
													<c:otherwise>
														<td class="text-center">No</td>
													</c:otherwise>
												</c:choose>
												<td class="text-right">${dailyrecordList.lateMin}</td> --%>
														<td class="text-right"
															title="In Time : ${dailyrecordList.inTime},Out Time : ${dailyrecordList.outTime}">${dailyrecordList.workingHrs}</td>

														<td class="text-right">${dailyrecordList.otHr}</td>

														<td>${dailyrecordList.currentShiftname}</td>
														<!-- <td class="text-center"></td> -->
													</tr>
												</c:forEach>

											</tbody>
										</table>
									</div>
									<br /> <span class="validation-invalid-label" id="error_chk"
										style="display: none;">Please Select the Employee.</span> <input
										type="hidden" id="stsaprv" value="1" name="stsaprv"> <input
										type="hidden" id="rejectResn" value="" name="rejectResn">

									<c:if test="${dailyrecordList.size()>0}">
										<!-- <div class="form-group row">
									<label
										class="col-form-label text-info font-weight-bold col-lg-2"
										for="date">Remark <span style="color: red">* </span> :
									</label>
									<div class="col-md-2">
										<input type="text" class="form-control  " placeholder="Remark"
											id="remark" name="remark" value="" autocomplete="off"> <span class="validation-invalid-label" id="error_remark"
											style="display: none;">Please Select the Employee.</span>
									</div>
								</div> -->

										<div class="col-md-12 text-center">

											<input type="submit" class="btn blue_btn" value="Approve"
												id="aprvbtn" style="align-content: center;"
												onclick="changeValue(1)">
											<!-- <input type="submit"
										class="btn blue_btn" value="Reject" id="rejectbtn"
										style="align-content: center;" onclick="changeValue(2)"> -->


										</div>
									</c:if>

								</form>
							</div>

							<div class="tab-pane fade" id="highlighted-justified-tab2">
								<div class="card-header header-elements-inline">
									<table width="100%">
										<tr width="100%">
											<td width="60%"><h5 class="pageTitle">
													<i class="icon-list-unordered"></i> Production Incentive
													Final Approval List (OT)
												</h5></td>
											<td width="40%" align="right"></td>
										</tr>
									</table>
								</div>

								<form
									action="${pageContext.request.contextPath}/submitFinalApproveProductionIncentive"
									id="submitApproveProductionIncentive" method="post"
									enctype="multipart/form-data">
									<div class="table-responsive">

										<table class="table datatable-scroll-y" id="printtable1">

											<!-- <table class="table datatable-scroll-y" width="100%"
									id="printtable1"> -->
											<thead>
												<tr class="bg-blue" style="text-align: center;">

													<th class="text-center" style="width: 10%;">Date</th>
													<th class="text-center">Emp Name</th>
													<th class="text-center">Status</th>
													<!-- <th class="text-center">In Time</th>
											<th class="text-center">Out Time</th> -->
													<!-- <th class="text-center">Late Mark</th>
											<th class="text-center">Late MIN</th> -->
													<th class="text-center">WR. Hrs</th>

													<th class="text-center">Production Incentive <br>Hrs
													</th>

													<th class="text-center">OShift/Loc</th>
													<!-- <th class="text-center" style="width: 10%;">Action</th> -->

												</tr>
											</thead>
											<tbody>


												<c:forEach items="${dailyrecordList}" var="dailyrecordList">
													<tr>
														<td class="text-center" style="width: 10%;"><input
															type="checkbox" name="selectEmp"
															id="selectEmp${dailyrecordList.id}"
															value="${dailyrecordList.id}">&nbsp;${dailyrecordList.attDate}</td>
														<td class="text-center">${dailyrecordList.empName}</td>
														<td class="text-center">${dailyrecordList.attStatus}</td>

														<%-- <c:choose>
													<c:when test="${dailyrecordList.inTime eq '00:00:00'}">
														<td class="text-center" style="background-color: #FFA8A8">${dailyrecordList.inTime}</td>
													</c:when>
													<c:otherwise>
														<td class="text-center">${dailyrecordList.inTime}</td>
													</c:otherwise>
												</c:choose>

												<c:choose>
													<c:when test="${dailyrecordList.outTime eq '00:00:00'}">
														<td class="text-center" style="background-color: #FFA8A8">${dailyrecordList.outTime}</td>
													</c:when>
													<c:otherwise>
														<td class="text-center">${dailyrecordList.outTime}</td>
													</c:otherwise>
												</c:choose> --%>


														<%-- <c:choose>
													<c:when test="${dailyrecordList.lateMark==1}">
														<td class="text-center" style="background-color: #FF9">Yes</td>
													</c:when>
													<c:otherwise>
														<td class="text-center">No</td>
													</c:otherwise>
												</c:choose>
												<td class="text-right">${dailyrecordList.lateMin}</td> --%>
														<td class="text-right"
															title="In Time : ${dailyrecordList.inTime},Out Time : ${dailyrecordList.outTime}">${dailyrecordList.workingHrs}</td>

														<td class="text-right">${dailyrecordList.otHr}</td>

														<td>${dailyrecordList.currentShiftname}</td>
														<!-- <td class="text-center"></td> -->
													</tr>
												</c:forEach>

											</tbody>
										</table>
									</div>
									<br /> <span class="validation-invalid-label" id="error_chk"
										style="display: none;">Please Select the Employee.</span> <input
										type="hidden" id="stsaprv" value="1" name="stsaprv"> <input
										type="hidden" id="rejectResn" value="" name="rejectResn">

									<c:if test="${dailyrecordList.size()>0}">
										<!-- <div class="form-group row">
									<label
										class="col-form-label text-info font-weight-bold col-lg-2"
										for="date">Remark <span style="color: red">* </span> :
									</label>
									<div class="col-md-2">
										<input type="text" class="form-control  " placeholder="Remark"
											id="remark" name="remark" value="" autocomplete="off"> <span class="validation-invalid-label" id="error_remark"
											style="display: none;">Please Select the Employee.</span>
									</div>
								</div> -->

										<div class="col-md-12 text-center">

											<input type="submit" class="btn blue_btn" value="Approve"
												id="aprvbtn" style="align-content: center;"
												onclick="changeValue(1)">
											<!-- <input type="submit"
										class="btn blue_btn" value="Reject" id="rejectbtn"
										style="align-content: center;" onclick="changeValue(2)"> -->


										</div>
									</c:if>

								</form>
							</div>


						</div>

					</div>

				</div>
				<!-- /highlighting rows and columns -->

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
		// Single picker
		$('.datepickerclass').daterangepicker({
			singleDatePicker : true,
			selectMonths : true,
			selectYears : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});

		$(document).ready(
				function() {
					//	$('#printtable').DataTable();

					$("#selAll").click(
							function() {
								$('#printtable1 tbody input[type="checkbox"]')
										.prop('checked', this.checked);
							});
				});
	</script>



</body>
</html>
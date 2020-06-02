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


					<div class="card-header header-elements-inline">
						<table width="100%">
							<tr width="100%">
								<td width="60%"><h5 class="pageTitle">
										<i class="icon-list-unordered"></i> Leave Approval By
										Authority
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
						<ul class="nav nav-tabs nav-tabs-highlight nav-justified1">
							<li class="nav-item"><a href="#highlighted-justified-tab1"
								class="nav-link active" data-toggle="tab">Pending
									Leave(${list1Count})</a></li>
							<li class="nav-item"><a href="#highlighted-justified-tab2"
								class="nav-link" data-toggle="tab">Information(${list2Count})</a></li>

						</ul>

						<div class="tab-content">
							<div class="tab-pane fade show active"
								id="highlighted-justified-tab1">
								<table
									class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
									id="printtable1">
									<thead>
										<tr class="bg-blue">
											<th class="text-center" width="10%">Sr.no</th>
											<th class="text-center">Employee Code</th>
											<th class="text-center">Employee Name</th>
											<th class="text-center">Leave Type</th>
											<th class="text-center">From Date</th>
											<th class="text-center">To Date</th>
											<th class="text-center">No. Of Days</th>
											<th class="text-center">Status</th>
											<th class="text-center" width="10%">Actions</th>
										</tr>
									</thead>
									<tbody>


										<c:forEach items="${leaveListForApproval}" var="leaveList"
											varStatus="count">

											<tr>
												<td>${count.index+1}</td>
												<td>${leaveList.empCode}</td>
												<td>${leaveList.empName}</td>
												<td>${leaveList.leaveTitle}</td>
												<td>${leaveList.leaveFromdt}</td>
												<td>${leaveList.leaveTodt}</td>
												<td>${leaveList.leaveNumDays}</td>

												<c:if test="${leaveList.exInt1==1}">
													<td><span class="badge badge-info">Initial
															Pending</span></td>
												</c:if>
												<c:if test="${leaveList.exInt1==2}">
													<td><span class="badge badge-secondary">Final
															Pending</span></td>
												</c:if>
												<c:if test="${leaveList.exInt1==3}">
													<td><span class="badge badge-success"> Final
															Approved</span></td>
												</c:if>
												<c:if test="${leaveList.exInt1==7}">
													<td><span class="badge badge-danger">Leave
															Cancelled</span></td>
												</c:if>
												<c:if test="${leaveList.exInt1==8}">
													<td><span class="badge badge-danger">Initial
															Rejected</span></td>
												</c:if>
												<c:if test="${leaveList.exInt1==9}">
													<td><span class="badge badge-danger"> Final
															Rejected</span></td>
												</c:if>

												<td class="text-center"><c:choose>
														<c:when test="${leaveList.finAuthEmpId==empIdOrig}">

															<%-- <a
																href="${pageContext.request.contextPath}/approveLeaveByInitialAuth?empId=${leaveList.leaveTypeName}&leaveId=${leaveList.circulatedTo}&stat=3"
																title="Approve"><i class="icon-checkmark4 "
																style="color: black;"></i></a>

															<a
																href="${pageContext.request.contextPath}/approveLeaveByInitialAuth?empId=${leaveList.leaveTypeName}&leaveId=${leaveList.circulatedTo}&stat=9"
																title="Reject"><i class="icon-x"
																style="color: black;"></i></a> --%>

															<a
																href="${pageContext.request.contextPath}/approveLeaveByInitialAuth?empId=${leaveList.leaveTypeName}&leaveId=${leaveList.circulatedTo}&apprsts=3&rejctsts=9"
																title="Approve or Reject"><i class="icon-checkmark4"
																style="color: black;"></i></a>

														</c:when>

														<c:when test="${leaveList.iniAuthEmpId==empIdOrig}">

															<%-- <a
																href="${pageContext.request.contextPath}/approveLeaveByInitialAuth?empId=${leaveList.leaveTypeName}&leaveId=${leaveList.circulatedTo}&stat=2"
																title="Approve"><i class="icon-checkmark4 "
																style="color: black;"></i></a>

															<a
																href="${pageContext.request.contextPath}/approveLeaveByInitialAuth?empId=${leaveList.leaveTypeName}&leaveId=${leaveList.circulatedTo}&stat=8"
																title="Reject"><i class="icon-x"
																style="color: black;"></i></a> --%>

															<a
																href="${pageContext.request.contextPath}/approveLeaveByInitialAuth?empId=${leaveList.leaveTypeName}&leaveId=${leaveList.circulatedTo}&apprsts=2&rejctsts=8"
																title="Approve or Reject"><i class="icon-checkmark4"
																style="color: black;"></i></a>

														</c:when>

														<c:when test="${leaveList.empId==empIdOrig}">

															<%-- <a
																href="${pageContext.request.contextPath}/approveLeaveByInitialAuth?empId=${leaveList.leaveTypeName}&leaveId=${leaveList.circulatedTo}&stat=7"
																title="Cancel"><i class="icon-cancel-squareed65"
																style="color: black;"></i></a> --%>
															<a
																href="${pageContext.request.contextPath}/approveLeaveByInitialAuth?empId=${leaveList.leaveTypeName}&leaveId=${leaveList.circulatedTo}&apprsts=7&rejctsts=0"
																title="Cancel"><i class="icon-cancel-square "
																style="color: black;"></i></a>


														</c:when>


														<c:otherwise>




														</c:otherwise>
													</c:choose> <a
													href="${pageContext.request.contextPath}/empDetailHistory?leaveId=${leaveList.circulatedTo}"
													title="Detail"><i class="icon-list-unordered"
														style="color: black;"></i></a></td>
											</tr>
										</c:forEach>

									</tbody>
								</table>
							</div>

							<div class="tab-pane fade" id="highlighted-justified-tab2">
								<table
									class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
									id="printtable1">
									<thead>
										<tr class="bg-blue">
											<th class="text-center" width="10%">Sr.no</th>
											<th class="text-center">Employee Code</th>
											<th class="text-center">Employee Name</th>
											<th class="text-center">Type</th>
											<th class="text-center">From Date</th>
											<th class="text-center">To Date</th>
											<th class="text-center">No. Of Days</th>
											<th class="text-center">Status</th>
											<th class="text-center" width="10%">Actions</th>
										</tr>
									</thead>
									<tbody>


										<c:forEach items="${leaveListForApproval1}" var="leaveList1"
											varStatus="count">

											<tr>
												<td>${count.index+1}</td>
												<td>${leaveList1.empCode}</td>
												<td>${leaveList1.empName}</td>
												<td>${leaveList1.leaveTitle}</td>
												<td>${leaveList1.leaveFromdt}</td>
												<td>${leaveList1.leaveTodt}</td>
												<td>${leaveList1.leaveNumDays}</td>

												<%-- <c:choose>
													<c:when test="${leaveList1.exInt1==1}">
														<td><span class="badge badge-info">Initial Applied</span></td>
													</c:when>
													<c:when test="${leaveList1.exInt1==2}">
														<td><span class="badge badge-secondary">Approve By Initial Authority</span></td>
													</c:when>

												</c:choose> --%>

												<c:if test="${leaveList1.exInt1==1}">
													<td><span class="badge badge-info">Initial
															Pending & Final Pending</span></td>
												</c:if>
												<c:if test="${leaveList1.exInt1==2}">
													<td><span class="badge badge-secondary">Final
															Pending</span></td>
												</c:if>
												<c:if test="${leaveList1.exInt1==3}">
													<td><span class="badge badge-success"> Final
															Approved</span></td>
												</c:if>
												<c:if test="${leaveList1.exInt1==7}">
													<td><span class="badge badge-danger"> Leave
															Cancelled</span></td>
												</c:if>
												<c:if test="${leaveList1.exInt1==8}">
													<td><span class="badge badge-danger">Initial
															Rejected</span></td>
												</c:if>
												<c:if test="${leaveList1.exInt1==9}">
													<td><span class="badge badge-danger">Final
															Rejected</span></td>
												</c:if>




												<td class="text-center"><c:choose>
														<c:when test="${leaveList1.finAuthEmpId==empIdOrig}">

															<%-- <a
																href="${pageContext.request.contextPath}/approveLeaveByInitialAuth?empId=${leaveList1.leaveTypeName}&leaveId=${leaveList1.circulatedTo}&stat=3"
																title="Approve"><i class="icon-checkmark4 "
																style="color: black;"></i></a>

															<a
																href="${pageContext.request.contextPath}/approveLeaveByInitialAuth?empId=${leaveList1.leaveTypeName}&leaveId=${leaveList1.circulatedTo}&stat=9"
																title="Reject"><i class="icon-x"
																style="color: black;"></i></a> --%>

															<a
																href="${pageContext.request.contextPath}/approveLeaveByInitialAuth?empId=${leaveList1.leaveTypeName}&leaveId=${leaveList1.circulatedTo}&apprsts=3&rejctsts=9"
																title="Approve or Reject"><i class="icon-checkmark4"
																style="color: black;"></i></a>
														</c:when>

														<c:when test="${leaveList1.iniAuthEmpId==empIdOrig}">

															<%-- <a
															href="${pageContext.request.contextPath}/approveLeaveByInitialAuth?empId=${leaveList.leaveTypeName}&leaveId=${leaveList.circulatedTo}&stat=2"
															class="dropdown-item"><i class="icon-pencil7"></i>Approve</a>
															
													<a
															href="${pageContext.request.contextPath}/approveLeaveByInitialAuth?empId=${leaveList.leaveTypeName}&leaveId=${leaveList.circulatedTo}&stat=8"
															class="dropdown-item"><i class="icon-pencil7"></i>Reject</a> --%>



														</c:when>

														<c:otherwise>

														</c:otherwise>
													</c:choose> <c:if test="${leaveList1.empId==empIdOrig}">

														<%-- 	<a
															href="${pageContext.request.contextPath}/approveLeaveByInitialAuth?empId=${leaveList1.leaveTypeName}&leaveId=${leaveList1.circulatedTo}&stat=7"
															title="Cancel"><i class="icon-cancel-square "
															style="color: black;"></i></a> --%>

														<a
															href="${pageContext.request.contextPath}/approveLeaveByInitialAuth?empId=${leaveList1.leaveTypeName}&leaveId=${leaveList1.circulatedTo}&apprsts=7&rejctsts=0"
															title="Cancel"><i class="icon-cancel-square "
															style="color: black;"></i></a>


													</c:if> <a
													href="${pageContext.request.contextPath}/empDetailHistory?leaveId=${leaveList1.circulatedTo}"
													title="Detail"><i class="icon-list-unordered"
														style="color: black;"></i></a></td>
											</tr>
										</c:forEach>

									</tbody>
								</table>
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
		$(document).ready(
				function() {
					$('#bootstrap-data-table-export').DataTable();

					$("#selAll").click(
							function() {
								$('#printtable1 tbody input[type="checkbox"]')
										.prop('checked', this.checked);
							});
				});
	</script>



</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
			<div class="card">


				<div class="card-header header-elements-inline"></div>

				<div class="card-body"></div>

			</div>
			<div class="content">


				<!-- Highlighting rows and columns -->
				<div class="card">




					<div class="card-body">
						<div class="row">
							<div class="col-md-4">
								<div class="card bg-primary">
									<div class="card-header header-elements-inline">
										<h6 class="card-title">Today's Birthday</h6>

									</div>

									<div class="card-body">
										<div class="table-responsive">
											<table class="table text-nowrap">


												<c:forEach items="${birth.birthListToday}" var="birth"
													varStatus="count">
													<tr>

														<td><a href="#" class="text-white">
																<div>
																	<i class="icon-gift "> [${birth.empCode}]
																		${birth.name}</i>
																</div>
														</a></td>

													</tr>
												</c:forEach>
											</table>
										</div>
									</div>
								</div>

							</div>

							<div class="col-md-4">
								<div class="card bg-purple-300 text-white">
									<div class="card-header header-elements-inline">
										<h6 class="card-title">Upcomming Birthday(next 7 days)</h6>

									</div>

									<div class="card-body">
										<div class="table-responsive">
											<table class="table text-nowrap">


												<c:forEach items="${birth.birthListUpcoming}" var="birth"
													varStatus="count">
													<tr>

														<td><a href="#" class="text-white">
																<div>
																	<i class="icon-gift "> [${birth.empCode}]
																		${birth.name}</i>
																</div>
														</a></td>

													</tr>
												</c:forEach>
											</table>
										</div>
									</div>
								</div>



							</div>

							<div class="col-md-4">
								<div class="card bg-warning">
									<div class="card-header header-elements-inline">
										<h6 class="card-title">Upcoming Holidays (next 30 days)</h6>

									</div>

									<div class="card-body">
										<div class="table-responsive">
											<table class="table text-nowrap">


												<c:forEach items="${birth.holiList}" var="birth"
													varStatus="count">
													<tr>

														<td><a href="#" class="text-white">
																<div>${birth.holidayName}</div>
														</a></td>


														<td><a href="#" class="text-white">
																<div>${birth.holidayDate}</div>
														</a></td>

													</tr>
												</c:forEach>
											</table>
										</div>
									</div>
								</div>

							</div>


						</div>

						<div class="row">
							<div class="col-md-4">
								<div class="card bg-primary">
									<div class="card-header header-elements-inline">
										<h6 class="card-title">New Hires (Past 30 days)</h6>

									</div>

									<div class="card-body">
										<div class="table-responsive">
											<table class="table text-nowrap">



												<tr>

													<td><a href="#" class="text-white">
															<div>Total</div>
													</a></td>


													<td><a href="#" class="text-white">
															<div>${newHire.maleEmp+newHire.femaleEmp+newHire.othEmp}</div>
													</a></td>

												</tr>


												<tr>

													<td><a href="#" class="text-white">
															<div>Male</div>
													</a></td>


													<td><a href="#" class="text-white">
															<div>${newHire.maleEmp}</div>
													</a></td>

												</tr>

												<tr>

													<td><a href="#" class="text-white">
															<div>Female</div>
													</a></td>


													<td><a href="#" class="text-white">
															<div>${newHire.femaleEmp}</div>
													</a></td>

												</tr>

												<tr>

													<td><a href="#" class="text-white">
															<div>Other</div>
													</a></td>


													<td><a href="#" class="text-white">
															<div>${newHire.othEmp}</div>
													</a></td>

												</tr>

											</table>
										</div>
									</div>
								</div>

							</div>

							<div class="col-md-4">
								<div class="card bg-purple-300 text-white">
									<div class="card-header header-elements-inline">
										<h6 class="card-title">Leave Application Pending</h6>

									</div>

									<div class="card-body">
										<div class="table-responsive">
											<table class="table text-nowrap">



												<tr>

													<td><a href="#" class="text-white">
															<div>New Application</div>
													</a></td>


													<td><a href="#" class="text-white">
															<div>${lvDet.newApp}</div>
													</a></td>

												</tr>


												<tr>

													<td><a href="#" class="text-white">
															<div>Initial Authority Pending/Approved</div>
													</a></td>


													<td><a href="#" class="text-white">
															<div>${lvDet.newApp}/${lvDet.finalPending}</div>
													</a></td>

												</tr>

												<tr>

													<td><a href="#" class="text-white">
															<div>Final Authority Pending</div>
													</a></td>


													<td><a href="#" class="text-white">
															<div>${lvDet.finalPending}</div>
													</a></td>

												</tr>



											</table>
										</div>
									</div>
								</div>



							</div>

							<div class="col-md-4">
								<div class="card bg-warning">
									<div class="card-header header-elements-inline">
										<h6 class="card-title">Today Weekly Off(Total:)</h6>

									</div>

									<div class="card-body">
										<div class="table-responsive">
											<table class="table text-nowrap">


												<c:forEach items="${deptwiseWkoff}" var="deptwiseWkoff"
													varStatus="count">
													<tr>

														<td><a href="#" class="text-white">
																<div>${deptwiseWkoff.nameSd}</div>
														</a></td>


														<td><a href="#" class="text-white">
																<div>${deptwiseWkoff.empCount}</div>
														</a></td>

													</tr>
												</c:forEach>
											</table>
										</div>
									</div>
								</div>

							</div>


						</div>

						<div class="row">
							<div class="col-md-4">
								<div class="card bg-primary">
									<div class="card-header header-elements-inline">
										<h6 class="card-title">Attendance Previous Day(Date:
											${attnDet.attnDate})</h6>

									</div>

									<div class="card-body">
										<div class="table-responsive">
											<table class="table text-nowrap">



												<tr>

													<td><a href="#" class="text-white">
															<div>Total Emp</div>
													</a></td>


													<td><a href="#" class="text-white">
															<div>${attnDet.preEmp+attnDet.lvEmp+attnDet.woEmp+attnDet.absentEmp}</div>
													</a></td>

												</tr>


												<tr>

													<td><a href="#" class="text-white">
															<div>Present</div>
													</a></td>


													<td><a href="#" class="text-white">
															<div>${attnDet.preEmp}</div>
													</a></td>

												</tr>

												<tr>

													<td><a href="#" class="text-white">
															<div>Leave</div>
													</a></td>


													<td><a href="#" class="text-white">
															<div>${attnDet.lvEmp}</div>
													</a></td>

												</tr>



												<tr>

													<td><a href="#" class="text-white">
															<div>Weekly Off Taken</div>
													</a></td>


													<td><a href="#" class="text-white">
															<div>${attnDet.woEmp}</div>
													</a></td>

												</tr>



												<tr>

													<td><a href="#" class="text-white">
															<div>Absent</div>
													</a></td>


													<td><a href="#" class="text-white">
															<div>${attnDet.absentEmp}</div>
													</a></td>

												</tr>





											</table>
										</div>
									</div>
								</div>

							</div>

							<div class="col-md-4">
								<div class="card bg-purple-300 text-white">
									<div class="card-header header-elements-inline">
										<h6 class="card-title">Pay Deduction (Current Month)</h6>

									</div>

									<div class="card-body">
										<div class="table-responsive">
											<table class="table text-nowrap">

												<tr>
													<td><a href="#" class="text-white">
															<div>Total Emp/amount</div>
													</a></td>
													<td><a href="#" class="text-white">
															<div>${dedDet.empCount}/${dedDet.tot}</div>
													</a></td>

												</tr>
											</table>
										</div>

									</div>
								</div>



							</div>

							<div class="col-md-4">
								<div class="card bg-warning">
									<div class="card-header header-elements-inline">
										<h6 class="card-title">Reward (Current Month)</h6>

									</div>

									<div class="card-body">
										<div class="table-responsive">
											<table class="table text-nowrap">

												<tr>
													<td><a href="#" class="text-white">
															<div>Total Emp/amount</div>
													</a></td>
													<td><a href="#" class="text-white">
															<div>${rewardDet.empCount}/${rewardDet.tot}</div>
													</a></td>

												</tr>
											</table>
										</div>
									</div>
								</div>

							</div>


						</div>


						<div class="row">
							<div class="col-md-4">
								<div class="card bg-primary">
									<div class="card-header header-elements-inline">
										<h6 class="card-title">Advance Deduction (Current Moth)</h6>

									</div>

									<div class="card-body">
										<div class="table-responsive">
											<table class="table text-nowrap">



												<tr>

													<td><a href="#" class="text-white">
															<div>Total Emp/amount</div>
													</a></td>


													<td><a href="#" class="text-white">
															<div>${advDet.emp}/${advDet.advTot}</div>
													</a></td>

												</tr>


												<tr>

													<td><a href="#" class="text-white">
															<div>Total Skip Emp/Amt</div>
													</a></td>


													<td><a href="#" class="text-white">
															<div>${advDet.skipId}/${advDet.skipTott}</div>
													</a></td>

												</tr>




											</table>
										</div>
									</div>
								</div>

							</div>

							<div class="col-md-4">
								<div class="card bg-purple-300 text-white">
									<div class="card-header header-elements-inline">
										<h6 class="card-title">Loan Deduction (Current Moth)</h6>

									</div>

									<div class="card-body">
										<div class="table-responsive">
											<table class="table text-nowrap">



												<tr>

													<td><a href="#" class="text-white">
															<div>Total Emp/amount</div>
													</a></td>


													<td><a href="#" class="text-white">
															<div>${loanDet.emp}/${loanDet.advTot}</div>
													</a></td>

												</tr>


												<tr>

													<td><a href="#" class="text-white">
															<div>Total Skip Emp/Amt</div>
													</a></td>


													<td><a href="#" class="text-white">
															<div>${loanDet.skipId}/${loanDet.skipTott}</div>
													</a></td>

												</tr>




											</table>
										</div>

									</div>
								</div>



							</div>

							<div class="col-md-4">
								<div class="card bg-warning">
									<div class="card-header header-elements-inline">
										<h6 class="card-title">Pending Master one time</h6>

									</div>

									<div class="card-body">
										<div class="table-responsive">
											<table class="table text-nowrap">
												<c:if test="${masterDet.companyCount==0}">
													<tr>
														<td><a
															href="${pageContext.request.contextPath}/companySubAdd"
															class="text-white">
																<div>Add Company:0</div>
														</a></td>

													</tr>
												</c:if>
												<c:if test="${masterDet.emptypeCount==0}">
													<tr>
														<td><a
															href="${pageContext.request.contextPath}/mstEmpTypeAdd"
															class="text-white">
																<div>Add Emp Type:0</div>
														</a></td>

													</tr>
												</c:if>
												<c:if test="${masterDet.locCount==0}">
													<tr>
														<td><a
															href="${pageContext.request.contextPath}/locationAdd"
															class="text-white">
																<div>Add Location:0</div>
														</a></td>

													</tr>
												</c:if>
												<c:if test="${masterDet.desnCount==0}">
													<tr>
														<td><a
															href="${pageContext.request.contextPath}/dsesignationAdd"
															class="text-white">
																<div>Add Designation:0</div>
														</a></td>

													</tr>
												</c:if>
												<c:if test="${masterDet.deptCount==0}">
													<tr>
														<td><a
															href="${pageContext.request.contextPath}/departmentAdd"
															class="text-white">
																<div>Add Department:0</div>
														</a></td>

													</tr>
												</c:if>
												<c:if test="${masterDet.hoCount==0}">
													<tr>
														<td><a
															href="${pageContext.request.contextPath}/holidayAdd"
															class="text-white">
																<div>Add Holiday:0</div>
														</a></td>

													</tr>
												</c:if>
												<c:if test="${masterDet.hocatCount==0}">
													<tr>
														<td><a
															href="${pageContext.request.contextPath}/holidayCategoryAdd"
															class="text-white">
																<div>Add Holiday Cat:0</div>
														</a></td>

													</tr>
												</c:if>


												<c:if test="${masterDet.wocatCount==0}">
													<tr>
														<td><a
															href="${pageContext.request.contextPath}/weekoffCategoryAdd"
															class="text-white">
																<div>Add Weekly off Cat:0</div>
														</a></td>

													</tr>
												</c:if>


												<c:if test="${masterDet.shiftCount==0}">
													<tr>
														<td><a
															href="${pageContext.request.contextPath}/addShift"
															class="text-white">
																<div>Add Shift:0</div>
														</a></td>

													</tr>
												</c:if>


												<c:if test="${masterDet.lvtypeCount==0}">
													<tr>
														<td><a
															href="${pageContext.request.contextPath}/leaveTypeAdd"
															class="text-white">
																<div>Add Leave Type:0</div>
														</a></td>

													</tr>
												</c:if>

												<c:if test="${masterDet.lvstructCount==0}">
													<tr>
														<td><a
															href="${pageContext.request.contextPath}/addLeaveStructure"
															class="text-white">
																<div>Add Leave Structure:0</div>
														</a></td>

													</tr>
												</c:if>
												<tr></tr>


												<!--Pending  -->


												<c:if test="${masterDet.compPending!=0}">
													<tr>
														<td><a
															href="${pageContext.request.contextPath}/assignSubCompany"
															class="text-white">
																<div>Assign Company:${masterDet.compPending}</div>
														</a></td>

													</tr>
												</c:if>
												<c:if test="${masterDet.typePending!=0}">
													<tr>
														<td><a
															href="${pageContext.request.contextPath}/showAssignEmpType"
															class="text-white">
																<div>Assign Emp Type:${masterDet.typePending}</div>
														</a></td>

													</tr>
												</c:if>
												<c:if test="${masterDet.locPending!=0}">
													<tr>
														<td><a
															href="${pageContext.request.contextPath}/showAssignLocation"
															class="text-white">
																<div>Assign Location:${masterDet.locPending}</div>
														</a></td>

													</tr>
												</c:if>
												<c:if test="${masterDet.desnPending!=0}">
													<tr>
														<td><a
															href="${pageContext.request.contextPath}/showAssignDesignation"
															class="text-white">
																<div>Assign Designation:${masterDet.desnPending}</div>
														</a></td>

													</tr>
												</c:if>
												<c:if test="${masterDet.deptPending!=0}">
													<tr>
														<td><a
															href="${pageContext.request.contextPath}/assignDept"
															class="text-white">
																<div>Assign Department:${masterDet.deptPending}</div>
														</a></td>

													</tr>
												</c:if>
												<c:if test="${masterDet.hocatPending!=0}">
													<tr>
														<td><a
															href="${pageContext.request.contextPath}//assignHolidayCategory"
															class="text-white">
																<div>Assign Holiday:${masterDet.hocatPending}</div>
														</a></td>

													</tr>
												</c:if>


												<c:if test="${masterDet.wocatPending!=0}">
													<tr>
														<td><a
															href="${pageContext.request.contextPath}/assignWeekoffCategory"
															class="text-white">
																<div>Assign Weekly off
																	Cat:${masterDet.wocatPending}</div>
														</a></td>

													</tr>
												</c:if>


												<c:if test="${masterDet.shiftPending!=0}">
													<tr>
														<td><a
															href="${pageContext.request.contextPath}/showEmpListToAssignShift"
															class="text-white">
																<div>Assign Shift:${masterDet.shiftPending}</div>
														</a></td>

													</tr>
												</c:if>


												<c:if test="${masterDet.lvStruvtPending!=0}">
													<tr>
														<td><a
															href="${pageContext.request.contextPath}/leaveStructureAllotment"
															class="text-white">
																<div>Assign Leave
																	Type:${masterDet.lvStruvtPending}</div>
														</a></td>

													</tr>
												</c:if>

												<c:if test="${masterDet.lvAuthPending!=0}">
													<tr>
														<td><a
															href="${pageContext.request.contextPath}/leaveAuthorityList"
															class="text-white">
																<div>Assign Leave
																	Structure:${masterDet.lvAuthPending}</div>
														</a></td>

													</tr>
												</c:if>



											</table>
										</div>
									</div>
								</div>

							</div>


						</div>

						<div></div>
						<!-- /highlighting rows and columns -->

					</div>
				</div>
			</div>

			<!-- /content area -->

			<%
				if (session.getAttribute("errorMsg") != null) {
			%>


			<%
				session.removeAttribute("errorMsg");
				}
			%>
			<%
				if (session.getAttribute("successMsg") != null) {
			%>

			<%
				session.removeAttribute("successMsg");
				}
			%>

			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
			<!-- /footer -->

		</div>
		<!-- /main content -->

	</div>
	<!-- /page content -->

</body>
</html>
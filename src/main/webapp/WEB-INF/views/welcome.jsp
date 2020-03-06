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

					<form action="${pageContext.request.contextPath}/dashboard">

						<div class="form-group row">
							<label class="col-form-label text-info font-weight-bold col-lg-2"
								for="dob">Date <span class="text-danger">*</span>:
							</label>
							<div class="col-lg-4">
								<input type="text" class="form-control datepickerclass"
									placeholder=" " id="fiterdate" name="fiterdate"
									value="${fiterdate}" autocomplete="off" onchange="trim(this)">
								<span class="hidedefault  validation-invalid-label"
									id="error_empDob" style="display: none;">This field is
									required.</span>
							</div>
							<div class="col-lg-2">
								<button type="submit" class="btn bg-blue ml-3 legitRipple"
									id="submtbtn">
									Submit <i class="icon-paperplane ml-2"></i>
								</button>
							</div>
						</div>

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
							<c:if test="${userType == 2}">

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



								</div>

							</c:if>
							<c:if test="${userType == 2 || isAuth >0 }">

								<div class="row">

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
												<h6 class="card-title">Today Leavs/Absent(Total:)</h6>

											</div>

											<div class="card-body">
												<div class="table-responsive">
													<table class="table text-nowrap">


														<c:forEach items="${deptWiseLvAbLList}"
															var="deptWiseLvAbLList" varStatus="count">
															<tr>

																<td><a href="#" class="text-white">
																		<div>${deptWiseLvAbLList.nameSd}</div>
																</a></td>


																<td><a href="#" class="text-white">
																		<div>${deptWiseLvAbLList.empCount}</div>
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
							</c:if>
							<c:if test="${userType == 2}">

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
							</c:if>


							<!--  -->

							<c:if test="${userType == 2 || isAuth > 0 }">

								<div class="row">
									<div class="col-md-4">
										<div class="card bg-primary">
											<div class="card-header header-elements-inline">
												<h6 class="card-title">My Attendance (Current Month)</h6>

											</div>

											<div class="card-body">
												<div class="table-responsive">
													<table class="table text-nowrap">

														<tr>

															<td><a href="#" class="text-white">
																	<div>Present</div>
															</a></td>


															<td><a href="#" class="text-white">
																	<div>${attnLastMon.presentDays}</div>
															</a></td>

														</tr>


														<tr>

															<td><a href="#" class="text-white">
																	<div>LWP Leaves</div>
															</a></td>


															<td><a href="#" class="text-white">
																	<div>${attnLastMon.unpaidLeave}</div>
															</a></td>

														</tr>


														<tr>

															<td><a href="#" class="text-white">
																	<div>Paid Leaves</div>
															</a></td>


															<td><a href="#" class="text-white">
																	<div>${attnLastMon.paidLeave}</div>
															</a></td>

														</tr>


													</table>
												</div>
											</div>
										</div>

									</div>

									<c:if test="${userType == 2}">
										<div class="col-md-4">
											<div class="card bg-primary">
												<div class="card-header header-elements-inline">
													<h6 class="card-title">Today's Task</h6>

												</div>

												<div class="card-body">
													<div class="table-responsive">
														<table class="table text-nowrap">

															<tr>

																<td><a href="#" class="text-white">
																		<div>Total Pending Application</div>
																</a></td>


																<td><a href="#" class="text-white">
																		<div>${list1Count}</div>
																</a></td>

															</tr>

														</table>
													</div>
												</div>
											</div>

										</div>
									</c:if>

								</div>
							</c:if>



							<div class="row">

								<div class="col-md-4">
									<div class="card bg-warning">
										<div class="card-header header-elements-inline">
											<h6 class="card-title">My Deductions</h6>

										</div>

										<div class="card-body">
											<div class="table-responsive">
												<table class="table text-nowrap">


													<c:forEach items="${dedWiseDedList}" var="dedWiseDedList"
														varStatus="count">
														<tr>

															<td><a href="#" class="text-white">
																	<div>${dedWiseDedList.nameSd}</div>
															</a></td>


															<td><a href="#" class="text-white">
																	<div>${dedWiseDedList.empCount}</div>
															</a></td>

														</tr>
													</c:forEach>


													<tr>

														<td><a href="#" class="text-white">
																<div>Total Advance</div>
														</a></td>


														<td><a href="#" class="text-white">
																<div>${icent.perfIncentive}</div>
														</a></td>

													</tr>


													<tr>

														<td><a href="#" class="text-white">
																<div>Total Loan</div>
														</a></td>


														<td><a href="#" class="text-white">
																<div>${icent.prodIncentive}</div>
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
											<h6 class="card-title">My Rewards</h6>

										</div>

										<div class="card-body">
											<div class="table-responsive">
												<table class="table text-nowrap">


													<c:forEach items="${rewardWiseDedList}"
														var="rewardWiseDedList" varStatus="count">
														<tr>

															<td><a href="#" class="text-white">
																	<div>${rewardWiseDedList.nameSd}</div>
															</a></td>


															<td><a href="#" class="text-white">
																	<div>${rewardWiseDedList.empCount}</div>
															</a></td>

														</tr>
													</c:forEach>


													<tr>

														<td><a href="#" class="text-white">
																<div>Performance Incentive(Amt/Days)</div>
														</a></td>


														<td><a href="#" class="text-white">
																<div>${perfList.prodAmt}/${perfList.prodDays}</div>
														</a></td>

													</tr>


													<tr>

														<td><a href="#" class="text-white">
																<div>Production Incentive(Amt/Days)</div>
														</a></td>


														<td><a href="#" class="text-white">
																<div>${prodList.prodAmt}/${prodList.prodDays}</div>
														</a></td>

													</tr>
												</table>
											</div>
										</div>
									</div>

								</div>


								<div class="col-md-4">
									<div class="card bg-primary">
										<div class="card-header header-elements-inline">
											<h6 class="card-title">Important Links</h6>

										</div>

										<div class="card-body">
											<div class="table-responsive">
												<table class="table text-nowrap">

													<tr>

														<td><a
															href="${pageContext.request.contextPath}/showApplyForLeave"
															class="text-white">
																<div>Apply Leave</div>
														</a></td>

													</tr>


													<c:if test="${isAuth > 0 || userType==2}">

														<tr>
															<td><a
																href="${pageContext.request.contextPath}//viewPayDeduction"
																class="text-white">
																	<div>Pay Deduction</div>
															</a></td>
														</tr>
														<tr>
															<td><a
																href="${pageContext.request.contextPath}/viewEmpRewarAddList"
																class="text-white">
																	<div>Add Reward</div>
															</a></td>
														</tr>
														<tr>
															<td><a
																href="${pageContext.request.contextPath}/showEmpListToAddAdvance"
																class="text-white">
																	<div>Add Advance</div>
															</a></td>

														</tr>
														<tr>
															<td><a
																href="${pageContext.request.contextPath}/showEmpListToAddLoan"
																class="text-white">
																	<div>Add Loan</div>
															</a></td>




														</tr>


														<c:if test="${userType==2}">
															<tr>
																<td><a
																	href="${pageContext.request.contextPath}/attendanceSelectMonth"
																	class="text-white">
																		<div>Upload Attendence</div>
																</a></td>

															</tr>


															<tr>
																<td><a href="#" class="text-white">
																		<div>Add OT Hour</div>
																</a></td>

															</tr>
														</c:if>
													</c:if>
												</table>
											</div>
										</div>
									</div>

								</div>

							</div>

							<!-- HR Dash  -->

							<c:if test="${userType ==2}">
								<div class="row">


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


									<div class="col-md-4">
										<div class="card bg-warning">
											<div class="card-header header-elements-inline">
												<h6 class="card-title">Performance Bonus (Current
													Month)</h6>

											</div>
											<div class="card-body">
												<div class="table-responsive">
													<table class="table text-nowrap">

														<c:forEach items="${perfListDept}" var="perfListDept"
															varStatus="count">

															<tr>

																<td><a href="#" class="text-white">
																		<div>${perfListDept.nameSd}</div>
																</a></td>


																<td><a href="#" class="text-white">
																		<div>${perfListDept.empCount}</div>
																</a></td>

															</tr>
														</c:forEach>

													</table>
												</div>
											</div>
										</div>

									</div>





								</div>
							</c:if>
							<!--Leave Details -->

							<div class="row">
								<div class="col-md-12">
									<div class="table-responsive">
										<table
											class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
											id="printtable22">


											<thead>
												<tr class="bg-blue">

													<th>Leave Type</th>
													<th>Opening Leave</th>
													<th>Earned</th>
													<th>Approved</th>
													<th>Applied</th>
													<th>Balanced</th>


												</tr>
											</thead>
											<tbody>
												<c:forEach items="${leaveHistoryList}"
													var="leaveHistoryList">


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

								</div>
								<!--Leave History -->
							</div>

							<div class="row">
								<div class="col-md-12">
									<div class="table-responsive">
										<table
											class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
											id="printtable11">


											<thead>
												<tr class="bg-blue">

													<th>Sr. No.</th>
													<th>Leave Type</th>
													<th>Dates</th>
													<th>Days</th>
													<th>Remark</th>
													<th>Status</th>


												</tr>
											</thead>
											<tbody>
												<c:forEach items="${lvApplList}" var="lvApplList"
													varStatus="count">



													<tr>
														<td>${count.index+1}</td>
														<td>${lvApplList.lvTitleShort}</td>
														<td>${lvApplList.leaveFromdt}to
															${lvApplList.leaveTodt}</td>
														<td style="text-align: right;">${lvApplList.leaveNumDays}</td>


														<td>${lvApplList.leaveEmpReason}</td>
														<td>${lvApplList.exInt1==1 ? 'Applied': lvApplList.exInt1==7 ? 'cancelled by employee': lvApplList.exInt1==2 ? ' ia approval' : lvApplList.exInt1==8 ? 'ia reject' : lvApplList.exInt1==3 ? 'fa approval & leave confirmed' :lvApplList.exInt1==9 ? 'fa reject'   : ''}</td>

													</tr>


												</c:forEach>




											</tbody>
										</table>
									</div>
								</div>
							</div>
							<c:if test="${userType ==2}">

								<div class="row">
									<div class="col-md-12">
										<div class="card bg-primary">
											<div class="card-header header-elements-inline">
												<h6 class="card-title">Employee Diversity Report</h6>

											</div>

											<div class="card-body">

												<div class="row">
													<div class="col-md-3">Gender</div>
													<div class="col-md-3">Age</div>
													<div class="col-md-3">Experience</div>
													<div class="col-md-3">Salary</div>
												</div>


												<div class="row">
													<div class="col-md-3">
														Male:${ageDiv.maleEmp} <br>
														Female:${ageDiv.femaleEmp} <br>
														Other:${ageDiv.othEmp} <br>------<br>
														<c:forEach items="${deptWiseEmpCntList}"
															var="deptWiseEmpCntList" varStatus="count">
															<c:if test="${deptWiseEmpCntList.empCount >0}">
 													
													 ${deptWiseEmpCntList.nameSd}:   ${deptWiseEmpCntList.empCount}
													 
													 
													 <br>
															</c:if>

														</c:forEach>

													</div>
													<div class="col-md-3">

														18-20: ${ageDiversity.ageRange1}<br> 21-25:
														${ageDiversity.ageRange2}<br> 26-30:
														${ageDiversity.ageRange3}<br> 31-35:
														${ageDiversity.ageRange5}<br> 36-40:
														${ageDiversity.ageRange6}<br> 41-45:
														${ageDiversity.ageRange7}<br> 46-50:
														${ageDiversity.ageRange8}<br> 51-55:
														${ageDiversity.ageRange9}<br> 56-60:
														${ageDiversity.ageRange10}<br> 60-65:
														${ageDiversity.ageRange11}<br>

													</div>
													<div class="col-md-3">

														0 Year: ${expDiversity.ageRange1}<br> 1
														Year:${expDiversity.ageRange2}<br> 2
														Year:${expDiversity.ageRange3}<br> 5
														Year:${expDiversity.ageRange4}<br> 10
														Year:${expDiversity.ageRange5}<br> 10+ :
														${expDiversity.ageRange6}<br>

													</div>
													<div class="col-md-3">
														up to 10000 : ${salDiversity.ageRange1}<br>
														10000-20000: ${salDiversity.ageRange2}<br>
														21000-30000: ${salDiversity.ageRange3}<br>

														31000-40000:${salDiversity.ageRange4}<br>
														41000-50000: ${salDiversity.ageRange5}<br>
														51000-60000: ${salDiversity.ageRange6}<br>
														61000-70000 : ${salDiversity.ageRange7}<br>
														71000-80000: ${salDiversity.ageRange8}<br>
														81000-9000: ${salDiversity.ageRange9}<br>
														91000-100000: ${salDiversity.ageRange10}<br>
													</div>
												</div>
											</div>
										</div>
									</div>

								</div>
							</c:if>

						</div>
						<!-- /highlighting rows and columns -->
					</form>
				</div>
			</div>

			<!-- /content area -->

			<script type="text/javascript">
				$(document).ready(
						function($) {

							//btn_go_next_tab
							$(".btn_go_next_tab").click(
									function(e) {
										$('.nav-tabs > .nav-item > .active')
												.parent().next('li').find('a')
												.trigger('click');

									});
							$(".btn_go_prev_tab").click(
									function(e) {
										$('.nav-tabs > .nav-item > .active')
												.parent().prev('li').find('a')
												.trigger('click');

									});

						});
				// Single picker
				/* $('#leaveDate').daterangepicker({
				    "autoUpdateInput": false,
					singleDatePicker : true,
					selectMonths : true,
					selectYears : true,
					locale : {
						format : 'DD-MM-YYYY'
					}
				}, function (start_date) {
				    $('#leaveDate').val(start_date.format('DD-MM-YYYY'));
				}); */
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
			</script>
			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
			<!-- /footer -->

		</div>
		<!-- /main content -->

	</div>
	<!-- /page content -->

</body>
</html>
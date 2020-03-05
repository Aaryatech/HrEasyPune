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

							<!-- HR Dash  -->

							<div class="row">
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
								<div class="col-md-4">
									<div class="card bg-warning">
										<div class="card-header header-elements-inline">
											<h6 class="card-title">Performance Bonus (Current Month)</h6>

										</div>

										<div class="card-body">
											<div class="table-responsive">
												<table class="table text-nowrap">


													<c:forEach items="${perfList}" var="perfList"
														varStatus="count">
														<tr>

															<td><a href="#" class="text-white">
																	<div>${perfList.nameSd}</div>
															</a></td>


															<td><a href="#" class="text-white">
																	<div>${perfList.empCount}</div>
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
							</div>
							<!--Leave Details -->

							<div class="row">
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


								<!--Leave History -->
							</div>

							<div class="row">
								<div class="table-responsive">
									<table
										class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
										id="printtable1">


										<thead>
											<tr class="bg-blue" style="text-align: center;">

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

						<div></div>
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
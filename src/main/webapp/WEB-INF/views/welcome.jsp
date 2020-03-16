<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
<link
	href="${pageContext.request.contextPath}/resources/assets/css/dashboard.css"
	rel="stylesheet" type="text/css">
	

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
			<!-- <div class="card">


				<div class="card-header header-elements-inline"></div>

				<div class="card-body">
					<h6>Dashboard</h6>
				</div>

			</div>-->
			<div class="content">


				<!-- Highlighting rows and columns -->
				<div class="card">

					<form action="${pageContext.request.contextPath}/dashboard">
						<div class="card-body">
							<div class="form-group row title_row">
								<label
									class="col-form-label text-info font-weight-bold col-lg-2"
									for="dob">Date <span class="text-danger">*</span>:
								</label>
								<div class="col-lg-4">
									<input type="text" class="form-control datepickerclass"
										placeholder=" " id="fiterdate" name="fiterdate"
										value="${fiterdate}" autocomplete="off" onchange1="trim(this)">
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
						</div>
						<div class="card-body fixed_height">

							<div class="row">
								<div class="col-md-4">
									<div class="card bg-primary">
										<div class="card-header header-elements-inline">
											<h6 class="card-title dash_title">Today's Birthday</h6>

										</div>

										<div class="card-body white_bg">
										
											<div class="dashboard_bx">
												<c:forEach items="${birth.birthListToday}" var="birth" varStatus="count">
												<div class="dashboard_one">
													
	<div class="dashboard_single"><a href="#" class="text-white"><i class="icon-gift "> [${birth.empCode}]${birth.name}</i></a></div>
													
													
												</div>
												</c:forEach>
											</div>
											
																				
												
										</div>
									</div>

								</div>

								<div class="col-md-4">
									<div class="card bg-purple-300 text-white">
										<div class="card-header header-elements-inline">
											<h6 class="card-title dash_title">Upcomming Birthday(next 7 days)</h6>

										</div>

										<div class="card-body white_bg">
											<div class="dashboard_bx">
												<c:forEach items="${birth.birthListUpcoming}" var="birth" varStatus="count">
												<div class="dashboard_one">
													
	<div class="dashboard_single"><a href="#" class="text-white"><i class="icon-gift "> [${birth.empCode}] ${birth.name}</i></a></div>
													
													
												</div>
												</c:forEach>
											</div>
											
											
										</div>
									</div>



								</div>

								<div class="col-md-4">
									<div class="card bg-warning">
										<div class="card-header header-elements-inline">
											<h6 class="card-title dash_title">Upcoming Holidays (next 30 days)</h6>

										</div>

										<div class="card-body white_bg">
											
											<div class="dashboard_bx">
												<c:forEach items="${birth.holiList}" var="birth" varStatus="count">
												<div class="dashboard_one">													
													<div class="dashboard_l"><a href="#" class="text-white">${birth.holidayName}</a></div>
													<div class="dashboard_r"><a href="#" class="text-white">${birth.holidayDate}</a></div>
													<div class="clr"></div>													
												</div>
												</c:forEach>
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
												<h6 class="card-title dash_title">New Hires (Past 30 days)</h6>

											</div>

											<div class="card-body white_bg">
												<div class="table-responsive">
												
												<div class="dashboard_bx">												
													<div class="dashboard_one">													
														<div class="dashboard_l"><a href="#" class="text-white">Total</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${newHire.maleEmp+newHire.femaleEmp+newHire.othEmp}</a></div>
														<div class="clr"></div>													
													</div>
													
													<div class="dashboard_one">													
														<div class="dashboard_l"><a href="#" class="text-white">Male</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${newHire.maleEmp}</a></div>
														<div class="clr"></div>													
													</div>
													
													<div class="dashboard_one">													
														<div class="dashboard_l"><a href="#" class="text-white">Female</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${newHire.femaleEmp}</a></div>
														<div class="clr"></div>													
													</div>
													
													<div class="dashboard_one">													
														<div class="dashboard_l"><a href="#" class="text-white">Other</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${newHire.othEmp}</a></div>
														<div class="clr"></div>													
													</div>												
												</div>
													
												</div>
											</div>
										</div>

									</div>

									<div class="col-md-4">
										<div class="card bg-purple-300 text-white">
											<div class="card-header header-elements-inline">
												<h6 class="card-title dash_title">Leave Application Pending</h6>

											</div>

											<div class="card-body white_bg">
											
												<div class="dashboard_bx">												
													<div class="dashboard_one">													
														<div class="dashboard_l"><a href="#" class="text-white">New Application</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${lvDet.newApp}</a></div>
														<div class="clr"></div>													
													</div>
													
													<div class="dashboard_one">													
														<div class="dashboard_l"><a href="#" class="text-white">Initial Authority Pending/Approved</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${lvDet.newApp}/${lvDet.finalPending}</a></div>
														<div class="clr"></div>													
													</div>
													
													<div class="dashboard_one">													
														<div class="dashboard_l"><a href="#" class="text-white">Final Authority Pending</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${lvDet.finalPending}</a></div>
														<div class="clr"></div>													
													</div>
												</div>
											
												
											</div>
										</div>



									</div>



									<div class="col-md-4">
										<div class="card bg-primary">
											<div class="card-header header-elements-inline">
												<h6 class="card-title dash_title">Attendance Previous Day(Date:
													${attnDet.attnDate})</h6>

											</div>

											<div class="card-body white_bg">											
												
												
													<div class="dashboard_bx">
														<div class="dashboard_one">
															<div class="dashboard_l"><a href="#" class="text-white">Total Emp</a></div>
															<div class="dashboard_r"><a href="#" class="text-white">${attnDet.preEmp+attnDet.lvEmp+attnDet.woEmp+attnDet.absentEmp}</a></div>
															<div class="clr"></div>
														</div>
													
													
													
														<div class="dashboard_one">
															<div class="dashboard_l"><a href="#" class="text-white">Present</a></div>
															<div class="dashboard_r"><a href="#" class="text-white">${attnDet.preEmp}</a></div>
															<div class="clr"></div>
														</div>
													
													
													
														<div class="dashboard_one">
															<div class="dashboard_l"><a href="#" class="text-white">Leave</a></div>
															<div class="dashboard_r"><a href="#" class="text-white">${attnDet.lvEmp}</a></div>
															<div class="clr"></div>
														</div>
													
													
													
														<div class="dashboard_one">
															<div class="dashboard_l"><a href="#" class="text-white">Weekly Off Taken</a></div>
															<div class="dashboard_r"><a href="#" class="text-white">${attnDet.woEmp}</a></div>
															<div class="clr"></div>
														</div>
													
													
													
														<div class="dashboard_one">
															<div class="dashboard_l"><a href="#" class="text-white">Absent</a></div>
															<div class="dashboard_r"><a href="#" class="text-white">${attnDet.absentEmp}</a></div>
															<div class="clr"></div>
														</div>
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
												<h6 class="card-title dash_title">Pay Deduction (Current Month)</h6>

											</div>

											<div class="card-body white_bg">
												<div class="dashboard_bx">
													<div class="dashboard_one">
														<div class="dashboard_l"><a href="#" class="text-white">Total Emp/amount</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${dedDet.empCount}/${dedDet.tot}</a></div>
														<div class="clr"></div>
													</div>
												</div>												

											</div>
										</div>



									</div>



									<div class="col-md-4">
										<div class="card bg-warning">
											<div class="card-header header-elements-inline">
												<h6 class="card-title dash_title">Today Leavs/Absent(Total:)</h6>

											</div>

											<div class="card-body white_bg">
												<div class="dashboard_bx">
													<c:forEach items="${deptWiseLvAbLList}" var="deptWiseLvAbLList" varStatus="count">
													<div class="dashboard_one">
														<div class="dashboard_l"><a href="#" class="text-white">${deptWiseLvAbLList.nameSd}</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${deptWiseLvAbLList.empCount}</a></div>
														<div class="clr"></div>
													</div>
													</c:forEach>
												</div>											
											
												
											</div>
										</div>

									</div>



									<div class="col-md-4">
										<div class="card bg-warning">
											<div class="card-header header-elements-inline">
												<h6 class="card-title dash_title">Today Weekly Off(Total:)</h6>

											</div>

											<div class="card-body white_bg">
											
												<div class="dashboard_bx">
													<c:forEach items="${deptwiseWkoff}" var="deptwiseWkoff" varStatus="count">
													<div class="dashboard_one">
														<div class="dashboard_l"><a href="#" class="text-white">${deptwiseWkoff.nameSd}</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${deptwiseWkoff.empCount}</a></div>
														<div class="clr"></div>
													</div>
													</c:forEach>
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
												<h6 class="card-title dash_title">Advance Deduction (Current Moth)</h6>

											</div>

											<div class="card-body white_bg">
											
												<div class="dashboard_bx">
													
													<div class="dashboard_one">
														<div class="dashboard_l"><a href="#" class="text-white">Total Emp/amount</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${advDet.emp}/${advDet.advTot}</a></div>
														<div class="clr"></div>
													</div>
													
													<div class="dashboard_one">
														<div class="dashboard_l"><a href="#" class="text-white">Total Skip Emp/Amt</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${advDet.skipId}/${advDet.skipTott}</a></div>
														<div class="clr"></div>
													</div>
													
												</div>
																						
												
											</div>
										</div>

									</div>

									<div class="col-md-4">
										<div class="card bg-purple-300 text-white">
											<div class="card-header header-elements-inline">
												<h6 class="card-title dash_title">Loan Deduction (Current Moth)</h6>

											</div>

											<div class="card-body white_bg">
												<div class="dashboard_bx">													
													<div class="dashboard_one">
														<div class="dashboard_l"><a href="#" class="text-white">Total Emp/amount</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${loanDet.emp}/${loanDet.advTot}</a></div>
														<div class="clr"></div>
													</div>
													
													<div class="dashboard_one">
														<div class="dashboard_l"><a href="#" class="text-white">Total Skip Emp/Amt</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${loanDet.skipId}/${loanDet.skipTott}</a></div>
														<div class="clr"></div>
													</div>
												</div>	

											</div>
										</div>



									</div>

									<div class="col-md-4">
										<div class="card bg-warning">
											<div class="card-header header-elements-inline">
												<h6 class="card-title">Pending Master one time</h6>

											</div>

											<div class="card-body white_bg">
												<div class="table-responsive">
												
													<div class="dashboard_bx">	
													<c:if test="${masterDet.companyCount==0}">												
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/companySubAdd"
																	class="text-white"> Add Company:0</a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.emptypeCount==0}">											
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/mstEmpTypeAdd"
																	class="text-white"> Add Emp Type:0 </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.locCount==0}">									
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/locationAdd"
																	class="text-white"> Add Location:0 </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.desnCount==0}">									
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/dsesignationAdd"
																	class="text-white"> Add Designation:0 </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.deptCount==0}">							
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/departmentAdd"
																	class="text-white"> Add Department:0 </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.hoCount==0}">						
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/holidayAdd"
																	class="text-white"> Add Holiday:0 </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.hocatCount==0}">					
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/holidayCategoryAdd"
																	class="text-white"> Add Holiday Cat:0 </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.wocatCount==0}">				
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/weekoffCategoryAdd"
																	class="text-white"> Add Weekly off Cat:0 </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.shiftCount==0}">				
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/addShift"
																	class="text-white"> Add Shift:0 </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.lvtypeCount==0}">				
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/leaveTypeAdd"
																	class="text-white"> Add Leave Type:0 </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.lvstructCount==0}">			
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/addLeaveStructure"
																	class="text-white"> Add Leave Structure:0 </a>
													</div>
													</c:if>
													
													<!--Pending  -->
													
													<c:if test="${masterDet.compPending!=0}">			
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/assignSubCompany"
																	class="text-white"> Assign Company:${masterDet.compPending} </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.typePending!=0}">		
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/showAssignEmpType"
																	class="text-white"> Assign Emp Type:${masterDet.typePending} </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.locPending!=0}">	
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/showAssignLocation"
																	class="text-white">
																		Assign Location:${masterDet.locPending} </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.desnPending!=0}">
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/showAssignDesignation"
																	class="text-white"> Assign Designation:${masterDet.desnPending}
																</a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.deptPending!=0}">
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/assignDept"
																	class="text-white">
																		Assign Department:${masterDet.deptPending}
																</a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.hocatPending!=0}">
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}//assignHolidayCategory"
																	class="text-white">
																		Assign Holiday:${masterDet.hocatPending}
																</a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.wocatPending!=0}">
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/assignWeekoffCategory"
																	class="text-white">
																		Assign Weekly off
																			Cat:${masterDet.wocatPending}
																</a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.shiftPending!=0}">
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/showEmpListToAssignShift"
																	class="text-white">
																		Assign Shift:${masterDet.shiftPending}
																</a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.lvStruvtPending!=0}">
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/leaveStructureAllotment"
																	class="text-white"> Assign Leave Type:${masterDet.lvStruvtPending} </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.lvAuthPending!=0}">
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/leaveAuthorityList"
																	class="text-white"> Assign Leave
																			Structure:${masterDet.lvAuthPending}
																</a>
													</div>
													</c:if>
													
													</div>
												</div>
											</div>
										</div>

									</div>


								</div>
							</c:if>


							<c:if test="${userType == 2 || isAuth > 0 }">

								<div class="row">
									<div class="col-md-4">
										<div class="card bg-primary">
											<div class="card-header header-elements-inline">
												<h6 class="card-title dash_title">My Attendance (Current Month)</h6>

											</div>

											<div class="card-body white_bg">
											
												<div class="dashboard_bx">													
													<div class="dashboard_one">
														<div class="dashboard_l"><a href="#" class="text-white">Present</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${attnLastMon.presentDays}</a></div>
														<div class="clr"></div>
													</div>
													
													<div class="dashboard_one">
														<div class="dashboard_l"><a href="#" class="text-white">LWP Leaves</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${attnLastMon.unpaidLeave}</a></div>
														<div class="clr"></div>
													</div>
													
													<div class="dashboard_one">
														<div class="dashboard_l"><a href="#" class="text-white">Paid Leaves</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${attnLastMon.paidLeave}</a></div>
														<div class="clr"></div>
													</div>
												</div>	
												
											</div>
										</div>

									</div>

									<c:if test="${userType == 2}">
										<div class="col-md-4">
											<div class="card bg-primary">
												<div class="card-header header-elements-inline">
													<h6 class="card-title dash_title">Today's Task</h6>

												</div>

												<div class="card-body white_bg">
													<div class="dashboard_bx">													
														<div class="dashboard_one">
															<div class="dashboard_l"><a href="#" class="text-white">Total Pending Application</a></div>
															<div class="dashboard_r"><a href="#" class="text-white">${list1Count}</a></div>
															<div class="clr"></div>
														</div>
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
											<h6 class="card-title dash_title">My Deductions</h6>

										</div>

										<div class="card-body white_bg">
										
											<div class="dashboard_bx">	
												<c:forEach items="${dedWiseDedList}" var="dedWiseDedList" varStatus="count">												
												<div class="dashboard_one">
													<div class="dashboard_l"><a href="#" class="text-white">${dedWiseDedList.nameSd}</a></div>
													<div class="dashboard_r"><a href="#" class="text-white">${dedWiseDedList.empCount}</a></div>
													<div class="clr"></div>
												</div>
												</c:forEach>
												
												<div class="dashboard_one">
													<div class="dashboard_l"><a href="#" class="text-white">Total Advance</a></div>
													<div class="dashboard_r"><a href="#" class="text-white">${icent.perfIncentive}</a></div>
													<div class="clr"></div>
												</div>
												
												<div class="dashboard_one">
													<div class="dashboard_l"><a href="#" class="text-white">Total Loan</a></div>
													<div class="dashboard_r"><a href="#" class="text-white">${icent.prodIncentive}</a></div>
													<div class="clr"></div>
												</div>
											</div>
										
											
										</div>
									</div>

								</div>


								<div class="col-md-4">
									<div class="card bg-warning">
										<div class="card-header header-elements-inline">
											<h6 class="card-title dash_title">My Rewards</h6>

										</div>

										<div class="card-body white_bg">
										
											<div class="dashboard_bx">	
												<c:forEach items="${rewardWiseDedList}"
														var="rewardWiseDedList" varStatus="count">	
												<div class="dashboard_one">
													<div class="dashboard_l"><a href="#" class="text-white">${rewardWiseDedList.nameSd}</a></div>
													<div class="dashboard_r"><a href="#" class="text-white">${rewardWiseDedList.empCount}</a></div>
													<div class="clr"></div>
												</div>
												</c:forEach>
												
												<div class="dashboard_one">
													<div class="dashboard_l"><a href="#" class="text-white">Performance Incentive(Amt/Days)</a></div>
													<div class="dashboard_r"><a href="#" class="text-white">${perfList.prodAmt}/${perfList.prodDays}</a></div>
													<div class="clr"></div>
												</div>
												
												<div class="dashboard_one">
													<div class="dashboard_l"><a href="#" class="text-white">Production Incentive(Amt/Days)</a></div>
													<div class="dashboard_r"><a href="#" class="text-white">${prodList.prodAmt}/${prodList.prodDays}</a></div>
													<div class="clr"></div>
												</div>
												
												</div>
										
											
										</div>
									</div>

								</div>


								<div class="col-md-4">
									<div class="card bg-primary">
										<div class="card-header header-elements-inline">
											<h6 class="card-title dash_title">Important Links</h6>

										</div>

										<div class="card-body white_bg">
											<div class="dashboard_bx">
												<div class="dashboard_single">
													<a href="${pageContext.request.contextPath}/showApplyForLeave"
															class="text-white"> Apply Leave </a>
												</div>
												
												<c:if test="${isAuth > 0 || userType==2}">
												
												<div class="dashboard_single">
													<a href="${pageContext.request.contextPath}//viewPayDeduction"
																class="text-white"> Pay Deduction</a>
												</div>
												<div class="dashboard_single">
													<a href="${pageContext.request.contextPath}/viewEmpRewarAddList"
																class="text-white"> Add Reward </a>
												</div>
												<div class="dashboard_single">
													<a href="${pageContext.request.contextPath}/showEmpListToAddAdvance"
																class="text-white"> Add Advance </a>
												</div>
												
												<div class="dashboard_single">
													<a href="${pageContext.request.contextPath}/showEmpListToAddLoan"
																class="text-white"> Add Loan </a>
												</div>
												
												<c:if test="${userType==2}">
												<div class="dashboard_single">
													<a href="${pageContext.request.contextPath}/attendanceSelectMonth"
																	class="text-white"> Upload Attendence </a>
												</div>
												</c:if>
												<div class="dashboard_single">
													<a href="#" class="text-white"> Add OT Hour </a>
												</div>
												
												
												</c:if>
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
												<h6 class="card-title dash_title">Reward (Current Month)</h6>

											</div>

											<div class="card-body white_bg">
											
												<div class="dashboard_bx">													
													<div class="dashboard_one">
														<div class="dashboard_l"><a href="#" class="text-white">Total Emp/amount</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${rewardDet.empCount}/${rewardDet.tot}</a></div>
														<div class="clr"></div>
													</div>
												</div>
											
												
											</div>
										</div>

									</div>


									<div class="col-md-4">
										<div class="card bg-warning">
											<div class="card-header header-elements-inline">
												<h6 class="card-title dash_title">Performance Bonus (Current
													Month)</h6>

											</div>
											<div class="card-body white_bg">
												
												<div class="dashboard_bx">	
													<c:forEach items="${perfListDept}" var="perfListDept" varStatus="count">
																									
													<div class="dashboard_one">
														<div class="dashboard_l"><a href="#" class="text-white">${perfListDept.nameSd}</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${perfListDept.empCount}</a></div>
														<div class="clr"></div>
													</div>
													</c:forEach>													
												</div>
											
											
											
												
											</div>
										</div>

									</div>





								</div>
							</c:if>
							<!--Leave Details -->

							<div class="row">
								<div class="col-md-12">
									<div class="table-responsive marg_btm">
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
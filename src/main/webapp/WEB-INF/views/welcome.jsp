<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<!-- <link href="https://fonts.googleapis.com/css2?family=Grandstander&display=swap" rel="stylesheet"> -->
<!-- font-family: 'Grandstander', cursive; -->
<c:url var="getdeptwiseEmp" value="/getdeptwiseEmp" />
<c:url var="totalOtPrevioussixMonth" value="/totalOtPrevioussixMonth" />
<link
	href="https://fonts.googleapis.com/css2?family=Lobster&display=swap"
	rel="stylesheet">
<style type="text/css">
.birthday-bg {
	background:
		url(${pageContext.request.contextPath}/resources/global_assets/images/birthday_bg.jpg)
		no-repeat center top;
	background-size: cover;
	padding: 50px 20px;
	text-align: center;
	/* border-radius: 5px;
	font-size: 36px;
	color: #FFF;
	
	text-shadow: 0px 6px 10px rgba(0, 0, 0, 0.6);
	animation: color-change 1s infinite; */
	position: relative;
}

.birthday-bg:after {
	content: '';
	position: absolute;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background: rgba(220, 0, 112, 0.7);
}

.birthday-bg span {
	position: relative;
	z-index: 10;
}

/* @
keyframes color-change { 0% {
	color: #fac307;
}
50%
{
color
#FFF
;
}
100%
{
color
#fac307
;
}
} */

/*
blue color code : #01bcf3 #0089c2;
purple color : #7200a9    #8317c2;
Yellow color : #d7ac00    #ffd709;
Green Color : #007c24     #07a43d
*/
</style>
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
			<!-- <div class="card">


				<div class="card-header header-elements-inline"></div>

				<div class="card-body">
					<h6>Dashboard</h6>
				</div>

			</div>-->
			<div class="content">
				<c:if test="${toDayIsBirthday ==1}">
					<div class="row">
						<div class="col-md-12">
							<div class="card">
								<div class="row">
									<div class="col-md-12">
										<!-- <div class="element"> <i class="fa fa-birthday-cake" aria-hidden="true"></i> Wish You a very very happy returns of the day Dude... </div>  -->
										<div class="birthday-bg">
											<span class="element">Wish you Happy Birthday
												${sessionScope.userInfo.firstName}..!!! </span>
										</div>
									</div>
									<!--Leave History -->
								</div>
							</div>
						</div>
					</div>
				</c:if>
				<c:if test="${userType ==2}">
					<!-- new html start here -->
					<div class="row">
						<div class="col-lg-8">
							<div class="card">
								<div class="tab_round">
									<div class="row">
										<div class="col-lg-3">
											<div class="shift_round bg-purple-300">
												<div class="round_size">
													<span>980</span> Present Employee
												</div>
											</div>
										</div>
										<div class="col-lg-3">
											<div class="shift_round bg-pink-400"">
												<div class="round_size">
													<span>32</span> Late Employee
												</div>
											</div>
										</div>
										<div class="col-lg-3">
											<div class="shift_round bg-warning">
												<div class="round_size">
													<span>11</span> Leave Employee
												</div>
											</div>
										</div>
										<div class="col-lg-3">
											<div class="shift_round bg-primary">
												<div class="round_size">
													<span>26</span> Absent Employee
												</div>
											</div>
										</div>
									</div>


									<!-- Late Employee tab start here -->
									<div class="row">
										<div class="late_employee">
											<!-- <h3 class="bg-pink-400 employee_title">Late Employee</h3> -->

											<div class="late_one fix_scroll">

												<div class="datatable-scroll-wrap">
													<table
														class="table table-bordered table-hover datatable-highlight1">
														<thead>
															<tr class="bg-pink-400" role="row">
																<th class="sorting_desc">Employee Name</th>
																<th class="sorting">Department</th>
																<th class="sorting">Late Minutes</th>
																<th class="sorting">Monthly Latemark</th>
															</tr>
														</thead>
														<tbody>


															<tr role="row" class="odd">
																<td><a href="#" data-toggle="modal"
																	onclick="getEmpData(82,1)">AKSHAY MADHUKAR
																		RAOANDORE</a></td>
																<td>Development</td>
																<td>20 Minutes</td>
																<td>234 Minutes</td>
															</tr>
															<tr role="row" class="odd">
																<td><a href="#" data-toggle="modal"
																	onclick="getEmpData(82,2)">AKSHAY MADHUKAR
																		RAOANDORE</a></td>
																<td>Development</td>
																<td>20 Minutes</td>
																<td>234 Minutes</td>
															</tr>
															<tr role="row" class="odd">
																<td>AKSHAY MADHUKAR RAOANDORE</td>
																<td>Development</td>
																<td>20 Minutes</td>
																<td>234 Minutes</td>
															</tr>
															<tr role="row" class="odd">
																<td>AKSHAY MADHUKAR RAOANDORE</td>
																<td>Development</td>
																<td>20 Minutes</td>
																<td>234 Minutes</td>
															</tr>
															<tr role="row" class="odd">
																<td>AKSHAY MADHUKAR RAOANDORE</td>
																<td>Development</td>
																<td>20 Minutes</td>
																<td>234 Minutes</td>
															</tr>
														</tbody>
													</table>
												</div>

											</div>

										</div>
									</div>

									<!-- Leave Employee tab start here -->
									<div class="row" style="display: none;">
										<div class="late_employee">

											<div class="late_one fix_scroll">

												<div class="datatable-scroll-wrap">
													<table
														class="table table-bordered table-hover datatable-highlight1">
														<thead>
															<tr class="bg-warning" role="row">
																<th class="sorting_desc">Employee Name</th>
																<th class="sorting">Department</th>
																<th class="sorting">Todate</th>
																<th class="sorting">Balance Leaves</th>
															</tr>
														</thead>
														<tbody>


															<tr role="row" class="odd">
																<td>AKSHAY MADHUKAR RAOANDORE</td>
																<td>Development</td>
																<td>19 - 03 - 2020</td>
																<td>12 Leave</td>
															</tr>

															<tr role="row" class="odd">
																<td>AKSHAY MADHUKAR RAOANDORE</td>
																<td>Development</td>
																<td>19 - 03 - 2020</td>
																<td>15 Leave</td>
															</tr>

															<tr role="row" class="odd">
																<td>AKSHAY MADHUKAR RAOANDORE</td>
																<td>Development</td>
																<td>19 - 03 - 2020</td>
																<td>08 Leave</td>
															</tr>

															<tr role="row" class="odd">
																<td>AKSHAY MADHUKAR RAOANDORE</td>
																<td>Development</td>
																<td>19 - 03 - 2020</td>
																<td>02 Leave</td>
															</tr>

															<tr role="row" class="odd">
																<td>AKSHAY MADHUKAR RAOANDORE</td>
																<td>Development</td>
																<td>19 - 03 - 2020</td>
																<td>01 Leave</td>
															</tr>

														</tbody>
													</table>
												</div>

											</div>

										</div>
									</div>

									<!-- Absent Employee tab start here -->
									<div class="row" style="display: none;">
										<div class="late_employee">

											<div class="late_one fix_scroll">

												<div class="datatable-scroll-wrap">
													<table
														class="table table-bordered table-hover datatable-highlight1">
														<thead>
															<tr class="bg-primary" role="row">
																<th class="sorting_desc">Employee Name</th>
																<th class="sorting">Department</th>
																<th class="sorting">Todate</th>
																<th class="sorting">Balance Leaves</th>
															</tr>
														</thead>
														<tbody>


															<tr role="row" class="odd">
																<td>AKSHAY MADHUKAR RAOANDORE</td>
																<td>Development</td>
																<td>19- 03 - 2020</td>
																<td>12 Leave</td>
															</tr>

															<tr role="row" class="odd">
																<td>AKSHAY MADHUKAR RAOANDORE</td>
																<td>Development</td>
																<td>19 - 03 - 2020</td>
																<td>15 Leave</td>
															</tr>

															<tr role="row" class="odd">
																<td>AKSHAY MADHUKAR RAOANDORE</td>
																<td>Development</td>
																<td>19 - 03 - 2020</td>
																<td>08 Leave</td>
															</tr>

															<tr role="row" class="odd">
																<td>AKSHAY MADHUKAR RAOANDORE</td>
																<td>Development</td>
																<td>19 - 03 - 2020</td>
																<td>02 Leave</td>
															</tr>

															<tr role="row" class="odd">
																<td>AKSHAY MADHUKAR RAOANDORE</td>
																<td>Development</td>
																<td>19 - 03 - 2020</td>
																<td>01 Leave</td>
															</tr>

														</tbody>
													</table>
												</div>

											</div>

										</div>
									</div>

									<!-- Present Employee tab start here -->
									<div class="row" style="display: none;">
										<div class="late_employee">

											<div class="late_one fix_scroll">

												<div class="datatable-scroll-wrap">
													<table
														class="table table-bordered table-hover datatable-highlight1">
														<thead>
															<tr class="bg-purple-300" role="row">
																<th class="sorting_desc">Employee Name</th>
																<th class="sorting">Department</th>
																<th class="sorting">Todate</th>
																<th class="sorting">Balance Leaves</th>
															</tr>
														</thead>
														<tbody>


															<tr role="row" class="odd">
																<td>AKSHAY MADHUKAR RAOANDORE</td>
																<td>Development</td>
																<td>19- 03 - 2020</td>
																<td>12 Leave</td>
															</tr>

															<tr role="row" class="odd">
																<td>AKSHAY MADHUKAR RAOANDORE</td>
																<td>Development</td>
																<td>19 - 03 - 2020</td>
																<td>15 Leave</td>
															</tr>

															<tr role="row" class="odd">
																<td>AKSHAY MADHUKAR RAOANDORE</td>
																<td>Development</td>
																<td>19 - 03 - 2020</td>
																<td>08 Leave</td>
															</tr>

															<tr role="row" class="odd">
																<td>AKSHAY MADHUKAR RAOANDORE</td>
																<td>Development</td>
																<td>19 - 03 - 2020</td>
																<td>02 Leave</td>
															</tr>

															<tr role="row" class="odd">
																<td>AKSHAY MADHUKAR RAOANDORE</td>
																<td>Development</td>
																<td>19 - 03 - 2020</td>
																<td>01 Leave</td>
															</tr>

														</tbody>
													</table>
												</div>

											</div>

										</div>
									</div>


								</div>
							</div>
						</div>

						<div class="col-md-4">
							<div class="card bg-warning">
								<div class="card-header header-elements-inline">
									<h6 class="card-title dash_title">Today Weekly Off (Total)</h6>

								</div>

								<div class="card-body white_bg">

									<div class="dashboard_bx">
										<c:forEach items="${deptwiseWkoff}" var="deptwiseWkoff"
											varStatus="count">
											<div class="dashboard_one">
												<div class="dashboard_l">
													<a class="text-white">${deptwiseWkoff.nameSd}</a>
												</div>
												<div class="dashboard_r">
													<a class="text-white">${deptwiseWkoff.empCount}</a>
												</div>
												<div class="clr"></div>
											</div>
										</c:forEach>
									</div>



								</div>
							</div>

						</div>

						<c:set var="peningtask" value="0" />
						<div class="col-md-4">
							<div class="card bg-warning">
								<div class="card-header header-elements-inline">
									<h6 class="card-title dash_title">Pending Master one time</h6>

								</div>

								<div class="card-body white_bg">
									<div class="table-responsive">

										<div class="dashboard_bx">
											<c:if test="${masterDet.companyCount==0}">
												<c:set var="peningtask" value="1" />
												<div class="dashboard_single">
													<a href="${pageContext.request.contextPath}/companySubAdd"
														class="text-white"> Add Company:0</a>
												</div>
											</c:if>

											<c:if test="${masterDet.emptypeCount==0}">
												<c:set var="peningtask" value="1" />
												<div class="dashboard_single">
													<a href="${pageContext.request.contextPath}/mstEmpTypeAdd"
														class="text-white"> Add Emp Type:0 </a>
												</div>
											</c:if>

											<c:if test="${masterDet.locCount==0}">
												<c:set var="peningtask" value="1" />
												<div class="dashboard_single">
													<a href="${pageContext.request.contextPath}/locationAdd"
														class="text-white"> Add Location:0 </a>
												</div>
											</c:if>

											<c:if test="${masterDet.desnCount==0}">
												<c:set var="peningtask" value="1" />
												<div class="dashboard_single">
													<a
														href="${pageContext.request.contextPath}/dsesignationAdd"
														class="text-white"> Add Designation:0 </a>
												</div>
											</c:if>

											<c:if test="${masterDet.deptCount==0}">
												<c:set var="peningtask" value="1" />
												<div class="dashboard_single">
													<a href="${pageContext.request.contextPath}/departmentAdd"
														class="text-white"> Add Department:0 </a>
												</div>
											</c:if>

											<c:if test="${masterDet.hoCount==0}">
												<c:set var="peningtask" value="1" />
												<div class="dashboard_single">
													<a href="${pageContext.request.contextPath}/holidayAdd"
														class="text-white"> Add Holiday:0 </a>
												</div>
											</c:if>

											<c:if test="${masterDet.hocatCount==0}">
												<c:set var="peningtask" value="1" />
												<div class="dashboard_single">
													<a
														href="${pageContext.request.contextPath}/holidayCategoryAdd"
														class="text-white"> Add Holiday Cat:0 </a>
												</div>
											</c:if>

											<c:if test="${masterDet.wocatCount==0}">
												<c:set var="peningtask" value="1" />
												<div class="dashboard_single">
													<a
														href="${pageContext.request.contextPath}/weekoffCategoryAdd"
														class="text-white"> Add Weekly off Cat:0 </a>
												</div>
											</c:if>
											<c:if test="${calYearCnt==0}">
												<c:set var="peningtask" value="1" />
												<div class="dashboard_single">
													<a href="${pageContext.request.contextPath}/calYearAdd"
														class="text-white"> Add Calendar Year </a>
												</div>
											</c:if>

											<c:if test="${masterDet.lvtypeCount==0}">
												<c:set var="peningtask" value="1" />
												<div class="dashboard_single">
													<a href="${pageContext.request.contextPath}/leaveTypeAdd"
														class="text-white"> Add Leave Type:0 </a>
												</div>
											</c:if>

											<c:if test="${masterDet.lvstructCount==0}">
												<c:set var="peningtask" value="1" />
												<div class="dashboard_single">
													<a
														href="${pageContext.request.contextPath}/addLeaveStructure"
														class="text-white"> Add Leave Structure:0 </a>
												</div>
											</c:if>

											<!--Pending  -->

											<c:if test="${masterDet.compPending!=0}">
												<c:set var="peningtask" value="1" />
												<div class="dashboard_single">
													<a
														href="${pageContext.request.contextPath}/assignSubCompany"
														class="text-white"> Assign
														Company:${masterDet.compPending} </a>
												</div>
											</c:if>

											<c:if test="${masterDet.typePending!=0}">
												<c:set var="peningtask" value="1" />
												<div class="dashboard_single">
													<a
														href="${pageContext.request.contextPath}/showAssignEmpType"
														class="text-white"> Assign Emp
														Type:${masterDet.typePending} </a>
												</div>
											</c:if>

											<c:if test="${masterDet.locPending!=0}">
												<c:set var="peningtask" value="1" />
												<div class="dashboard_single">
													<a
														href="${pageContext.request.contextPath}/showAssignLocation"
														class="text-white"> Assign
														Location:${masterDet.locPending} </a>
												</div>
											</c:if>

											<c:if test="${masterDet.desnPending!=0}">
												<c:set var="peningtask" value="1" />
												<div class="dashboard_single">
													<a
														href="${pageContext.request.contextPath}/showAssignDesignation"
														class="text-white"> Assign
														Designation:${masterDet.desnPending} </a>
												</div>
											</c:if>

											<c:if test="${masterDet.deptPending!=0}">
												<c:set var="peningtask" value="1" />
												<div class="dashboard_single">
													<a href="${pageContext.request.contextPath}/assignDept"
														class="text-white"> Assign
														Department:${masterDet.deptPending} </a>
												</div>
											</c:if>

											<c:if test="${masterDet.hocatPending!=0}">
												<c:set var="peningtask" value="1" />
												<div class="dashboard_single">
													<a
														href="${pageContext.request.contextPath}/assignHolidayCategory"
														class="text-white"> Assign
														Holiday:${masterDet.hocatPending} </a>
												</div>
											</c:if>

											<c:if test="${masterDet.wocatPending!=0}">
												<c:set var="peningtask" value="1" />
												<div class="dashboard_single">
													<a
														href="${pageContext.request.contextPath}/assignWeekoffCategory"
														class="text-white"> Assign Weekly off
														Cat:${masterDet.wocatPending} </a>
												</div>
											</c:if>

											<c:if test="${masterDet.lvStruvtPending!=0}">
												<c:set var="peningtask" value="1" />
												<div class="dashboard_single">
													<a
														href="${pageContext.request.contextPath}/leaveStructureAllotment"
														class="text-white"> Assign Leave
														Structure:${masterDet.lvStruvtPending} </a>
												</div>
											</c:if>

											<c:if test="${masterDet.lvAuthPending!=0}">
												<c:set var="peningtask" value="1" />
												<div class="dashboard_single">
													<a
														href="${pageContext.request.contextPath}/leaveAuthorityList"
														class="text-white"> Assign Leave
														Authority:${masterDet.lvAuthPending} </a>
												</div>
											</c:if>

										</div>
									</div>
								</div>
							</div>

						</div>


						<div class="col-md-4">
							<div class="card bg-warning">
								<div class="card-header header-elements-inline">
									<h6 class="card-title dash_title">Department wise Employee
									</h6>

								</div>

								<div class="card-body white_bg">
									<div id="dept_pie_chart" style="width: 100%; height: 100%;"></div>
								</div>
							</div>

						</div>
						<div class="col-md-4">
							<div class="card bg-warning">
								<div class="card-header header-elements-inline">
									<h6 class="card-title dash_title">Production HRS</h6>

								</div>

								<div class="card-body white_bg">
									<div id="dept_prod_ince" style="width: 100%; height: 100%;"></div>
								</div>
							</div>

						</div>
						<c:if
							test="${birth.birthListToday.size()>0 || birth.birthListUpcoming.size()>0}">
							<div class="col-md-4">
								<div class="card bg-primary">
									<div class="card-header header-elements-inline">
										<h6 class="card-title dash_title">
											<i class="fas fa-birthday-cake "></i>Birthday
										</h6>

									</div>

									<div class="card-body white_bg">

										<div class="dashboard_bx">

											<c:if test="${birth.birthListToday.size()>0}">
												<div class="dashboard_one">

													<div class="dashboard_single">
														<a class="text-white"> <strong> Today's
																Birthday</strong></a>
													</div>


												</div>
											</c:if>
											<c:forEach items="${birth.birthListToday}" var="birth"
												varStatus="count">
												<div class="dashboard_one">

													<div class="dashboard_single">
														<a class="text-white"><i class="icon-gift "></i>
															[${birth.empCode}] ${birth.name}</a>
													</div>


												</div>
											</c:forEach>

											<c:if test="${birth.birthListUpcoming.size()>0}">
												<div class="dashboard_one">

													<div class="dashboard_single">
														<a class="text-white"><strong> Upcomming
																Birthday (next 7 days)</strong></a>
													</div>


												</div>
											</c:if>
											<c:forEach items="${birth.birthListUpcoming}" var="birth"
												varStatus="count">
												<div class="dashboard_one">

													<div class="dashboard_single">
														<a class="text-white"><i class="icon-gift "></i>
															[${birth.empCode}] ${birth.name} <span
															style="float: right;">${birth.dateMonth}</span> </a>
													</div>


												</div>
											</c:forEach>
										</div>



									</div>
								</div>

							</div>
						</c:if>
						<c:if test="${birth.holiList.size()>0 }">
							<div class="col-md-4">
								<div class="card bg-warning">
									<div class="card-header header-elements-inline">
										<h6 class="card-title dash_title">
											<i class="fas fa-calendar-alt "></i> Upcoming Holidays (next
											30 days)
										</h6>

									</div>

									<div class="card-body white_bg">

										<div class="dashboard_bx">
											<c:forEach items="${birth.holiList}" var="birth"
												varStatus="count">
												<div class="dashboard_one">
													<div class="dashboard_l">
														<a class="text-white">${birth.holidayName}</a>
													</div>
													<div class="dashboard_r">
														<a class="text-white">${birth.holidayDate}</a>
													</div>
													<div class="clr"></div>
												</div>
											</c:forEach>
										</div>

									</div>
								</div>

							</div>

						</c:if>

						<div class="col-md-4">
							<div class="card bg-primary">
								<div class="card-header header-elements-inline">
									<h6 class="card-title dash_title">New Hires (Past 30 days)</h6>

								</div>

								<div class="card-body white_bg">
									<div class="table-responsive">

										<div class="dashboard_bx">
											<div class="dashboard_one">
												<div class="dashboard_l">
													<a class="text-white">Total</a>
												</div>
												<div class="dashboard_r">
													<a class="text-white">${newHire.maleEmp+newHire.femaleEmp+newHire.othEmp}</a>
												</div>
												<div class="clr"></div>
											</div>

											<div class="dashboard_one">
												<div class="dashboard_l">
													<a class="text-white">Male</a>
												</div>
												<div class="dashboard_r">
													<a class="text-white">${newHire.maleEmp}</a>
												</div>
												<div class="clr"></div>
											</div>

											<div class="dashboard_one">
												<div class="dashboard_l">
													<a class="text-white">Female</a>
												</div>
												<div class="dashboard_r">
													<a class="text-white">${newHire.femaleEmp}</a>
												</div>
												<div class="clr"></div>
											</div>

											<div class="dashboard_one">
												<div class="dashboard_l">
													<a class="text-white">Other</a>
												</div>
												<div class="dashboard_r">
													<a class="text-white">${newHire.othEmp}</a>
												</div>
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
									<h6 class="card-title dash_title">Leave Application
										Pending</h6>

								</div>

								<div class="card-body white_bg">

									<div class="dashboard_bx">
										<div class="dashboard_one">
											<div class="dashboard_l">
												<a class="text-white" href="javascript:void(0)"
													onclick="getPendingLeaveList(1)">Initial Approve
													Pending</a>
											</div>
											<div class="dashboard_r">
												<a class="text-white">${lvDet.newApp}</a>
											</div>
											<div class="clr"></div>
										</div>

										<%-- <div class="dashboard_one">
												<div class="dashboard_l">
													<a class="text-white">Initial Authority
														Pending/Approved</a>
												</div>
												<div class="dashboard_r">
													<a class="text-white">${lvDet.newApp}/${lvDet.finalPending}</a>
												</div>
												<div class="clr"></div>
											</div> --%>

										<div class="dashboard_one">
											<div class="dashboard_l">
												<a class="text-white" href="javascript:void(0)"
													onclick="getPendingLeaveList(2)">Final Approve Pending</a>
											</div>
											<div class="dashboard_r">
												<a class="text-white">${lvDet.finalPending}</a>
											</div>
											<div class="clr"></div>
										</div>
										<div class="dashboard_one">
											<div class="dashboard_l">
												<a class="text-white" href="javascript:void(0)"
													onclick="getPendingLeaveList(3)">Optional Holiday
													Pending</a>
											</div>
											<div class="dashboard_r">
												<a class="text-white">${lvDet.ohPending}</a>
											</div>
											<div class="clr"></div>
										</div>
									</div>


								</div>
							</div>



						</div>




						<div class="col-md-4">
							<div class="card bg-purple-300 text-white">
								<div class="card-header header-elements-inline">
									<h6 class="card-title dash_title">Deduction (Current
										Month)</h6>

								</div>

								<div class="card-body white_bg">
									<div class="dashboard_bx">
										<div class="dashboard_one">
											<div class="dashboard_l">
												<a class="text-white"> Loan (EMP/Amount)</a>
											</div>
											<div class="dashboard_r">
												<a class="text-white">${loanDet.emp}/${loanDet.advTot}</a>
											</div>
											<div class="clr"></div>
										</div>
										<div class="dashboard_one">
											<div class="dashboard_l">
												<a class="text-white"> Advance (EMP/Amount)</a>
											</div>
											<div class="dashboard_r">
												<a class="text-white">${advDet.emp}/${advDet.advTot}</a>
											</div>
											<div class="clr"></div>
										</div>
										<div class="dashboard_one">
											<div class="dashboard_l">
												<a class="text-white"> Pay Deduction (EMP/Amount)</a>
											</div>
											<div class="dashboard_r">
												<a class="text-white">${dedDet.empCount}/${dedDet.tot}</a>
											</div>
											<div class="clr"></div>
										</div>
										<%-- <div class="dashboard_one">
												<div class="dashboard_l">
													<a class="text-white">Total Skip Emp/Amt</a>
												</div>
												<div class="dashboard_r">
													<a class="text-white">${loanDet.skipId}/${loanDet.skipTott}</a>
												</div>
												<div class="clr"></div>
											</div> --%>
									</div>

								</div>
							</div>



						</div>
						<div class="col-md-4">
							<div class="card bg-warning">
								<div class="card-header header-elements-inline">
									<h6 class="card-title dash_title">Reward (Current Month)</h6>

								</div>

								<div class="card-body white_bg">

									<div class="dashboard_bx">
										<div class="dashboard_one">
											<div class="dashboard_l">
												<a class="text-white">Total Emp/amount</a>
											</div>
											<div class="dashboard_r">
												<a class="text-white">${rewardDet.empCount}/${rewardDet.tot}</a>
											</div>
											<div class="clr"></div>
										</div>
									</div>


								</div>
							</div>

						</div>

					</div>

				</c:if>




				<!-- Highlighting rows and columns -->
				<div class="card" style="margin: 30px 0 0 0;">




					<div class="row">
						<div class="col-md-4">
							<div class="card bg-primary">
								<div class="card-header header-elements-inline">
									<h6 class="card-title dash_title">My Attendance (Current
										Month)</h6>

								</div>

								<div class="card-body white_bg">

									<div class="dashboard_bx">
										<div class="dashboard_one">
											<div class="dashboard_l">
												<a class="text-white">Present</a>
											</div>
											<div class="dashboard_r">
												<a class="text-white">${attnLastMon.presentDays}</a>
											</div>
											<div class="clr"></div>
										</div>
										<div class="dashboard_one">
											<div class="dashboard_l">
												<a class="text-white">Absent</a>
											</div>
											<div class="dashboard_r">
												<a class="text-white">${attnLastMon.absentDays}</a>
											</div>
											<div class="clr"></div>
										</div>
										<div class="dashboard_one">
											<div class="dashboard_l">
												<a class="text-white">LWP Leaves</a>
											</div>
											<div class="dashboard_r">
												<a class="text-white">${attnLastMon.unpaidLeave}</a>
											</div>
											<div class="clr"></div>
										</div>

										<div class="dashboard_one">
											<div class="dashboard_l">
												<a class="text-white">Paid Leaves</a>
											</div>
											<div class="dashboard_r">
												<a class="text-white">${attnLastMon.paidLeave}</a>
											</div>
											<div class="clr"></div>
										</div>
										<div class="dashboard_one">
											<div class="dashboard_l">
												<a class="text-white">Weekly Off</a>
											</div>
											<div class="dashboard_r">
												<a class="text-white">${attnLastMon.weeklyOff}</a>
											</div>
											<div class="clr"></div>
										</div>
										<div class="dashboard_one">
											<div class="dashboard_l">
												<a class="text-white">Holiday</a>
											</div>
											<div class="dashboard_r">
												<a class="text-white">${attnLastMon.paidHoliday}</a>
											</div>
											<div class="clr"></div>
										</div>
									</div>

								</div>
							</div>

						</div>

						<c:if test="${isAuth > 0 }">
							<div class="col-md-4">
								<div class="card bg-primary">
									<div class="card-header header-elements-inline">
										<h6 class="card-title dash_title">Today's Task</h6>

									</div>

									<div class="card-body white_bg">
										<div class="dashboard_bx">
											<div class="dashboard_one">
												<div class="dashboard_l">
													<a class="text-white"
														href="${pageContext.request.contextPath}/showLeaveApprovalByAuthority">Total
														Pending Application</a>
												</div>
												<div class="dashboard_r">
													<a class="text-white">${list1Count}</a>
												</div>
												<div class="clr"></div>
											</div>
										</div>

									</div>
								</div>

							</div>
						</c:if>
						<div class="col-md-4">
							<div class="card bg-warning">
								<div class="card-header header-elements-inline">
									<h6 class="card-title dash_title">My Deductions</h6>

								</div>

								<div class="card-body white_bg">

									<div class="dashboard_bx">
										<c:forEach items="${dedWiseDedList}" var="dedWiseDedList"
											varStatus="count">
											<div class="dashboard_one">
												<div class="dashboard_l">
													<a class="text-white">${dedWiseDedList.nameSd}</a>
												</div>
												<div class="dashboard_r">
													<a class="text-white">${dedWiseDedList.empCount}</a>
												</div>
												<div class="clr"></div>
											</div>
										</c:forEach>

										<div class="dashboard_one">
											<div class="dashboard_l">
												<a class="text-white">Total Advance</a>
											</div>
											<div class="dashboard_r">
												<a class="text-white">${icent.perfIncentive}</a>
											</div>
											<div class="clr"></div>
										</div>

										<div class="dashboard_one">
											<div class="dashboard_l">
												<a class="text-white">Total Loan</a>
											</div>
											<div class="dashboard_r">
												<a class="text-white">${icent.prodIncentive}</a>
											</div>
											<div class="clr"></div>
										</div>
									</div>


								</div>
							</div>

						</div>
					</div>




					<div class="row">




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
												<div class="dashboard_l">
													<a class="text-white">${rewardWiseDedList.nameSd}</a>
												</div>
												<div class="dashboard_r">
													<a class="text-white">${rewardWiseDedList.empCount}</a>
												</div>
												<div class="clr"></div>
											</div>
										</c:forEach>



									</div>


								</div>
							</div>

						</div>




					</div>



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

						</div>
						<!--Leave History -->
					</div>


					<br>
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
												Male:${ageDiv.maleEmp} <br> Female:${ageDiv.femaleEmp}
												<br> Other:${ageDiv.othEmp} <br>------<br>
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
												10000-20000: ${salDiversity.ageRange2}<br> 21000-30000:
												${salDiversity.ageRange3}<br>

												31000-40000:${salDiversity.ageRange4}<br> 41000-50000:
												${salDiversity.ageRange5}<br> 51000-60000:
												${salDiversity.ageRange6}<br> 61000-70000 :
												${salDiversity.ageRange7}<br> 71000-80000:
												${salDiversity.ageRange8}<br> 81000-9000:
												${salDiversity.ageRange9}<br> 91000-100000:
												${salDiversity.ageRange10}<br>
											</div>
										</div>
									</div>
								</div>
							</div>

						</div>
					</c:if>
				</div>

				<!-- /highlighting rows and columns -->
			</div>
		</div>

		<!-- /content area -->

		<div id="modal_full" class="modal fade" tabindex="-1">
			<div class="modal-dialog popup_third">
				<!-- modal-half -->
				<div class="modal-content">

					<div class="late_popup">

						<div class="late_title" id="detailGraphHead">Late Employee
							Details</div>

						<button type="button" class="close cross" data-dismiss="modal">&times;</button>
						<div class="modal-body" id="modalbody"></div>

					</div>


				</div>
			</div>
		</div>
		<!-- /full width modal -->

		<!-- Footer -->

		<!-- /footer -->

	</div>
	<!-- /main content -->

	<script type="text/javascript"
		src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
		function getPendingLeaveList(type) {

			if (type == 1) {
				$("#detailGraphHead").html("Initial Approve Pending List");
			} else if (type == 2) {
				$("#detailGraphHead").html("Final Approve Pending List");
			} else {
				$("#detailGraphHead").html("Optional Holiday Pending List");
			}
			var strhref = "${pageContext.request.contextPath}/leavePendingListForDashboard?type="
					+ type;
			$("#modalbody").load(strhref);
			$("#modal_full").modal("show");
			$('#modal_full').on('hidden.bs.modal', function() {
				$("#modalbody").html("");
			});
		}
		function getEmpData(empId, graphType) {
			//alert(empId)

			//alert(var1+':'+var2);

			if (graphType == 1) {
				$("#detailGraphHead").html("Late Employee Details");
			} else {
				$("#detailGraphHead").html("Leave and Absent Employee Details");
			}
			var strhref = "${pageContext.request.contextPath}/lateMarkDetailAndGraph?empId="
					+ empId + "&graphType=" + graphType;
			$("#modalbody").load(strhref);

			$("#modal_full").modal("show");
			$('#modal_full').on('hidden.bs.modal', function() {
				$("#modalbody").html("");
			});
		}
		$(document).ready(
				function($) {

					//btn_go_next_tab
					$(".btn_go_next_tab").click(
							function(e) {
								$('.nav-tabs > .nav-item > .active').parent()
										.next('li').find('a').trigger('click');

							});
					$(".btn_go_prev_tab").click(
							function(e) {
								$('.nav-tabs > .nav-item > .active').parent()
										.prev('li').find('a').trigger('click');

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
	<!-- /page content -->
	<script type="text/javascript">
		$(document).ready(function() {
			getGraphs();
			getLineGraphs();
		});
		function getGraphs() {

			$.getJSON('${getdeptwiseEmp}',

			{

				ajax : 'true'

			}, function(data1) {

				google.charts.load('current', {
					'packages' : [ 'corechart' ]
				});
				google.charts.setOnLoadCallback(drawChart);

				function drawChart() {
					var dept = [];

					dept.push([ 'Department', 'Count Per Deparment' ]);

					$.each(data1, function(key, dt) {

						dept.push([ dt.deptName, dt.deptCount ]);

					})

					var data = google.visualization.arrayToDataTable(dept);

					var options = {
						title : 'Department wise Employee',
						is3D : true,
					};

					var chart = new google.visualization.PieChart(document
							.getElementById('dept_pie_chart'));

					chart.draw(data, options);
				}
			});

		}

		function getLineGraphs() {

			$.getJSON('${totalOtPrevioussixMonth}',

			{

				ajax : 'true'

			}, function(data1) {

				alert(JSON.stringify(data1))
				/* google.charts.load("current", {
					packages : [ "imagelinechart" ]
				});
				google.charts.setOnLoadCallback(drawChart);

				function drawChart() {
					var dept = [];

					dept.push([ 'Year', 'Collevtive OT' ]);

					$.each(data1, function(key, dt) {

						dept.push([ dt.month, dt.ot ]);

					})

					  var data = google.visualization.arrayToDataTable([
							[ 'Year', 'Sales', 'Expenses' ],
							[ '2004', 1000, 400 ], [ '2005', 1170, 460 ],
							[ '2006', 660, 1120 ], [ '2007', 1030, 540 ] ]);  

					 var data = google.visualization.arrayToDataTable(dept);
					  var chart = new google.visualization.ImageLineChart(
							document.getElementById('dept_prod_ince'));  

					chart.draw(data, {
						width : 400,
						height : 240,
						min : 0
					});
				} */

				google.charts.load('current', {
					'packages' : [ 'line' ]
				});
				google.charts.setOnLoadCallback(drawChart);

				function drawChart() {

					var data = new google.visualization.DataTable();
					data.addColumn('string', 'Month');
					data.addColumn('number', 'Production HRS');
					data.addColumn('number', 'Production HRS');
					data.addColumn('number', 'Production HRS');
					$.each(data1, function(key, dt) {

						var dept = [];
						dept.push(dt.month);

						for (var i = 0; i < dt.otlist.length; i++) {
							alert(i)
							dept.push(dt.otList[i].ot);
						}
						data.addRows([ dept ]);
					})

					/* data.addRows([ [ 1, 37.8, 80.8, 41.8 ],
							[ 2, 30.9, 69.5, 32.4 ],
							[ 3, 25.4, 57, 25.7 ],
							[ 4, 11.7, 18.8, 10.5 ],
							[ 5, 11.9, 17.6, 10.4 ],
							[ 6, 8.8, 13.6, 7.7 ],
							[ 7, 7.6, 12.3, 9.6 ],
							[ 8, 12.3, 29.2, 10.6 ],
							[ 9, 16.9, 42.9, 14.8 ],
							[ 10, 12.8, 30.9, 11.6 ],
							[ 11, 5.3, 7.9, 4.7 ],
							[ 12, 6.6, 8.4, 5.2 ],
							[ 13, 4.8, 6.3, 3.6 ],
							[ 14, 4.2, 6.2, 3.4 ] ]); */

					var options = {
						chart : {
							title : 'Production HRS'
						}
					};

					var chart = new google.charts.Line(document
							.getElementById('dept_prod_ince'));

					chart
							.draw(data, google.charts.Line
									.convertOptions(options));
				}

			});

		}
	</script>
</body>
</html>
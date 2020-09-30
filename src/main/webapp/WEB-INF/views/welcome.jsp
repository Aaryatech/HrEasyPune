<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<!-- <link href="https://fonts.googleapis.com/css2?family=Grandstander&display=swap" rel="stylesheet"> -->
<!-- font-family: 'Grandstander', cursive; -->
<c:url var="getdeptwiseEmp" value="/getdeptwiseEmp" />
<c:url var="totalOtPrevioussixMonth" value="/totalOtPrevioussixMonth" />
<c:url var="getAmtBarGraph" value="/getAmtBarGraph" />
<c:url var="getPresentData" value="/getPresentData" />
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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-datepicker.css"
	type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-datepicker.js"></script>


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


								<div class="col-lg-2">
									<input type="text" class="form-control datepickerclass"
										placeholder="Select Date " id="attendaceDate"
										name="attendaceDate" value="01-08-2020" autocomplete="off">

								</div>
								<div class="col-lg-2">

									<button type="button" class="btn blue_btn" id="submtbtn"
										onclick="getPresentData()">Search</button>
								</div>

								<div class="tab_round">
									<div class="row">
										<div class="col-lg-3">
											<div class="shift_round bg-purple-300">
												<div class="round_size">
													<span id="present_count">0</span> Present Employee
												</div>
											</div>
										</div>
										<div class="col-lg-3">
											<a href="#" onclick="openCloseDive(3)"><div
													class="shift_round bg-pink-400">
													<div class="round_size">
														<span id="late_count">0</span> Late Employee
													</div>
												</div></a>
										</div>
										<div class="col-lg-3">
											<a href="#" onclick="openCloseDive(2)"><div
													class="shift_round bg-warning">
													<div class="round_size">
														<span id="leave_count">0</span> Leave Employee
													</div>
												</div></a>
										</div>
										<div class="col-lg-3">
											<a href="#" onclick="openCloseDive(1)"><div
													class="shift_round bg-primary">
													<div class="round_size">
														<span id="absent_count">0</span> Absent Employee
													</div>
												</div></a>
										</div>
									</div>


									<!-- Late Employee tab start here -->
									<div class="row">
										<div class="late_employee" id="late_emp_list">
											<!-- <h3 class="bg-pink-400 employee_title">Late Employee</h3> -->

											<div class="late_one fix_scroll">

												<div class="datatable-scroll-wrap">
													<!-- <table
														class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
														width="100%" id="printtable3"> -->
													<table
														class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
														id="printtable3">
														<thead>
															<tr class="bg-pink-400" role="row">
																<th class="sorting_desc">Employee Name</th>
																<th class="sorting">Department</th>
																<th class="sorting">Late Minutes</th>
															</tr>
														</thead>
														<tbody>


															<!-- <tr role="row" class="odd">
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
															</tr> -->
														</tbody>
													</table>
												</div>

											</div>

										</div>
									</div>

									<!-- Leave Employee tab start here -->
									<div class="row">
										<div class="late_employee" id="leave_emp_list"
											style="display: none;">

											<div class="late_one fix_scroll">

												<div class="datatable-scroll-wrap">
													<table
														class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
														id="printtable2">
														<!-- <table class="table" width="100%" id="printtable2"> -->
														<thead>
															<tr class="bg-warning" role="row">
																<th class="sorting_desc">Employee Name</th>
																<th class="sorting">Department</th>
																<th class="sorting">Type</th>
															</tr>
														</thead>
														<tbody>




														</tbody>
													</table>
												</div>
											</div>

										</div>
									</div>

									<!-- Absent Employee tab start here -->
									<div class="row">
										<div class="late_employee" id="abs_emp_list"
											style="display: none;">

											<div class="late_one fix_scroll">

												<div class="datatable-scroll-wrap">
													<table
														class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
														id="printtable1">
														<!-- <table
															class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
															width="100%" id="printtable1"> -->
														<thead>
															<tr class="bg-primary" role="row">
																<th class="sorting_desc">Employee Name</th>
																<th class="sorting">Department</th>
															</tr>
														</thead>
														<tbody>

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
						<div class="col-md-8">
							<div class="card bg-warning">
								<div class="card-header header-elements-inline">
									<h6 class="card-title dash_title">
										Production HRS
										<!-- <a class="list-icons-item" data-action="reload"></a> -->
									</h6>
									<div class="col-md-2" style="background: white;">
										<input type="text" class="form-control monthYear"
											placeholder="Select Date " id="monthYearLineGraph"
											name="monthYearLineGraph" value="${month}-${year}"
											autocomplete="off" onchange="getLineGraphs()">
									</div>
									<!-- <div class="col-md-2">
										<button type="button" class="btn blue_btn1" id="submtbtn"
											onclick="getLineGraphs()">Search</button>
									</div> -->
								</div>

								<div class="card-body white_bg">

									<div id="dept_prod_ince" style="width: 100%; height: 100%;"></div>
								</div>
							</div>

						</div>
						<div class="col-md-6">
							<div class="card bg-warning">
								<div class="card-header header-elements-inline">
									<h6 class="card-title dash_title">Amount Disbursed Month
										Wise</h6>
									<div class="col-md-2" style="background: white;">
										<input type="text" class="form-control monthYear"
											placeholder="Select Date " id="monthYearBarGraph"
											name="monthYearBarGraph" value="${month}-${year}"
											autocomplete="off" onchange="getAmtBarGraph()">
									</div>
								</div>

								<div class="card-body white_bg">
									<div id="deduction_graph" style="width: 100%; height: 100%;"></div>
								</div>
							</div>

						</div>
						<div class="col-md-6">
							<div class="card bg-warning">
								<div class="card-header header-elements-inline">
									<h6 class="card-title dash_title">Department wise Employee
									</h6>

								</div>

								<div class="card-body white_bg">
									<!-- <div id="dept_pie_chart" style="width: 100%; height: 100%;"></div> -->
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

		$(document).ready(function() {
			// month selector
			$('.monthYear').datepicker({
				autoclose : true,
				format : "mm-yyyy",
				viewMode : "months",
				minViewMode : "months"

			});
			getGraphs();
			getPresentData();
		});
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

			var monthYearLineGraph = $("#monthYearLineGraph").val();

			//alert(monthYearLineGraph);
			$.getJSON('${totalOtPrevioussixMonth}',

			{
				monthYearLineGraph : monthYearLineGraph,
				ajax : 'true'

			}, function(lineGraphData) {

				var data1 = lineGraphData.list;
				var deptList = lineGraphData.deptList;
				google.charts.load('current', {
					'packages' : [ 'line' ]
				});
				google.charts.setOnLoadCallback(drawChart);

				function drawChart() {

					var data = new google.visualization.DataTable();
					data.addColumn('string', 'Month');
					for (var j = 0; j < deptList.length; j++) {
						data.addColumn('number', deptList[j].name);
					}

					for (var j = 0; j < data1.length; j++) {

						var dept = [];
						dept.push(data1[j].month);

						console.log(data1[j].otlist)
						for (var i = 0; i < data1[j].otlist.length; i++) {
							/* try { */
							dept.push(data1[j].otlist[i].ot);
							/* } catch (err) {
								dept.push(0);
								//document.getElementById("demo").innerHTML = err.message;
							} */
						}
						data.addRows([ dept ]);
					}

					var options = {
						chart : {
							title : 'Production HRS'
						}
					};

					var chart = new google.charts.Line(document
							.getElementById('dept_prod_ince'));

					chart.draw(data, options);
				}

			});

		}

		function getAmtBarGraph() {

			var monthYearBarGraph = $("#monthYearBarGraph").val();

			//alert(monthYearLineGraph);
			$.getJSON('${getAmtBarGraph}',

			{
				monthYearBarGraph : monthYearBarGraph,
				ajax : 'true'

			}, function(res) {

				google.charts.load('current', {
					'packages' : [ 'corechart' ]
				});
				google.charts.setOnLoadCallback(drawChart);
				function drawChart() {

					var dataTable = new google.visualization.DataTable();

					dataTable.addColumn('string', 'Month Year'); // Implicit domain column.

					dataTable.addColumn('number', 'Advance');
					dataTable.addColumn('number', 'Loan');

					$.each(res, function(key, dt) {

						dataTable.addRows([

						[ dt.month, dt.advAmt, dt.loanAmt ]

						]);

					})

					/* slantedTextAngle: 60 */
					var options = {
						hAxis : {
							title : "Month Year",
							textPosition : 'out',
							slantedText : true
						},
						vAxis : {
							title : 'Amount',
							minValue : 0,
							viewWindow : {
								min : 0
							},
							format : '0',
						},
						colors : [ 'orange', 'blue' ],
						theme : 'material'
					};
					var chart = new google.visualization.ColumnChart(document
							.getElementById('deduction_graph'));

					chart.draw(dataTable, options);
				}

			});

		}

		function openCloseDive(type) {

			if (type == 1) {
				$("#late_emp_list").hide();
				$("#leave_emp_list").hide();
				$("#abs_emp_list").show();
			} else if (type == 2) {
				$("#late_emp_list").hide();
				$("#leave_emp_list").show();
				$("#abs_emp_list").hide();
			} else if (type == 3) {
				$("#late_emp_list").show();
				$("#leave_emp_list").hide();
				$("#abs_emp_list").hide();
			}

		}
		function getPresentData() {
			var attendaceDate = $("#attendaceDate").val();

			//alert(attendaceDate);
			$
					.getJSON(
							'${getPresentData}',

							{
								attendaceDate : attendaceDate,
								ajax : 'true'

							},
							function(res) {

								$("#present_count").html(res.countData.present);
								$("#absent_count").html(res.countData.absent);
								$("#leave_count")
										.html(res.countData.leavecount);
								$("#late_count").html(res.countData.latemark);
								//alert(JSON.stringify(res))

								$('#printtable3 td').remove();
								$('#printtable2 td').remove();
								$('#printtable1 td').remove();

								/* var table = $('#printtable3').DataTable();
								var rows = table.rows().remove().draw(); */

								/* var table2 = $('#printtable2').DataTable();
								var rows = table2.rows().remove().draw(); */

								/* var table1 = $('#printtable1').DataTable();
								var rows = table1.rows().remove().draw(); */

								for (var i = 0; i < res.lateList.length; i++) {

									var tr = $('<tr></tr>');

									tr
											.append($(
													'<td class="text-left"></td>')
													.html(
															'<a href="#" data-toggle="modal" onclick="getEmpData('
																	+ res.lateList[i].empId
																	+ ',1)">'
																	+ res.lateList[i].empName
																	+ '</a>'));
									tr.append($('<td class="text-left"></td>')
											.html(res.lateList[i].deptName));
									tr.append($('<td class="text-right"></td>')
											.html(res.lateList[i].lateMin));
									$('#printtable3 tbody').append(tr);

									/* var tr_data = '<tr  >' + '<td >'
											+ res.lateList[i].empName + '</td>'
											+ '<td  class="text-right">'
											+ res.lateList[i].deptName
											+ '</td><td class="text-right" >'
											+ res.lateList[i].lateMin + '</td> </tr>';
									$('#printtable3').append(tr_data); */

									/* $('#printtable3 td').css('white-space', 'initial');
									$('#printtable3').DataTable().row.add(
											[ res.lateList[i].empName,
													res.lateList[i].deptName,
													res.lateList[i].lateMin ]).draw(); */
								}

								for (var i = 0; i < res.presentList.length; i++) {

									if (res.presentList[i].lvSumupId == 7
											|| res.presentList[i].lvSumupId == 11) {

										var tr = $('<tr></tr>');

										tr
												.append($(
														'<td class="text-left"></td>')
														.html(
																'<a href="#" data-toggle="modal" onclick="getEmpData('
																		+ res.presentList[i].empId
																		+ ',2)">'
																		+ res.presentList[i].empName
																		+ '</a>'));
										tr
												.append($(
														'<td class="text-left"></td>')
														.html(
																res.presentList[i].deptName));
										tr
												.append($(
														'<td class="text-left"></td>')
														.html(
																res.presentList[i].attStatus));
										$('#printtable2 tbody').append(tr);

										/* var tr_data = '<tr  >' + '<td >'
												+ res.presentList[i].empName + '</td>'
												+ '<td  class="text-right">'
												+ res.presentList[i].deptName
												+ '</td><td class="text-right" >'
												+ res.presentList[i].attStatus
												+ '</td>  </tr>';
										$('#printtable2').append(tr_data); */
										/* $('#printtable2 td').css('white-space', 'initial');
										$('#printtable2').DataTable().row.add(
												[ res.presentList[i].empName,
														res.presentList[i].deptName,
														res.presentList[i].attStatus ]).draw(); */
									} else if (res.presentList[i].lvSumupId == 22) {

										var tr = $('<tr></tr>');

										tr
												.append($(
														'<td class="text-left"></td>')
														.html(
																'<a href="#" data-toggle="modal" onclick="getEmpData('
																		+ res.presentList[i].empId
																		+ ',2)">'
																		+ res.presentList[i].empName
																		+ '</a>'));
										tr
												.append($(
														'<td class="text-left"></td>')
														.html(
																res.presentList[i].deptName));
										$('#printtable1 tbody').append(tr);

										/* $('#printtable1 td').css('white-space',
												'initial');
										$('#printtable1').DataTable().row.add(
												[ res.presentList[i].empName,
														res.presentList[i].deptName,
														res.presentList[i].attStatus ])
												.draw(); */
									}

								}
							});
		}
	</script>
	<script type="text/javascript">
		$('.datatable-fixed-left_custom').DataTable({

			columnDefs : [ {
				orderable : false,
				targets : [ 0 ]
			} ],
			//scrollX : true,
			scrollX : true,
			scrollY : '50vh',
			scrollCollapse : true,
			paging : false,
			fixedColumns : {
				leftColumns : 0,
				rightColumns : 0
			}

		});
	</script>
</body>
</html>
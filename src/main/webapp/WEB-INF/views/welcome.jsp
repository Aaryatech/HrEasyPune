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
			<!-- <div class="card">


				<div class="card-header header-elements-inline"></div>

				<div class="card-body">
					<h6>Dashboard</h6>
				</div>

			</div>-->
			<div class="content">


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
																onclick="getEmpData(82,1)">AKSHAY MADHUKAR RAOANDORE</a></td>
															<td>Development</td>
															<td>20 Minutes</td>
															<td>234 Minutes</td>
														</tr>
														<tr role="row" class="odd">
															<td><a href="#" data-toggle="modal"
																onclick="getEmpData(82,2)">AKSHAY MADHUKAR RAOANDORE</a></td>
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
					<c:set var="peningtask" value="0" />
					<div class="col-md-4">
						<div class="card bg-warning">
							<div class="card-header header-elements-inline">
								<h6 class="card-title dash_title">Pending Master one time</h6>
								<!-- <div class="list-icons ml-auto">
									<a class="list-icons-item" data-action="reload"></a>
								</div> -->
							</div>

							<div class="card-body white_bg">
								<div class="table-responsive">
									<%-- <%
										System.out.print("Sdfsdf");
									%> --%>

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
												<a href="${pageContext.request.contextPath}/dsesignationAdd"
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
										<%-- <c:if test="${masterDet.shiftCount==0}">
											<c:set var="peningtask" value="1" />
											<div class="dashboard_single">
												<a href="${pageContext.request.contextPath}/addShift"
													class="text-white"> Add Shift:0 </a>
											</div>
										</c:if> --%>

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

										<%-- <c:if test="${masterDet.shiftPending!=0}">
											<c:set var="peningtask" value="1" />
											<div class="dashboard_single">
												<a
													href="${pageContext.request.contextPath}/showEmpListToAssignShift"
													class="text-white"> Assign
													Shift:${masterDet.shiftPending} </a>
											</div>
										</c:if> --%>

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


				</div>


				<!-- <div class="row">
					<div class="col-lg-4">
						<div class="card">
							<div class="card-header header-elements-inline bg-purple-300">
								<h6 class="card-title dash_title">
									<i class="fas fa-suitcase"></i> Employee Structure
								</h6>
							</div>

							<div>
								<div class="gendor_bx">
									<ul>
										<li>
											<h3 class="gender_head">
												Male <span>58%</span>
											</h3> <i class="fas fa-male male"></i>
										</li>
										<li>
											<h3 class="gender_head">
												Other <span>2%</span>
											</h3> <i class="fas fa-transgender other"></i>
										</li>
										<li>
											<h3 class="gender_head">
												Female <span>40%</span>
											</h3> <i class="fas fa-female female"></i>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>


				</div> -->
				<!-- 1st birthday row start here -->
				<!-- <div class="row">
					todays birthdays
					<div class="col-lg-4">
						<div class="card">
							<div class="card-header header-elements-inline bg-primary">
								<h6 class="card-title dash_title">
									<i class="fas fa-birthday-cake "></i> Today's Birthday
								</h6>
							</div>

							<div class="scroll_bx">
								<div class="birthday_list">
									<ul>
										<li><img
											src="https://aeealberta.org/wp-content/uploads/2018/10/profile.png">
											Aksahy Kasar <span>19-03-2020</span></li>
										<li><img
											src="https://aeealberta.org/wp-content/uploads/2018/10/profile.png">
											Aksahy Kasar <span>19-03-2020</span></li>
										<li><img
											src="https://aeealberta.org/wp-content/uploads/2018/10/profile.png">
											Aksahy Kasar <span>19-03-2020</span></li>
										<li><img
											src="https://aeealberta.org/wp-content/uploads/2018/10/profile.png">
											Aksahy Kasar <span>19-03-2020</span></li>
									</ul>
								</div>
							</div>
						</div>
					</div>

					upcoming birthdays
					<div class="col-lg-4">
						<div class="card">
							<div class="card-header header-elements-inline bg-purple-300">
								<h6 class="card-title dash_title">
									<i class="fas fa-birthday-cake "></i> Upcomming Birthday (next
									7 days)
								</h6>
							</div>

							<div class="scroll_bx">
								<div class="birthday_list">
									<ul>
										<li><img
											src="https://aeealberta.org/wp-content/uploads/2018/10/profile.png">
											Aksahy Kasar <span>19-03-2020</span></li>
										<li><img
											src="https://aeealberta.org/wp-content/uploads/2018/10/profile.png">
											Aksahy Kasar <span>19-03-2020</span></li>
										<li><img
											src="https://aeealberta.org/wp-content/uploads/2018/10/profile.png">
											Aksahy Kasar <span>19-03-2020</span></li>
										<li><img
											src="https://aeealberta.org/wp-content/uploads/2018/10/profile.png">
											Aksahy Kasar <span>19-03-2020</span></li>
									</ul>
								</div>
							</div>
						</div>
					</div>

					Upcoming Holidays
					<div class="col-lg-4">
						<div class="card">
							<div class="card-header header-elements-inline bg-warning">
								<h6 class="card-title dash_title">
									<i class="fas fa-calendar-alt "></i> Upcomming Holidays
								</h6>
							</div>

							<div class="scroll_bx">
								<div class="birthday_list">
									<ul>
										<li><i class="fas fa-gift gift-icon"></i> Holi <span>19-03-2020</span>
										</li>
										<li><i class="fas fa-gift gift-icon"></i> Rang Panchami <span>19-03-2020</span>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div> -->
				<c:if test="${peningtask==1}">


					<div class="row">
						<div class="col-md-4">
							<div class="card bg-primary">
								<div class="card-header header-elements-inline">
									<h6 class="card-title dash_title">
										<i class="fas fa-birthday-cake "></i>Today's Birthday
									</h6>

								</div>

								<div class="card-body white_bg">

									<div class="dashboard_bx">
										<c:forEach items="${birth.birthListToday}" var="birth"
											varStatus="count">
											<div class="dashboard_one">

												<div class="dashboard_single">
													<a class="text-white"><i class="icon-gift "></i>
														[${birth.empCode}] ${birth.name}</a>
												</div>


											</div>
										</c:forEach>
									</div>



								</div>
							</div>

						</div>

						<div class="col-md-4">
							<div class="card bg-purple-300 text-white">
								<div class="card-header header-elements-inline">
									<h6 class="card-title dash_title">
										<i class="fas fa-birthday-cake "></i> Upcomming Birthday(next
										7 days)
									</h6>

								</div>

								<div class="card-body white_bg">
									<div class="dashboard_bx">
										<c:forEach items="${birth.birthListUpcoming}" var="birth"
											varStatus="count">
											<div class="dashboard_one">

												<div class="dashboard_single">
													<a class="text-white"><i class="icon-gift "></i>
														[${birth.empCode}] ${birth.name} <span
														style="float: right;">${birth.dob}</span> </a>
												</div>


											</div>
										</c:forEach>
									</div>


								</div>
							</div>



						</div>

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


					</div>
					<c:if test="${userType == 2}">

						<div class="row">
							<div class="col-md-4">
								<div class="card bg-primary">
									<div class="card-header header-elements-inline">
										<h6 class="card-title dash_title">New Hires (Past 30
											days)</h6>

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
													<a class="text-white">New Application</a>
												</div>
												<div class="dashboard_r">
													<a class="text-white">${lvDet.newApp}</a>
												</div>
												<div class="clr"></div>
											</div>

											<div class="dashboard_one">
												<div class="dashboard_l">
													<a class="text-white">Initial Authority
														Pending/Approved</a>
												</div>
												<div class="dashboard_r">
													<a class="text-white">${lvDet.newApp}/${lvDet.finalPending}</a>
												</div>
												<div class="clr"></div>
											</div>

											<div class="dashboard_one">
												<div class="dashboard_l">
													<a class="text-white">Final Authority Pending</a>
												</div>
												<div class="dashboard_r">
													<a class="text-white">${lvDet.finalPending}</a>
												</div>
												<div class="clr"></div>
											</div>
										</div>


									</div>
								</div>



							</div>



							<div class="col-md-4">
								<div class="card bg-primary">
									<div class="card-header header-elements-inline">
										<h6 class="card-title dash_title">Attendance Previous Day
											(Date: ${attnDet.attnDate})</h6>

									</div>

									<div class="card-body white_bg">


										<div class="dashboard_bx">
											<div class="dashboard_one">
												<div class="dashboard_l">
													<a class="text-white">Total Emp</a>
												</div>
												<div class="dashboard_r">
													<a class="text-white">${attnDet.preEmp+attnDet.lvEmp+attnDet.woEmp+attnDet.absentEmp}</a>
												</div>
												<div class="clr"></div>
											</div>



											<div class="dashboard_one">
												<div class="dashboard_l">
													<a class="text-white">Present</a>
												</div>
												<div class="dashboard_r">
													<a class="text-white">${attnDet.preEmp}</a>
												</div>
												<div class="clr"></div>
											</div>



											<div class="dashboard_one">
												<div class="dashboard_l">
													<a class="text-white">Leave</a>
												</div>
												<div class="dashboard_r">
													<a class="text-white">${attnDet.lvEmp}</a>
												</div>
												<div class="clr"></div>
											</div>



											<div class="dashboard_one">
												<div class="dashboard_l">
													<a class="text-white">Weekly Off Taken</a>
												</div>
												<div class="dashboard_r">
													<a class="text-white">${attnDet.woEmp}</a>
												</div>
												<div class="clr"></div>
											</div>



											<div class="dashboard_one">
												<div class="dashboard_l">
													<a class="text-white">Absent</a>
												</div>
												<div class="dashboard_r">
													<a class="text-white">${attnDet.absentEmp}</a>
												</div>
												<div class="clr"></div>
											</div>
										</div>



									</div>
								</div>

							</div>



						</div>

					</c:if>

					<c:if test="${userType == 2}">
						<div class="row">

							<div class="col-md-4">
								<div class="card bg-warning">
									<div class="card-header header-elements-inline">
										<h6 class="card-title dash_title">Today Weekly Off
											(Total)</h6>

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


						</div>
						<div class="row">
							<div class="col-md-4">
								<div class="card bg-primary">
									<div class="card-header header-elements-inline">
										<h6 class="card-title dash_title">Advance Deduction
											(Current Moth)</h6>

									</div>

									<div class="card-body white_bg">

										<div class="dashboard_bx">

											<div class="dashboard_one">
												<div class="dashboard_l">
													<a class="text-white">Total Emp/amount</a>
												</div>
												<div class="dashboard_r">
													<a class="text-white">${advDet.emp}/${advDet.advTot}</a>
												</div>
												<div class="clr"></div>
											</div>

											<div class="dashboard_one">
												<div class="dashboard_l">
													<a class="text-white">Total Skip Emp/Amt</a>
												</div>
												<div class="dashboard_r">
													<a class="text-white">${advDet.skipId}/${advDet.skipTott}</a>
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
										<h6 class="card-title dash_title">Loan Deduction (Current
											Moth)</h6>

									</div>

									<div class="card-body white_bg">
										<div class="dashboard_bx">
											<div class="dashboard_one">
												<div class="dashboard_l">
													<a class="text-white">Total Emp/amount</a>
												</div>
												<div class="dashboard_r">
													<a class="text-white">${loanDet.emp}/${loanDet.advTot}</a>
												</div>
												<div class="clr"></div>
											</div>

											<div class="dashboard_one">
												<div class="dashboard_l">
													<a class="text-white">Total Skip Emp/Amt</a>
												</div>
												<div class="dashboard_r">
													<a class="text-white">${loanDet.skipId}/${loanDet.skipTott}</a>
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
										<h6 class="card-title dash_title">Pay Deduction (Current
											Month)</h6>

									</div>

									<div class="card-body white_bg">
										<div class="dashboard_bx">
											<div class="dashboard_one">
												<div class="dashboard_l">
													<a class="text-white">Total Emp/amount</a>
												</div>
												<div class="dashboard_r">
													<a class="text-white">${dedDet.empCount}/${dedDet.tot}</a>
												</div>
												<div class="clr"></div>
											</div>
										</div>

									</div>
								</div>



							</div>
						</div>
					</c:if>
				</c:if>
				<!--  -->
				<!-- <div class="row">
					<div class="col-lg-3">
						<div class="card bg-teal-400">
							<div class="order_bx">
								<h2 class="order_title">
									<span class="order_one">Order</span> 1,587 <span>15 New
										Order</span>
								</h2>
								<i class="far fa-file-alt "></i>
							</div>
						</div>
					</div>
					<div class="col-lg-3">
						<div class="card bg-pink-400">
							<div class="order_bx">
								<h2 class="order_title">
									<span class="order_one">Visitors</span> 250 <span>Bonus
										rate 25%</span>
								</h2>
								<i class="far fa-chart-bar"></i>
							</div>
						</div>
					</div>
					<div class="col-lg-3">
						<div class="card bg-blue-400">
							<div class="order_bx">
								<h2 class="order_title">
									<span class="order_one">User</span> 120 <span>25 New
										User</span>
								</h2>
								<i class="far fa-user "></i>
							</div>
						</div>
					</div>
					<div class="col-lg-3">
						<div class="card bg-warning">
							<div class="order_bx">
								<h2 class="order_title">
									<span class="order_one">Alerts</span> 58 <span>5 New
										Alerts</span>
								</h2>
								<i class="far fa-bell"></i>
							</div>
						</div>
					</div>
				</div> -->


				<!-- 1st birthday row start here -->
				<!-- pie chart box -->

				<%-- <div class="row">



					<div class="col-lg-4">
						<div class="card tab_round">
							<h6 class="card-title dash_title">Employee Gender Spilt</h6>

							<div class="chart-container has-scroll text-center">
								<div class="chart-container has-scroll text-center">
									<div class="d-inline-block" id="google-donut">
										<div style="position: relative;">
											<div style="position: relative; width: 500px; height: 300px;"
												dir="ltr">
												<div
													style="position: absolute; left: 0px; top: 0px; width: 100%; height: 100%;"
													aria-label="A chart.">
													<svg width="500" height="300" style="overflow: hidden;"
														aria-label="A chart.">
					<defs id="_ABSTRACT_RENDERER_ID_108">
						<filter id="_ABSTRACT_RENDERER_ID_137">
							<feGaussianBlur in="SourceAlpha" stdDeviation="2"></feGaussianBlur>
							<feOffset dx="1" dy="1"></feOffset>
							<feComponentTransfer>
														<feFuncA type="linear" slope="0.1"></feFuncA></feComponentTransfer>dashboard
							<feMerge>
														<feMergeNode></feMergeNode>
														<feMergeNode in="SourceGraphic"></feMergeNode></feMerge>
						</filter>
					</defs>
					<g>
														<rect x="347" y="15" width="153" height="88" stroke="none"
															stroke-width="0" fill-opacity="0" fill="#ffffff"></rect>
					<g column-id="Work">
														<rect x="347" y="15" width="153" height="12" stroke="none"
															stroke-width="0" fill-opacity="0" fill="#ffffff"></rect>
					<g>
														<text text-anchor="start" x="364" y="25.2"
															font-family="Roboto" font-size="12" stroke="none"
															stroke-width="0" fill="#222222">Male</text></g>
					<circle cx="353" cy="21" r="6" stroke="none" stroke-width="0"
															fill="#2ec7c9"></circle></g>
					<g column-id="Eat">
														<rect x="347" y="34" width="153" height="12" stroke="none"
															stroke-width="0" fill-opacity="0" fill="#ffffff"></rect>
					<g>
														<text text-anchor="start" x="364" y="44.2"
															font-family="Roboto" font-size="12" stroke="none"
															stroke-width="0" fill="#222222">Female</text></g>
					<circle cx="353" cy="40" r="6" stroke="none" stroke-width="0"
															fill="#b6a2de"></circle></g>
					<g column-id="Commute">
														<rect x="347" y="53" width="153" height="12" stroke="none"
															stroke-width="0" fill-opacity="0" fill="#ffffff"></rect>
					<g>
														<text text-anchor="start" x="364" y="63.2"
															font-family="Roboto" font-size="12" stroke="none"
															stroke-width="0" fill="#222222">Others</text></g>
					<circle cx="353" cy="59" r="6" stroke="none" stroke-width="0"
															fill="#5ab1ef"></circle></g>
					<g column-id="Watch TV">
														<rect x="347" y="72" width="153" height="12" stroke="none"
															stroke-width="0" fill-opacity="0" fill="#ffffff"></rect>
					<g>
														<text text-anchor="start" x="364" y="82.2"
															font-family="Roboto" font-size="12" stroke="none"
															stroke-width="0" fill="#222222">Watch TV</text></g>
					<circle cx="353" cy="78" r="6" stroke="none" stroke-width="0"
															fill="#ffb980"></circle></g>
					<g column-id="Sleep">
														<rect x="347" y="91" width="153" height="12" stroke="none"
															stroke-width="0" fill-opacity="0" fill="#ffffff"></rect>
					<g>
														<text text-anchor="start" x="364" y="101.2"
															font-family="Roboto" font-size="12" stroke="none"
															stroke-width="0" fill="#222222">Sleep</text></g>
					<circle cx="353" cy="97" r="6" stroke="none" stroke-width="0"
															fill="#d87a80"></circle></g></g>
					<g>
														<path
															d="M189,75.75L189,15A135,135,0,0,1,223.9405710888403,280.3999865490242L208.21731409886218,221.71999260196333A74.25,74.25,0,0,0,189,75.75"
															stroke="#ffffff" stroke-width="1" fill="#2ec7c9"></path>
					<text text-anchor="start" x="278.38378230950497"
															y="140.32596185374723" font-family="Roboto"
															font-size="12" stroke="none" stroke-width="0"
															fill="#ffffff">45.8%</text></g>
					<g>
														<path
															d="M117.28000739803669,169.21731409886218L58.60001345097578,184.94057108884033A135,135,0,0,1,189,15L189,75.75A74.25,74.25,0,0,0,117.28000739803669,169.21731409886218"
															stroke="#ffffff" stroke-width="1" fill="#d87a80"></path>
					<text text-anchor="start" x="88.46588543482142"
															y="89.33469248923318" font-family="Roboto" font-size="12"
															stroke="none" stroke-width="0" fill="#ffffff">29.2%</text></g>
					<g>
														<path
															d="M136.49732149689885,202.50267850310115L93.5405845398161,245.45941546018392A135,135,0,0,1,58.60001345097578,184.94057108884033L117.28000739803669,169.21731409886218A74.25,74.25,0,0,0,136.49732149689885,202.50267850310115"
															stroke="#ffffff" stroke-width="1" fill="#ffb980"></path>
					<text text-anchor="start" x="81.95586138688061"
															y="208.78508387858582" font-family="Roboto"
															font-size="12" stroke="none" stroke-width="0"
															fill="#ffffff">8.3%</text></g>
					<g>
														<path
															d="M169.78268590113782,221.71999260196333L154.05942891115967,280.3999865490242A135,135,0,0,1,93.5405845398161,245.45941546018392L136.49732149689885,202.50267850310115A74.25,74.25,0,0,0,169.78268590113782,221.71999260196333"
															stroke="#ffffff" stroke-width="1" fill="#5ab1ef"></path>
					<text text-anchor="start" x="120.84766500034016"
															y="250.5926717792545" font-family="Roboto" font-size="12"
															stroke="none" stroke-width="0" fill="#ffffff">8.3%</text></g>
					<g>
														<path
															d="M208.21731409886218,221.71999260196333L223.9405710888403,280.3999865490242A135,135,0,0,1,154.05942891115967,280.3999865490242L169.78268590113782,221.71999260196333A74.25,74.25,0,0,0,208.21731409886218,221.71999260196333"
															stroke="#ffffff" stroke-width="1" fill="#b6a2de"></path>
					<text text-anchor="start" x="176.50000000000003"
															y="270.5631889090833" font-family="Roboto" font-size="12"
															stroke="none" stroke-width="0" fill="#ffffff">8.3%</text></g>
					<g></g>
					</svg>
													<div
														aria-label="A tabular representation of the data in the chart."
														style="position: absolute; left: -10000px; top: auto; width: 1px; height: 1px; overflow: hidden;">
														<table>
															<thead>
																<tr>
																	<th>Task</th>
																	<th>Hours per Day</th>
																</tr>
															</thead>
															<tbody>
																<tr>
																	<td>Work</td>
																	<td>11</td>
																</tr>
																<tr>
																	<td>Eat</td>
																	<td>2</td>
																</tr>
																<tr>
																	<td>Commute</td>
																	<td>2</td>
																</tr>
																<tr>
																	<td>Watch TV</td>
																	<td>2</td>
																</tr>
																<tr>
																	<td>Sleep</td>
																	<td>7</td>
																</tr>
															</tbody>
														</table>
													</div>
												</div>
											</div>
											<div
												style="display: none; position: absolute; top: 310px; left: 510px; white-space: nowrap; font-family: Roboto; font-size: 12px; font-weight: bold;"
												aria-hidden="true">11 (45.8%)</div>
											<div></div>
										</div>
									</div>
								</div>
							</div>

						</div>
					</div>
					<div class="col-lg-8">
						<div class="card tab_round">
							<h6 class="card-title dash_title">Employee Gender Split</h6>
							<div class="chart-container">
								<div class="chart has-fixed-height" id="columns_clustered"
									style="user-select: none; position: relative;"
									_echarts_instance_="ec_1584698065971">
									<div
										style="position: relative; overflow: hidden; width: 100%; height: 300px; padding: 0px; margin: 0px; border-width: 0px; cursor: default;">
										<canvas
											style="position: absolute; left: 0px; top: 0px; width: 100%; height: 300px; user-select: none; padding: 0px; margin: 0px; border-width: 0px;"
											data-zr-dom-id="zr_0" width="100%" height="300"></canvas>
									</div>
									<div
										style="position: absolute; display: none; border-style: solid; white-space: nowrap; z-index: 9999999; transition: left 0.4s cubic-bezier(0.23, 1, 0.32, 1) 0s, top 0.4s cubic-bezier(0.23, 1, 0.32, 1) 0s; background-color: rgba(0, 0, 0, 0.75); border-width: 0px; border-color: rgb(51, 51, 51); border-radius: 4px; color: rgb(255, 255, 255); font: 13px/20px Roboto, sans-serif; padding: 10px 15px; left: 87px; top: 103px;">
										Line<br> <span
											style="display: inline-block; margin-right: 5px; border-radius: 10px; width: 10px; height: 10px; background-color: #E57373;"></span>
										Version 1.7 - 2k data: 680<br> <span
											style="display: inline-block; margin-right: 5px; border-radius: 10px; width: 10px; height: 10px; background-color: #81C784;">
										</span>Version 1.7 - 2w data: 1,212<br> <span
											style="display: inline-block; margin-right: 5px; border-radius: 10px; width: 10px; height: 10px; background-color: #64B5F6;"></span>
										Version 1.7 - 20w data: 2,200<br> <br>Line<br>
										<span
											style="display: inline-block; margin-right: 5px; border-radius: 10px; width: 10px; height: 10px; background-color: #F44336;"></span>
										Version 2.0 - 2k data: 247<br> <span
											style="display: inline-block; margin-right: 5px; border-radius: 10px; width: 10px; height: 10px; background-color: #4CAF50;"></span>
										Version 2.0 - 2w data: 488<br> <span
											style="display: inline-block; margin-right: 5px; border-radius: 10px; width: 10px; height: 10px; background-color: #2196F3;"></span>
										Version 2.0 - 20w data: 906
									</div>
								</div>
							</div>
						</div>
					</div>

				</div> --%>

				<!-- Highlighting rows and columns -->
				<div class="card" style="margin: 30px 0 0 0;">

					<form action="${pageContext.request.contextPath}/dashboard">
						<div class="card-body">
							<div class="form-group row title_row">
								<label
									class="col-form-label text-info font-weight-bold spacing_filed"
									for="dob">Date <span class="text-danger">*</span>:
								</label>
								<div>
									<input type="text" class="form-control datepickerclass"
										placeholder=" " id="fiterdate" name="fiterdate"
										value="${fiterdate}" autocomplete="off" onchange1="trim(this)">
									<span class="hidedefault  validation-invalid-label"
										id="error_empDob" style="display: none;">This field is
										required.</span>
								</div>
								<div>
									<button type="submit" class="btn bg-blue ml-3 legitRipple"
										id="submtbtn">
										Submit <i class="icon-paperplane ml-2"></i>
									</button>
								</div>
							</div>
						</div>
						<div class="card-body fixed_height">


							<!-- new code start here -->
							<!-- <div class="row">
								<div class="col-lg-4">

									Members online
									<div class="card bg-teal-400">
										<div class="card-body">
											<div class="d-flex">
												<h3 class="font-weight-semibold mb-0">3,450</h3>
												<span
													class="badge bg-teal-800 badge-pill align-self-center ml-auto">+53,6%</span>
											</div>

											<div>
												Members online
												<div class="font-size-sm opacity-75">489 avg</div>
											</div>
										</div>


									</div>
									/members online

								</div>

								<div class="col-lg-4">

									Current server load
									<div class="card bg-pink-400">
										<div class="card-body">
											<div class="d-flex">
												<h3 class="font-weight-semibold mb-0">49.4%</h3>
												<div class="list-icons ml-auto">
													<div class="dropdown">
														<a class="list-icons-item dropdown-toggle"
															data-toggle="dropdown"><i class="icon-cog3"></i></a>
														<div class="dropdown-menu dropdown-menu-right">
															<a class="dropdown-item"><i class="icon-sync"></i>
																Update data</a> <a class="dropdown-item"><i
																class="icon-list-unordered"></i> Detailed log</a> <a
																class="dropdown-item"><i class="icon-pie5"></i>
																Statistics</a> <a class="dropdown-item"><i
																class="icon-cross3"></i> Clear list</a>
														</div>
													</div>
												</div>
											</div>

											<div>
												Current server load
												<div class="font-size-sm opacity-75">34.6% avg</div>
											</div>
										</div>


									</div>
									/current server load

								</div>

								<div class="col-lg-4">

									Today's revenue
									<div class="card bg-blue-400">
										<div class="card-body">
											<div class="d-flex">
												<h3 class="font-weight-semibold mb-0">$18,390</h3>
												<div class="list-icons ml-auto">
													<a class="list-icons-item" data-action="reload"></a>
												</div>
											</div>

											<div>
												Today's revenue
												<div class="font-size-sm opacity-75">$37,578 avg</div>
											</div>
										</div>


									</div>
									/today's revenue

								</div>
							</div> -->

							<!-- new code end here -->

							<!-- end of if condtion -->

							<c:if test="${userType == 2 || isAuth > 0 }">

								<div class="row">
									<div class="col-md-4">
										<div class="card bg-primary">
											<div class="card-header header-elements-inline">
												<h6 class="card-title dash_title">My Attendance
													(Current Month)</h6>

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
															<div class="dashboard_l">
																<a class="text-white">Total Pending Application</a>
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

												<div class="dashboard_one">
													<div class="dashboard_l">
														<a class="text-white">Performance Incentive(Amt/Days)</a>
													</div>
													<div class="dashboard_r">
														<a class="text-white">${perfList.prodAmt}/${perfList.prodDays}</a>
													</div>
													<div class="clr"></div>
												</div>

												<div class="dashboard_one">
													<div class="dashboard_l">
														<a class="text-white">Production Incentive(Amt/Days)</a>
													</div>
													<div class="dashboard_r">
														<a class="text-white">${prodList.prodAmt}/${prodList.prodDays}</a>
													</div>
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
													<a
														href="${pageContext.request.contextPath}/showApplyForLeave"
														class="text-white"> Apply Leave </a>
												</div>

												<c:if test="${isAuth > 0 || userType==2}">

													<div class="dashboard_single">
														<a
															href="${pageContext.request.contextPath}//viewPayDeduction"
															class="text-white"> Pay Deduction</a>
													</div>
													<div class="dashboard_single">
														<a
															href="${pageContext.request.contextPath}/viewEmpRewarAddList"
															class="text-white"> Add Reward </a>
													</div>
													<div class="dashboard_single">
														<a
															href="${pageContext.request.contextPath}/showEmpListToAddAdvance"
															class="text-white"> Add Advance </a>
													</div>

													<div class="dashboard_single">
														<a
															href="${pageContext.request.contextPath}/showEmpListToAddLoan"
															class="text-white"> Add Loan </a>
													</div>

													<c:if test="${userType==2}">
														<div class="dashboard_single">
															<a
																href="${pageContext.request.contextPath}/attendanceSelectMonth"
																class="text-white"> Upload Attendence </a>
														</div>
													</c:if>
													<div class="dashboard_single">
														<a class="text-white"> Add OT Hour </a>
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
												<h6 class="card-title dash_title">Reward (Current
													Month)</h6>

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


									<div class="col-md-4">
										<div class="card bg-warning">
											<div class="card-header header-elements-inline">
												<h6 class="card-title dash_title">Performance Bonus
													(Current Month)</h6>

											</div>
											<div class="card-body white_bg">

												<div class="dashboard_bx">
													<c:forEach items="${perfListDept}" var="perfListDept"
														varStatus="count">

														<div class="dashboard_one">
															<div class="dashboard_l">
																<a class="text-white">${perfListDept.nameSd}</a>
															</div>
															<div class="dashboard_r">
																<a class="text-white">${perfListDept.empCount}</a>
															</div>
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


			<!-- Full width modal -->
			<!-- <div id="modal_full" class="modal fade" tabindex="-1">
				<div class="modal-dialog popup_third">
					modal-half
					<div class="modal-content">

						<div class="late_popup">

							<div class="late_title">Late Employee Details</div>

							<button type="button" class="close cross" data-dismiss="modal">&times;</button>

							<div class="row">
								<div class="col-md-3">
									<img
										src="https://aeealberta.org/wp-content/uploads/2018/10/profile.png"
										class="late_pic">
								</div>
								<div class="col-md-9">
									<div class="row pop_one_row">
										<div class="col-md-4 emp_nm">Employee Name :</div>
										<div class="col-md-8">Akshay Madhukar Raoandore</div>
									</div>
									<div class="row pop_one_row">
										<div class="col-md-4 emp_nm">Designation :</div>
										<div class="col-md-8">.Net Developer</div>
									</div>
									<div class="row pop_one_row">
										<div class="col-md-4 emp_nm">Department :</div>
										<div class="col-md-8">Development</div>
									</div>
									<div class="row pop_one_row">
										<div class="col-md-4 emp_nm">Mobile No :</div>
										<div class="col-md-8">+91 9876543210</div>
									</div>
									<div class="row pop_one_row">
										<div class="col-md-4 emp_nm">Alternate Mobile :</div>
										<div class="col-md-8">+91 9876543210</div>
									</div>
									<div class="row pop_one_row">
										<div class="col-md-4 emp_nm">Leave Authorities :</div>
										<div class="col-md-8">Human Resource Person (HR)</div>
									</div>

								</div>

							</div>



						</div>


					</div>
				</div>
			</div> -->
			<div id="modal_full" class="modal fade" tabindex="-1">
				<div class="modal-dialog popup_third">
					<!-- modal-half -->
					<div class="modal-content">

						<div class="late_popup">

							<div class="late_title" id="detailGraphHead">Late Employee
								Details</div>

							<button type="button" class="close cross" data-dismiss="modal">&times;</button>
							<div class="modal-body" id="modalbody">
								<!-- <div class="row">
									<div class="col-md-3">
										<img
											src="https://aeealberta.org/wp-content/uploads/2018/10/profile.png"
											class="late_pic">
									</div>
									<div class="col-md-9">
										<div class="row pop_one_row">
											<div class="col-md-4 emp_nm">Employee Name :</div>
											<div class="col-md-8">Akshay Madhukar Raoandore</div>
										</div>
										<div class="row pop_one_row">
											<div class="col-md-4 emp_nm">Designation :</div>
											<div class="col-md-8">.Net Developer</div>
										</div>
										<div class="row pop_one_row">
											<div class="col-md-4 emp_nm">Department :</div>
											<div class="col-md-8">Development</div>
										</div>
										<div class="row pop_one_row">
											<div class="col-md-4 emp_nm">Mobile No :</div>
											<div class="col-md-8">+91 9876543210</div>
										</div>
										<div class="row pop_one_row">
											<div class="col-md-4 emp_nm">Alternate Mobile :</div>
											<div class="col-md-8">+91 9876543210</div>
										</div>
										<div class="row pop_one_row">
											<div class="col-md-4 emp_nm">Leave Authorities :</div>
											<div class="col-md-8">Human Resource Person (HR)</div>
										</div>

									</div>

								</div> -->

							</div>

						</div>


					</div>
				</div>
			</div>
			<!-- /full width modal -->






			<script type="text/javascript">
				function getEmpData(empId, graphType) {
					//alert(empId)

					//alert(var1+':'+var2);

					if (graphType == 1) {
						$("#detailGraphHead").html("Late Employee Details");
					} else {
						$("#detailGraphHead").html(
								"Leave and Absent Employee Details");
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
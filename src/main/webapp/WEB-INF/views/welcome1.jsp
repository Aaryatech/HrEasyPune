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

				<div class="card-body">

					<c:choose>
						<c:when test="${designType==1}">
							<%-- <h6>Weekly off Count</h6>

							<div class="table-responsive">

								<table
									class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
									width="100%" id="printtable1">

									<thead>
										<tr class="bg-blue" style="text-align: center;">

											<th class="text-center" width="10%">SR No.</th>
											<th class="text-center">Name</th>
											<th class="text-center" width="10%">No Of Weekly Off</th>


										</tr>
									</thead>
									<tbody>


										<c:forEach items="${weeklyofcountList}"
											var="weeklyofcountList" varStatus="count">
											<tr>
												<td>${count.index+1}</td>
												<td>${weeklyofcountList.empName}
													&nbsp;(${weeklyofcountList.empCode})</td>
												<td class="text-center">${weeklyofcountList.weeklyOff}</td>
											</tr>
										</c:forEach>


									</tbody>
								</table>
							</div>
 --%>


							<!-- Sachin -->
<c:if test="${is_hod_dashb_show==1}">
							<h6>HOD DASHBOARD</h6>
							<div class="table-responsive">

								<table
									class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
									width="100%" id="printtable1">

									<thead>
										<tr class="bg-blue" style="text-align: center;">

											<th class="text-center">Name</th>
											<th class="text-center">Weeks Completed</th>
											<th class="text-center">Working Days</th>
											<th class="text-center">Present Days</th>
											<th class="text-center">Weekly Offs to be covered</th>
											<th class="text-center">WO Actually Covered</th>
											<th class="text-center">Pending Weekly offs</th>
											<th class="text-center">WIAB</th>
											<th class="text-center">Last month pending WO</th>
											<th class="text-center">OT last month</th>
										</tr>
									</thead>
									<tbody>


										<c:forEach items="${dashBList}" var="dashBList"
											varStatus="count">
											<tr>
												<td>${dashBList.firstName}&nbsp;${dashBList.surname} (${dashBList.empCode})</td>
												<td class="text-center">${currWeekNo}</td>

												<td class="text-center">${dashBList.workingDays}</td>

												<td class="text-center">${dashBList.presentDays}</td>

												<td class="text-center">${noOfWoffs-dashBList.weekOffCovered}</td>
												<td class="text-center">${dashBList.weekOffCovered}</td>

												<td class="text-center">${noOfWoffs-dashBList.weekOffCovered}</td>

												<td class="text-center">${dashBList.abDays}</td>

												<td class="text-center">${noOfWoffs-dashBList.lastMonthPendWoff}</td>
												<td class="text-center">${dashBList.otLastMonth}</td>
											</tr>
										</c:forEach>


									</tbody>
								</table>
							</div>
							</c:if>
						</c:when>
						<c:otherwise>
							<h6>Dashboard</h6>
						</c:otherwise>
					</c:choose>

				</div>

			</div>
			<div class="content">


				<!-- Highlighting rows and columns -->
				<div class="card"></div>
			</div>

			<!-- /content area -->


			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
			<!-- /footer -->

		</div>
		<!-- /main content -->

	</div>
	<script type="text/javascript">
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
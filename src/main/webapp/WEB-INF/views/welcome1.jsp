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

								<div id="modal_step1" class="modal fade " data-backdrop="false"
									tabindex="-1">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header bg-info">
												<h6 class="modal-title">Searching...</h6>
												<!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
											</div>

											<div class="modal-body">
												<h6 class="font-weight-semibold text-center">
													<h6>Please wait.....</h6>
												</h6>

												<hr>
												<p class="text-center text-info"></p>
											</div>

											<div class="modal-footer"></div>
										</div>
									</div>
								</div>

								<h6>HOD DASHBOARD</h6>
								<div class="row">
									<div class="col-md-6">
										<label
											class="col-form-label text-info font-weight-bold col-lg-5 float"
											for="vendor">Department <span class="text-danger">*
										</span>:
										</label>
										<div class="col-lg-7 float">
											<select name="deptId" data-placeholder="Select Dept"
												id="deptId"
												class="form-control form-control-select2 select2-hidden-accessible">
												<option selected disabled value="-1">Select
													Department</option>
												<c:forEach items="${deptList}" var="dept">
													<option value="${dept.departId}">${dept.nameSd}</option>
												</c:forEach>
											</select>

										</div>
									</div>
									<div class="col-md-2">
										<div style="margin: 0 auto;">
											<!--  class="col-lg-10 ml-lg-auto" -->

											<button type="button" class="btn blue_btn" id="searchbutton"
												onclick="searchDashboard()">
												Search <i class="icon-paperplane ml-2"></i>
											</button>
										</div>
									</div>
								</div>
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


											<%-- <c:forEach items="${dashBList}" var="dashBList"
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
										</c:forEach> --%>


										</tbody>
									</table>
								</div>

								<h6 style="font-weight: bold; margin-left: 180px;" >Department Summary</h6>
								<div class="col-md-6">
								<div class="table-responsive">

									<table class="table table-bordered  table-hover   table-striped" width="100%" id="printtable2">

										<thead>

										</thead>
										<tbody>
											<tr>
												<td class="text-left">Department OT Last Month</td>
												<td class="text-left" id="ot_lm"></td>
											</tr>
											<tr>

												<td class="text-left">Department Total HR</td>
												<td class="text-left" id="tot_hr"></td>
											</tr>
											<tr>

												<td class="text-left">BM-HR</td>
												<td class="text-left" id="bm_hr"></td>
											</tr>
											<tr>

												<td class="text-left">Actual Present Today</td>
												<td class="text-left" id="ac_pres_td"></td>
											</tr>
											<tr>
												<td class="text-left">Total Absent Today</td>
												<td class="text-left" id="to_ab_td"></td>
											</tr>
											<%-- <c:forEach items="${dashBList}" var="dashBList"
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
										</c:forEach> --%>

										</tbody>
									</table>
								</div>
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
				leftColumns : 1,
				rightColumns : 0
			}

		});

		function appendData(responseData) {

			var dataTable = $('#printtable1').DataTable();
			dataTable.clear().draw();
			var currWeekNo = ${currWeekNo};
			var noOfWoffs = ${noOfWoffs};

			$.each(responseData, function(i, v) {
				var x = parseInt(noOfWoffs) - parseInt(v.weekOffCovered);
				var x1 = parseInt(noOfWoffs) - parseInt(v.lastMonthPendWoff);
				dataTable.row.add(
						[ v.firstName + ' ' + v.surname + ' (' + v.empCode+')',
								currWeekNo, v.workingDays, v.presentDays, x,
								v.weekOffCovered, x, v.abDays, x1,
								v.otLastMonth ]).draw();
			});
			$('#modal_step1').modal('hide');
		}//end of function appendData.

		function searchDashboard() {
			$('#modal_step1').modal('show');
			var fd = new FormData();
			var deptId = document.getElementById("deptId").value;

			fd.append('deptId', deptId);

			$.ajax({
				url : '${pageContext.request.contextPath}/getHodDashboard',
				type : 'post',
				dataType : 'json',
				data : fd,
				contentType : false,
				processData : false,
				success : function(responseData) {
					if (responseData == "" || responseData == null) {
						$('#modal_step1').modal('hide');
					}
					appendData(responseData.hodDashList);
					var data2=responseData.hodDeptList;
				//	alert(data2);
					$.each(data2, function(i, v) {
						document.getElementById("to_ab_td").innerHTML=v.abDays;
						document.getElementById("ac_pres_td").innerHTML=v.presentDays;
							document.getElementById("bm_hr").innerHTML=v.actualEmpCount;
								document.getElementById("tot_hr").innerHTML=v.reqEmpCount;
									document.getElementById("ot_lm").innerHTML=v.otLastMonth;
						});
					
				}
			});

			/* $
					.ajax({
						url : '${pageContext.request.contextPath}/getHodDeptSummaryDashb',
						type : 'post',
						dataType : 'json',
						data : fd,
						contentType : false,
						processData : false,
						success : function(data) {
							$.each(data, function(i, v) {
							document.getElementById("to_ab_td").innerHTML=v.abDays;
							document.getElementById("ac_pres_td").innerHTML=v.presentDays;
								document.getElementById("bm_hr").innerHTML=v.actualEmpCount;
									document.getElementById("tot_hr").innerHTML=v.reqEmpCount;
										document.getElementById("ot_lm").innerHTML=v.otLastMonth;
							});
						}
					}); */
			$('#modal_step1').modal('hide');
		} //end of Function getData();
	</script>
</body>
</html>
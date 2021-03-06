<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"
	import="java.text.SimpleDateFormat"%>
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
			<div class="page-header page-header-light"></div>
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">

				<!-- Form validation -->
				<div class="row">
					<div class="col-md-12">
						<!-- Title -->
						<!-- <div class="mb-3">
							<h6 class="mb-0 font-weight-semibold">Hidden labels</h6>
							<span class="text-muted d-block">Inputs with empty values</span>
						</div> -->
						<!-- /title -->


						<div class="card">


							<div class="card-header header-elements-inline">
								<h5 class="pageTitle">
									<i class="icon-list-unordered"></i> Employee Attendance Details
									for ${year}-${month}
								</h5>
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
								<div class="form-group row">
									<label class="col-form-label col-lg-2"> Employee Code :
									</label> <label class="col-form-label col-lg-2">
										${summaryAttendance.empCode}</label> <label
										class="col-form-label col-lg-2"> Employee Name : </label> <label
										class="col-form-label col-lg-2">${summaryAttendance.empName}</label>
								</div>

								<div class="form-group row">
									<label class="col-form-label col-lg-1"> Total Days : </label> <label
										class="col-form-label col-lg-1">${summaryAttendance.totalDaysInmonth}</label>
									<label class="col-form-label col-lg-1"> Working Days :
									</label> <label class="col-form-label col-lg-1">${summaryAttendance.workingDays}</label>
									<label class="col-form-label col-lg-1"> Present : </label> <label
										class="col-form-label col-lg-1">${summaryAttendance.presentDays}</label>
									<label class="col-form-label col-lg-1"> Weekly Off : </label> <label
										class="col-form-label col-lg-1">${summaryAttendance.weeklyOff}</label>
									<label class="col-form-label col-lg-1"> Holiday : </label> <label
										class="col-form-label col-lg-1">${summaryAttendance.paidHoliday}</label>
								</div>

								<div class="form-group row">
									<label class="col-form-label col-lg-1"> Paid Leave : </label> <label
										class="col-form-label col-lg-1">${summaryAttendance.paidLeave}</label>
									<%-- <label class="col-form-label col-lg-1"> Unpaid Leave :
									</label> <label class="col-form-label col-lg-1">${summaryAttendance.unpaidLeave}</label> --%>
									<label class="col-form-label col-lg-1"> Absent Days : </label>
									<label class="col-form-label col-lg-1">${summaryAttendance.absentDays}</label>
									<label class="col-form-label col-lg-1"> Unpaid Leave :
									</label> <label class="col-form-label col-lg-1">${summaryAttendance.unpaidLeave}</label>
									<label class="col-form-label col-lg-1"> Payable Days :
									</label> <label class="col-form-label col-lg-1">${summaryAttendance.payableDays}</label>
									<c:if test="${mstEmpType.otApplicable eq 'Yes' }">
										<label class="col-form-label col-lg-1"> Production
											Incentive Hrs: </label>
										<label class="col-form-label col-lg-1">${summaryAttendance.totOthr}</label>
									</c:if>

									<%-- <label class="col-form-label col-lg-1"> NCP Days : </label> <label
										class="col-form-label col-lg-1">${summaryAttendance.ncpDays}</label> --%>
								</div>
								<div class="form-group row">

									<label class="col-form-label col-lg-1"> Total Late Mark
										: </label> <label class="col-form-label col-lg-1">${summaryAttendance.totLate}</label>



									<label class="col-form-label col-lg-1"> Total Late Mark
										Deduction : </label> <label class="col-form-label col-lg-1">${summaryAttendance.totlateDays}</label>

								</div>


							</div>
							<hr>

							<div id="editAttanceDiv" style="display: none;">
								<div class="card-header header-elements-inline">
									<h5 class="card-title">Edit Attendance Detail</h5>
								</div>
								<div class="card-body">
									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="attDate">
											Date : </label>
										<div class="col-lg-2">
											<input type="text" class="form-control"
												placeholder="Attendace Date" id="attDate" name="attDate"
												autocomplete="off" disabled>

										</div>
										<div class="col-lg-1"></div>
										<label class="col-form-label col-lg-2" for="attStatus">
											Status : </label>
										<div class="col-lg-2">
											<input type="text" class="form-control" placeholder="Status"
												id="attStatus" name="attStatus" autocomplete="off" disabled>

										</div>
									</div>

									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="selectStatus">
											Select Shift : </label>
										<div class="col-lg-4">
											<select name="selectShift"
												data-placeholder="Select Leave Type" id="selectShift"
												class="form-control ">
												<option value="0">Select Shift</option>
												<c:forEach items="${shiftMaster}" var="shiftMaster">
													<%-- data-leavestrname="${leaveHistoryList.lvTitle}" --%>
													<option value="${shiftMaster.id}">${shiftMaster.shiftname}</option>

												</c:forEach>
											</select>
										</div>

									</div>

									<div class="form-group row">
										<label class="col-form-label col-lg-2" for="selectUpdateBy">
											Update By : </label>
										<div class="col-lg-3">
											<input type="radio" name="selectUpdateBy" id="byStatus"
												value="1" checked onclick="openHideDiv(1)">By Status
											<input type="radio" name="selectUpdateBy" id="byIntime"
												value="2" onclick="openHideDiv(2)">In Time and Out
											Time
										</div>
										<div class="col-lg-2">
											<button type="button" class="btn bg-blue ml-3 legitRipple"
												id="addleave" onclick="addLeave()">Add Leave</button>
										</div>
									</div>
									<div id="byStatusDive">
										<div class="form-group row">
											<label class="col-form-label col-lg-2" for="selectStatus">
												Select Status : </label>
											<div class="col-lg-2">
												<select name="selectStatus"
													data-placeholder="Select Leave Type" id="selectStatus"
													class="form-control form-control-select2 select2-hidden-accessible">
													<option value="0" data-namesd="Select Status" id="newSts0">Select
														Status</option>
													<c:forEach items="${lvTypeList}" var="lvTypeList">

														<option value="${lvTypeList.lvSumupId}"
															data-namesd="${lvTypeList.nameSd}"
															id="newSts${lvTypeList.lvSumupId}">${lvTypeList.nameSdShow}</option>

													</c:forEach>
												</select>
											</div>
											<div class="col-lg-1"></div>


										</div>
										<div class="form-group row">
											<label class="col-form-label col-lg-2" for="lateMark">
												Late Mark : </label>
											<div class="col-lg-2">
												<input type="checkbox" class="chk" name="lateMark"
													id="lateMark">
											</div>
											<div class="col-lg-1"></div>
											<label class="col-form-label col-lg-2" for="lateMin">
												Late Min : </label>
											<div class="col-lg-2">
												<input type="text" class="form-control numbersOnly"
													placeholder="Late Min" id="lateMin" name="lateMin"
													autocomplete="off">

											</div>
										</div>
										<div class="form-group row">
											<label class="col-form-label col-lg-2" for="otHours">
												Production Incentive Hrs : </label>
											<div class="col-lg-2">
												<input type="time" class="form-control"
													placeholder="OT Hours" id="otHours" name="otHours"
													autocomplete="off">

											</div>
											<div class="col-lg-1"></div>
											<label class="col-form-label col-lg-2" for="otApproval">
												Approve PI : </label>
											<div class="col-lg-2">
												<select name="otApproval" id="otApproval"
													class="form-control ">
													<option value="0">Select</option>
													<option value="1">Approve</option>

												</select>
											</div>

										</div>
									</div>
									<div id="byIntimeDive" style="display: none;">
										<div class="form-group row">
											<label class="col-form-label col-lg-2" for="inTime">
												In Time : </label>
											<div class="col-lg-2">
												<input type="time" class="form-control"
													placeholder="In Time" id="inTime" name="inTime"
													autocomplete="off">

											</div>
											<div class="col-lg-1"></div>
											<label class="col-form-label col-lg-2" for="outTime">
												Out Time : </label>
											<div class="col-lg-2">
												<input type="time" class="form-control"
													placeholder="Out Time" id="outTime" name="outTime"
													autocomplete="off">

											</div>
										</div>

									</div>



									<div class="col-md-12 text-center">
										<button type="submit" class="btn bg-blue ml-3 legitRipple"
											id="submtbtnn" onclick="saveAttendanceDetail()">Save</button>
										<button type="button" class="btn btn-primary"
											onclick="closeEditDetailTab()">Cancel</button>
										<input type="hidden" class="form-control"
											placeholder="Out Time" id="dailyId" name="dailyId"
											autocomplete="off"> <input type="hidden"
											class="form-control" placeholder="Out Time" id="dailyId"
											name="dailyId" autocomplete="off"> <input
											type="hidden" id="lvSumupId" name="lvSumupId" value="0"><input
											type="hidden" id="year" name="year" value="${year}">
										<input type="hidden" id="month" name="month" value="${month}">
										<input type="hidden" id="empId" name="empId" value="${empId}">

									</div>


								</div>
								<hr>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<table
										class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
										id="printtable1">


										<thead>
											<tr class="bg-blue" style="text-align: center;">

												<th class="text-center">Date</th>
												<th class="text-center">Status</th>
												<th class="text-center">In Time</th>
												<th class="text-center">Out Time</th>
												<th class="text-center">Late Mark</th>
												<th class="text-center">Late MIN</th>
												<th class="text-center">WR. Hrs</th>
												<c:if test="${mstEmpType.otApplicable eq 'Yes' }">
													<th class="text-center">Production Incentive <br>Hrs
													</th>
												</c:if>
												<th class="text-center">OShift/Loc</th>
												<th class="text-center">Action</th>

											</tr>
										</thead>
										<tbody>
											<c:forEach items="${dailyrecordList}" var="dailyrecordList">
												<tr>
													<td class="text-center">${dailyrecordList.attDate}</td>
													<td class="text-center">${dailyrecordList.attsSdShow}</td>

													<c:choose>
														<c:when test="${dailyrecordList.inTime eq '00:00:00'}">
															<td class="text-center" style="background-color: #FFA8A8">${dailyrecordList.inTime}</td>
														</c:when>
														<c:otherwise>
															<td class="text-center">${dailyrecordList.inTime}</td>
														</c:otherwise>
													</c:choose>

													<c:choose>
														<c:when test="${dailyrecordList.outTime eq '00:00:00'}">
															<td class="text-center" style="background-color: #FFA8A8">${dailyrecordList.outTime}</td>
														</c:when>
														<c:otherwise>
															<td class="text-center">${dailyrecordList.outTime}</td>
														</c:otherwise>
													</c:choose>


													<c:choose>
														<c:when test="${dailyrecordList.lateMark==1}">
															<td class="text-center" style="background-color: #FF9">Yes</td>
														</c:when>
														<c:otherwise>
															<td class="text-center">No</td>
														</c:otherwise>
													</c:choose>
													<td class="text-right">${dailyrecordList.lateMin}</td>
													<td class="text-right">${dailyrecordList.workingHrs}</td>
													<c:if test="${mstEmpType.otApplicable eq 'Yes' }">

														<c:set value="" var="bgclr"></c:set>
														<c:choose>
															<c:when test="${dailyrecordList.freezeBySupervisor==1}">
																<c:set value="#e4cf12" var="bgclr"></c:set>
															</c:when>
															<c:when test="${dailyrecordList.freezeBySupervisor==2}">
																<c:set value="#a2951e" var="bgclr"></c:set>
															</c:when>
														</c:choose>
														<td class="text-right" style="background-color: ${bgclr}">${dailyrecordList.otHr}</td>
													</c:if>
													<td>${dailyrecordList.currentShiftname}</td>
													<td class="text-center"><c:if
															test="${dailyrecordList.isFixed==0 && dailyrecordList.atsummUid eq '0'}">

															<c:choose>
																<c:when
																	test="${(dailyrecordList.attStatus eq 'WO-OT' 
																	|| dailyrecordList.attStatus eq 'PH-OT' 
																	|| dailyrecordList.attStatus eq 'PH-WO-P')}">
																	<a href="#"
																		onclick="editAttendanceDetail(${dailyrecordList.id})"
																		class="list-icons-item text-primary-600"
																		data-popup="tooltip" title="edit"><i
																		class="icon-pencil7"></i></a>&nbsp;
																		 <c:if test="${mstEmpType.whWork eq 'Compoff'}">
																		<a href="#"
																			class="list-icons-item text-primary-600 bootbox_custom"
																			data-dailyid="${dailyrecordList.id}"
																			data-attstatus="${dailyrecordList.attStatus}"
																			data-popup="tooltip" title="Mark As Compoff">Mark
																			as Compoff</a>
																	</c:if>
																</c:when>
																<c:otherwise>
																	<a href="#"
																		onclick="editAttendanceDetail(${dailyrecordList.id})"
																		class="list-icons-item text-primary-600"
																		data-popup="tooltip" title=""><i
																		class="icon-pencil7"></i></a>
																</c:otherwise>
															</c:choose>
														</c:if></td>
												</tr>
											</c:forEach>




										</tbody>
									</table>
								</div>


							</div>
						</div>


					</div>
				</div>

			</div>
			<!-- /content area -->
			<!-- Info modal -->
			<div id="modal_step1" class="modal fade " data-backdrop="false"
				tabindex="-1">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header bg-info">
							<h6 class="modal-title">Updating Attendance</h6>
							<!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
						</div>

						<div class="modal-body">
							<h6 class="font-weight-semibold text-center">
								<h6>Please wait.....</h6>
							</h6>

							<hr>
							<p class="text-center text-info">If it is taking time please
								reload the page</p>
						</div>

						<div class="modal-footer">
							<!--   <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button> -->

						</div>
					</div>
				</div>
			</div>

			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
			<!-- /footer -->

		</div>
		<!-- /main content -->

	</div>
	<!-- /page content -->
	<!-- Large modal -->
	<div id="modal_large1" class="modal fade" tabindex="-1">

		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title"></h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<div class="modal-body" id="modalbody">
					<!--  Profile Model -->
					<!--  Profile Model -->
					<!--  Profile Model -->
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
					<!-- <button type="button" class="btn bg-primary">Save changes</button> -->
				</div>
			</div>
		</div>
	</div>
	<!-- /large modal -->
	<script type="text/javascript">
		function openHideDiv(value) {

			if (value == 1) {

				document.getElementById("byIntimeDive").style.display = 'none';
				document.getElementById("byStatusDive").style.display = 'block';

			} else {
				document.getElementById("byIntimeDive").style.display = 'block';
				document.getElementById("byStatusDive").style.display = 'none';
			}
		}

		function closeEditDetailTab() {

			document.getElementById("editAttanceDiv").style.display = 'none';
		}

		function editAttendanceDetail(dailyId) {
 
			
			
			var fd = new FormData();
			fd.append('dailyId', dailyId);
			
			$
			.ajax({
				url : '${pageContext.request.contextPath}/editDailyRecord',
				type : 'post',
				dataType : 'json',
				data : fd,
				contentType : false,
				processData : false,
				success : function(response) {

					document.getElementById("editAttanceDiv").style.display = 'block';
					document.getElementById("byIntimeDive").style.display = 'none';
					document.getElementById("byStatusDive").style.display = 'block';
					document.getElementById("byStatus").checked = true;
					document.getElementById("dailyId").value = response.id;
					document.getElementById("lvSumupId").value = response.lvSumupId;
					document.getElementById("attDate").value = response.attDate;
					document.getElementById("attStatus").value = response.attsSdShow;
					document.getElementById("selectShift").value = response.currentShiftid;
					
					if(response.otHr.length==4){
						document.getElementById("otHours").value = 0+response.otHr;
					}else{
						document.getElementById("otHours").value = response.otHr;
					}
					

					document.getElementById("inTime").value = response.inTime.substr(0, 5);
					document.getElementById("outTime").value = response.outTime.substr(0, 5);
					
					
					if(response.lateMark==1){
						document.getElementById("lateMark").checked = true;
					}else{
						document.getElementById("lateMark").checked = false;
					}
					document.getElementById("lateMin").value=response.lateMin;
				},
			});

		}
		
	function markAsCompOff(dailyId,sts) {
 
			//alert(sts);
			
			var fd = new FormData();
			fd.append('dailyId', dailyId);
			fd.append('sts', sts);
			$('#modal_step1').modal('show');
			
			  $
			.ajax({
				url : '${pageContext.request.contextPath}/markAsCompOff',
				type : 'post',
				dataType : 'json',
				data : fd,
				contentType : false,
				processData : false,
				success : function(response) {

					location.reload(true);
					 
				},
			}); 

		}
		
	function saveAttendanceDetail() {
  
	 
		
		
		var selectStatus = document.getElementById("selectStatus").value;
		var selectStatusText = $("#newSts"+selectStatus).data("namesd");
		 
		var namesd = $("#selectStatus option:selected").text();
		var otHours = document.getElementById("otHours").value;  
		var dailyId = document.getElementById("dailyId").value;
		var inTime = document.getElementById("inTime").value;
		var outTime = document.getElementById("outTime").value;
		var selectShift = document.getElementById("selectShift").value;
		
		var byStatus=1;
		var lateMark=0;
		var month = document.getElementById("month").value;
		var year = document.getElementById("year").value;
		var otApproval = document.getElementById("otApproval").value;
		
		if(document.getElementById("byIntime").checked==true){
			byStatus=2;
		}
		if(document.getElementById("lateMark").checked==true){
			lateMark=1;
		}
		var lateMin = document.getElementById("lateMin").value;
		if(lateMin==""){
			lateMin=0;
		}
		var lvSumupId = $("#lvSumupId").val();
		
		if((lvSumupId==7 || lvSumupId==11) && byStatus==1 && selectStatus!=0){
			
			bootbox.alert("Leave has applied on this date. first cancel leave.");
 
		}else{
			$('#modal_step1').modal('show');
			
			var fd = new FormData();
			fd.append('dailyId', dailyId);
			fd.append('otHours', otHours);
			fd.append('selectStatus', selectStatus);
			fd.append('byStatus', byStatus);
			fd.append('lateMark', lateMark);
			fd.append('inTime', inTime);
			fd.append('outTime', outTime);
			fd.append('selectStatusText', selectStatusText);
			fd.append('month', month);
			fd.append('year', year);
			fd.append('selectShift', selectShift);
			fd.append('otApproval', otApproval);
			fd.append('namesd', namesd);
			fd.append('lateMin', lateMin);
			  $
			.ajax({
				url : '${pageContext.request.contextPath}/submitAttendanceDetail',
				type : 'post',
				dataType : 'json',
				data : fd,
				contentType : false,
				processData : false,
				success : function(response) {

					location.reload(true);
				},
			}); 
		}
		 

		}
	</script>
	<script>
		// Custom bootbox dialog
		$('.bootbox_custom')
				.on(
						'click',
						function() {
							var dailyId = $(this).data("dailyid")
							var sts = $(this).data("attstatus") // will return the number 123
							  
										bootbox.confirm({
										title : 'Confirm ',
										message : 'Are you sure you want to Mark as Compoff ? you Can not edit attendance again',
										buttons : {
											confirm : {
												label : 'Yes',
												className : 'btn-success'
											},
											cancel : {
												label : 'Cancel',
												className : 'btn-link'
											}
										},
										callback : function(result) {
											if (result) {
												var fd = new FormData();
												fd.append('dailyId', dailyId);
												fd.append('sts', sts);
												$('#modal_step1').modal('show');
												
												   $
												.ajax({
													url : '${pageContext.request.contextPath}/markAsCompOff',
													type : 'post',
													dataType : 'json',
													data : fd,
													contentType : false,
													processData : false,
													success : function(response) {

														location.reload(true);
														 
													},
												});  

											}
										}
									});
						});
	</Script>

	<script type="text/javascript">
	function addLeave() {
		
		var empId = document.getElementById("empId").value;  
		var attDate = document.getElementById("attDate").value;  
		var month = document.getElementById("month").value;
		var year = document.getElementById("year").value;
		
		   var strhref ="${pageContext.request.contextPath}/addleaveFromAttendance?empId="+empId+"&attDate="+attDate+"&month="+month+"&year="+year+"&flag="+0;
		   $("#modalbody").load(strhref);
		   $("#modal_large1").modal("show");
		   $('#modal_large1').on('hidden.bs.modal', function () {
			 $("#modalbody").html("");
		   }); 
		   
		$(document).ready(function(){
 
		 
			});
	}
	
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
<c:url var="getSubmoduleList" value="/getSubmoduleList" />
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
									<i class="icon-list-unordered"></i>Generate Letter
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

								<form
									action="${pageContext.request.contextPath}/submitInsertAccessRole"
									id="submitInsertEmpType" method="post">
									<div class="form-group row">
										<label class="col-form-label  col-lg-4" for="empTypeName">
											Absent Apology Letter : </label>
										<div class="col-lg-5">
											<button type="button" class="btn bg-blue ml-3 legitRipple"
												id="submtbtn" onclick="apologyLetter()">Generate</button>
										</div>
									</div>
									<hr>
									<div class="form-group row">
										<label class="col-form-label  col-lg-4" for="empTypeName">
											Misbehaviour Apology Letter : </label>
										<div class="col-lg-5">
											<button type="button" class="btn bg-blue ml-3 legitRipple"
												id="submtbtn" onclick="misbehaviour()">Generate</button>
										</div>
									</div>

									<hr>
									<div class="form-group row">
										<label class="col-form-label  col-lg-4" for="empTypeName">
											Late Mark Apology Letter : </label>
										<div class="col-lg-5">
											<button type="button" class="btn bg-blue ml-3 legitRipple"
												id="submtbtn" onclick="lateMarkLatter()">Generate</button>
										</div>
									</div>
									<hr>
									<div class="form-group row">
										<label class="col-form-label  col-lg-4" for="empTypeName">
											Cash Received Letter : </label>
										<div class="col-lg-5">
											<button type="button" class="btn bg-blue ml-3 legitRipple"
												id="submtbtn" onclick="cashReceivedLetter()">Generate</button>
										</div>
									</div>
									<hr>
									<div class="form-group row">
										<label class="col-form-label  col-lg-4" for="empTypeName">
											Contract Letter : </label>
										<div class="col-lg-5">
											<button type="button" class="btn bg-blue ml-3 legitRipple"
												id="submtbtn" onclick="contractLetter()">Generate</button>
										</div>
									</div>

								</form>
							</div>
						</div>


					</div>
				</div>

			</div>
			<!-- /content area -->


			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
			<!-- /footer -->

		</div>
		<!-- /main content -->

	</div>
	<!-- /page content -->

	<!-- Scrollable modal -->
	<div id="modal_scrollable" class="modal fade" data-backdrop="false"
		tabindex="-1">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header pb-3">

					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<div class="modal-body py-0">
					<h5 class="modal-title">Apology Letter - Absent</h5>
					<br>

					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="lvType">
							Employee Code : </label> <label class="col-form-label col-lg-2"
							id="empCode1" for="empCode1"> ${empDetail.empCode}</label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="lvType">
							Employee Name : </label> <label class="col-form-label col-lg-6"
							id="empName1" for="empName1">${empDetail.firsName}&nbsp;${empDetail.surname}</label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="lvType">
							Department : </label> <label class="col-form-label col-lg-6" id="lvType"
							for="lvType">${empDetail.deptName}</label>

					</div>


					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="fromdate1">
							From Date : </label> <label class="col-form-label col-lg-6"
							for="fromdate1"><input type="text"
							class="form-control datepickerclass" placeholder="Select Date "
							id="fromdate1" name="fromdate1" autocomplete="off"></label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="todate1"> To
							Date : </label> <label class="col-form-label col-lg-6" for="toDate1"><input
							type="text" class="form-control datepickerclass"
							placeholder="Select Date " id="toDate1" name="toDate1"
							autocomplete="off"></label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="date1"> Date :
						</label> <label class="col-form-label col-lg-6" for="date1"><input
							type="text" class="form-control datepickerclass"
							placeholder="Select Date " id="date1" name="date1"
							autocomplete="off"></label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="noOfDays"> No.
							of Days : </label> <label class="col-form-label col-lg-3" for="noOfDays1"><input
							type="text" class="form-control numbersOnly"
							placeholder="No.of Days" id="noOfDays1" name="noOfDays1"
							autocomplete="off" value="1"></label>

					</div>
				</div>

				<div class="modal-footer pt-3">
					<button type="button" class="btn btn-link" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn bg-primary"
						onclick="submitFormApologyLetter(${empDetail.empId})">Submit</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /scrollable modal -->

	<!-- Scrollable modal -->
	<div id="modal_scrollable1" class="modal fade" data-backdrop="false"
		tabindex="-1">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header pb-3">

					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<div class="modal-body py-0">
					<h5 class="modal-title">Apology Letter - Misbehaviour</h5>
					<br>

					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="lvType">
							Employee Code : </label> <label class="col-form-label col-lg-2"
							id="empCode1" for="empCode1"> ${empDetail.empCode}</label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="lvType">
							Employee Name : </label> <label class="col-form-label col-lg-6"
							id="empName1" for="empName1">${empDetail.firsName}&nbsp;${empDetail.surname}</label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="lvType">
							Department : </label> <label class="col-form-label col-lg-6" id="lvType"
							for="lvType">${empDetail.deptName}</label>

					</div>


					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="fromdate1">
							Misbehaviour Date : </label> <label class="col-form-label col-lg-6"
							for="fromdate2"><input type="text"
							class="form-control datepickerclass" placeholder="Select Date "
							id="fromdate2" name="fromdate2" autocomplete="off"></label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="reason">
							Reason : </label> <label class="col-form-label col-lg-6" for="reason"><input
							type="text" class="form-control  " placeholder="Reason"
							id="reason" name="reason" autocomplete="off"
							onchange="trim(this)"></label>

					</div>

					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="date1"> Date :
						</label> <label class="col-form-label col-lg-6" for="date2"><input
							type="text" class="form-control datepickerclass"
							placeholder="Select Date " id="date2" name="date2"
							autocomplete="off"></label>

					</div>

				</div>

				<div class="modal-footer pt-3">
					<button type="button" class="btn btn-link" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn bg-primary"
						onclick="submitMisbehaviourLetter(${empDetail.empId})">Submit</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /scrollable modal -->

	<!-- Scrollable modal -->
	<div id="modal_scrollable2" class="modal fade" data-backdrop="false"
		tabindex="-1">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header pb-3">

					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<div class="modal-body py-0">
					<h5 class="modal-title">Apology Letter - Late Mark</h5>
					<br>

					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="lvType">
							Employee Code : </label> <label class="col-form-label col-lg-2"
							id="empCode1" for="empCode1"> ${empDetail.empCode}</label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="lvType">
							Employee Name : </label> <label class="col-form-label col-lg-6"
							id="empName1" for="empName1">${empDetail.firsName}&nbsp;${empDetail.surname}</label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="lvType">
							Department : </label> <label class="col-form-label col-lg-6" id="lvType"
							for="lvType">${empDetail.deptName}</label>

					</div>


					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="lateDate">
							Late Mark Date : </label> <label class="col-form-label col-lg-6"
							for="lateDate"><input type="text"
							class="form-control datepickerclass" placeholder="Select Date "
							id="lateDate" name="lateDate" autocomplete="off"></label>

					</div>


					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="date1"> Date :
						</label> <label class="col-form-label col-lg-6" for="date3"><input
							type="text" class="form-control datepickerclass"
							placeholder="Select Date " id="date3" name="date3"
							autocomplete="off"></label>

					</div>

				</div>

				<div class="modal-footer pt-3">
					<button type="button" class="btn btn-link" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn bg-primary"
						onclick="submitLateMarkLetter(${empDetail.empId})">Submit</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /scrollable modal -->

	<!-- Scrollable modal -->
	<div id="modal_scrollable3" class="modal fade" data-backdrop="false"
		tabindex="-1">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header pb-3">

					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<div class="modal-body py-0">
					<h5 class="modal-title">Cash Received Letter</h5>
					<br>

					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="lvType">
							Employee Code : </label> <label class="col-form-label col-lg-2"
							id="empCode1" for="empCode1"> ${empDetail.empCode}</label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="lvType">
							Employee Name : </label> <label class="col-form-label col-lg-6"
							id="empName1" for="empName1">${empDetail.firsName}&nbsp;${empDetail.surname}</label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="lvType">
							Department : </label> <label class="col-form-label col-lg-6" id="lvType"
							for="lvType">${empDetail.deptName}</label>

					</div>


					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="cashDate">
							Cash Received Date : </label> <label class="col-form-label col-lg-6"
							for="cashDate"><input type="text"
							class="form-control datepickerclass" placeholder="Select Date "
							id="cashDate" name="cashDate" autocomplete="off"></label>

					</div>

					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="cmpName">
							Company Name : </label> <label class="col-form-label col-lg-6"
							for="cmpName"><input type="text" class="form-control  "
							placeholder="Company Name" id="cmpName" name="cmpName"
							autocomplete="off" onchange="trim(this)"></label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="date1"> Date :
						</label> <label class="col-form-label col-lg-6" for="date3"><input
							type="text" class="form-control datepickerclass"
							placeholder="Select Date " id="date3" name="date3"
							autocomplete="off"></label>

					</div>

				</div>

				<div class="modal-footer pt-3">
					<button type="button" class="btn btn-link" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn bg-primary"
						onclick="submitcashReceivedLetter(${empDetail.empId})">Submit</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /scrollable modal -->

	<!-- Scrollable modal -->
	<div id="modal_scrollable4" class="modal fade" data-backdrop="false"
		tabindex="-1">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header pb-3">

					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<div class="modal-body py-0">
					<h5 class="modal-title">Contract Letter</h5>
					<br>

					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="lvType">
							Employee Code : </label> <label class="col-form-label col-lg-2"
							id="empCode1" for="empCode1"> ${empDetail.empCode}</label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="lvType">
							Employee Name : </label> <label class="col-form-label col-lg-6"
							id="empName1" for="empName1">${empDetail.firsName}&nbsp;${empDetail.surname}</label>

					</div>
					<%-- <div class="form-group row">
						<label class="col-form-label col-lg-3" for="lvType">
							Department : </label> <label class="col-form-label col-lg-6" id="lvType"
							for="lvType">${empDetail.deptName}</label>

					</div> --%>


					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="city"> City :
						</label> <label class="col-form-label col-lg-6" for="city"><input
							type="text" class="form-control  " placeholder="City" id="city"
							name="city" autocomplete="off" onchange="trim(this)"></label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="contractorName">
							Contractor Name : </label> <label class="col-form-label col-lg-6"
							for="contractorName"><input type="text"
							class="form-control  " placeholder="Contractor Name"
							id="contractorName" name="contractorName" autocomplete="off"
							onchange="trim(this)" value="${empDetail.orgName}"></label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="ownerName">
							Owner Name : </label> <label class="col-form-label col-lg-6"
							for="ownerName"><input type="text" class="form-control  "
							placeholder="Owner Name" id="ownerName" name="ownerName"
							autocomplete="off" onchange="trim(this)"
							value="${empDetail.owner}"></label>

					</div>

					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="contJointDate">
							Contractor Join Date : </label> <label class="col-form-label col-lg-6"
							for="contJointDate"><input type="text"
							class="form-control datepickerclass" placeholder="Select Date "
							id="contJointDate" name="contJointDate" autocomplete="off"></label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="date4"> Date :
						</label> <label class="col-form-label col-lg-6" for="date4"><input
							type="text" class="form-control datepickerclass"
							placeholder="Select Date " id="date4" name="date4"
							autocomplete="off"></label>

					</div>
					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="noOfMonth">
							No. of Months Contract: </label> <label class="col-form-label col-lg-6"
							for="noOfMonth"><input type="text"
							class="form-control numbersOnly" placeholder="No. of Months"
							id="noOfMonth" name="noOfMonth" autocomplete="off" value="1"
							onchange="trim(this)"></label>

					</div>

					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="noticeMonth">
							No of Month Notice : </label> <label class="col-form-label col-lg-6"
							for="noticeMonth"><input type="text"
							class="form-control numbersOnly" placeholder="No of Month Notice"
							id="noticeMonth" name="noticeMonth" autocomplete="off" value="1"
							onchange="trim(this)"></label>

					</div>

					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="payDate">
							Payment Date : </label> <label class="col-form-label col-lg-6"
							for="payDate"><input type="text"
							class="form-control numbersOnly" placeholder="Payment Date"
							id="payDate" name="payDate" autocomplete="off" value="1"
							onchange="trim(this)"></label>

					</div>

					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="designationAs">
							Designation as : </label> <label class="col-form-label col-lg-6"
							for="designationAs"><input type="text"
							class="form-control  " placeholder="Designation as"
							id="designationAs" name="designationAs" autocomplete="off"
							onchange="trim(this)"></label>

					</div>

					<div class="form-group row">
						<label class="col-form-label col-lg-3" for="mobileNo">
							Mobile No : </label> <label class="col-form-label col-lg-6"
							for="mobileNo"><input type="text" class="form-control  "
							placeholder="Mobile No" id="mobileNo" name="mobileNo"
							autocomplete="off" value="${empDetail.mobile}"
							onchange="trim(this)"></label>

					</div>



				</div>

				<div class="modal-footer pt-3">
					<button type="button" class="btn btn-link" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn bg-primary"
						onclick="submitContractLetterLetter(${empDetail.empId})">Submit</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /scrollable modal -->

	<script>
		function trim(el) {
			el.value = el.value.replace(/(^\s*)|(\s*$)/gi, ""). // removes leading and trailing spaces
			replace(/[ ]{2,}/gi, " "). // replaces multiple spaces with one space 
			replace(/\n +/, "\n"); // Removes spaces after newlines
			checkSame();
			return;
		}
		$('.datepickerclass').daterangepicker({
			singleDatePicker : true,
			selectMonths : true,
			selectYears : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});
		//
	</script>
	<script>
		function apologyLetter() {
			$('#modal_scrollable').modal('show');

		}
		function misbehaviour() {
			$('#modal_scrollable1').modal('show');

		}
		function lateMarkLatter() {
			$('#modal_scrollable2').modal('show');

		}
		function cashReceivedLetter() {
			$('#modal_scrollable3').modal('show');

		}
		function contractLetter() {
			$('#modal_scrollable4').modal('show');

		}
		function submitFormApologyLetter(empId) {
			//window.open('pdfForReport?url=/pdf/gernerateApologyletterAbsent/' + empId);
			var fromdate = document.getElementById("fromdate1").value; 
			var toDate = document.getElementById("toDate1").value;
			var noOfDays = document.getElementById("noOfDays1").value;
			var date1 = document.getElementById("date1").value; 
			
			if(noOfDays==""){
				alert("Enter No. of Days");
			}else{
				window.open('${pageContext.request.contextPath}/pdf/gernerateApologyletterAbsent/' + empId +'/'+date1+'/'+fromdate+'/'+toDate+'/'+noOfDays);
			}
			

		}
		function submitMisbehaviourLetter(empId) {
			//window.open('pdfForReport?url=/pdf/gernerateApologyletterAbsent/' + empId);
			var fromdate = document.getElementById("fromdate2").value;  
			var reason = document.getElementById("reason").value;
			var date = document.getElementById("date2").value; 
			
			if(reason==""){
				alert("Enter Reason");
			}else{
				window.open('${pageContext.request.contextPath}/pdf/gernerateApologyletterMisbehaviour/' + empId +'/'+date+'/'+fromdate+'/'+reason);
			}
			

		}
		function submitLateMarkLetter(empId) {
			//window.open('pdfForReport?url=/pdf/gernerateApologyletterAbsent/' + empId);
			var fromdate = document.getElementById("lateDate").value; 
			var date = document.getElementById("date3").value; 
			 
				window.open('${pageContext.request.contextPath}/pdf/gernerateApologyletterLateMark/' + empId +'/'+date+'/'+fromdate);
			 
		}
		function submitcashReceivedLetter(empId) {
			//window.open('pdfForReport?url=/pdf/gernerateApologyletterAbsent/' + empId);
			var fromdate = document.getElementById("cashDate").value; 
			var cmpName = document.getElementById("cmpName").value;
			var date = document.getElementById("date3").value; 
			
			if(cmpName==""){
				alert("Enter Company Name");
			}else{
				window.open('${pageContext.request.contextPath}/pdf/gerneratecashReceivedLetter/' + empId +'/'+date+'/'+cmpName+'/'+fromdate);
			}
			

		} 
		function submitContractLetterLetter(empId) {
			          
			
			var contJointDate = document.getElementById("contJointDate").value; 
			var city = document.getElementById("city").value;
			var contractorName = document.getElementById("contractorName").value;
			var ownerName = document.getElementById("ownerName").value;
			var noOfMonth = document.getElementById("noOfMonth").value;
			var noticeMonth = document.getElementById("noticeMonth").value;
			var payDate = document.getElementById("payDate").value;
			var mobileNo = document.getElementById("mobileNo").value;
			var designationAs = document.getElementById("designationAs").value;
			var date = document.getElementById("date4").value; 
			var isError=0;
			
			if(city==""){
				alert("Enter City Name");
				isError=1;
			}else if(contractorName==""){
				alert("Enter Contractor Name");
				isError=1;
			}else if(ownerName==""){
				alert("Enter Owner Name");
				isError=1;
			}else if(noOfMonth==""){
				alert("Enter No. of month");
				isError=1;
			}else if(noticeMonth==""){
				alert("Enter No. of month for notice period");
				isError=1;
			}else if(payDate==""){
				alert("Enter Payment Date");
				isError=1;
			}else if(designationAs==""){
				alert("Enter Designation");
				isError=1;
			}else if(mobileNo==""){
				alert("Enter Mobile No.");
				isError=1;
			}
			
			
			
			if(isError==0){
				window.open('${pageContext.request.contextPath}/pdf/gernerateContractLetter/' + empId +'/'+contJointDate+'/'+city+'/'+contractorName+'/'+ownerName+'/'+noOfMonth+'/'+noticeMonth+'/'+payDate+'/'+mobileNo+'/'+date+'/'+designationAs);
			}
			

		}
	</script>
</body>
</html>
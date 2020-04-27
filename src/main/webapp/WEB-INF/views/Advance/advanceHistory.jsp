<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<c:url var="getAdvanceHistory" value="/getAdvanceHistory" />

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

			<!-- Page header -->
			<div class="page-header page-header-light"></div>
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">


				<!-- Highlighting rows and columns -->
				<div class="card">


					<div class="card-header header-elements-inline">
						<table width="100%">
							<tr width="100%">
								<td width="60%"><h5 class="pageTitle"><i class="icon-list-unordered"></i> Advance History
										 </h5></td>
						 
							</tr>
						</table>
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
								
								<label class="col-form-label text-info font-weight-bold col-lg-2" for="locId">
								Year<span style="color: red">* </span>:
								</label>
								<div class="col-lg-4">
									<!-- <select name="calYrId" data-placeholder="Select  "
										id="calYrId" onchange="show()"
										class="form-control form-control-select2 select2-hidden-accessible"
										data-fouc="" aria-hidden="true">

										<option value="0">Select Year</option>

 											<option value="2019">2019</option>
 											<option value="2020">2020</option>
 											<option value="2021">2021</option>
 									</select>   -->
 									
 									<input type="text" onchange="show()" class="form-control datepickerclass"
														value="2020" placeholder="Select Year "
														id="calYrId" name ="calYrId"
														autocomplete="off">
									<span
											class="validation-invalid-label" id="error_datepicker"
											style="display: none;">Please Select Date. </span>
								</div>
								
								<label class="col-form-label text-info font-weight-bold col-lg-2" for="empId">
								Employee<span style="color: red">* </span>:
								</label>
								<div class="col-lg-4">
									<select name="empId" data-placeholder="Select  "
										id="empId" onchange="show()"
										class="form-control form-control-select2 select2-hidden-accessible"
										data-fouc="" aria-hidden="true">

										<option value="0">Select Employee</option>

										<c:forEach items="${empdetList}" var="empdetList">
											<option value="${empdetList.empId}">${empdetList.empCode}&nbsp;${empdetList.surname}&nbsp;${empdetList.firstName}</option>
										</c:forEach>
									</select>  
									<span
											class="validation-invalid-label" id="error_emp"
											style="display: none;">Please select employee. </span>
									
								</div>
								
							</div>
							
							 
						<table
							class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
							id="printtable1">
							<thead>
								<tr class="bg-blue">

									<th width="10%">Sr. No.</th>
									<th>Emp Code</th>
									<th>Designation</th>
									<th>Name</th>
									<th>Voucher No.</th>
									<th>Adv Date</th>
									<th>Advance Amount</th>
 									<th>Deduction Month/Year</th>
									<th>is Deducted</th>
 								</tr>
							</thead>
							<tbody>

<%-- 
								<c:forEach items="${empdetList}" var="empdetList" varStatus="count">
									<tr>
										<td>${count.index+1}</td>
										<td>${empdetList.empCode}</td>
										<td>${empdetList.designation}</td>
										<td>${empdetList.surname}&nbsp;${empdetList.middleName}&nbsp;${empdetList.firstName}</td>
										<td>${empdetList.voucherNo}</td>
										<td>${empdetList.advDate}</td>
										<td>${empdetList.advAmount}</td>
										<td>${empdetList.advRemainingAmount}</td>
										<td>${empdetList.dedMonth}</td>
										<td>${empdetList.isDed}</td>
 
									</tr>
								</c:forEach> --%>

							</tbody>
						</table>

					</div>

				</div>
				<!-- /highlighting rows and columns -->

			</div>
			<!-- /content area -->


			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
			<!-- /footer -->

		</div>
		<!-- /main content -->

	</div>
	<!-- /page content -->
	
	<script>
	$(document).ready(function() {
        // month selector
        $('.datepickerclass').datepicker({
            autoclose: true,
            format: "yyyy",
            viewMode: "years",
            minViewMode: "years"

        });


    });
 	</script> 
	 <script type="text/javascript">
		function show() {

			var error = false;

			var calYrId = document.getElementById("calYrId").value;
			if (calYrId.length == 0 || calYrId == null || calYrId == "") {
				error = true;
				$("#error_datepicker").show();

			} else {
				//	alert(0);
				$("#error_datepicker").hide();
			}
			var empId = document.getElementById("empId").value;
			if (empId.length == 0 || empId == null || empId == "") {
				error = true;
				$("#error_emp").show();

			} else {
				//	alert(empId);
				$("#error_emp").hide();
			}
			
			if (error) {
				return false
			}
			
		//	var empId = document.getElementById("empId").value;
			//var calYrId = document.getElementById("calYrId").value;
 
			 
			var valid = true;

			/* if (empId == null || empId == "") {
				valid = false;
				//alert("Please Select Employee");
				//return false;
			}

			var valid = true;
			if (calYrId == null || calYrId == "") {
				valid = false;
				//alert("Please Select Year");
				//return false;
			//	var dataTable = $('#printtable1').DataTable();
			//	dataTable.clear().draw();

			}
			
			 */
			$("#loader").show();

			if (valid == true) {

				$.getJSON('${getAdvanceHistory}', {
					empId : empId,
					calYrId : calYrId,
					ajax : 'true',
				},

				function(data) {
					
				//	alert("Data " +JSON.stringify(data));

					var dataTable = $('#printtable1').DataTable();
					dataTable.clear().draw();

					$.each(data, function(i, v) {
						
					 var dedStr;
					 if(parseInt(v.isDed)==1){
						 dedStr="Yes";
					 }else{
						 dedStr="No";
					 }
						 
						dataTable.row.add(
								[
										i + 1,
										v.empCode,
										v.designation,
										 v.surname+''+v.firstName,
										v.voucherNo,
										v.advDate,
										v.advAmount,
										v.dedMonth+'-'+v.dedYear,
										dedStr
										 
										]).draw();
					});
					$("#loader").hide(); 

				});

			}//end of if valid ==true

		}
	</script>
	
</body>
</html>
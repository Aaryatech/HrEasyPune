<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
<script
	src="${pageContext.request.contextPath}/resources/global_assets/js/demo_pages/components_modals.js"></script>

</head>
<style>
* {
	box-sizing: border-box;
}

.myInput {
	background-image: url('https://www.w3schools.com/css/searchicon.png');
	background-position: 8px 7px;
	background-repeat: no-repeat;
	width: 20%;
	font-size: 16px;
	padding: 5px 5px 5px 40px;
	border: 1px solid #ddd;
	margin-bottom: 12px;
}

#myTable {
	border-collapse: collapse;
	width: 100%;
	border: 1px solid #ddd;
	font-size: 18px;
}

#myTable th, #myTable td {
	text-align: left;
	padding: 12px;
}

#myTable tr {
	border-bottom: 1px solid #ddd;
}

#myTable tr.header, #myTable tr:hover {
	background-color: #f1f1f1;
}
</style>
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
			<%-- <div class="page-header page-header-light">


				<div
					class="breadcrumb-line breadcrumb-line-light header-elements-md-inline">
					<div class="d-flex">
						<div class="breadcrumb">
							<a href="index.html" class="breadcrumb-item"><i
								class="icon-home2 mr-2"></i> Home</a> <span
								class="breadcrumb-item active">Dashboard</span>

						</div>


						<a href="#" class="header-elements-toggle text-default d-md-none"><i
							class="icon-more"></i></a>
					</div>

						<div class="breadcrumb justify-content-center">
						<a href="${pageContext.request.contextPath}/holidayAdd"
							class="breadcrumb-elements-item"> Add Holiday </a>

					</div>


				</div>
			</div> --%>
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">

				<div class="card">


					<div class="card-header header-elements-inline">
						<table width="100%">
							<tr width="100%">
								<td width="60%"><h5 class="pageTitle">
										<i class="icon-list-unordered"></i> Apply Previous Leave
									</h5></td>
								<td width="40%" align="right">
									<%-- <a
									href="${pageContext.request.contextPath}/showAddKra?empId=${editKra.exVar3}&finYrId=${editKra.exVar2}"
									class="breadcrumb-elements-item">
										<button type="button" class="btn btn-primary">KRA List </button>
								</a>  --%>
								</td>
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



						<div class="tab-pane fade show active"
							id="highlighted-justified-tab1">
							<form
								action="${pageContext.request.contextPath}/submitPriviousLeave"
								method="post" id="assignstuct">
								<!-- <input type="text" id="myInput2" class="myInput"
									onkeyup="myFunction2()" placeholder="Search for employee.."
									title="Type in a name"> -->
								<div class="table-responsive">
									<table
										class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
										width="100%" id="printtable2">
										<thead>
											<tr class="bg-blue">

												<th class="text-center" width="5%">Sr. No.</th>
												<th class="text-center">Employee Name</th>
												<th class="text-center">Leave Type</th>
												<th class="text-center">Year Opening</th>
												<th class="text-center">Year Earning</th>
												<th class="text-center">Month Opening</th>
												<th class="text-center">No. of Day to Apply</th>


											</tr>
										</thead>
										<tbody>
											<c:set value="0" var="sameEmpId"></c:set>
											<c:set value="0" var="previousEmpId"></c:set>
											<c:set value="0" var="index"></c:set>
											<c:forEach items="${list}" var="emp" varStatus="count">

												<tr>
													<td><c:choose>
															<c:when test="${emp.empId==previousEmpId}"></c:when>
															<c:otherwise>${index+1}<c:set var="index"
																	value="${index+1}"></c:set>
															</c:otherwise>
														</c:choose></td>

													<td>${emp.empName}&nbsp;(${emp.empCode})</td>
													<td>${emp.lvTitle}</td>
													<td><input class="form-control numbersOnly"
														id="opBal${emp.empId}${emp.lvTypeId}"
														name="opBal${emp.empId}${emp.lvTypeId}"
														onchange="calNoOfDay(${emp.empId},${emp.lvTypeId})"
														value="${emp.opBal}"> <input type="hidden"
														id="opBalId${emp.empId}${emp.lvTypeId}"
														name="opBalId${emp.empId}${emp.lvTypeId}"
														value="${emp.lvbalId}"></td>
													<td><input class="form-control"
														id="earning${emp.empId}${emp.lvTypeId}"
														name="earning${emp.empId}${emp.lvTypeId}"
														value="${emp.lvs_alloted_leaves}" readonly="readonly"></td>
													<td id="dataEarn${emp.empId}${emp.lvTypeId}"
														data-earn="${emp.lvs_alloted_leaves}"><input
														class="form-control numbersOnly"
														id="opning${emp.empId}${emp.lvTypeId}"
														name="opning${emp.empId}${emp.lvTypeId}"
														onchange="calNoOfDay(${emp.empId},${emp.lvTypeId})"
														value="${emp.opBal+emp.lvs_alloted_leaves-emp.leaveNumDays}"></td>
													<td><input class="form-control"
														id="noOfDay${emp.empId}${emp.lvTypeId}"
														name="noOfDay${emp.empId}${emp.lvTypeId}" value="0"
														readonly="readonly"></td>
												</tr>
												<c:set value="${emp.empId}" var="previousEmpId"></c:set>
											</c:forEach>

										</tbody>
									</table>
								</div>

								<%-- <input type="text" id="myInput2" class="myInput"
									onkeyup="myFunction2()" placeholder="Search for employee.."
									title="Type in a name">
								<table
									class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
									width="100%" id="printtable1">
									<thead>
										<tr class="bg-blue">

											<th class="text-center" width="5%">Sr. No.</th>
											<th class="text-center">Employee Name</th>
											<th class="text-center">Leave Type</th>
											<th class="text-center">Opening</th>
											<th class="text-center">No. of Day to Apply</th>
										</tr>
									</thead>
									<tbody>


										<c:set value="0" var="sameEmpId"></c:set>
										<c:set value="0" var="previousEmpId"></c:set>
										<c:set value="0" var="index"></c:set>
										<c:forEach items="${list}" var="emp" varStatus="count">

											<c:choose>
												<c:when test="${emp.empId==previousEmpId}">
												</c:when>
												<c:otherwise>
													<tr>
														<td colspan="5"></td>
													</tr>
												</c:otherwise>

											</c:choose>
											<tr>
												<td><c:choose>
														<c:when test="${emp.empId==previousEmpId}"></c:when>
														<c:otherwise>${index+1}<c:set var="index"
																value="${index+1}"></c:set>
														</c:otherwise>
													</c:choose></td>

												<td>${emp.empName}&nbsp;(${emp.empCode})</td>
												<td>${emp.lvTitle}</td>
												<td id="dataEarn${emp.empId}${emp.lvTypeId}"
													data-earn="${emp.lvs_alloted_leaves}"><input
													class="form-control" id="opning${emp.empId}${emp.lvTypeId}"
													name="opning${emp.empId}${emp.lvTypeId}"
													onchange="calNoOfDay(${emp.empId},${emp.lvTypeId})"
													value="${emp.lvs_alloted_leaves-emp.leaveNumDays}"></td>
												<td><input class="form-control"
													id="noOfDay${emp.empId}${emp.lvTypeId}"
													name="noOfDay${emp.empId}${emp.lvTypeId}" value="0"
													readonly="readonly"></td>
											</tr>
											<c:set value="${emp.empId}" var="previousEmpId"></c:set>
										</c:forEach>

									</tbody>
								</table> --%>
								<span class="validation-invalid-label" id="error_table1"
									style="display: none;">Please select one employee.</span> <br>

								<div class="form-group text-center ">
									<input type="submit" class="btn blue_btn" value="Save"
										id="btnassignstuct">

								</div>



							</form>
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

	<script type="text/javascript">
	
	$('.datatable-fixed-left_custom').DataTable({

		columnDefs : [ {
			orderable : false,
			targets : [0]
		}, {
			width : "10px",
			targets : [ 0 ]
		}, {
			width : "10px",
			targets : [ 1 ]
		}, {
			width : "200px",
			targets : [ 3 ]
		} ],"order": [],
		//scrollX : true,
		scrollX : true,
		scrollY : '65vh',
		scrollCollapse : true,
		paging : false,
		fixedColumns : {
			leftColumns : 0,
			rightColumns : 0
		}

	});
		$(document).ready(
				function() {
					//$('#bootstrap-data-table-export').DataTable();

					$("#selAll").click(
							function() {
								$('#printtable1 tbody input[type="checkbox"]')
										.prop('checked', this.checked);
							});
				});

		$(document)
				.ready(
						function($) {

							$("#assignstuct")
									.submit(
											function(e) {

												var table = $('#printtable2')
														.DataTable();
												table.search("").draw(); 

												var isError = false;
												var errMsg = "";
 
												if (!isError) {
 
													bootbox
													.confirm({
														title : 'Confirm ',
														message : 'Are you sure to set leave opening balance ?',
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
																document
																		.getElementById("btnassignstuct").disabled = true;
																document
																		.getElementById(
																				"assignstuct")
																		.submit();

															}
														}
													});
													 /*  var x = confirm("Do you really want to submit the form?");
													if (x == true) {

														document.getElementById("btnassignstuct").disabled = true;
														return true;
													}   */
													//end ajax send this to php page
												}
												return false;
											});
						});
	</script>
	<script>
		function submitForm() {
			$('#modal_scrollable').modal('hide');
			document.getElementById("btnassignstuct").disabled = true;
			document.getElementById("assignstuct").submit();

		}
	</script>
	<script>
		function calNoOfDay(empId, typeId) {
			
			var opBal = parseFloat($("#opBal"+empId+""+typeId).val()); 
			var dataEarn = parseFloat($("#dataEarn"+empId+""+typeId).data("earn"));
			var opning = parseFloat($("#opning"+empId+""+typeId).val()); 
			 
			if(isNaN(opning)){
				opning=dataEarn;
				$("#opning"+empId+""+typeId).val(dataEarn);
			}
			var bal=opBal+dataEarn-opning;
			
			if(bal<0){
				$("#noOfDay"+empId+""+typeId).val(0);
				$("#opning"+empId+""+typeId).val(opBal+dataEarn);
			}else{
				$("#noOfDay"+empId+""+typeId).val(bal);
			}
			
			
		}
 
		function myFunction2() {
			var input, filter, table, tr, td, i, txtValue;
			input = document.getElementById("myInput2");
			filter = input.value.toUpperCase();
			table = document.getElementById("printtable1");
			tr = table.getElementsByTagName("tr");
			for (i = 0; i < tr.length; i++) {
				td = tr[i].getElementsByTagName("td")[1];
				if (td) {
					txtValue = td.textContent || td.innerText;
					if (txtValue.toUpperCase().indexOf(filter) > -1) {
						tr[i].style.display = "";
					} else {
						tr[i].style.display = "none";
					}
				}
			}
		}
	</script>

</body>
</html>
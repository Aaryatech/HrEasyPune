<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>
<!-- <link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css"> -->
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
						<h5 class="pageTitle">
							<i class="icon-list-unordered"></i>Arrears Calculation
							${fromMonth} To ${toMonth}
						</h5>

					</div>

					<div class="card-body">

						<form action="${pageContext.request.contextPath}/generateArears"
							id="generateArears" method="post">

							<input type="hidden" name="searchDate" id="searchDate"
								value="${date}" /> <input type="hidden" name="empIds"
								id="empIds" value="${empIds}" />
							<div id="loader" style="display: none;">
								<img
									src="${pageContext.request.contextPath}/resources/assets/images/giphy.gif"
									width="150px" height="150px"
									style="display: block; margin-left: auto; margin-right: auto">
							</div>
							<br>
							<div class="text-center">
								<button type="button"
									class="btn bg-blue ml-3 legitRipple bootbox_custom"
									id="submtbtn">Complete Arrears Process</button>
								<button type="button" class="btn bg-blue ml-3 legitRipple"
									id="button-excel" onclick="getProgReport(0,'excelForArears')">Excel</button>
							</div>
							<br>
							<%-- <div class="table-responsive accordion">
								<table class="table">
									<thead>
										<tr class="bg-blue">
											<th class="text-center" scope="col">#</th>
											<th class="text-center" scope="col">Employee Name</th>
											<th class="text-center" scope="col">Department</th>
											<th class="text-center" scope="col">Designation</th>
											<th class="text-center" scope="col">Net AMT</th>
										</tr>
									</thead>
									<tbody>

										<c:forEach items="${empList}" var="empList" varStatus="count">
											<c:if test="${empList.generatedPayrollList.size()>0}">
												<tr class="accordion-toggle collapsed"
													id="accordion${count.index+1}" data-toggle="collapse"
													data-parent="#accordion${count.index+1}"
													href="#collapseOne${count.index+1}">
													<td><span class="expand-button"></span></td>
													<td>${empList.empName}&nbsp;(${empList.empCode})</td>
													<td class="text-center">${empList.deptName}</td>
													<td class="text-center">${empList.designation}</td>
													<td class="text-right">${empList.totalDiffCal}</td>
												</tr>
												<tr class="hide-table-padding">

													<td colspan="5"><div class=" collapse in p-3"
															id="collapseOne${count.index+1}">
															<div class="table-responsive ">
																<table
																	class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
																	width="100%" id="printtable${count.index+1}">


																	<thead>
																		<tr class="bg-blue">

																			<th class="text-center" rowspan="2">Month</th>
																			<th class="text-center" rowspan="2">PayableDays</th>
																			<th class="text-center" rowspan="2">Total DIFF</th>
																			<th class="text-center" rowspan="2">Net AMT</th>
																			<th class="text-center" colspan="4">Basic</th>
																			<c:forEach items="${allowanceList}"
																				var="allowanceList">
																				<th class="text-center" colspan="4">${allowanceList.name}</th>
																			</c:forEach>

																		</tr>
																		<tr class="bg-blue">


																			<th class="text-center">Old</th>
																			<th class="text-center">Current</th>
																			<th class="text-center">DIFF</th>
																			<th class="text-center">Cal</th>
																			<c:forEach items="${allowanceList}"
																				var="allowanceList">
																				<th class="text-center">Old</th>
																				<th class="text-center">Current</th>
																				<th class="text-center">DIFF</th>
																				<th class="text-center">Cal</th>
																			</c:forEach>

																		</tr>

																	</thead>

																	<tbody>

																		<c:forEach items="${empList.generatedPayrollList}"
																			var="generatedPayrollList">
																			<tr>

																				<td class="text-center">${generatedPayrollList.email}</td>

																				<td class="text-right">${generatedPayrollList.payableDays}</td>
																				<td class="text-right">${generatedPayrollList.salTotalDiff}</td>
																				<td class="text-right">${generatedPayrollList.netCalArear}</td>
																				<td class="text-right">${generatedPayrollList.basicDefault}</td>
																				<td class="text-right">${empList.basic}</td>
																				<td class="text-right">${generatedPayrollList.salBasicDiff}</td>
																				<td class="text-right">${generatedPayrollList.basicCalArear}</td>
																				<c:forEach items="${allowanceList}"
																					var="allowanceList">
																					<c:forEach
																						items="${generatedPayrollList.difAlloList}"
																						var="difAlloList">
																						<c:if
																							test="${difAlloList.allowanceId==allowanceList.allowanceId}">
																							<td class="text-right">${difAlloList.allowanceValueCal}
																							</td>
																							<td class="text-right">${difAlloList.allowanceValue}
																							</td>
																							<td class="text-right">${difAlloList.allowanceDifference}
																							</td>
																							<td class="text-right">${difAlloList.arearCal}</td>
																						</c:if>
																					</c:forEach>
																				</c:forEach>

																			</tr>
																		</c:forEach>

																	</tbody>
																</table>
															</div>
														</div></td>
												</tr>
											</c:if>
										</c:forEach>

									</tbody>
								</table>
							</div> --%>
							<div class="table-responsive">
								<table
									class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
									width="100%" id="printtable10">


									<thead>
										<tr class="bg-blue">

											<th width="20%" class="text-center" rowspan="2">EMP Name</th>
											<th class="text-center" rowspan="2">Department</th>
											<th class="text-center" rowspan="2">Designation</th>
											<th class="text-center" rowspan="2">PayableDays</th>
											<th class="text-center" rowspan="2">Total DIFF</th>
											<th class="text-center" rowspan="2">Net AMT</th>
											<th class="text-center" colspan="4">Basic</th>
											<c:forEach items="${allowanceList}" var="allowanceList">
												<th class="text-center" colspan="4">${allowanceList.name}</th>
											</c:forEach>

										</tr>
										<tr class="bg-blue">

											<th class="text-center">Old</th>
											<th class="text-center">Current</th>
											<th class="text-center">DIFF</th>
											<th class="text-center">Cal</th>
											<c:forEach items="${allowanceList}" var="allowanceList">
												<th class="text-center">Old</th>
												<th class="text-center">Current</th>
												<th class="text-center">DIFF</th>
												<th class="text-center">Cal</th>
											</c:forEach>

										</tr>

									</thead>

									<tbody>
										<c:forEach items="${empList}" var="empList" varStatus="count">
											<c:if test="${empList.generatedPayrollList.size()>0}">
												<tr>

													<td>${empList.empName}&nbsp;(${empList.empCode})</td>
													<td class="text-center">${empList.deptName}</td>
													<td class="text-center">${empList.designation}</td>
													<td colspan="3"></td>
													<td style="display: none;"></td>
													<td style="display: none;"></td>
													<td colspan="4"></td>
													<td style="display: none;"></td>
													<td style="display: none;"></td>
													<td style="display: none;"></td>
													<c:forEach items="${allowanceList}" var="allowanceList">
														<th class="text-center" colspan="4"></th>
														<th class="text-center" style="display: none;"></th>
														<th class="text-center" style="display: none;"></th>
														<th class="text-center" style="display: none;"></th>
													</c:forEach>

												</tr>
												<c:forEach items="${empList.generatedPayrollList}"
													var="generatedPayrollList">
													<tr>

														<td class="text-center">${generatedPayrollList.email}</td>
														<td colspan="2"></td>
														<td style="display: none;"></td>
														<td class="text-right">${generatedPayrollList.payableDays}</td>
														<td class="text-right">${generatedPayrollList.salTotalDiff}</td>
														<td class="text-right">${generatedPayrollList.netCalArear}</td>
														<td class="text-right">${generatedPayrollList.basicDefault}</td>
														<td class="text-right">${empList.basic}</td>
														<td class="text-right">${generatedPayrollList.salBasicDiff}</td>
														<td class="text-right">${generatedPayrollList.basicCalArear}</td>
														<c:forEach items="${allowanceList}" var="allowanceList">
															<c:forEach items="${generatedPayrollList.difAlloList}"
																var="difAlloList">
																<c:if
																	test="${difAlloList.allowanceId==allowanceList.allowanceId}">
																	<td class="text-right">${difAlloList.allowanceValueCal}
																	</td>
																	<td class="text-right">${difAlloList.allowanceValue}
																	</td>
																	<td class="text-right">${difAlloList.allowanceDifference}
																	</td>
																	<td class="text-right">${difAlloList.arearCal}</td>
																</c:if>
															</c:forEach>
														</c:forEach>

													</tr>
												</c:forEach>
											</c:if>
										</c:forEach>

									</tbody>
								</table>
							</div>


						</form>
					</div>

				</div>
				<!-- /highlighting rows and columns -->

			</div>

			<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
			<!-- /footer -->

		</div>
		<!-- /main content -->

	</div>
	<!-- /page content -->



	<script type="text/javascript">
		$('.bootbox_custom')
				.on(
						'click',
						function() {
							//var uuid = $(this).data("uuid") // will return the number 123
							bootbox
									.confirm({
										title : 'Confirm ',
										message : 'Are you sure want to generate the Arrears? Once it Gerenerated you will not able to edit any records/data.',
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
												document.getElementById(
														'generateArears')
														.submit();

											}
										}
									});
						});

		$('.datatable-fixed-left_custom').DataTable({

			columnDefs : [ {
				orderable : false,
				targets : [ 0 ]
			} ],
			"order" : [],
			"ordering" : false,
			//scrollX : true,
			scrollX : true,
			scrollY : '65vh',
			scrollCollapse : true,
			paging : false,
			fixedColumns : {
				leftColumns : 1,
				rightColumns : 0
			}

		});
		function getProgReport(prm, mapping) {

			window.open("${pageContext.request.contextPath}/" + mapping + "/",
					"_blank");

		}
	</script>
</body>
</html>
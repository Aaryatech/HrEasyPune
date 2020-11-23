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

						<form action="${pageContext.request.contextPath}/generatePayRoll"
							id="submitInsertLeave" method="post">

							<input type="hidden" name="searchDate" id="searchDate"
								value="${date}" /> <input type="hidden" name="empIds"
								id="empIds" value="${empIds}" />
							<div id="loader" style="display: none;">
								<img
									src="${pageContext.request.contextPath}/resources/assets/images/giphy.gif"
									width="150px" height="150px"
									style="display: block; margin-left: auto; margin-right: auto">
							</div>

							<div class="table-responsive">
								<table
									class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
									width="100%" id="printtable1">


									<thead>

										<tr class="bg-blue">

											<th width="20%" class="text-center">EMP Name</th>
											<th class="text-center">Department</th>
											<th class="text-center">Designation</th>
											<th class="text-center">Total DIFF</th>
											<th class="text-center">Basic Old</th>
											<th class="text-center">Basic Current</th>
											<th class="text-center">Basic DIFF</th>
											<th class="text-center">Basic Cal</th>
											<c:forEach items="${allowanceList}" var="allowanceList">
												<th class="text-center">${allowanceList.name}&nbsp;Old</th>
												<th class="text-center">${allowanceList.name}&nbsp;Current</th>
												<th class="text-center">${allowanceList.name}&nbsp;DIFF</th>
												<th class="text-center">${allowanceList.name}&nbsp;Cal</th>
											</c:forEach>

										</tr>

									</thead>

									<tbody>
										<c:forEach items="${empList}" var="empList" varStatus="count">
											<tr>

												<td>${empList.empName}&nbsp;(${empList.empCode})</td>
												<td class="text-center">${empList.deptName}</td>
												<td class="text-center">${empList.designation}</td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<c:forEach items="${allowanceList}" var="allowanceList">
													<th class="text-center"></th>
													<th class="text-center"></th>
													<th class="text-center"></th>
												</c:forEach>

											</tr>
											<c:forEach items="${empList.generatedPayrollList}"
												var="generatedPayrollList">
												<tr>

													<td class="text-center">${generatedPayrollList.email}</td>
													<td></td>
													<td></td>
													<td class="text-right">${generatedPayrollList.salTotalDiff}</td>
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
															</c:if>
														</c:forEach>
													</c:forEach>

												</tr>
											</c:forEach>
										</c:forEach>

									</tbody>
								</table>
							</div>
							<br>
							<div class="text-center">

								<button type="submit" class="btn bg-blue ml-3 legitRipple"
									id="submtbtn">
									Process Pay Roll <i class="icon-paperplane ml-2"></i>
								</button>

							</div>

						</form>
					</div>

				</div>
				<!-- /highlighting rows and columns -->

			</div>
			<!-- /content area -->

			<!-- Info modal -->
			<div id="modal_step1" class="modal fade " data-backdrop="false"
				tabindex="-1">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header bg-info">
							<h6 class="modal-title">Updating Record...</h6>
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



	<script type="text/javascript">
		$('.datatable-fixed-left_custom').DataTable({

			columnDefs : [ {
				orderable : false,
				targets : [ 0 ]
			} ],
			"order" : [],
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
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>

<body>
	<%-- <c:url var="getEmployeeProfile" value="/getEmployeeProfile"></c:url> --%>
	<c:url var="showEmployeeProfile" value="/showEmployeeProfile"></c:url>
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
							<i class="icon-list-unordered"></i> Employee List
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
							action="${pageContext.request.contextPath}/submitupdateempcode"
							id="attendaceSheetForHrDateWise" method="post">
							<div class="table-responsive">
								<table
									class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
									width="100%" id="printtable1">
									<thead>
										<tr class="bg-blue">

											<th class="text-center" width="10%">Sr. No.</th>
											<th class="text-center">Emp Code</th>
											<th class="text-center">Name</th>
											<th class="text-center">New Code</th>
										</tr>
									</thead>
									<tbody>


										<c:forEach items="${empList}" var="empList" varStatus="count">
											<tr>
												<td>${count.index+1}</td>
												<td>${empList.empCode}</td>

												<td>
													${empList.firstName}&nbsp;${empList.middleName}&nbsp;${empList.surname}
												</td>

												<td><input id="code${empList.empId}"
													name="code${empList.empId}" value="${empList.empCode}"
													class="form-control"></td>

											</tr>
										</c:forEach>

									</tbody>
								</table>
							</div>
							<div class="form-group row">
								<button type="submit" class="btn bg-blue ml-3 legitRipple"
									id="submtbtn1">
									Submit <i class="icon-paperplane ml-2"></i>
								</button>
							</div>
						</form>
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
	<!-- Large modal -->
	<div id="modal_large1" class="modal fade" tabindex="-1">

		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Employee Details</h5>
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
	<!-- /page content -->

	<script type="text/javascript">
		$('.datatable-fixed-left_custom').DataTable({

			columnDefs : [ {
				orderable : false,
				targets : [ 0 ]
			} ],
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
	</script>

</body>
</html>
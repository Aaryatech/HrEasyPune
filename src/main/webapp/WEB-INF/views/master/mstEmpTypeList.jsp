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
								<td width="60%"><h5 class="pageTitle">
										<i class="icon-list-unordered"></i> Employee Type List
									</h5></td>
								<td width="40%" align="right"><a
									href="${pageContext.request.contextPath}/mstEmpTypeAdd"
									class="breadcrumb-elements-item">
										<button type="button" class="btn blue_btn">Add
											Employee Type</button>
								</a></td>
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
						<table
							class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
							id="printtable1">
							<thead>
								<tr class="bg-blue">

									<th width="5%" style="text-align: center;">Sr. No.</th>
									<th style="text-align: center;">Name</th>
									<c:choose>
										<c:when test="${COMPOFFCONDITION.value==0}">
											<th style="text-align: center;">Performance Incentive</th>
										</c:when>
										<c:otherwise>
											<th style="text-align: center;">Weekly off Holiday Work</th>
										</c:otherwise>
									</c:choose>

									<!-- <th>Performance Incentive Applicable</th>
									<th>Performance Incentive Type</th> -->
									<th style="text-align: center;">Production Incentive
										Applicable</th>

									<!-- 	<th>Late Mark</th>
									<th>Half Day Deduction</th> -->
									<!-- 	<th>Minimum Work Hour Rule Applicable</th> -->
									<!-- 	<th>Minimum Work Hour</th> -->

									<!-- <th>Remarks</th> -->


									<th width="10%" class="text-center" style="text-align: center;">Actions</th>
								</tr>
							</thead>
							<tbody>


								<c:forEach items="${locationList}" var="locationList"
									varStatus="count">
									<tr>
										<td>${count.index+1}</td>
										<td class="text-left">${locationList.name}</td>
										<td class="text-left"><c:choose>
												<c:when test="${COMPOFFCONDITION.value==0}">
													<c:choose>
														<c:when test="${locationList.whWork eq 'OT'}">Yes</c:when>
														<c:otherwise>No</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${locationList.whWork eq 'OT'}">Performance Incentive</c:when>
														<c:otherwise>${locationList.whWork}</c:otherwise>
													</c:choose>
												</c:otherwise>
											</c:choose></td>
										<%-- <td class="text-left">${locationList.otApplicable=='Yes' ? 'Yes': locationList.otApplicable=='No' ? 'No'  : ''}</td>
										<td class="text-left">${locationList.otType=='0' ? 'No': locationList.otType=='1' ? '1 HR of Gross Salary x 1'  :locationList.otType=='1.5' ? '1 HR of Gross Salary x 1.5'  :locationList.otType=='2' ? '1 HR of Gross Salary x 2'  : ''}</td> --%>
										<td class="text-left">${locationList.otApplicable=='Yes' ? 'Yes': locationList.otApplicable=='No' ? 'No'  : ''}</td>


										<%-- 	<td class="text-left">${locationList.lmApplicable==1 ? 'Yes': locationList.lmApplicable==0 ? 'No'  : ''}</td>
										<td class="text-left">${locationList.halfDay==1 ? 'Yes': locationList.halfDay==0 ? 'No'  : ''}</td> --%>
										<%-- 										<td class="text-left">${locationList.minworkApplicable==1 ? 'Yes': locationList.minworkApplicable==0 ? 'No'  : ''}</td>
 --%>
										<%-- 		<td class="text-right">${locationList.minWorkHr}</td> --%>

										<%-- 	<td>${locationList.details}</td> --%>



										<td class="text-center"><c:if test="${editAccess == 0}">
												<%-- <a
													href="${pageContext.request.contextPath}/editMstType?empTypeId=${locationList.attType}"
													class="list-icons-item text-primary-600" title="Edit"><i class="icon-pencil7"
													style="color: black;"></i></a>
													 --%>

												<a
													href="${pageContext.request.contextPath}/editMstType?empTypeId=${locationList.attType}"
													class="list-icons-item text-primary-600"
													data-popup="tooltip" title="" data-original-title="Edit"><i
													class="icon-pencil7"></i></a>
											</c:if> <c:if test="${deleteAccess == 0}">
												<%-- 	<a
													href="${pageContext.request.contextPath}/deleteLMstEmpType?empTypeId=${locationList.attType}"
													onClick="return confirm('Are you sure want to delete this record');"
													title="Delete"><i class="icon-trash"
													style="color: black;"></i> </a> --%>

												<a href="javascript:void(0)"
													class="list-icons-item text-danger-600 bootbox_custom"
													data-uuid="${locationList.attType}" data-popup="tooltip"
													title="" data-original-title="Delete"><i
													class="icon-trash"></i></a>
											</c:if></td>
									</tr>
								</c:forEach>

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
		// Custom bootbox dialog
		$('.bootbox_custom')
				.on(
						'click',
						function() {
							var uuid = $(this).data("uuid") // will return the number 123
							bootbox
									.confirm({
										title : 'Confirm ',
										message : 'Are you sure you want to delete selected records ?',
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
												location.href = "${pageContext.request.contextPath}/deleteLMstEmpType?empTypeId="
														+ uuid;

											}
										}
									});
						});
	</Script>
</body>
</html>
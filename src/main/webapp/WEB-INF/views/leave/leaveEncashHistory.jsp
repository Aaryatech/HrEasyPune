<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="org.springframework.util.LinkedMultiValueMap"%>
<%@ page import="org.springframework.util.MultiValueMap"%>
<%@ page import="com.ats.hreasy.common.Constants"%>
<%@ page import="com.ats.hreasy.model.Setting"%>
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
										<i class="icon-list-unordered"></i> ${editEmp.firstName}
										${editEmp.surname} Leave Encash History
									</h5></td>
								<td width="40%" align="right"></td>
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

									<th style="text-align: center;" width="10%">Sr.No</th>
									<th style="text-align: center;">Leave Type</th>
									<th style="text-align: center;">Leave Count</th>
									<th style="text-align: center;">Per Day</th>
									<th style="text-align: center;">Total</th>
									<th style="text-align: center;">Paying Month-Year</th>
									<th style="text-align: center;">Action</th>


								</tr>
							</thead>
							<tbody>


								<c:forEach items="${encashHistoryList}" var="encashHistoryList"
									varStatus="count">
									<tr>

										<td style="text-align: center;">${count.index+1}</td>

										<td>${encashHistoryList.lvTitle}</td>
										<td>${encashHistoryList.leaveCount}</td>
										<td style="text-align: right;"><fmt:formatNumber
												type="number" maxFractionDigits="2" minFractionDigits="2"
												groupingUsed="false" value="${encashHistoryList.perDayAmt}" /></td>
										<td style="text-align: right;"><fmt:formatNumber
												type="number" maxFractionDigits="2" minFractionDigits="2"
												groupingUsed="false" value="${encashHistoryList.totalAmt}" /></td>
										<td style="text-align: center;">${encashHistoryList.month}-${encashHistoryList.year}</td>
										<td style="text-align: center;"><c:choose>
												<c:when test="${encashHistoryList.isFreeze==0}">
													<a href="javascript:void(0)"
														class="list-icons-item text-danger-600 bootbox_custom"
														data-uuid="${encashHistoryList.id}"
														data-empid="${encashHistoryList.empId}" title="Delete"><i
														class="icon-trash"></i></a>
													<%-- <a
														href="${pageContext.request.contextPath}/deleteEncashLeave?empId=${encashHistoryList.empId}&id=${encashHistoryList.id}"
														title="Cancel"><i class="icon-cancel-square "></i></a> --%>
												</c:when>
												<c:otherwise>Salary is Generated</c:otherwise>
											</c:choose></td>

									</tr>
								</c:forEach>

							</tbody>
						</table>

						<div class="col-md-12" style="text-align: center;">

							<a
								href="${pageContext.request.contextPath}/empListForLeaveIncash"><button
									type="button" class="btn btn-light">Back</button></a>
						</div>


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
							var uuid = $(this).data("uuid")
							var empid = $(this).data("empid")// will return the number 123
							bootbox
									.confirm({
										title : 'Confirm ',
										message : 'Are you sure you want to delete records ?',
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
												location.href = "${pageContext.request.contextPath}/deleteEncashLeave?empId="
														+ empid + "&id=" + uuid;

											}
										}
									});
						});
	</Script>



</body>
</html>
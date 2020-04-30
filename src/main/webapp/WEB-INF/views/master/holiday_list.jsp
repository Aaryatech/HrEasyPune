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
			<div class="page-header page-header-light">


				<%-- div
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


				</div> --%>
			</div>
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">


				<!-- Highlighting rows and columns -->
				<div class="card">




					<div class="card-header header-elements-inline">
						<table width="100%">
							<tr width="100%">
								<td width="60%"><h5 class="pageTitle">
										<i class="icon-list-unordered"></i> Holiday List
									</h5></td>
								<td width="40%" align="right"><c:if
										test="${addAccess == 0}">
										<a href="${pageContext.request.contextPath}/holidayAdd"
											class="breadcrumb-elements-item">
											<button type="button" class="btn blue_btn">Add
												Holiday</button>
										</a>
									</c:if></td>
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
						<%-- <table
							class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
							id="printtable1">
							<thead>
								<tr class="bg-blue">

									<th width="10%" class="text-center">Sr. No.</th>

									<th class="text-center">Category</th>
									<th class="text-center">Holiday Title</th>
									<th class="text-center">Calendar</th>
									<th class="text-center">Date</th>
									<th width="10%" class="text-center">Actions</th>
								</tr>
							</thead>
							<tbody>


								<c:forEach items="${holList}" var="holiday" varStatus="count">
									<tr>
										<td>${count.index+1}</td>
										<td>${holiday.hoCatName}</td>
										<td>${holiday.exVar2}</td>
										<td>${holiday.calYrFromDate}&nbsp;To&nbsp;${holiday.calYrToDate}</td>
										<td>${holiday.holidayFromdt}</td>

										<td class="text-center">
											<c:if test="${editAccess == 0}">
												<a
													href="${pageContext.request.contextPath}/editHoliday?holidayId=${holiday.exVar1}"
													class="list-icons-item text-primary-600"
													data-popup="tooltip" title="" data-original-title="Edit"><i
													class="icon-pencil7"></i></a>
											</c:if> <c:if test="${deleteAccess == 0}">


												<a href="javascript:void(0)"
													class="list-icons-item text-danger-600 bootbox_custom"
													data-uuid="${holiday.exVar1}" data-popup="tooltip" title=""
													data-original-title="Delete"><i class="icon-trash"></i></a>
											</c:if>
										</td>
									</tr>
								</c:forEach>

							</tbody>
						</table> --%>


						<div class="table-responsive accordion">
							<table class="table">
								<thead>
									<tr class="bg-blue">
										<th style="text-align: center;" scope="col">#</th>
										<th style="text-align: center;" scope="col">Year</th>
										<th style="text-align: center;" scope="col">Category</th>
										<th style="text-align: center;" scope="col">Optional
											Holiday/Optional</th>
										<th style="text-align: center;" scope="col">Fixed</th>
										<th style="text-align: center;" scope="col">Total</th>
										<th style="text-align: center;" scope="col">Action</th>
									</tr>
								</thead>
								<tbody>

									<c:forEach items="${holList}" var="holList" varStatus="count">
										<tr class="accordion-toggle collapsed"
											id="accordion${count.index+1}" data-toggle="collapse"
											data-parent="#accordion${count.index+1}" href="#collapseOne">
											<td><span class="expand-button"></span></td>
											<td>${holList.yearDate}</td>
											<td>${holList.hoCatName}</td>
											<td>${holList.optionalHoliday}/${holList.optionalCount}</td>
											<td align="center">${holList.fixedCount}</td>
											<td align="center">${holList.fixedCount+holList.optionalCount}</td>
											<td style="text-align: center;"><a
												href="javascript:void(0)"
												class="list-icons-item text-danger-600 bootbox_custom"
												data-uuid="${holList.calYrId}" data-catid="${holList.catId}"
												data-popup="tooltip" title="" data-original-title="Delete"><i
													class="icon-trash"></i></a></td>
										</tr>
										<tr class="hide-table-padding">
											<!-- <td></td> -->
											<td colspan="8"><div id="collapseOne"
													class="collapse in p-3">
													<c:forEach items="${holList.holidaylist}" var="holidaylist">




														<div class="row">
															<div class="col-3 row_padd">${holidaylist.exVar2}</div>
															<div class="col-3 row_padd">${holidaylist.holidayFromdt}</div>
															<div class="col-3 row_padd">
																<c:choose>
																	<c:when test="${holidaylist.hotype==1}">Fixed</c:when>
																	<c:when test="${holidaylist.hotype==2}">Optional</c:when>
																	<c:when test="${holidaylist.hotype==0}">NA</c:when>
																</c:choose>
															</div>

															<%--<div class="col-3 row_padd">${holidaylist.holidaylist}</div> --%>
															<!-- <div class="col-3 row_padd">
															<a href="#" class="list-icons-item text-primary-600"><i
																class="icon-pencil7"></i></a> <a href="#"
																class="list-icons-item text-danger-600 bootbox_custom"><i
																class="icon-trash"></i></a>
														</div> -->
														</div>
													</c:forEach>
												</div></td>
										</tr>
									</c:forEach>
									<!-- <tr class="accordion-toggle collapsed" id="accordion1"
										data-toggle="collapse" data-parent="#accordion1"
										href="#collapseOne">
										<td><span class="expand-button"></span></td>
										<td>Cell</td>
										<td>Cell</td>
										<td>Cell</td>

									</tr>
									<tr class="hide-table-padding">
										<td></td>
										<td colspan="4">
											<div id="collapseOne" class="collapse in p-3">

												<div class="row">
													<div class="col-3 row_padd">label</div>
													<div class="col-3 row_padd">value 1</div>

													<div class="col-3 row_padd">label</div>
													<div class="col-3 row_padd">
														<a href="#" class="list-icons-item text-primary-600"><i
															class="icon-pencil7"></i></a> <a href="#"
															class="list-icons-item text-danger-600 bootbox_custom"><i
															class="icon-trash"></i></a>
													</div>
												</div>
												<div class="row">
													<div class="col-3 row_padd">label</div>
													<div class="col-3 row_padd">value 1</div>

													<div class="col-3 row_padd">label</div>
													<div class="col-3 row_padd">
														<a href="#" class="list-icons-item text-primary-600"><i
															class="icon-pencil7"></i></a> <a href="#"
															class="list-icons-item text-danger-600 bootbox_custom"><i
															class="icon-trash"></i></a>
													</div>
												</div>
												<div class="row">
													<div class="col-3 row_padd">label</div>
													<div class="col-3 row_padd">value 1</div>

													<div class="col-3 row_padd">label</div>
													<div class="col-3 row_padd">
														<a href="#" class="list-icons-item text-primary-600"><i
															class="icon-pencil7"></i></a> <a href="#"
															class="list-icons-item text-danger-600 bootbox_custom"><i
															class="icon-trash"></i></a>
													</div>
												</div>
												<div class="row">
													<div class="col-3 row_padd">label</div>
													<div class="col-3 row_padd">value 1</div>

													<div class="col-3 row_padd">label</div>
													<div class="col-3 row_padd">
														<a href="#" class="list-icons-item text-primary-600"><i
															class="icon-pencil7"></i></a> <a href="#"
															class="list-icons-item text-danger-600 bootbox_custom"><i
															class="icon-trash"></i></a>
													</div>
												</div>
											</div>
										</td>
									</tr>


									<tr class="accordion-toggle collapsed" id="accordion2"
										data-toggle="collapse" data-parent="#accordion2"
										href="#collapseTwo">
										<td><span class="expand-button"></span></td>
										<td>Cell</td>
										<td>Cell</td>
										<td>Cell</td>

									</tr>
									<tr class="hide-table-padding">
										<td></td>
										<td colspan="4">
											<div id="collapseTwo" class="collapse in p-3">
												<div class="row">
													<div class="col-2">label</div>
													<div class="col-4">value</div>
													<div class="col-2">label</div>
													<div class="col-4">value</div>
												</div>
												<div class="row">
													<div class="col-2">label</div>
													<div class="col-4">value</div>
													<div class="col-2">label</div>
													<div class="col-4">value</div>
												</div>
												<div class="row">
													<div class="col-2">label</div>
													<div class="col-4">value</div>
													<div class="col-2">label</div>
													<div class="col-4">value</div>
												</div>
												<div class="row">
													<div class="col-2">label</div>
													<div class="col-4">value</div>
													<div class="col-2">label</div>
													<div class="col-4">value</div>
												</div>
											</div>
										</td>


									</tr> -->





								</tbody>
							</table>
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
							var uuid = $(this).data("uuid") // will return the number 123
							var catid = $(this).data("catid")
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
												location.href = "${pageContext.request.contextPath}/deleteHoliday?holidayId="
														+ uuid
														+ "&catid="
														+ catid;

											}
										}
									});
						});
	</Script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<c:url var="getLoanHistory" value="/getLoanHistory" />

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
										<i class="icon-list-unordered"></i> Pending Loan List Detail
									</h5></td>

								<td width="40%" align="right"><a
									href="${pageContext.request.contextPath}/showCompLoanList"
									class="breadcrumb-elements-item">
										<button type="button" class="btn blue_btn">Pending
											Loan List</button>
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

						<div class="form-group row">

							<label class="col-form-label col-lg-2" for="locId"> Emp
								Code: </label> <label class="col-form-label col-lg-2" for="locId"
								style="color: red;"> ${empDeatil.empCode}</label> <label
								class="col-form-label col-lg-2" for="locId"> Emp Name: </label>
							<label class="col-form-label col-lg-2" for="locId"
								style="color: red;">${empDeatil.surname}&nbsp;${empDeatil.firstName}
							</label> <label class="col-form-label col-lg-2" for="locId"> Emp
								Designation: </label> <label class="col-form-label col-lg-2" for="locId"
								style="color: red;"> ${empDeatil.designation} </label>

						</div>


						<div class="form-group row">

							<label class="col-form-label col-lg-2" for="locId"> Loan
								Amount: </label> <label class="col-form-label col-lg-2" for="locId"
								style="color: red;">${empDeatil.loanAmt} </label> <label
								class="col-form-label col-lg-2" for="locId"> Loan Repay
								Amount: </label> <label class="col-form-label col-lg-2" for="locId"
								style="color: red;"> ${empDeatil.loanRepayAmt} </label> <label
								class="col-form-label col-lg-2" for="locId"> EMI Amount:
							</label> <label class="col-form-label col-lg-2" for="locId"
								style="color: red;"> ${empDeatil.loanEmi} </label>

						</div>

						<%-- <div class="form-group row">

							<label class="col-form-label col-lg-2" for="locId"> Loan
								Guarantor 1: </label> <label class="col-form-label col-lg-2" for="locId"
								style="color: red;">${empdetList[0].empCode}-${empdetList[0].firstName}
								${empdetList[0].surname}</label> <label class="col-form-label col-lg-2"
								for="locId">Loan Guarantor 2: </label> <label
								class="col-form-label col-lg-2" for="locId" style="color: red;">${empdetList[1].empCode}-${empdetList[1].firstName}
								${empdetList[1].surname}</label> <label class="col-form-label col-lg-2"
								for="locId"> Loan Document: </label> <label
								class="col-form-label col-lg-2" for="locId" style="color: red;"><a
								class="icon-file-pdf icon-1x text-danger  text-danger"
								href="${docUrl}">&nbsp;Loan Document</a></label>


						</div> --%>


						<table
							class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
							id="printtable1">
							<thead>
								<tr class="bg-blue">

									<th width="10%" class="text-center">Sr. No.</th>
									<th class="text-center">Application No.</th>
									<th class="text-center">Loan Date</th>
									<th class="text-center">Loan Amount</th>
									<th class="text-center">Repay Amount</th>
									<th class="text-center">Loan EMI</th>
									<th class="text-center">Current Outstanding</th>
									<th class="text-center">Status</th>
									<th class="text-center">Action</th>
								</tr>
							</thead>
							<tbody>


								<c:forEach items="${loanList}" var="empdetList"
									varStatus="count">
									<tr>
										<td>${count.index+1}</td>
										<td>${empdetList.loanApplNo}</td>
										<td>${empdetList.loanAddDate}</td>
										<td>${empdetList.loanAmt}</td>
										<td>${empdetList.loanRepayAmt}</td>
										<td>${empdetList.loanEmi}</td>
										<td>${empdetList.currentOutstanding}</td>
										<td>${empdetList.loanStatus}</td>
										<td class="text-center"><c:if
												test="${empdetList.skipId==0}">
												<a
													href="${pageContext.request.contextPath}/showSkipLoan?id=${empdetList.exVar1}&empId=${empdetList.exVar2}"
													class="list-icons-item text-primary-600"
													data-popup="tooltip" title=""
													data-original-title="Skip Loan"><i class="icon-last"></i></a>
											</c:if> <a
											href="${pageContext.request.contextPath}/showForeCloseLoan?id=${empdetList.exVar1}&empId=${empdetList.exVar2}"
											class="list-icons-item text-primary-600" data-popup="tooltip"
											title="" data-original-title="Foreclose Loan"><i
												class="icon-close2 "></i></a> <a
											href="${pageContext.request.contextPath}/showPartialPayLoan?id=${empdetList.exVar1}&empId=${empdetList.exVar2}"
											class="list-icons-item text-primary-600" data-popup="tooltip"
											title="" data-original-title="Partial Pay"><i
												class="icon-comments e9a9"></i></a> <a
											href="${pageContext.request.contextPath}/showRepayLoan?id=${empdetList.exVar1}&empId=${empdetList.exVar2}"
											class="list-icons-item text-primary-600" data-popup="tooltip"
											title="" data-original-title="Repay Schedule"><i
												class="icon-sort-time-desc"></i></a> &nbsp;<%-- <a
											href="${pageContext.request.contextPath}/showChangeGuarantor?id=${empdetList.exVar1}&empId=${empdetList.exVar2}"
											class="list-icons-item text-primary-200" data-popup="tooltip"
											title="" data-original-title="Change Guarantor"><i
												class="icon-pencil7"></i></a> --%></td>


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

</body>
</html>
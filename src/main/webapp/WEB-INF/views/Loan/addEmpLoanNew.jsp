<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	

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
								<td width="60%"><h5 class="pageTitle"><i class="icon-list-unordered"></i> Employee List For Loan/Guarantor
									</h5></td>
								<td width="40%" align="right"></td>
							</tr>
						</table>
					</div>

					<div class="card-body">
<form action="proceedLoanGuarantar" id="submitInsertEmp" method="post">
<input type="hidden" readonly="readonly" id="empId" name="empId" value="${empKey}"> 
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

										<th width="10%">Sr.No</th>
										<c:if test="${empIdForLoan!=0}">
													 <th>Select Guarantor</th>
													 </c:if>
 										<th>Employee Code</th>
										<th>Employee Name</th>
										<th>Emp Type</th>
										<th>Department</th>
										<th>Designation</th>
										<th>Location</th>
										<th>Action</th>


									</tr>
								</thead>
								<tbody>


									<c:forEach items="${empdetList}" var="empdetList"
										varStatus="count">
										
										<tr>

											<td>${count.index+1}</td>
											<c:if test="${empIdForLoan!=0}">
													 <td><input type="checkbox"
													id="empIds${empdetList.empId}" value="${empdetList.empId}"
													name="empIds" class="select_all"> </td>
													 </c:if>
 											<td>${empdetList.empCode}</td>
											<td>${empdetList.surname}&nbsp;${empdetList.middleName}&nbsp;${empdetList.firstName}</td>
											<td>${empdetList.empTypeName}</td>
											<td>${empdetList.deptName}</td>
											<td>${empdetList.empDesgn}</td>

											<td>${empdetList.locName}</td>
											<td><c:if test="${editAccess == 0}">
											<c:choose>
												<c:when test="${linkType=='ByEMI'}">
													<%-- <a
													href="${pageContext.request.contextPath}/showCalLoan?empId=${empdetList.exVar1}"
													class="list-icons-item text-primary-600" data-popup="tooltip" title="Calculate Loan" data-original-title="Calculate Loan"><i class="icon-enlarge5 "
													 ></i></a> --%>
													 <c:if test="${empIdForLoan==0}">
													  <a
													href="${pageContext.request.contextPath}/showGuaranters?empId=${empdetList.exVar1}"
													class="list-icons-item text-primary-600" data-popup="tooltip" title="Calculate Loan" data-original-title="Calculate Loan"><i class="icon-enlarge5 "
													 ></i></a>
													 </c:if>
													  
													
											</c:when>
											<c:otherwise>
											
											<a
													href="${pageContext.request.contextPath}/showAddLoan?empId=${empdetList.exVar1}"
													class="list-icons-item text-primary-600" data-popup="tooltip" title="Add Loan" data-original-title="Edit"><i class="icon-enlarge5 "
													 ></i></a>
											</c:otherwise>
											</c:choose>
											 </c:if></td>

										</tr>
									</c:forEach>

								</tbody>
							</table>
<c:if test="${empIdForLoan!=0}">
						 <div style="text-align: center;">
								<input type="submit" class="btn blue_btn" value="Proceed For Loan"
									id="deleteId"
									style="align-content: center; width: 160px; margin-left: 30px;">
									
							</div>
							<span class="validation-invalid-label" id="error_chk"
								style="display: none;">Please select two guarantar from employee list .</span>
								</c:if>
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
	<!-- /page content -->


	<script type="text/javascript">
		$(document).ready(function($) {
			$("#submitInsertEmp").submit(function(e) {

				var isError = false;
				var errMsg = "";

				var checked = $("#submitInsertEmp input:checked").length > 0;
				var tot=$("#submitInsertEmp input:checked").length
				if (parseInt(tot)==2) {
					$("#error_chk").hide()
					isError = false;
				} else {
					$("#error_chk").show()
					isError = true;
				}

				if (!isError) {

					var x = true;
					if (x == true) {

						document.getElementById("deleteId").disabled = true;

						return true;
					}
					//end ajax send this to php page
				}
				return false;
			});
		});
	</script>

	<script type="text/javascript">
		$(document).ready(
				function() {
					//	$('#printtable').DataTable();

					$("#selAll").click(
							function() {
								$('#printtable1 tbody input[type="checkbox"]')
										.prop('checked', this.checked);
							});
				});
	</script>

</body>
</html>
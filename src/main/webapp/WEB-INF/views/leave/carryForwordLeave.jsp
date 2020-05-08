<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
<c:url var="getPreviousYearHistory" value="/getPreviousYearHistory" />
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


			<!-- Content area -->
			<div class="content">


				<!-- Highlighting rows and columns -->
				<div class="card">



					<div class="card-header header-elements-inline">
						<table width="100%">
							<tr width="100%">
								<td width="60%"><h5 class="pageTitle">
										<i class="icon-list-unordered"></i> Carry forward Leave
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
						<form
							action="${pageContext.request.contextPath}/carryForwordLeave"
							id="submitInsertProjectHeader" method="get">



							<div class="form-group row">
								<label
									class="col-form-label text-info font-weight-bold col-lg-2"
									for="locId">Select Location <span style="color: red">*
								</span> :
								</label>
								<div class="col-md-2">
									<select name="locId" data-placeholder="Select Location"
										id="locId"
										class="form-control form-control-select2 select2-hidden-accessible"
										tabindex="-1" required="required">
										<option value="">Select Location</option>
										<c:forEach items="${locationList}" var="locationList">

											<c:choose>
												<c:when test="${locationList.locId==locId}">
													<option value="${locationList.locId}" selected>${locationList.locName}</option>
												</c:when>
												<c:otherwise>
													<option value="${locationList.locId}">${locationList.locName}</option>
												</c:otherwise>
											</c:choose>

										</c:forEach>
									</select>

								</div>

							</div>


							<div class="col-md-12">
								<div class="text-center">
									<input type="submit" class="btn blue_btn" id="searchh"
										value="Search" />

								</div>
							</div>
						</form>



						<br>
						<div id='loader' style='display: none;'>
							<img
								src='${pageContext.request.contextPath}/resources/assets/images/giphy.gif'
								width="150px" height="150px"
								style="display: block; margin-left: auto; margin-right: auto">
						</div>


						<div class="table-responsive">
							<table
								class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
								id="printtable2">
								<thead>
									<tr class="bg-blue">

										<th class="text-center" width="5%">Sr. No.</th>
										<th class="text-center" width="10%">Employee Code<br>(Emp
											Type)
										</th>
										<th class="text-center" class="text-center" width="20%">Employee
											Name<br>(Designation-Department)
										</th>
										<th class="text-center" class="text-center"></th>

									</tr>
								</thead>
								<tbody>


									<c:forEach items="${employeeInfoList}" var="employeeInfoList"
										varStatus="count">
										<tr>
											<td>${count.index+1}</td>
											<td>${employeeInfoList.empCode}<br>(${employeeInfoList.empTypeName})
											</td>
											<td>${employeeInfoList.empName}<br>(${employeeInfoList.empDesgn}-${employeeInfoList.deptName})<br>Per
												Day - <fmt:formatNumber type="number" maxFractionDigits="2"
													minFractionDigits="2" groupingUsed="false"
													value=" ${((employeeInfoList.basic+
																	employeeInfoList.allowSum)/day)}" />
											</td>

											<td><table
													class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1">

													<tr>
														<td class="text-center">Leave Type Name</td>
														<!-- <td>Opening Bal</td>
														<td>Earned</td>
														<td>Approved</td>
														<td>Applied</td> -->
														<td class="text-center">Balanced</td>
														<td class="text-center">Max CF - Encash</td>
														<td class="text-center">Encash Count</td>
														<td class="text-center">Encash AMT</td>
														<td class="text-center">Carry Forward</td>
													</tr>
													<c:forEach items="${leaveHistoryDetailForCarryList}"
														var="leaveHistoryDetailForCarryList">
														<c:if
															test="${leaveHistoryDetailForCarryList.empId==employeeInfoList.empId}">

															<c:set
																value="${leaveHistoryDetailForCarryList.balLeave+leaveHistoryDetailForCarryList.lvsAllotedLeaves-
																leaveHistoryDetailForCarryList.sactionLeave-leaveHistoryDetailForCarryList.aplliedLeaeve}"
																var="ballv"></c:set>
															<c:set var="carryForward" value="0"></c:set>
															<c:if
																test="${leaveHistoryDetailForCarryList.maxAccumulateCarryforward>0}">
																<c:choose>

																	<c:when
																		test="${ballv>leaveHistoryDetailForCarryList.maxAccumulateCarryforward}">
																		<c:set var="carryForward"
																			value="${leaveHistoryDetailForCarryList.maxAccumulateCarryforward}"></c:set>
																	</c:when>

																	<c:otherwise>
																		<c:set var="carryForward" value="${ballv}"></c:set>
																	</c:otherwise>
																</c:choose>
															</c:if>
															<c:set var="inCashleavCount" value="0"></c:set>
															<c:set var="inCashleavYesNo" value="No"></c:set>
															<c:choose>
																<c:when
																	test="${leaveHistoryDetailForCarryList.isInCash==1}">
																	<c:set var="inCashleavCount"
																		value="${ballv-carryForward}"></c:set>
																	<c:set var="inCashleavYesNo" value="Yes"></c:set>
																	<%-- <td>${inCashleavCount}</td> --%>

																	<%-- <td><input
																		id="inCash${previousleavehistorylist.lvTypeId}"
																		name="inCash${previousleavehistorylist.lvTypeId}"
																		onchange="resetAmtValue(${previousleavehistorylist.lvTypeId})"
																		value="<fmt:formatNumber type="number"
																		maxFractionDigits="2" minFractionDigits="2" groupingUsed="false" 
																		value=" ${((empBasicAllownceForLeaveInCash.basic+
																	empBasicAllownceForLeaveInCash.allowanceValue)/day)*inCashleavCount}" />"
																		class="form-control numbersOnly" type="text" required></td> --%>
																</c:when>
															</c:choose>
															<c:set
																value="${leaveHistoryDetailForCarryList.balLeave+leaveHistoryDetailForCarryList.lvsAllotedLeaves-
																leaveHistoryDetailForCarryList.sactionLeave-leaveHistoryDetailForCarryList.aplliedLeaeve}"
																var="carryForword"></c:set>
															<tr>
																<td>${leaveHistoryDetailForCarryList.lvTitleShort}
																</td>
																<%-- <td>${leaveHistoryDetailForCarryList.balLeave}</td>
																<td>${leaveHistoryDetailForCarryList.lvsAllotedLeaves}</td>
																<td>${leaveHistoryDetailForCarryList.sactionLeave}</td>
																<td>${leaveHistoryDetailForCarryList.aplliedLeaeve}</td> --%>
																<td class="text-right">${ballv}</td>
																<td class="text-center">${leaveHistoryDetailForCarryList.maxAccumulateCarryforward}-${inCashleavYesNo}</td>
																<td class="text-right">${inCashleavCount}</td>
																<td><input style="text-align: right;"
																	id="inCash${leaveHistoryDetailForCarryList.lvTypeId}${employeeInfoList.empId}"
																	name="inCash${leaveHistoryDetailForCarryList.lvTypeId}${employeeInfoList.empId}"
																	value="<fmt:formatNumber type="number"
																		maxFractionDigits="2" minFractionDigits="2" groupingUsed="false" 
																		value=" ${((employeeInfoList.basic+
																	employeeInfoList.allowSum)/day)*inCashleavCount}" />"
																	class="form-control numbersOnly" type="text" required></td>
																<td class="text-right"><input
																	style="text-align: right;"
																	id="carryfrwd${leaveHistoryDetailForCarryList.lvTypeId}${employeeInfoList.empId}"
																	name="carryfrwd${leaveHistoryDetailForCarryList.lvTypeId}${employeeInfoList.empId}"
																	value="${carryForward}"
																	onchange="changeCarryforward(${previousleavehistorylist.lvTypeId})"
																	class="form-control numbersOnly" type="text" required></td>
															</tr>
														</c:if>
													</c:forEach>
												</table></td>

										</tr>


									</c:forEach>

								</tbody>
							</table>
						</div>
					</div>

				</div>
				<!-- /highlighting rows and columns -->


				<!-- /content area -->
			</div>

			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
			<!-- /footer -->

		</div>
		<!-- /main content -->

	</div>
	<!-- /page content -->
	<script type="text/javascript">
		 

		function callDetail(exVar1, empId) {
			alert(exVar1);
			window
					.open("${pageContext.request.contextPath}/empDetailHistory?empId="
							+ exVar1);

		}

		function callDelete(weighId) {
			window.open("${pageContext.request.contextPath}/deleteWeighing/"
					+ weighId);

		}
	</script>
	<script>
													function trim(el) {
														el.value = el.value
																.replace(
																		/(^\s*)|(\s*$)/gi,
																		"")
																. // removes leading and trailing spaces
																replace(
																		/[ ]{2,}/gi,
																		" "). // replaces multiple spaces with one space 
																replace(/\n +/,
																		"\n"); // Removes spaces after newlines
														return;
													}

													function validateEmail(
															email) {

														var eml = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;

														if (eml.test($
																.trim(email)) == false) {

															return false;

														}

														return true;

													}
													function validateMobile(
															mobile) {
														var mob = /^[1-9]{1}[0-9]{9}$/;

														if (mob.test($
																.trim(mobile)) == false) {

															//alert("Please enter a valid email address .");
															return false;

														}
														return true;

													}
													function changeCarryforward(
															typeId) {
														var carryfrwd = parseFloat(document
																.getElementById("carryfrwd"
																		+ typeId).value);
														var currentYearBalace = parseFloat($(
																"#currentEarn"
																		+ typeId)
																.data("uuid"));

														if (isNaN(carryfrwd)) {

															carryfrwd = parseFloat($(
																	"#currentEarn"
																			+ typeId)
																	.data(
																			"orignalcarryfrwd"));
															//alert(carryfrwd)
															document
																	.getElementById('carryfrwd'
																			+ typeId).value = carryfrwd;
														}
														document
																.getElementById('currentYearBalance'
																		+ typeId).innerHTML = carryfrwd
																+ currentYearBalace;

													}
													function resetAmtValue(
															typeId) {
														var inCash = parseFloat(document
																.getElementById("inCash"
																		+ typeId).value);
														 
														if (isNaN(inCash)) {

															 
															document
																	.getElementById('inCash'
																			+ typeId).value = 0;
														}
														 

													}
													
													/* $(document).ready(function($) {

														$("#submitForm").submit(function(e) {
															var isError = false;

															if (!isError) {

																var x = confirm("Do you really want to Assign Structure?");
																if (x == true) {

																	document.getElementById("submtbtn").disabled = true;
																	return true;
																}
																//end ajax send this to php page
															}
															return false;
														});
													}); */

													$('.bootbox_custom')
															.on(
																	'click',
																	function() {

																		bootbox
																				.confirm({
																					title : 'Confirm ',
																					message : 'Do you really want to Assign Structure?',
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
																					callback : function(
																							result) {
																						if (result) {
																							document
																									.getElementById(
																											'submitForm')
																									.submit();

																						}
																					}
																				});
																	});
													//
												</script>
</body>
</html>
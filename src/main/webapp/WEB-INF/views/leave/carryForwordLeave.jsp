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

						<form
							action="${pageContext.request.contextPath}/submitCarryFrwdAndAssignNewStructure"
							id="submitCarryFrwdAndAssignNewStructure" method="post">
							<div class="table-responsive">
								<table
									class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
									id="printtable1">
									<thead>
										<tr class="bg-blue">

											<th class="text-center" width="5%">Sr. No.</th>
											<th class="text-center" width="5%"><input
												type="checkbox" name="selAll" id="selAll" /></th>
											<th class="text-center" width="10%">Employee Code<br>(Emp
												Type)
											</th>
											<th class="text-center" class="text-center" width="20%">Employee
												Name<br>(Designation-Department)
											</th>
											<th class="text-center" class="text-center"></th>
											<th class="text-center" class="text-center"
												class="text-center" width="10%">Current Year Structure
												Allotment</th>

										</tr>
									</thead>
									<tbody>


										<c:forEach items="${employeeInfoList}" var="employeeInfoList"
											varStatus="count">

											<c:set var="perDay"
												value="${((employeeInfoList.basic+
																	employeeInfoList.allowSum)/day)}"></c:set>
											<tr>
												<td>${count.index+1}</td>
												<td><input type="checkbox"
													id="empId${employeeInfoList.empId}"
													value="${employeeInfoList.empId}" name="empId"
													class="select_all"></td>
												<td>${employeeInfoList.empCode}<br>(${employeeInfoList.empTypeName})
												</td>
												<td>${employeeInfoList.empName}<br>(${employeeInfoList.empDesgn}-${employeeInfoList.deptName})<br>Per
													Day - <fmt:formatNumber type="number" maxFractionDigits="2"
														minFractionDigits="2" groupingUsed="false"
														value=" ${((employeeInfoList.basic+
																	employeeInfoList.allowSum)/day)}" />
													<input id="perDay${employeeInfoList.empId}"
													name="perDay${employeeInfoList.empId}"
													value="<fmt:formatNumber type="number" maxFractionDigits="2"
														minFractionDigits="2" groupingUsed="false"
														value=" ${((employeeInfoList.basic+
																	employeeInfoList.allowSum)/day)}" />"
													type="hidden" required>
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

																<c:if
																	test="${ballv!=0 || leaveHistoryDetailForCarryList.maxAccumulateCarryforward!=0 || inCashleavYesNo!='No'}">
																	<tr>
																		<td>${leaveHistoryDetailForCarryList.lvTitleShort}
																		</td>
																		<%-- <td>${leaveHistoryDetailForCarryList.balLeave}</td>
																<td>${leaveHistoryDetailForCarryList.lvsAllotedLeaves}</td>
																<td>${leaveHistoryDetailForCarryList.sactionLeave}</td>
																<td>${leaveHistoryDetailForCarryList.aplliedLeaeve}</td> --%>
																		<td class="text-right">${ballv}</td>
																		<td class="text-center">${leaveHistoryDetailForCarryList.maxAccumulateCarryforward}-${inCashleavYesNo}</td>
																		<td class="text-right">
																			<%-- <c:choose>
																				<c:when test="${inCashleavYesNo=='Yes'}"> --%> <input
																			style="text-align: right;"
																			id="inCash${leaveHistoryDetailForCarryList.lvTypeId}${employeeInfoList.empId}"
																			name="inCash${leaveHistoryDetailForCarryList.lvTypeId}${employeeInfoList.empId}"
																			value="${inCashleavCount}"
																			onchange="changeCarryforward(${employeeInfoList.empId},
																		${leaveHistoryDetailForCarryList.lvTypeId})"
																			class="form-control numbersOnly" type="text" required>
																			<%-- </c:when>
																				<c:otherwise>${inCashleavCount}</c:otherwise>
																			</c:choose> --%>
																		</td>
																		<td class="text-right"
																			id="amtTd${leaveHistoryDetailForCarryList.lvTypeId}${employeeInfoList.empId}"
																			data-bal="${ballv}" data-perday="${perDay}"
																			data-incashleavcount="${inCashleavCount}"
																			data-carryforward="${carryForward}"><fmt:formatNumber
																				type="number" maxFractionDigits="2"
																				minFractionDigits="2" groupingUsed="false"
																				value=" ${perDay*inCashleavCount}" /></td>
																		<td class="text-right"><input
																			style="text-align: right;"
																			id="carryfrwd${leaveHistoryDetailForCarryList.lvTypeId}${employeeInfoList.empId}"
																			name="carryfrwd${leaveHistoryDetailForCarryList.lvTypeId}${employeeInfoList.empId}"
																			value="${carryForward}"
																			onchange="changeCarryforward(${employeeInfoList.empId},
																		${leaveHistoryDetailForCarryList.lvTypeId})"
																			class="form-control numbersOnly" type="text" required></td>
																	</tr>
																</c:if>
															</c:if>
														</c:forEach>
													</table></td>
												<td><select name="structId${employeeInfoList.empId}"
													data-placeholder="Select Structure"
													id="structId${employeeInfoList.empId}"
													class="form-control form-control-select2 select2-hidden-accessible">

														<option value="">Select Structure</option>
														<c:forEach items="${lStrList}" var="lStrList">

															<option value="${lStrList.lvsId}">${lStrList.lvsName}</option>

														</c:forEach>

												</select><span class="validation-invalid-label"
													id="error_structId${employeeInfoList.empId}"
													style="display: none;">This field is required.</span></td>

											</tr>


										</c:forEach>

									</tbody>
								</table>
							</div>
							<br>
							<div style="text-align: center;">
								<input type="submit" class="btn blue_btn" value="Submit"
									id="sbtnbutn">
							</div>
						</form>
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

	<script>
												 

											 
													function changeCarryforward(
															empId,typeId) {
														
														var perday = $("#amtTd"+typeId+""+empId).data("perday");
														var carryforward = $("#amtTd"+typeId+""+empId).data("carryforward");
														var incashleavcount = $("#amtTd"+typeId+""+empId).data("incashleavcount");
														
														 var carryfrwdChange = parseFloat(document
																.getElementById("carryfrwd"
																		+typeId+''+empId).value);
														 
														 var inCash = parseFloat(document
																	.getElementById("inCash"
																			+typeId+''+empId).value);
														 
														if (isNaN(carryfrwdChange)) {

															carryfrwdChange=carryforward;
															document
																	.getElementById('carryfrwd'
																			+typeId+''+empId).value = carryforward;
														}
														
														if (isNaN(inCash)) {
															inCash=incashleavcount;
															document
																	.getElementById('inCash'
																			+typeId+''+empId).value = incashleavcount;
														}
														
														document
														.getElementById('amtTd'
																+ typeId+''+empId).innerHTML = (inCash*perday).toFixed(2);
														 

													}
												 
													
													  $(document).ready(function($) {

														$("#submitCarryFrwdAndAssignNewStructure").submit(function(e) {
															var isError = false;
															var checkboxes = document.getElementsByName('empId');
															var vals = "";
															for (var i=0, n=checkboxes.length;i<n;i++) 
															{
															    if (checkboxes[i].checked) 
															    {
															        //vals += ","+checkboxes[i].value;
															        
															        if(document.getElementById("structId"+checkboxes[i].value).value == ""){
															        	
															        	$("#error_structId"+checkboxes[i].value).show();
															        	var isError = true;
															        }else{
															        	$("#error_structId"+checkboxes[i].value).hide();
															        }
															    }
															}
															
															//alert(vals)
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
													}); 
</script>
</body>
</html>
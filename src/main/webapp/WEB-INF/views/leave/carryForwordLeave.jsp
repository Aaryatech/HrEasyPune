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
										<th class="text-center" class="text-center" width="30%">Employee
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
											<td>${employeeInfoList.empName}<br>(${employeeInfoList.empDesgn}-${employeeInfoList.deptName})
											</td>

											<td><table
													class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1">



													<tr>

														<td>${employeeInfoList.empCode}<br>(${employeeInfoList.empTypeName})
														</td>
														<td>${employeeInfoList.empName}<br>(${employeeInfoList.empDesgn}-${employeeInfoList.deptName})
														</td>

													</tr>

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
		function search() {

			//alert("
												Hi View Orders  ");

			var empId=document.getElementById(
												"empId").value;

			//alert(compId);

			var valid=true;
												if (empId== null || empId== "") {
				valid=false;
												alert("Please Select Employee");
			}

			if (valid==
												true) {
				$("#loader").show();
				$
						.getJSON(
								'${getPreviousYearHistory}',
								{
									empId
												: empId,
									ajax
												: 'true',
								},

								function(data) {

									$("#printtable1
												tbody").empty();

									for (var i=0; i< data.length; i++) {

										var ballv = data[i].balLeave
												+ data[i].lvsAllotedLeaves
												- data[i].sactionLeave
												- data[i].aplliedLeaeve;
										var tr_data = '<tr>
													<td>' + data[i].lvTitle + '</td>' + '
													<td>' + data[i].balLeave + '</td>' + '
													<td>' + data[i].lvsAllotedLeaves + '</td>' + '
													<td>' + data[i].sactionLeave + '</td>' + '
													<td>' + data[i].aplliedLeaeve + '</td>
													<td>' + ballv + '</td>
													<td><input id="inchashLv'+data[i].lvTypeId+'"
														name="inchashLv'+data[i].lvTypeId+'" value="'+0+'"
														class="form-control" type="number" required></td>' + '
													<td><input id="carryfrwd'+data[i].lvTypeId+'"
														name="carryfrwd'+data[i].lvTypeId+'" value="'+ballv+'"
														class="form-control" type="text" required></td>
												</tr>';
										$('#printtable1' + ' tbody').append(
												tr_data);
									}

									$("#loader").hide();

								});

			}//end of if valid ==true

		}

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
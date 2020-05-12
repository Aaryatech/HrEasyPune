<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>


<body>
<c:url value="/sendUserCredByEmail" var="sendUserCred"></c:url>
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
										<i class="icon-list-unordered"></i> Employee Login Assignment
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
						<form
							action="${pageContext.request.contextPath}/submitAssignLoginType"
							id="submitInsertEmp" method="post">

							<div class="form-group row">

								<label
									class="col-form-label text-info font-weight-bold col-lg-2"
									for="desigId"> Login Types <span class="text-danger">*</span>:
								</label>
								<div class="col-lg-4">
									<select name="login_type" data-placeholder="Select  Login Type"
										id="login_type"
										class="form-control form-control-select2 select2-hidden-accessible">
										<option selected disabled value="-1">Select login</option>
										<option value="1">Web Application</option>
										<option value="2">Mobile App</option>
										<option value="3">Mobile and Web Application Both</option>

									</select> <span class="hidedefault   validation-invalid-label"
										style="display: none;" id="error_desigId">This field is
										required.</span>
								</div>
								<div class="col-lg-3">
								<div id="loader" align="center" style="display: none;">

								<button type="button" class="btn bg-teal-400 ml-2" id="spinner-dark">
									<i class="icon-spinner spinner mr-2"></i>
									Sending...
								</button>
							</div>
							</div>
							</div>

							<div class="table-responsive">
								<table
									class="table  table-bordered table-hover datatable-highlight  "
									id="printtable1">

									<!-- <table class="table datatable-scroll-y" width="100%"
									id="printtable1"> -->
									<thead>
										<tr class="bg-blue">

											<th width="10%">Sr.no</th>

											<th><input type="checkbox" name="selAll" id="selAll" /></th>
										<th>Employee Code</th>
											<th>Employee Detail</th>
											<!-- <th>Department</th>
											<th>Designation</th> -->
											<th>Mobile</th>
											<th>Email</th>
											<th>Login Type</th>
											<th>Action</th>

										</tr>
									</thead>
									<tbody>


										<c:forEach items="${empdetList}" var="empdetList"
											varStatus="count">
											
											<c:set  var="sty_color" value="orange"></c:set>
											<c:choose>
								<c:when test="${empdetList.shiftname eq '0'}">
									<c:set  var="sty_color" value="orange"></c:set>
											</c:when>
											<c:otherwise>
											<c:set  var="sty_color" value=""></c:set>
											</c:otherwise>
											</c:choose>
											<tr id="empId${empdetList.empId}" style="background: ${sty_color};">

												<td>${count.index+1}</td>
												<td><input type="checkbox"
													id="empId${empdetList.empId}" value="${empdetList.empId}"
													name="empId" class="select_all"></td>
												<td>${empdetList.empCode}&nbsp;(${empdetList.empTypeName})</td>
											<td>${empdetList.surname}&nbsp;&nbsp;${empdetList.firstName}
												(${empdetList.empDesgn} - ${empdetList.deptName})</td>
												
												<td>${empdetList.mobileNo1}</td>
												<td>${empdetList.woCatName}</td>
												
												<%-- <td>${empdetList.deptName}</td>
												<td>${empdetList.empDesgn}</td> --%>
												<c:set var="loginType" value="NA" />
												<c:choose>
													<c:when test="${empdetList.shiftname eq '1'}">
														<c:set var="loginType" value="Web Application" />
													</c:when>
													<c:when test="${empdetList.shiftname eq '2'}">
														<c:set var="loginType" value="Mobile App" />
													</c:when>
													<c:when test="${empdetList.shiftname eq '3'}">
														<c:set var="loginType"
															value="Mobile and Web Application Both" />
													</c:when>
													<c:otherwise>
													<c:set var="loginType" value="NA" />
													</c:otherwise>
												</c:choose>
												<td>${loginType}</td>
												
												<td><a href="#" title="Reset and send Login Credential on Email" onclick="sendUserCred(${empdetList.empId},'${empdetList.woCatName}')" ><i class="icon-mail5 mr-3 icon-2x" style="color:red;"></i></a></td>

											</tr>
										</c:forEach>

									</tbody>
								</table>
							</div>
							<br /> <span class="validation-invalid-label" id="error_chk"
								style="display: none;">Please Select the Employee.</span>


							<div style="text-align: center;">
								<input type="submit" class="btn blue_btn" value="Assign"
									id="deleteId"
									style="align-content: center; width: 113px; margin-left: 40px;">
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
	<!-- /page content -->


	<script type="text/javascript">
	function sendUserCred(empId,empEmail){
		$("#loader").show();
		$.getJSON('${sendUserCred}', { 
			empId : empId,
			empEmail : empEmail,
			ajax : 'true',
		},

		function(data) {
			//alert(JSON.stringify(data));
			$("#loader").hide();
			if(data.error==true)
			document.getElementById("empId"+empId).style.backgroundColor='orange';
			else
			document.getElementById("empId"+empId).style.backgroundColor='green';

		});

		
	}
		$(document).ready(function($) {
			$("#submitInsertEmp").submit(function(e) {

				var isError = false;
				var errMsg = "";
				var login_type = $("#login_type").val();

				var checked = $("#submitInsertEmp input:checked").length > 0;
				if (!checked) {
					$("#error_chk").show()
					isError = true;
				} else {
					$("#error_chk").hide()
					isError = false;
				}
				//alert("checked" +checked);
				if (login_type == null || login_type == "") {
					isError = true;
					$("#error_desigId").show()
				} else {
					$("#error_desigId").hide()
				}

				if (!isError) {

					var x = true;
					if (x == true) {
						var table = $('#printtable1').DataTable();
						table.search("").draw();
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
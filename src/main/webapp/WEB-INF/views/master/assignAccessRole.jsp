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
										<i class="icon-list-unordered"></i> Employee Category
										Assignment (Access Role)
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
						<c:if test="${editAccess == 0}">
							<form
								action="${pageContext.request.contextPath}/submitAssignAccessRole"
								id="submitInsertEmp" method="post">
						</c:if>
						<div class="form-group row">

							<label class="col-form-label text-info font-weight-bold col-lg-2"
								for="skillId"> Employee Category <span
								class="text-danger">*</span>:
							</label>
							<div class="col-lg-4">
								<select name="accessId"
									data-placeholder="Select Employee
										Category"
									id="accessId"
									class="form-control form-control-select2 select2-hidden-accessible">
									<option value="">Select</option>
									<c:forEach items="${empTypeList}" var="empTypeList">
										<option value="${empTypeList.empTypeId}">${empTypeList.empTypeName}</option>
									</c:forEach>
								</select> <span class="hidedefault   validation-invalid-label"
									style="display: none;" id="error_accessId">This field is
									required.</span>
							</div>

						</div>

						<div class="table-responsive">
							<!-- <table
									class="table table-bordered table-hover datatable-highlight"
									id="printtable1"> -->
							<table
								class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
								width="100%" id="printtable1">
								<thead>
									<tr class="bg-blue">

										<th width="10%">Sr.no</th>

										<th><input type="checkbox" name="selAll" id="selAll" /></th>
										<th>Employee Code</th>
										<th>Employee Detail</th>

										<th>Company</th>
										<th>Employee Category</th>

									</tr>
								</thead>
								<tbody>


									<c:forEach items="${empdetList}" var="empdetList"
										varStatus="count">
										<c:set var="sty_color" value="orange"></c:set>
										<c:choose>
											<c:when test="${empdetList.locName eq null}">
												<c:set var="sty_color" value="orange"></c:set>
											</c:when>
											<c:otherwise>
												<c:set var="sty_color" value=""></c:set>
											</c:otherwise>
										</c:choose>
										<tr style="background: ${sty_color};">

											<td>${count.index+1}</td>

											<td><input type="checkbox" id="empId${empdetList.empId}"
												value="${empdetList.empId}" name="empId" class="select_all"></td>
											<td>${empdetList.empCode}&nbsp;(${empdetList.empTypeName})</td>
											<td>${empdetList.surname}&nbsp;&nbsp;${empdetList.firstName}
												(${empdetList.empDesgn} - ${empdetList.deptName})</td>
											<td>${empdetList.subCompName}</td>
											<td>${empdetList.locName}</td>
										</tr>
									</c:forEach>

								</tbody>
							</table>
						</div>
						<br /> <span class="validation-invalid-label" id="error_chk"
							style="display: none;">Please Select the Employee.</span>

						<c:if test="${editAccess == 0}">
							<div style="text-align: center;">
								<input type="submit" class="btn blue_btn" value="Assign"
									id="deleteId"
									style="align-content: center; width: 113px; margin-left: 40px;">
							</div>
							</form>
						</c:if>
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

				var table = $('#printtable1').DataTable();
				table.search("").draw();

				var isError = false;
				var errMsg = "";

				var checked = $("#submitInsertEmp input:checked").length > 0;
				if (!checked) {
					$("#error_chk").show()
					isError = true;
				} else {
					$("#error_chk").hide()
					isError = false;
				}
				//alert("checked" +checked);
				if ($("#accessId").val() == "") {

					isError = true;

					$("#error_accessId").show()

				} else {
					$("#error_accessId").hide()
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
		/* 	$(document).ready(
					function() {
						//	$('#printtable').DataTable();

						$("#selAll").click(
								function() {
									$('#printtable1 tbody input[type="checkbox"]')
											.prop('checked', this.checked);
								});
					}); */
	</script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/js/scrolltable.js"></script>

</body>
</html>
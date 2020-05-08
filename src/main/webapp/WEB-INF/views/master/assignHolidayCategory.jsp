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
										<i class="icon-list-unordered"></i> Employee Holiday Category
										Assignment
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
							action="${pageContext.request.contextPath}/submitAssignHolidayCatToEmp"
							id="submitInsertEmp" method="post">

							<div class="form-group row">
								<label
									class="col-form-label text-info font-weight-bold col-lg-3"
									for="locId"> Select Holiday Category <span
									class="text-danger">* </span>:
								</label>
								<div class="col-lg-3">
									<select name="holiCatId"
										data-placeholder="Select Holiday Category" id="holiCatId"
										class="form-control form-control-select2 select2-hidden-accessible"
										data-fouc="" aria-hidden="true">
										<option value="">Select Holiday Category</option>
										<c:forEach items="${holiList}" var="holiList">
											<option value="${holiList.hoCatId}">${holiList.hoCatName}
												[${holiList.hoCatShortName}]</option>
										</c:forEach>
									</select> <span class="validation-invalid-label" id="error_shiftId"
										style="display: none;">This field is required.</span>
								</div>
							</div>

							<div class="table-responsive">
								<!-- <table
									class="table table-bordered table-hover datatable-highlight"
									id="printtable1"> -->

									<table class="table datatable-scroll-y" width="100%"
										id="printtable1">
									<thead>
										<tr class="bg-blue">

											<th width="10%">Sr.no</th>

											<th><input type="checkbox" name="selAll" id="selAll" /></th>
											<th>Employee Code</th>
											<th>Employee Detail</th>
											<th>Location</th>
											<th>Holiday Category</th>


										</tr>
									</thead>
									<tbody>

										<c:forEach items="${empdetList}" var="empdetList"
											varStatus="count">
											<c:set var="sty_color" value="orange"></c:set>
											<c:choose>
												<c:when test="${empdetList.hoCatName eq null}">
													<c:set var="sty_color" value="orange"></c:set>
												</c:when>
												<c:otherwise>
													<c:set var="sty_color" value=""></c:set>
												</c:otherwise>
											</c:choose>
											<tr style="background: ${sty_color};">

												<td>${count.index+1}</td>
												<td><input type="checkbox"
													id="empId${empdetList.empId}" value="${empdetList.empId}"
													name="empId" class="select_all"></td>
												<td>${empdetList.empCode}&nbsp;(${empdetList.empTypeName})</td>
												<td>${empdetList.surname}&nbsp;&nbsp;${empdetList.firstName}
													(${empdetList.empDesgn} - ${empdetList.deptName})</td>
												<td>${empdetList.locName}</td>
												<td>${empdetList.hoCatName}</td>

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
	<!-- 
	<script>
		function myFunction1() {
			var input, filter, table, tr, i, txtValue, td0, td1, td2, td3, td4, td5, td6, td7, td8;
			input = document.getElementById("myInput1");
			filter = input.value.toUpperCase();
			table = document.getElementById("printtable2");
			tr = table.getElementsByTagName("tr");

			for (i = 0; i < tr.length; i++) {

				td0 = tr[i].getElementsByTagName("td")[0];
				td1 = tr[i].getElementsByTagName("td")[1];
				td2 = tr[i].getElementsByTagName("td")[2];
				td3 = tr[i].getElementsByTagName("td")[3];
				td4 = tr[i].getElementsByTagName("td")[4];
				td5 = tr[i].getElementsByTagName("td")[5];
				td6 = tr[i].getElementsByTagName("td")[6];
				td7 = tr[i].getElementsByTagName("td")[7];
				td8 = tr[i].getElementsByTagName("td")[8];

				if (td0 || td1 || td2 || td3 || td4 || td5 || td6 || td7 || td8) {

					if (td0.innerText.toUpperCase().indexOf(filter) > -1) {
						tr[i].style.display = "";
					} else if (td1.innerText.toUpperCase().indexOf(filter) > -1) {
						tr[i].style.display = "";
					} else if (td2.innerText.toUpperCase().indexOf(filter) > -1) {
						tr[i].style.display = "";
					} else if (td3.innerText.toUpperCase().indexOf(filter) > -1) {
						tr[i].style.display = "";
					} else if (td4.innerText.toUpperCase().indexOf(filter) > -1) {
						tr[i].style.display = "";
					} else if (td5.innerText.toUpperCase().indexOf(filter) > -1) {
						tr[i].style.display = "";
					} else if (td6.innerText.toUpperCase().indexOf(filter) > -1) {
						tr[i].style.display = "";
					} else if (td7.innerText.toUpperCase().indexOf(filter) > -1) {
						tr[i].style.display = "";
					} else if (td8.innerText.toUpperCase().indexOf(filter) > -1) {
						tr[i].style.display = "";
					} else {
						tr[i].style.display = "none";
					}
				}
			}
		}
	</script> -->
	<script type="text/javascript">
		$(document).ready(function($) {
			$("#submitInsertEmp").submit(function(e) {

				var table = $('#printtable1').DataTable();
				table.search("").draw();
				
				var isError = false;
				var errMsg = "";
				var holiCatId = $("#holiCatId").val();

				var checked = $("#submitInsertEmp input:checked").length > 0;
				if (!checked) {
					$("#error_chk").show()
					isError = true;
				} else {
					$("#error_chk").hide()
					isError = false;
				}
				//alert("checked" +checked);
				if (holiCatId == null || holiCatId == "") {
					isError = true;
					$("#error_shiftId").show()
				} else {
					$("#error_shiftId").hide()
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
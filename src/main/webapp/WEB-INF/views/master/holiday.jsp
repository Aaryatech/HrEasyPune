<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

				<%-- 
				<div
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
						<a href="${pageContext.request.contextPath}/showHolidayList"
							class="breadcrumb-elements-item"> Holiday List</a>

					</div>


				</div> --%>
			</div>
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">

				<!-- Form validation -->
				<div class="row">
					<div class="col-md-12">
						<!-- Title -->
						<!-- <div class="mb-3">
							<h6 class="mb-0 font-weight-semibold">Hidden labels</h6>
							<span class="text-muted d-block">Inputs with empty values</span>
						</div> -->
						<!-- /title -->


						<div class="card">

							<div class="card-header header-elements-inline">
								<table width="100%">
									<tr width="100%">
										<td width="60%"><h5 class="pageTitle">
												<i class="icon-list-unordered"></i> Add Holiday
											</h5></td>
										<td width="40%" align="right">
											<%-- 
								 <a
									href="${pageContext.request.contextPath}/holidayAdd"
									class="breadcrumb-elements-item">
										<button type="button" class="btn btn-primary">Add Holiday</button>
								</a> --%>
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

								<form action="${pageContext.request.contextPath}/holidayAdd"
									id="submitInsertHoli" method="get">

									<!-- <div class="form-group row">
										<label
											class="col-form-label text-info font-weight-bold col-lg-2"
											for="holidayTitle">Holiday Title <span
											class="text-danger">* </span>:
										</label>
										<div class="col-lg-10">
											<input type="text" class="form-control"
												placeholder="Enter Holiday Title" id="holidayTitle"
												name="holidayTitle" autocomplete="off" onchange="trim(this)"
												maxlength="100"> <span
												class="validation-invalid-label" id="error_holidayTitle"
												style="display: none;">This field is required.</span>
										</div>
									</div> -->

									<div class="form-group row">

										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="yearId">Select Calendar Year<span
												class="text-danger">* </span>:
											</label>
											<div class="col-lg-7 float">
												<select name="yearId" data-placeholder="Select " id="yearId"
													class="form-control form-control-select2 select2-hidden-accessible"
													data-fouc="" aria-hidden="true">

													<option value="0">Select</option>

													<c:forEach items="${calenderYearList}"
														var="calenderYearList">
														<c:choose>
															<c:when test="${yearId==calenderYearList.calYrId}">
																<option value="${calenderYearList.calYrId}" selected>${calenderYearList.calYrFromDate}
																	TO ${calenderYearList.calYrToDate}</option>
															</c:when>
															<c:otherwise>
																<option value="${calenderYearList.calYrId}">${calenderYearList.calYrFromDate}
																	TO ${calenderYearList.calYrToDate}</option>
															</c:otherwise>
														</c:choose>

													</c:forEach>
												</select> <span class="validation-invalid-label" id="error_yearId"
													style="display: none;">This field is required.</span>
											</div>
										</div>


										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="hoCatId">Holiday Category <span
												class="text-danger">* </span>:
											</label>
											<div class="col-lg-7 float">
												<select name="hoCatId" data-placeholder="Select "
													id="hoCatId"
													class="form-control form-control-select2 select2-hidden-accessible"
													data-fouc="" required>

													<option value="0">Select</option>

													<c:forEach items="${holidayCatList}" var="holidayCatList">

														<c:choose>
															<c:when test="${hoCatId==holidayCatList.hoCatId}">
																<option value="${holidayCatList.hoCatId}" selected>${holidayCatList.hoCatName}</option>
															</c:when>
															<c:otherwise>
																<option value="${holidayCatList.hoCatId}">${holidayCatList.hoCatName}</option>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</select> <span class="validation-invalid-label" id="error_hoCatId"
													style="display: none;">This field is required.</span>
											</div>
										</div>


									</div>

									<div class="text-center">
										<button type="submit" class="btn bg-blue ml-3 legitRipple"
											id="showbtn">Show</button>
									</div>
									<br>
								</form>
								<%-- <div class="form-group row">
										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="locId">Select Holidays <span
												class="text-danger">* </span>:
											</label>
											<div class="col-lg-7 float">
												<select name="locId" data-placeholder="Select Holidays"
													id="locId" multiple="multiple"
													class="form-control form-control-sm select"
													data-container-css-class="select-sm" data-fouc>
													<option value="">Select Holidays</option>
													<c:forEach items="${holiList}" var="holiList">
														<option value="${holiList.holidayId}">${holiList.holidayName}-${holiList.holidayDate}</option>
													</c:forEach>
												</select> <span class="validation-invalid-label"
													id="error_locationId" style="display: none;">This
													field is required.</span>
												<div class=" pt-2 text-info font-weight-bold "
													id="selected_count">Number of Holiday:</div>
											</div>

										</div>

										<div class="form-group row"></div>

									</div> --%>

								<!-- <div class="form-group row">
										<div class="col-md-6">
											<label class="col-form-label col-lg-5 float" for="remark">
												Remark : </label>
											<div class="col-lg-7 float">
												<textarea rows="3" cols="3" class="form-control"
													placeholder="Any Remark for Holiday" onchange="trim(this)"
													id="holidayRemark" name="holidayRemark">-</textarea>

											</div>
										</div>
									</div> -->
								<form
									action="${pageContext.request.contextPath}/submitInsertHoliday"
									id="fianlsubmitInsertHoli" method="post">
									<div class="table-responsive">
										<table
											class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
											id="printtable1">


											<thead>
												<tr class="bg-blue" style="text-align: center;">

													<th>Holiday Caption</th>
													<th>Date</th>
													<th>Type</th>
													<th>Remark</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${holiList}" var="holiList"
													varStatus="count">
													<tr>

														<td><input type="text" class="form-control"
															placeholder="Holiday Caption Name"
															id="capName${holiList.holidayId}"
															name="capName${holiList.holidayId}" autocomplete="off"
															onchange="trim(this)" value="${holiList.holidayName}"></td>
														<td><input type="text"
															class="form-control datepickerclass"
															placeholder="Select Date" id="date${holiList.holidayId}"
															name="date${holiList.holidayId}" autocomplete="off"
															value="${holiList.holidayDate}"></td>
														<td><select name="typeId${holiList.holidayId}"
															id="typeId${holiList.holidayId}" class="form-control">
																<option value="0" selected>NA</option>
																<option value="1">Fixed</option>
																<option value="2">Optional</option>
														</select></td>
														<td><input type="text" class="form-control  "
															placeholder="Remark"
															id="holidayRemark${holiList.holidayId}"
															name="holidayRemark${holiList.holidayId}"
															autocomplete="off" onchange="trim(this)"></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
										<c:if test="${flag==1}">
											<span class="validation-invalid-label" id="error_notallow">Already
												Holiday is define of selected year for selected category</span>
										</c:if>

									</div>
									<br>
									<div class="form-group row mb-0">
										<div style="margin: 0 auto;">
											<c:if test="${flag==0}">
												<button type="submit" class="btn bg-blue ml-3 legitRipple"
													id="submtbtn">
													Submit <i class="icon-paperplane ml-2"></i>
												</button>
											</c:if>
											<a href="${pageContext.request.contextPath}/showHolidayList"><button
													type="button" class="btn btn-light">Back</button></a>
										</div>
									</div>
								</form>
								<p class="desc text-danger fontsize11">Note : * Fields are
									mandatory.</p>
							</div>
						</div>


					</div>
				</div>

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
		function trim(el) {
			el.value = el.value.replace(/(^\s*)|(\s*$)/gi, ""). // removes leading and trailing spaces
			replace(/[ ]{2,}/gi, " "). // replaces multiple spaces with one space 
			replace(/\n +/, "\n"); // Removes spaces after newlines
			return;
		}

		function validateEmail(email) {

			var eml = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;

			if (eml.test($.trim(email)) == false) {

				return false;

			}

			return true;

		}
		function validateMobile(mobile) {
			var mob = /^[1-9]{1}[0-9]{9}$/;

			if (mob.test($.trim(mobile)) == false) {

				//alert("Please enter a valid email address .");
				return false;

			}
			return true;

		}
		$(document).on(
				'change',
				'#locId',
				function() {
					// Does some stuff and logs the event to the console
					//alert( $("#locId :selected").length);
					$("#selected_count").html(
							"Number of Holiday: "
									+ $("#locId :selected").length);
				});
		$(document)
				.ready(
						function($) {

							$("#submitInsertHoli")
									.submit(
											function(e) {
												var isError = false;
												var errMsg = "";

												$("#error_yearId").hide()
												$("#error_hoCatId").hide()
												if ($("#yearId").val() == 0) {

													isError = true;

													$("#error_yearId").show()

												}

												if (!$("#hoCatId").val()
														|| parseInt($(
																"#hoCatId")
																.val()) == 0) {

													isError = true;

													$("#error_hoCatId").show()

												}

												if (!isError) {

													document
															.getElementById("showbtn").disabled = true;
													return true;

												}
												return false;
											});
						});

		function geHolidayList() {

			var yearId = $("#yearId").val();

			if ($("#yearId").val() != 0) {

				var fd = new FormData();

				fd.append('yearId', yearId);
				$
						.ajax({
							url : '${pageContext.request.contextPath}/geHolidayListByYearId',
							type : 'post',
							dataType : 'json',
							data : fd,
							contentType : false,
							processData : false,
							success : function(response) {

								$('#printtable1 td').remove();

								$
										.each(
												response,
												function(key, trans) {

													var tr = $('<tr></tr>');

													tr
															.append($(
																	'<td   align="center"></td>')
																	.html(
																			'<input type="text" class="form-control"  placeholder="Holiday Caption Name" id="capName'
																					+ trans.holidayId
																					+ '" name="capName'
																					+ trans.holidayId
																					+ '" autocomplete="off" onchange="trim(this)" value="'
																					+ trans.holidayName
																					+ '">'));

													tr
															.append($(
																	'<td  width="20%"   align="center"></td>')
																	.html(
																			trans.holidayDate));
													tr
															.append($(
																	'<td  width="20%"  ></td>')
																	.html(
																			'<select name="typeId'+trans.holidayId+'" data-placeholder="Select " id="typeId'+trans.holidayId+'" class="form-control"  > <option value="0" selected>NA</option>'
																					+ ' <option value="1"  >Fixed</option> <option value="2"  >Optional</option> </select>'));

													tr
															.append($(
																	'<td   align="center"></td>')
																	.html(
																			'<input type="text" class="form-control  "  placeholder="Remark" id="holidayRemark'
																					+ trans.holidayId
																					+ '" name="holidayRemark'
																					+ trans.holidayId
																					+ '" autocomplete="off" onchange="trim(this)"  >'));

													$('#printtable1 tbody')
															.append(tr);

												})

							},
						});

			}

		}
		//
	</script>

	<script type="text/javascript">
		// Single picker
		$('.datepickerclass').daterangepicker({
			singleDatePicker : true,
			selectMonths : true,
			selectYears : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});

		//daterange-basic_new
		// Basic initialization
		$('.daterange-basic_new').daterangepicker({
			applyClass : 'bg-slate-600',

			cancelClass : 'btn-light',
			locale : {
				format : 'DD-MM-YYYY',
				separator : ' to '
			}
		});
	</script>

</body>
</html>
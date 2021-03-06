<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<c:url var="getShiftListByLocationIdAndSelftGroupId"
	value="/getShiftListByLocationIdAndSelftGroupId" />
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
								<h5 class="pageTitle">
									<i class="icon-list-unordered"></i> Add Shift
								</h5>
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
									action="${pageContext.request.contextPath}/submitEditShiftTiming"
									id="submitShiftTiming" method="post">
									<div class="form-group row">
										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="shrtName">Shift Short Name <span
												style="color: red"> *</span>:
											</label>
											<div class="col-lg-7 float">
												<input type="text" class="form-control"
													placeholder="Shift Short Name" id="shrtName"
													name="shrtName" autocomplete="off" onchange="trim(this)"
													value="${shiftMaster.shortName}" maxlength="10"><span
													class="validation-invalid-label" id="error_shrtName"
													style="display: none;">This field is required.</span>
											</div>
										</div>

										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold  col-lg-5 float"
												for="shiftName">Shift Name <span style="color: red">*
											</span>:
											</label>
											<div class="col-lg-7 float">
												<input type="text" class="form-control"
													placeholder="Shift Name" id="shiftName"
													value="${shiftMaster.shiftname}" name="shiftName"
													autocomplete="off" onchange="trim(this)"> <span
													class="validation-invalid-label" id="error_shiftName"
													style="display: none;">This field is required.</span>
											</div>
										</div>
									</div>


									<div class="form-group row">
										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold  col-lg-5 float"
												for="intime">In Time<span style="color: red">*
											</span>:
											</label>
											<div class="col-lg-7 float">
												<input type="time" class="form-control timehour24 "
													id="intime" name="intime" autocomplete="off"
													value="${shiftMaster.fromtime}"> <span
													class="validation-invalid-label" id="error_intime"
													style="display: none;">This field is required.</span>
											</div>
										</div>

										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold  col-lg-5 float"
												for="outtime">Out Time<span style="color: red">*
											</span>:
											</label>
											<div class="col-lg-7 float">
												<input type="time" class="form-control timehour24"
													id="outtime" name="outtime" autocomplete="off"
													value="${shiftMaster.totime}"> <span
													class="validation-invalid-label" id="error_outtime"
													style="display: none;">This field is required.</span>
											</div>
										</div>
									</div>

									<div class="form-group row">
										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold  col-lg-5 float"
												for="hfdayhour">Shift Half Day Hour<span
												style="color: red">* </span>:
											</label>
											<div class="col-lg-7 float">
												<input type="text" data-mask="99:99" class="form-control"
													id="hfdayhour" name="hfdayhour" autocomplete="off"
													value="${shiftMaster.shiftHalfdayHr}">
												<!-- <input type="time" class="form-control  " id="hfdayhour"
													name="hfdayhour" autocomplete="off"> -->
												<span class="validation-invalid-label" id="error_hfdayhour"
													style="display: none;">This field is required.</span>
											</div>
										</div>

										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float text-info font-weight-bold"
												for="othour">Shift OT Hour<span style="color: red">*
											</span>:
											</label>
											<div class="col-lg-7 float">
												<input type="text" data-mask="99:99" class="form-control"
													id="othour" name="othour" autocomplete="off"
													value="${shiftMaster.shiftOtHour}">
												<!-- <input type="time" class="form-control  " id="othour"
													name="othour" autocomplete="off"> -->
												<span class="validation-invalid-label" id="error_othour"
													style="display: none;">This field is required.</span>
											</div>
										</div>
									</div>


									<div class="form-group row">
										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold col-lg-5 float"
												for="lateMin">Late Allowed in MIN <span
												style="color: red">* </span>:
											</label>
											<div class="col-lg-7 float">
												<input type="text" class="form-control numbersOnly"
													id="lateMin" name="lateMin" autocomplete="off"
													value="${shiftMaster.maxLateTimeAllowed}"> <span
													class="validation-invalid-label" id="error_lateMin"
													style="display: none;">This field is required.</span>
											</div>
										</div>

										<div class="col-md-6">
											<label
												class="col-form-label text-info font-weight-bold  col-lg-5 float"
												for="groupId">Select Group <span style="color: red">*
											</span>:
											</label>
											<div class="col-lg-7 float">
												<select name="groupId" data-placeholder="Select Group"
													id="groupId"
													class="form-control form-control-select2 select2-hidden-accessible"
													aria-hidden="true"
													onchange="getShiftListByLocationIdAndSelftGroupId()">
													<option value="">Please Select</option>
													<c:forEach items="${selfGroupList}" var="selfGroupList">
														<c:choose>
															<c:when
																test="${selfGroupList.selftGroupId==shiftMaster.selfGroupId}">
																<option value="${selfGroupList.selftGroupId}" selected>${selfGroupList.name}</option>
															</c:when>
															<c:otherwise>
																<option value="${selfGroupList.selftGroupId}">${selfGroupList.name}</option>
															</c:otherwise>
														</c:choose>

													</c:forEach>
												</select> <span class="validation-invalid-label" id="error_groupId"
													style="display: none;">This field is required.</span>
											</div>
										</div>
									</div>

									<div class="form-group row">
										<div class="col-md-6">
											<label
												class="col-form-label  text-info font-weight-bold col-lg-5 float"
												for="ischange">Is Changeable<span style="color: red">*
											</span>:
											</label>
											<div class="col-lg-7 float">
												<c:choose>
													<c:when test="${shiftMaster.changeable==1}">
														<input type="checkbox" id="ischange" name="ischange"
															onchange="changeIsChange()" checked="checked">
													</c:when>
													<c:otherwise>
														<input type="checkbox" id="ischange" name="ischange"
															onchange="changeIsChange()">
													</c:otherwise>
												</c:choose>


											</div>

										</div>

										<div class="col-md-6">
											<label
												class="col-form-label   text-info font-weight-bold col-lg-5 float"
												for="isNightShiftNo">Is Night Shift<span
												style="color: red">* </span>:
											</label>
											<div class="col-lg-7 float">
												<c:choose>
													<c:when test="${shiftMaster.departmentId==1}">
														<input type="radio" id="isNightShiftNo"
															name="isNightShift" value="0">No <input
															type="radio" id="isNightShiftYes" name="isNightShift"
															value="1" checked>Yes</c:when>
													<c:otherwise>
														<input type="radio" id="isNightShiftNo"
															name="isNightShift" checked value="0">No <input
															type="radio" id="isNightShiftYes" name="isNightShift"
															value="1">Yes</c:otherwise>
												</c:choose>


											</div>

										</div>

									</div>
									<div id="changeHideShow" style="display: none;">
										<div class="form-group row">
											<div class="col-md-6">
												<label class="col-form-label col-lg-5 float"
													for="changeWith">Change With : </label>
												<div class="col-lg-7 float">
													<select name="changeWith" data-placeholder="Change With"
														id="changeWith"
														class="form-control form-control-select2 select2-hidden-accessible"
														aria-hidden="true">


													</select>
												</div>
											</div>
										</div>
									</div>


									<div class="form-group row mb-0">
										<div style="margin: 0 auto;">

											<button type="submit" class="btn bg-blue ml-3 legitRipple"
												id="submtbtn">
												Submit <i class="icon-paperplane ml-2"></i>
											</button>
											<a href="${pageContext.request.contextPath}/getshiftList"><button
													type="button" class="btn btn-light">Back</button></a>
										</div>
									</div>
									<input type="hidden" id="shiftId" name="shiftId"
										value="${shiftMaster.id}"> <input type="hidden"
										id="changewithshift" name="changewithshift" autocomplete="off"
										value="${shiftMaster.changewith}">
								</form>
								<p class="desc text-danger fontsize11">MIN : (in Minutes)</p>
								<p class="desc text-danger fontsize11">Is Changeable - Note
									: Post cyclic shift allotment, existing shift change with
									selected shift.</p>
								<p class="desc text-danger fontsize11">Is Night Shift - Note
									: In case of Night Shift - Night Shift allowance will be
									applicable to employees working in this shift</p>
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
		// Time picker
		$('.timehour24').AnyTime_picker({
			format : '%H:%i'
		});
		function changeIsChange() {

			if (document.getElementById("ischange").checked == true) {
				$("#changeHideShow").show();
				document.getElementById("ischange").value = 1;
			} else {
				$("#changeHideShow").hide();
				document.getElementById("ischange").value = 0;
			}
		}
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
		$(document)
				.ready(
						function($) {

							$("#submitShiftTiming")
									.submit(
											function(e) {
												var isError = false;
												var errMsg = "";
												//$("#error_locId").hide();
												$("#error_shiftName").hide();
												$("#error_intime").hide();
												$("#error_outtime").hide();
												$("#error_hfdayhour").hide();
												$("#error_othour").hide();
												$("#error_lateMin").hide();
												$("#error_groupId").hide();
												$("#error_shrtName").hide();

												/* if (!$("#locId").val()) {

													isError = true;
													$("#error_locId").show()
												} */

												if (!$("#shrtName").val()) {

													isError = true;
													$("#error_shrtName").show()
												}

												if (!$("#shiftName").val()) {

													isError = true;
													$("#error_shiftName")
															.show()
												}

												if (!$("#intime").val()) {

													isError = true;
													$("#error_intime").show()

												}

												if (!$("#outtime").val()) {

													isError = true;
													$("#error_outtime").show()

												}

												if (!$("#hfdayhour").val()
														|| $("#hfdayhour")
																.val() == "__:__") {

													isError = true;
													$("#error_hfdayhour")
															.show()
												}

												if (!$("#othour").val()
														|| $("#othour").val() == "__:__") {

													isError = true;
													$("#error_othour").show()

												}

												if (!$("#lateMin").val()) {

													isError = true;
													$("#error_lateMin").show()

												}

												if (!$("#groupId").val()) {

													isError = true;
													$("#error_groupId").show()

												}
												if (!isError) {

													document
															.getElementById("submtbtn").disabled = true;
													return true;

												}
												return false;
											});
						});
		//
	</script>

	<script type="text/javascript">
		function getShiftListByLocationIdAndSelftGroupId() {

			var changewithshift = $("#changewithshift").val()
			var shiftId = $("#shiftId").val()
			var groupId = $("#groupId").val()

			$
					.getJSON(
							'${getShiftListByLocationIdAndSelftGroupId}',
							{
								groupId : groupId,
								ajax : 'true',
							},

							function(data) {
								var html;

								html += '<option  value="" > Change With</option>';

								var temp = 0;

								var len = data.length;
								for (var i = 0; i < len; i++) {

									if (shiftId != data[i].id) {

										if (changewithshift == data[i].id) {
											html += '<option   value="' + data[i].id + '" selected>'
													+ data[i].shiftname
													+ '</option>';
										} else {
											html += '<option   value="' + data[i].id + '">'
													+ data[i].shiftname
													+ '</option>';
										}
									}
								}

								$('#changeWith').html(html);
								$("#changeWith").trigger("chosen:updated");

							});

		}
	</script>

</body>
</html>
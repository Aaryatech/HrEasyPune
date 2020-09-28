<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>
<!-- <link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css"> -->
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

					<div id="editBonusDiv" style="display: none;">
						<div class="card-header header-elements-inline">
							<h5 class="card-title">Edit Attendance Detail</h5>
						</div>
						<div class="card-body">

							<div class="form-group row">
								<label class="col-form-label col-lg-2" for="empName">
									EMP Name : </label>
								<div class="col-lg-2">
									<input type="text" class="form-control" placeholder="EMP Name"
										id="empName" name="empName" autocomplete="off" disabled>

								</div>

							</div>

							<div class="form-group row">
								<label class="col-form-label col-lg-2" for="empCode">
									EMP Code : </label>
								<div class="col-lg-2">
									<input type="text" class="form-control" placeholder="EMP Code"
										id="empCode" name="empCode" autocomplete="off" disabled>

								</div>

							</div>

							<div class="form-group row">
								<label class="col-form-label col-lg-2" for="itAmt">TDS
									AMT: </label>
								<div class="col-lg-2">
									<input type="text" class="form-control numbersOnly"
										placeholder="IT Ammount" id="itAmt" name="itAmt"
										autocomplete="off">
									<!-- <input type="hidden"
										class="form-control numbersOnly" placeholder="Status"
										id="perBonus" name="perBonus" autocomplete="off"> -->

								</div>
								<div class="col-lg-1"></div>
								<label class="col-form-label col-lg-2" for="perBonus">
									Performance Bonus AMT: </label>
								<div class="col-lg-2">
									<input type="text" class="form-control numbersOnly"
										placeholder="Status" id="perBonus" name="perBonus"
										autocomplete="off">

								</div>
							</div>

							<!-- <div class="form-group row">
								<label class="col-form-label col-lg-2" for="comnt">
									Comments : </label>
								<div class="col-lg-2">
									<input type="text" class="form-control" placeholder="Comments"
										id="comnt" name="comnt" autocomplete="off">

								</div>
							</div> -->

							<div class="col-md-12 text-center">
								<button type="submit" class="btn bg-blue ml-3 legitRipple"
									id="submtbtn" onclick="saveBonusDetail()">Save</button>
								<button type="button" class="btn btn-primary"
									onclick="closeEditDetailTab()">Cancel</button>
								<input type="hidden" class="form-control" id="tempSalDaynamicId"
									name="tempSalDaynamicId" autocomplete="off">
							</div>


						</div>
						<hr>
					</div>
					<div class="card-header header-elements-inline">
						<h5 class="pageTitle">
							<i class="icon-list-unordered"></i>Enter Dynamic Amount ${date}
						</h5>

					</div>

					<div class="card-body">

						<form action="${pageContext.request.contextPath}/generatePayRoll"
							id="submitInsertLeave" method="post">

							<input type="hidden" name="searchDate" id="searchDate"
								value="${date}" /> <input type="hidden" name="empIds"
								id="empIds" value="${empIds}" />
							<div id="loader" style="display: none;">
								<img
									src="${pageContext.request.contextPath}/resources/assets/images/giphy.gif"
									width="150px" height="150px"
									style="display: block; margin-left: auto; margin-right: auto">
							</div>

							<div class="table-responsive">
								<table
									class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
									width="100%" id="printtable1">

									<c:set value="0" var="payroll_claim_show"></c:set>
									<c:set value="0" var="payroll_advance_show"></c:set>
									<c:set value="0" var="payroll_loan_show"></c:set>
									<c:set value="0" var="payroll_payded_show"></c:set>
									<c:set value="0" var="payroll_reward_show"></c:set>
									<%-- <c:set value="0" var="payroll_tds_show"></c:set>
									<c:set value="0" var="payroll_performancebonus_show"></c:set> --%>

									<c:forEach items="${settingList}" var="settingList">

										<c:choose>
											<c:when
												test="${settingList.key eq 'payroll_claim_show' and settingList.value==1}">
												<c:set value="1" var="payroll_claim_show"></c:set>
											</c:when>
											<c:when
												test="${settingList.key eq 'payroll_advance_show' and settingList.value==1}">
												<c:set value="1" var="payroll_advance_show"></c:set>
											</c:when>
											<c:when
												test="${settingList.key eq 'payroll_loan_show' and settingList.value==1}">
												<c:set value="1" var="payroll_loan_show"></c:set>
											</c:when>
											<c:when
												test="${settingList.key eq 'payroll_payded_show' and settingList.value==1}">
												<c:set value="1" var="payroll_payded_show"></c:set>
											</c:when>
											<c:when
												test="${settingList.key eq 'payroll_reward_show' and settingList.value==1}">
												<c:set value="1" var="payroll_reward_show"></c:set>
											</c:when>
										</c:choose>

									</c:forEach>
									<thead>
										<tr class="bg-blue">
											<!-- <th width="5%" class="text-center">Sr.no</th>
											<th class="text-center">EMP Code</th> -->
											<th width="20%" class="text-center">EMP Name</th>
											<th class="text-center">Salary STR.</th>
											<th class="text-center">Designation</th>
											<c:if test="${payroll_claim_show==1}">
												<th class="text-center">Misc/Claim Add</th>
											</c:if>
											<c:if test="${payroll_advance_show==1}">
												<th class="text-center">Advance</th>
											</c:if>
											<c:if test="${payroll_loan_show==1}">
												<th class="text-center">Loan EMI</th>
											</c:if>
											<c:if test="${payroll_payded_show==1}">
												<th class="text-center">Pay Ded</th>
											</c:if>
											<th class="text-center">TDS</th>
											<th class="text-center">Performance Bonus</th>
											<th class="text-center">Other1</th>
											<c:if test="${payroll_reward_show==1}">
												<th class="text-center">Reward</th>
											</c:if>
											<!-- <th class="text-center">Edit</th> -->
										</tr>

									</thead>

									<tbody>
										<c:forEach items="${empList}" var="empList" varStatus="count">
											<tr>
												<%-- <td>${count.index+1}</td>
												<td></td> --%>
												<td>${empList.empName}&nbsp;${empList.empCode}</td>
												<td>${empList.salTypeName}</td>
												<td>${empList.designation}</td>
												<c:if test="${payroll_claim_show==1}">
													<td class="text-right">${empList.miscExpAdd}</td>
												</c:if>
												<c:if test="${payroll_advance_show==1}">
													<td class="text-right">${empList.advanceDed}</td>
												</c:if>
												<c:if test="${payroll_loan_show==1}">
													<td class="text-right">${empList.loanDed}</td>
												</c:if>
												<c:if test="${payroll_payded_show==1}">
													<td class="text-right">${empList.payDed}</td>
												</c:if>
												<td class="text-right"><input type="text"
													class="form-control numbersOnly" value="${empList.itded}"
													placeholder="TDS AMT" id="itAmt${empList.id}"
													name="itAmt${empList.id}" autocomplete="off"
													data-itamt="${empList.itded}" style="text-align: right;"
													onchange="saveBonusDetail(${empList.id})"></td>
												<td class="text-right"><input type="text"
													class="form-control numbersOnly"
													value="${empList.performanceBonus}"
													placeholder="Performance Bonus" id="perBonus${empList.id}"
													name="perBonus${empList.id}" autocomplete="off"
													data-performancebonus="${empList.performanceBonus}"
													style="text-align: right;"
													onchange="saveBonusDetail(${empList.id})"></td>
												<td class="text-right"><input type="text"
													class="form-control numbersOnly" value="${empList.other1}"
													placeholder="Other Amt" id="other1${empList.id}"
													name="other1${empList.id}" autocomplete="off"
													data-other1="${empList.other1}" style="text-align: right;"
													onchange="saveBonusDetail(${empList.id})"></td>
												<c:if test="${payroll_reward_show==1}">
													<td class="text-right">${empList.reward}</td>
												</c:if>
												<%-- <td class="text-center"><a href="#"
													onclick="editBonus(${empList.id})"
													data-original-title="Edit" title="Edit"><i
														class="icon-pencil7"></i></a></td> --%>
											</tr>
										</c:forEach>

									</tbody>
								</table>
							</div>
							<br>
							<div class="text-center">

								<button type="submit" class="btn bg-blue ml-3 legitRipple"
									id="submtbtn">
									Process Pay Roll <i class="icon-paperplane ml-2"></i>
								</button>

							</div>

						</form>
					</div>

				</div>
				<!-- /highlighting rows and columns -->

			</div>
			<!-- /content area -->

			<!-- Info modal -->
			<div id="modal_step1" class="modal fade " data-backdrop="false"
				tabindex="-1">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header bg-info">
							<h6 class="modal-title">Updating Record...</h6>
							<!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
						</div>

						<div class="modal-body">
							<h6 class="font-weight-semibold text-center">
								<h6>Please wait.....</h6>
							</h6>

							<hr>
							<p class="text-center text-info">If it is taking time please
								reload the page</p>
						</div>

						<div class="modal-footer">
							<!--   <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button> -->

						</div>
					</div>
				</div>
			</div>

			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
			<!-- /footer -->

		</div>
		<!-- /main content -->

	</div>
	<!-- /page content -->
	<script type="text/javascript">
		// Single picker
		$(function() {
			$("#datepicker").datepicker({
				changeMonth : true,
				changeYear : true,
				yearRange : "-50:+50",
				dateFormat : "mm-yy"
			});
		});
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

	<script type="text/javascript">
		function editBonus(tempSalDaynamicId) {

			var fd = new FormData();
			fd.append('tempSalDaynamicId', tempSalDaynamicId);

			$
					.ajax({
						url : '${pageContext.request.contextPath}/editBonus',
						type : 'post',
						dataType : 'json',
						data : fd,
						contentType : false,
						processData : false,
						success : function(response) {

							document.getElementById("editBonusDiv").style.display = 'block';
							document.getElementById("tempSalDaynamicId").value = response.id;
							document.getElementById("empName").value = response.empName;
							document.getElementById("empCode").value = response.empCode;
							document.getElementById("itAmt").value = response.itded;
							document.getElementById("perBonus").value = response.performanceBonus;
						},
					});

		}
		function closeEditDetailTab() {

			document.getElementById("editBonusDiv").style.display = 'none';
		}
		function saveBonusDetail(tempSalDaynamicId) {

			 
			var itAmt = document.getElementById("itAmt"+tempSalDaynamicId).value;
			var perBonus = document.getElementById("perBonus"+tempSalDaynamicId).value;
			var other1 = document.getElementById("other1"+tempSalDaynamicId).value;
			
			var itAmtDefault = $("#itAmt"+tempSalDaynamicId).data("itamt")
			var perBonusDefault = $("#perBonus"+tempSalDaynamicId).data("performancebonus")
			var other1Default = $("#other1"+tempSalDaynamicId).data("other1")
			 
			if (itAmt == "") {
				 
				document.getElementById("itAmt"+tempSalDaynamicId).value=0;
				itAmt=0;
			}  
			if (perBonus == "") {
			 
				document.getElementById("perBonus"+tempSalDaynamicId).value=0;
				perBonus=0;
			}
			if (other1 == "") {
			 
				document.getElementById("other1"+tempSalDaynamicId).value=0;
				other1=0;
			}

			 

				//$('#modal_step1').modal('show');
				var fd = new FormData();
				fd.append('tempSalDaynamicId', tempSalDaynamicId);
				fd.append('itAmt', itAmt);
				fd.append('perBonus', perBonus);
				fd.append('other1', other1);
				$.ajax({
					url : '${pageContext.request.contextPath}/saveBonusDetail',
					type : 'post',
					dataType : 'json',
					data : fd,
					contentType : false,
					processData : false,
					success : function(response) {

						//location.reload(true);
					},
				});
			 
		}
		/* function saveBonusDetail() {
			  
			var tempSalDaynamicId = document.getElementById("tempSalDaynamicId").value;  
			var itAmt = document.getElementById("itAmt").value;  
			var perBonus = document.getElementById("perBonus").value; 
			var flag=0;
			if(itAmt==""){
				alert("Enter IT Ammount");
				flag=1;
			}else if(perBonus==""){
				alert("Enter Bonus Ammount");
				flag=1;
			}
			
			if(flag==0){
				
				$('#modal_step1').modal('show');
				var fd = new FormData();
				fd.append('tempSalDaynamicId', tempSalDaynamicId);
				fd.append('itAmt', itAmt);
				fd.append('perBonus', perBonus); 
				
				  $
				.ajax({
					url : '${pageContext.request.contextPath}/saveBonusDetail',
					type : 'post',
					dataType : 'json',
					data : fd,
					contentType : false,
					processData : false,
					success : function(response) {

						location.reload(true);
					},
				}); 
			}
			} */
	</script>
	<script type="text/javascript">
		$('.datatable-fixed-left_custom').DataTable({

			columnDefs : [ {
				orderable : false,
				targets : [ 0 ]
			} ],
			"order" : [],
			//scrollX : true,
			scrollX : true,
			scrollY : '65vh',
			scrollCollapse : true,
			paging : false,
			fixedColumns : {
				leftColumns : 1,
				rightColumns : 0
			}

		});
	</script>
</body>
</html>
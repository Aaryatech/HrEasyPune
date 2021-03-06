<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>

<!-- <style type="text/css">
.daterangepicker{width: 100%;}
.daterangepicker.show-calendar .calendar{display: inline--block;}
.daterangepicker .calendar, .daterangepicker .ranges{float: right;}
</style> -->

<body>
<c:url var="getAssetAMCInfo" value="/getAssetAMCInfo"></c:url>
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
								<td width="60%"><h5 class="pageTitle"><i class="icon-list-unordered"></i> Assign 
								Assets </h5></td>
								<%-- <td width="40%" align="right"><c:if test="${addAccess==0}">
										<a href="${pageContext.request.contextPath}/addAsset"
											class="breadcrumb-elements-item">
											<button type="button" class="btn blue_btn legitRipple">Add
												Asset</button>
										</a>
									</c:if></td> --%>
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
						
								<div class="form-group row">									
										<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="empName">Employee
													Name <span class="text-danger"></span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"  readonly="readonly" 
													value="${emp.empCode}-${emp.firstName} ${emp.middleName} ${emp.surname}">
													
												</div>
											</div>
											
											<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="empDept">Department
												 <span class="text-danger"></span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control"  readonly="readonly" 
												value="${emp.departName}">
												
											</div>
										</div>											
									</div>	
									
									<div class="form-group row">									
										<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCode">Designation
													Type <span class="text-danger"></span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"  readonly="readonly" 
													value="${emp.desingnation}">
													<span class="validation-invalid-label" id="error_assetCode"
														style="display: none;">This field is required.</span>
												</div>
											</div>
											
											<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetName">Location
												<span class="text-danger"></span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control"  readonly="readonly" 
												 value="${emp.location}">
												<span class="validation-invalid-label" id="error_assetName"
													style="display: none;">This field is required.</span>
											</div>
										</div>											
									</div>										
					
						<form
									action="${pageContext.request.contextPath}/submitAssignAsset"
									id="submitAssignAsset" method="post" enctype="multipart/form-data">
									
									<input type="hidden" id="empId" name="empId" value="${emp.empId}">
						<div class="table-responsive">						
								<table class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
							 id="printtable1" style="font-size: 13px;">
							<thead>
								<tr class="bg-blue">

									<th class="text-center" width="2%">Sr. No.</th>
									<th class="text-center" width="2%"><input type="checkbox" name="selAll" id="selAll" /></th>									
									<th class="text-center">Asset Name</th>
									<th class="text-center">Category</th>
									<th class="text-center" colspan="2" width="20%">Period</th>
									<th class="text-center" width="10%">Asset Img</th>	
									<th class="text-center">Remark</th>	
								</tr>
							</thead>
							<tbody>
							
								<c:forEach items="${assetsList}" var="assetsList"
									varStatus="count">
									<tr>
										<td>${count.index+1}
											<input type="hidden" id="transIds" name="transIds${assetsList.assetId}">
										</td>
									
									<td>
										<input type="hidden" class="select_all" id="assetIds${assetsList.assetId}" name="assetIds${assetsList.assetId}"
										value="${assetsList.assetId}">
										<input type="checkbox" class="select_all" id="chkAssetId${assetsList.assetId}" name="chkAssetId"
										value="${assetsList.assetId}" ${assetsList.assetId>0 ? 'checked' : ''}>
									</td>									
									
									<td>
										<a href="${pageContext.request.contextPath}/" data-toggle="modal" data-target="#modal_large"
										onclick="getAssetInfo(${assetsList.assetId})"
										class="list-icons-item text-primary-600" data-popup="tooltip"  data-original-title="Asset Details">
										${assetsList.assetCode}-${assetsList.assetName}</a>
									</td>
									
									<td>${assetsList.catName}</td>
									
									<td style="font-size: 8px;">
										<input type="text" class="form-control datepickerclass" placeholder="Enter Period" 
										name="fromDate${assetsList.assetId}" id="fromDate${assetsList.assetId}"
										autocomplete="off">
									</td>
									
									<td style="font-size: 8px;">
										<input type="text" class="form-control datepickerclass" placeholder="Enter Period"
										name="toDate${assetsList.assetId}" id="toDate${assetsList.assetId}" autocomplete="off">
									</td>
									
									<td>
										<img id="output" width="150"/>
												<input type="file" accept="image/*" name="doc" id="doc${assetsList.assetId}" 
												accept=".jpg,.png,.gif,.doc,.xls,.pdf" onchange="loadFile(event)"><span
													class="form-text text-muted">Only
													.jpg,.png,.gif,.doc,.xls,.pdf</span>
												<span class="validation-invalid-label" id="error_doc"
													style="display: none;">This field is required.</span>												
									</td>	
											
									<td><input type="text" class="form-control" placeholder="Any Remark" 
										autocomplete="off" onchange="trim(this)" name="remark${assetsList.assetId}" id="remark${assetsList.assetId}"></td>									
									
								</tr>
								</c:forEach>																
							</tbody>							
						</table>
					
						</div>
						<div class="form-group row mb-0">
									<div  style="margin: 0 auto;"><!--  class="col-lg-10 ml-lg-auto" -->
										
											<button type="submit" class="btn blue_btn"
												id="submtbtn">
												Submit <i class="icon-paperplane ml-2"></i>
											</button>
											<a href="${pageContext.request.contextPath}/manageAssets"><button id="cnclbtn"
										type="button" class="btn btn-light"><i class="${sessionScope.cancelIcon}" aria-hidden="true"></i>&nbsp;&nbsp; Back</button></a>
										</div>
									</div>
								</form>
										<span
										class="validation-invalid-label" id="error_chk"
										style="display: none;">Please Select one or more Asset.</span>

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
	<script>
		function submitForm() {
			$('#modal_scrollable').modal('hide');
			document.getElementById("submitAssignAsset").submit();

		}
		
		$(document).ready(function($) {
			$("#submitAssignAsset").submit(function(e) {

				var isError = false;
				var errMsg = "";

				var checked = $("#submitAssignAsset input:checked").length > 0;
				if (!checked) {
					$("#error_chk").show()
					isError = true;
				} else {
					$("#error_chk").hide()
					isError = false;
				}

				if (!isError) {
					 
					$('#modal_scrollable')
					.modal('show');

						return false;
 				}
				return false;
			});
		});
	</script>
		<div id="modal_scrollable" class="modal fade" data-backdrop="false"
		tabindex="-1">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header pb-3">

					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<div class="modal-body py-0">
					<h5 class="modal-title">Are You Sure You Want To Assign This Asset</h5>
					<br>
				 
				</div>

				<div class="modal-footer pt-3">
					<button type="button" class="btn btn-link" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn bg-primary" onclick="submitForm()">Submit</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Large modal -->
				<div id="modal_large" class="modal fade" tabindex="-1">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-header">
								<!-- <h5 class="modal-title">Assets Details</h5> -->
								<h5 class="pageTitle"><i class="icon-list-unordered"></i>Assets Details</h5>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>

							<div class="modal-body">
							<div class="form-group row">									
										<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCode">Asset
													Name <span class="text-danger"></span>:</label>
												<div class="col-lg-7  float">
													<span id="assetName"></span>
												</div>
											</div>
											
											<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetName">Purchase
												Vendor <span class="text-danger"></span>:</label>
												<div class="col-lg-7 float">
												<span id="purchaseVendor"></span>
											</div>
										</div>											
									</div>	
									
									<div class="form-group row">									
										<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCode">Category
													<span class="text-danger"></span>:</label>
												<div class="col-lg-7  float">
													<span id="category"></span>
												</div>
											</div>
											
											<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCode">Asset
													Purchase Date<span class="text-danger"></span>:</label>
												<div class="col-lg-7  float">
													<span id="purchaseDate"></span>
												</div>
											</div>						
									</div>	
									<div class="form-group row">									
										<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCode">Model
													<span class="text-danger"></span>:</label>
												<div class="col-lg-7  float">
													<span id="modelNo"></span>
												</div>
											</div>
											
											<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetName">Serial
												No. <span class="text-danger"></span>:</label>
												<div class="col-lg-7 float">
												<span id="serialNo"></span>
											</div>
										</div>											
									</div>	
							<table
							class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
							id="modal_printtable1">
							<thead>
								<tr class="bg-blue">

									<th class="text-center" width="10%">Sr. No.</th>
									<th class="text-center">AMC Vendor Name</th>
									<th class="text-center">AMC Period</th>
									<th class="text-center">AMC Status</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
							
						</table>
							</div>

							<div class="modal-footer">
								<button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
								<!-- <button type="button" class="btn bg-primary">Save changes</button> -->
							</div>
						</div>
					</div>
				</div>
				<!-- /large modal -->
<script>
function getAssetInfo(assetId){  
	document.getElementById("assetName").innerHTML = ''; 								
	document.getElementById("purchaseVendor").innerHTML = '';
	document.getElementById("category").innerHTML = ''; 
	document.getElementById("purchaseDate").innerHTML = '';
	document.getElementById("modelNo").innerHTML = '';
	document.getElementById("serialNo").innerHTML = '';
	
	//alert(assetId)
	
	var status = null;
			 $
					.getJSON(
							'${getAssetAMCInfo}',
							{
								assetId : assetId,
								ajax : 'true',

							},
							function(data) {
								
								document.getElementById("assetName").innerHTML = data.assetDetails.assetCode+' - '+data.assetDetails.assetName; 								
								document.getElementById("purchaseVendor").innerHTML = data.assetDetails.vendor; 
								document.getElementById("category").innerHTML = data.assetDetails.catName; 
								document.getElementById("purchaseDate").innerHTML = data.assetDetails.assetPurDate;
								document.getElementById("modelNo").innerHTML = data.assetDetails.assetModel;
								document.getElementById("serialNo").innerHTML = data.assetDetails.assetSrno;
								
								//alert("Data  " +JSON.stringify(data.empInfo.empCode));

								var dataTable = $('#modal_printtable1').DataTable();
								dataTable.clear().draw();
								
								$
										.each(
												data.assetAMCList,
												function(i, v) {

													if(v.amcStatus==11){
														status='Live';
													}else if(v.amcStatus==10){
														status='Pending';
													}else if(v.amcStatus==12){
														status='Renewed';
													}else if(v.amcStatus==13){
														status='Renewed';
													}else{
														status='NA';
													}
													dataTable.row
															.add(
																	[
																			i + 1,
																			v.compName,
																			v.amcFrDate+' to '+v.amcToDate,											
																			status

																	]).draw();
												}); 
								
							 }); 
	}
</script>
				
<script type="text/javascript">
//show uploaded img
var loadFile1 = function(event) {
	var image1 = document.getElementById('output1');
	image1.src = URL.createObjectURL(event.target.files[0]);
	
	
};

var loadFile2 = function(event) {
	var image2 = document.getElementById('output2');
	image2.src = URL.createObjectURL(event.target.files[0]);
};

var loadFile3 = function(event) {
	var image3 = document.getElementById('output3');
	image3.src = URL.createObjectURL(event.target.files[0]);
};

var loadFile4 = function(event) {
	var image4 = document.getElementById('output4');
	image4.src = URL.createObjectURL(event.target.files[0]);
};

var loadFile5 = function(event) {
	var image5 = document.getElementById('output5');
	image5.src = URL.createObjectURL(event.target.files[0]);
};
</script>
	
<script>
//Inner table scroll
/* $('#printtable1').DataTable( {
    scrollResize: true,
    scrollY: 500,
    scrollCollapse: true,
    paging: false
} ); */

		// Custom bootbox dialog
		$('.bootbox_custom')
				.on(
						'click',
						function() {
							var uuid = $(this).data("uuid") // will return the number 123
										bootbox.confirm({
										title : 'Confirm ',
										message : 'Are you sure you want to delete selected records ?',
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
										callback : function(result) {
											if (result) {
												location.href = "${pageContext.request.contextPath}/deleteAsset?assetId="
														+ uuid;

											}
										}
									});
						});
		
		$('.daterange-basic_new').daterangepicker({
			applyClass : 'bg-slate-600',
			drops:'auto',
			open:'center',
			cancelClass : 'btn-light',
			locale : {
				format : 'DD-MM-YYYY',
				separator : ' to '
			}
		});
		
		$('.datepickerclass').daterangepicker({
			singleDatePicker : true,
			selectMonths : true,
			selectYears : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});
		
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
	<script type="text/javascript">
	$("#assetCat").change(function(){  
	    var cat = $("#assetCat").val();
	    alert(cat)
	    

				$
						.getJSON(
								'${getAssetCategoryInfo}',
								{
									cat : cat,
									ajax : 'true',

								},
								function(data) {
									//alert("data" + data);

									alert("Data  " +JSON.stringify(data));
									if (data.facultyId > 0) {
										
									} else {} 

								});
		});
	
	</script>
</body>
</html>
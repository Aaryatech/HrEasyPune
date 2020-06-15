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
								<td width="60%"><h5 class="pageTitle"><i class="icon-list-unordered"></i> Return 
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
						
						
						<form
									action="${pageContext.request.contextPath}/submitReturnAsset"
									id="submitReturnAsset" method="post">	
									
							<div class="form-group row">									
										<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="empName">Employee
													Name <span class="text-danger"></span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"  readonly="readonly" 
													autocomplete="off" onchange="trim(this)" value="${emp.empCode}-${emp.firstName} ${emp.middleName} ${emp.surname}">
													<span class="validation-invalid-label" id="error_assetCode"
														style="display: none;">This field is required.</span>
												</div>
											</div>
											
											<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCode">Designation
													<span class="text-danger"></span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"  readonly="readonly" 
													value="${emp.designation}">
												</div>
											</div>									
									</div>							
					
						<div class="table-responsive">
								<table class="table datatable-scroll-y" id="printtable1">
							<thead>
								<tr class="bg-blue">

									<th class="text-center" width="5%">Sr. No.</th>
									<th class="text-center"><input type="checkbox" name="selAll" id="selAll" /></th>
									<th class="text-center">Asset Name</th>
									<th class="text-center">Category</th>
									<th class="text-center">Assigned Period</th>
									<th class="text-center">Remark</th>	
									<th class="text-center">Return Asset Img</th>	
									<th class="text-center">Return Remark</th>	
								</tr>
							</thead>							
							<tbody>
									<c:forEach items="${assignAssetsList}" var="assetsList"
									varStatus="count">
									<tr>
										<td>${count.index+1}
											<input type="hidden" id="transIds${assetsList.assetId}" name="transIds${assetsList.assetId}" value="${assetsList.assetTransId}">
										</td>
									
										<td>
											<input type="hidden" class="select_all" id="assetIds${assetsList.assetId}" name="assetIds${assetsList.assetId}"
											value="${assetsList.assetId}">
											<input type="checkbox" class="select_all" id="chkAssetId${assetsList.assetId}" name="chkAssetId"
											value="${assetsList.assetId}">
										</td>								
									
										<td>
											<a href="${pageContext.request.contextPath}/" data-toggle="modal" data-target="#modal_large"
											class="list-icons-item text-primary-600" data-popup="tooltip"  data-original-title="Asset Details">
											${assetsList.assetCode}-${assetsList.assetName}</a>
										</td>
										<td>${assetsList.catName}</td>
										<td>${assetsList.useFromDate} to ${assetsList.useToDate}</td>
										<td>${assetsList.assignRemark}</td>
										<td>
										<img id="output" width="150"/>
												<input type="file" accept="image/*" name="doc${assetsList.assetId}" id="doc${assetsList.assetId}" 
												accept=".jpg,.png,.gif,.doc,.xls,.pdf" onchange="loadFile(event)"><span
													class="form-text text-muted">Only
													.jpg,.png,.gif,.doc,.xls,.pdf</span>
												<span class="validation-invalid-label" id="error_doc"
													style="display: none;">This field is required.</span>
												</div>
									</td>			
									<td><input type="text" class="form-control" placeholder="Any Remark" 
										autocomplete="off" onchange="trim(this)" name="returRemark${assetsList.assetId}" id="returRemark${assetsList.assetId}"></td>									
									
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
			document.getElementById("submitReturnAsset").submit();

		}
		
		$(document).ready(function($) {
			$("#submitReturnAsset").submit(function(e) {

				var isError = false;
				var errMsg = "";

				var checked = $("#submitReturnAsset input:checked").length > 0;
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
					<h5 class="modal-title">Are You Sure You Want To Return This Asset</h5>
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
								<!-- <h5 class="modal-title">Asset Assign History</h5> -->
								<h5 class="pageTitle"><i class="icon-list-unordered"></i>Asset Assign History</h5>
								
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>

							<div class="modal-body">
							<div class="form-group row">									
								<div class="col-md-4">
									<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCode">Assign Image
															Name <span class="text-danger"></span>:</label>
									<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTKI7IY-cNuEyZmw-eC4fjyoxaW8oauU5gbVlp13Bi--fVYOCbb3mACK1PZso0&usqp=CAc">
								</div>
								
								<div class="col-md-4">
									<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCode">Purchase Image
															Name <span class="text-danger"></span>:</label>
									<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTKI7IY-cNuEyZmw-eC4fjyoxaW8oauU5gbVlp13Bi--fVYOCbb3mACK1PZso0&usqp=CAc">
								</div>
								
								<div class="col-md-4">
									<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCode">Remark
									<span class="text-danger"></span>:</label>
									<input type="text" class="form-control"  readonly="readonly" 
									value="Battery Problem" style="width: 50%;">
								</div>
							</div>
							
							<div class="form-group row">									
										<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCode">Asset
													Name <span class="text-danger"></span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"  readonly="readonly" 
													autocomplete="off" onchange="trim(this)" value="ASST001-Laptop">
													<span class="validation-invalid-label" id="error_assetCode"
														style="display: none;">This field is required.</span>
												</div>
											</div>
											
											<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetName">Purchase
												Vendor <span class="text-danger"></span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control"  readonly="readonly" 
												autocomplete="off" onchange="trim(this)" value="Dells Gallery">
												<span class="validation-invalid-label" id="error_assetName"
													style="display: none;">This field is required.</span>
											</div>
										</div>											
									</div>	
									
									<div class="form-group row">									
										<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCode">Category
													<span class="text-danger"></span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"  readonly="readonly" 
													autocomplete="off" onchange="trim(this)" value="Computer">
													<span class="validation-invalid-label" id="error_assetCode"
														style="display: none;">This field is required.</span>
												</div>
											</div>
											
											<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCode">Asset
													Purchase Date<span class="text-danger"></span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"  readonly="readonly" 
													autocomplete="off" onchange="trim(this)" value="10-04-2020">
													<span class="validation-invalid-label" id="error_assetCode"
														style="display: none;">This field is required.</span>
												</div>
											</div>						
									</div>		
							<table
							class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
							id="modal_printtable1">
							<thead>
								<tr class="bg-blue">

									<th class="text-center" width="10%">Sr. No.</th>
									<th class="text-center">Emp Name</th>
									<th class="text-center">Department</th>
									<th class="text-center">Location</th>
									<th class="text-center">Assign Period</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>AD001-BYASPRASAD S GAUD</td>
									<td>SBU1</td>
									<td>KHL</td>
									<td>20-05-2020 to 01-06-2020</td>
								</tr>
								<tr>
									<td>2</td>
									<td>AD002-MAHENDRA A GHAG</td>
									<td>SBU1</td>
									<td>KHL</td>
									<td>20-05-2020 to 01-06-2020</td>									
								</tr>
								<tr>
									<td>3</td>
									<td>AD003-PURUSHOTTAM G AMBRE</td>
									<td>SBU1</td>
									<td>KHL</td>
									<td>20-05-2020 to 01-06-2020</td>									
								</tr>
								<tr>
									<td>4</td>
									<td>AD00-BYASPRASAD S GAUD</td>
									<td>SBU1</td>
									<td>KHL</td>
									<td>20-05-2020 to 01-06-2020</td>								
								</tr>
								
							</tbody>
							<%-- <tbody>


								<c:forEach items="${assetsList}" var="assetList"
									varStatus="count">
									<tr>
										 <td>${count.index+1}</td>
										<td>${assetList.assetCode}</td>
										<td>${assetList.assetName}</td>
										<td>${assetList.assetDesc}</td>
										<td>${assetList.catName}</td>
										<td>${assetList.assetMake}</td>
										<td>${assetList.assetModel}</td>										
										<td>${assetList.assetSrno}</td>
										<td>${assetList.assetPurDate}</td>
										<td>${assetList.vendor}</td>
										<td class="text-center"><c:if test="${editAccess == 0}">
												<a
													href="${pageContext.request.contextPath}/editAsset?assetId=${assetList.exVar1}"
													class="list-icons-item text-primary-600" data-popup="tooltip"  data-original-title="Edit"><i class="icon-pencil7"
													 ></i></a>
											</c:if> <c:if test="${deleteAccess == 0}">
												 
												 
											<a href="javascript:void(0)"
													class="list-icons-item text-danger-600 bootbox_custom"
													data-uuid="${assetList.exVar1}" data-popup="tooltip"
													title="" data-original-title="Delete"><i
													class="icon-trash"></i></a>
											</c:if></td>
									</tr>
								</c:forEach>

							</tbody> --%>
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
<script type="text/javascript">
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
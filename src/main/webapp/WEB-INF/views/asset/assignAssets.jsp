<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>

<style type="text/css">
.daterangepicker{width: 100%;}
.daterangepicker.show-calendar .calendar{display: inline--block;}
.daterangepicker .calendar, .daterangepicker .ranges{float: right;}
</style>

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
						
						
						<form
									action="${pageContext.request.contextPath}/"
									id="submitInsertAsset" method="post">	
									
								<div class="form-group row">									
										<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="empName">Employee
													Name <span class="text-danger"></span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"  readonly="readonly" 
													autocomplete="off" onchange="trim(this)" value="AD001-BYASPRASAD S GAUD">
													<span class="validation-invalid-label" id="error_assetCode"
														style="display: none;">This field is required.</span>
												</div>
											</div>
											
											<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="empDept">Department
												 <span class="text-danger"></span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control"  readonly="readonly" 
												autocomplete="off" onchange="trim(this)" value="SBU1-WORKER">
												<span class="validation-invalid-label" id="error_assetName"
													style="display: none;">This field is required.</span>
											</div>
										</div>											
									</div>	
									
									<div class="form-group row">									
										<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCode">Designation
													Type <span class="text-danger"></span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"  readonly="readonly" 
													autocomplete="off" onchange="trim(this)" value="EXE">
													<span class="validation-invalid-label" id="error_assetCode"
														style="display: none;">This field is required.</span>
												</div>
											</div>
											
											<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetName">Location
												<span class="text-danger"></span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control"  readonly="readonly" 
												autocomplete="off" onchange="trim(this)" value="KHL">
												<span class="validation-invalid-label" id="error_assetName"
													style="display: none;">This field is required.</span>
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
									<th class="text-center">Period</th>
									<th class="text-center">Asset Img</th>	
									<th class="text-center">Remark</th>	
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td><input type="checkbox" class="select_all"></td>									
									<td>
										<a href="${pageContext.request.contextPath}/" data-toggle="modal" data-target="#modal_large"
										class="list-icons-item text-primary-600" data-popup="tooltip"  data-original-title="Asset Details">
										ASST001-Laptop</a>
									</td>
									<td>Computer</td>
									<td><input type="text" class="form-control daterange-basic_new" placeholder="Enter Period" 
										autocomplete="off"></td>
									<td>
										<img id="output1" width="150"/>
										<input type="file" accept="image/*" name="image" id="file"  onchange="loadFile1(event)"> 
									</td>			
									<td><input type="text" class="form-control" placeholder="Any Remark" 
										autocomplete="off" onchange="trim(this)"></td>									
									
								</tr>
								<tr>
									<td>2</td>
									<td><input type="checkbox" class="select_all"></td>									
									<td>
										<a href="${pageContext.request.contextPath}/" data-toggle="modal" data-target="#modal_large"
										class="list-icons-item text-primary-600" data-popup="tooltip"  data-original-title="Asset Details">
										ASST002-Cell Phone</a>
									</td>
									<td>Mobile</td>
									<td><input type="text" class="form-control daterange-basic_new" placeholder="Enter Period" 
										autocomplete="off"></td>
									<td>
										<img id="output2" width="150"/>
										<input type="file" accept="image/*" name="image" id="file"  onchange="loadFile2(event)"> 
									</td>	
									<td><input type="text" class="form-control" placeholder="Any Remark" 
										autocomplete="off" onchange="trim(this)"></td>									
									
								</tr>
								<tr>
									<td>3</td>
									<td><input type="checkbox" class="select_all"></td>
									<td>
										<a href="${pageContext.request.contextPath}/" data-toggle="modal" data-target="#modal_large"
										class="list-icons-item text-primary-600" data-popup="tooltip"  data-original-title="Asset Details">
										ASST003-Papers</a>
									</td>
									<td>Stationary</td>
									<td><input type="text" class="form-control daterange-basic_new" placeholder="Enter Period" 
										autocomplete="off"></td>
									<td>
										<img id="output3" width="150"/>
										<input type="file" accept="image/*" name="image" id="file"  onchange="loadFile3(event)"> 
									</td>	
									<td><input type="text" class="form-control" placeholder="Any Remark" 
										autocomplete="off" onchange="trim(this)"></td>									
									
								</tr>
								<tr>
									<td>4</td>
									<td><input type="checkbox" class="select_all"></td>
									<td>
										<a href="${pageContext.request.contextPath}/" data-toggle="modal" data-target="#modal_large"
										class="list-icons-item text-primary-600" data-popup="tooltip"  data-original-title="Asset Details">
										ASST004-Printer</a>
									</td>
									<td>Computer</td>
									<td><input type="text" class="form-control daterange-basic_new" placeholder="Enter Period" 
										autocomplete="off"></td>
									<td>
										<img id="output4" width="150"/>
										<input type="file" accept="image/*" name="image" id="file"  onchange="loadFile4(event)"> 
									</td>	
									<td><input type="text" class="form-control" placeholder="Any Remark" 
										autocomplete="off" onchange="trim(this)"></td>									
									
								</tr>
								<tr>
									<td>5</td>
									<td><input type="checkbox" class="select_all"></td>
									<td>
										<a href="${pageContext.request.contextPath}/" data-toggle="modal" data-target="#modal_large"
										class="list-icons-item text-primary-600" data-popup="tooltip"  data-original-title="Asset Details">
										ASST005-Laptop</a>
									</td>
									<td>Computer</td>
									<td><input type="text" class="form-control daterange-basic_new" placeholder="Enter Period" 
										autocomplete="off"></td>
									<td>
										<img id="output5" width="150"/>
										<input type="file" accept="image/*" name="image" id="file"  onchange="loadFile5(event)"> 
									</td>	
									<td><input type="text" class="form-control" placeholder="Any Remark" 
										autocomplete="off" onchange="trim(this)"></td>	
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
									<!-- <p class="desc text-danger fontsize11">Note : * Fields are
									mandatory.</p> -->

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
									<div class="form-group row">									
										<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCode">Model
													<span class="text-danger"></span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"  readonly="readonly" 
													autocomplete="off" onchange="trim(this)" value="Dell Inspiron">
													<span class="validation-invalid-label" id="error_assetCode"
														style="display: none;">This field is required.</span>
												</div>
											</div>
											
											<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetName">Serial
												No. <span class="text-danger"></span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control"  readonly="readonly" 
												autocomplete="off" onchange="trim(this)" value="D32A145">
												<span class="validation-invalid-label" id="error_assetName"
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
									<th class="text-center">AMC Vendor Name</th>
									<th class="text-center" colspan="2">AMC Period</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>Vendor 1</td>
									<td>20-05-2020</td>
									<td>01-06-2020</td>
									
									
								</tr>
<tr>
									<td>2</td>
									<td>Vendor 2</td>
									<td>20-05-2020</td>
									<td>01-06-2020</td>
									
								</tr>
								<tr>
									<td>3</td>
									<td>Vendor 3</td>
									<td>20-05-2020</td>
									<td>01-06-2020</td>
									
								</tr>
								<tr>
									<td>4</td>
									<td>Vendor 4</td>
									<td>20-05-2020</td>
									<td>01-06-2020</td>
								
								</tr>
								<tr>
									<td>5</td>
									<td>Vendor 5</td>
									<td>20-05-2020</td>
									<td>01-06-2020</td>
									
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
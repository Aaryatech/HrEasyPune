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
								<td width="60%"><h5 class="pageTitle"><i class="icon-list-unordered"></i> Employee Assets 
								Management </h5></td>
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
											<form action="manageAssets" id="showAllAssetsEmployee" method="get">				
									<div class="form-group row">									
											<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetCatId">Accessible 
											Location<span class="text-danger"></span>:</label>
												<div class="col-lg-6 float">
													<select name="locId_list" data-placeholder="Select Location" id="locId_list" 
														class="form-control form-control-select2 select2-hidden-accessible">

														<!-- <option value="">Select Location</option> -->
														<c:forEach items="${locationList}" var="locationList">
															<c:set value="0" var="find"></c:set>															
																<c:if test="${locationList.locId==locationIds}">
																	<option selected="selected"
																		value="${locationList.locId}">${locationList.locName}</option>
																	<c:set value="1" var="find"></c:set>
																</c:if>															
															<c:if test="${find==0}">
																<option value="${locationList.locId}">${locationList.locName}</option>
															</c:if>
														</c:forEach>
													</select>
													 <span
														class="validation-invalid-label" id="error_assetCatId"
														style="display: none;">This field is required.</span>
																										
												</div>
											</div>	
											<button type="submit" class="btn blue_btn" id="submtbtn">
									Search <i class="icon-paperplane ml-2"></i>
								</button>	
									</div>
									
									</form>
						<table
							class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
							id="printtable1">
							<thead>
								<tr class="bg-blue">

									<th class="text-center" width="5%">Sr. No.</th>
									<th class="text-center">Emp Code</th>
									<th class="text-center">Name</th>
									<th class="text-center">Emp Type</th>
									<th class="text-center">Department.</th>
									<th class="text-center">Designation</th>
									<th class="text-center">Location</th>
									<th width="10%" class="text-center">Actions</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${assetEmpList}" var="assetEmpList"
									varStatus="count">
								<tr>
									<td>${count.index+1}</td>
									<td>${assetEmpList.empCode}</td>
									<td>
									<a href="${pageContext.request.contextPath}/assignAssets" data-toggle="modal" data-target="#modal_large"
										class="list-icons-item text-primary-600" data-popup="tooltip"  data-original-title="Assigned Assets">
										${assetEmpList.firstName} ${assetEmpList.middleName} ${assetEmpList.surname}</a></td>
									<td>${assetEmpList.empType}</td>
									<td>${assetEmpList.department}</td>
									<td>${assetEmpList.designation}</td>									
									<td>${assetEmpList.location}</td>
									<td>
									<a href="${pageContext.request.contextPath}/assignAssets?empId=${assetEmpList.exVar1}&locId=${assetEmpList.locId}"
										class="list-icons-item text-primary-600" data-popup="tooltip"  data-original-title="Assign Asset">
										<i class="icon-enlarge5"></i></a>
											
									<a href="${pageContext.request.contextPath}/returnAssets?empId=${assetEmpList.exVar1}&locId=${assetEmpList.locId}"
										class="list-icons-item text-primary-600" data-popup="tooltip"  data-original-title="Return Asset">
										<i class="icon-last"></i></a>
										
									<a href="${pageContext.request.contextPath}/editAssignAssets?empId=${assetEmpList.exVar1}&locId=${assetEmpList.locId}"
										class="list-icons-item text-primary-600" data-popup="tooltip"  data-original-title="Edit">
										<i class="icon-pencil7"></i></a>
									</td>
									
								</tr>
								</c:forEach>

							</tbody>
						</table>
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
								<h5 class="pageTitle"><i class="icon-list-unordered"></i>Current Assets Assigned to   
								Employee </h5>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>

							<div class="modal-body">
							<div class="form-group row">									
										<div class="col-md-6">										
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="empName">Employee
													Name <span class="text-danger"></span>:</label>
												<div class="col-lg-7  float">
													<input type="text" class="form-control"  readonly="readonly"  
													 value="AD001-BYASPRASAD S GAUD">
													<span class="validation-invalid-label" id="error_assetCode"
														style="display: none;">This field is required.</span>
												</div>
											</div>
											
											<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="empDept">Department
												 <span class="text-danger"></span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control"  readonly="readonly" 
												value="SBU1-WORKER">
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
													 value="EXE">
													<span class="validation-invalid-label" id="error_assetCode"
														style="display: none;">This field is required.</span>
												</div>
											</div>
											
											<div class="col-md-6">
												<label class="col-form-label text-info font-weight-bold col-lg-5 float" for="assetName">Location
												<span class="text-danger"></span>:</label>
												<div class="col-lg-7 float">
												<input type="text" class="form-control"  readonly="readonly" 
												value="KHL">
												<span class="validation-invalid-label" id="error_assetName"
													style="display: none;">This field is required.</span>
											</div>
										</div>											
									</div>	
							<table
							class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
							id="printtable1">
							<thead>
								<tr class="bg-blue">

									<th class="text-center" width="5%">Sr. No.</th>
									<th class="text-center">Asset Name</th>
									<th class="text-center">Category</th>
									<th class="text-center">Model</th>
									<th class="text-center">Assign Period</th>
									<th class="text-center">Status</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>ASST001-Laptop</td>
									<td>Computer</td>
									<td>Dell Inspiron</td>
									<td>20-05-2020 to 01-06-2020</td>
									<td>Live</td>	
								</tr>
<tr>
									<td>2</td>
									<td>ASST002-Sim</td>
									<td>Phone</td>
									<td>Vodefone</td>
									<td>20-05-2020 to 01-06-2020</td>
									<td>Live</td>
								</tr>
								<tr>
									<td>3</td>
									<td>ASST003-Papers</td>
									<td>Stationary</td>
									<td>A4</td>
									<td>20-05-2020 to 01-06-2020</td>
									<td>Pending</td>
								</tr>
								<tr>
									<td>4</td>
									<td>ASST004-Cell Phone</td>
									<td>Phone</td>
									<td>One Plus T</td>
									<td>20-05-2020 to 01-06-2020</td>
									<td>Scrap</td>
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
	</Script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>

<body>
	<c:url var="getAssetsAMCs" value="/getAssetsAMCs"></c:url>
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
										<i class="icon-list-unordered"></i> Asset Master
									</h5></td>
								<td width="40%" align="right"><c:if test="${addAccess==0}">
										<a href="${pageContext.request.contextPath}/addAsset"
											class="breadcrumb-elements-item">
											<button type="button" class="btn blue_btn legitRipple">Add
												Asset</button>
										</a>
									</c:if></td>
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
						<form action="showAllAssets" id="showAllAssets" method="get">
							<div class="form-group row">
								<div class="col-md-6">
									<label
										class="col-form-label text-info font-weight-bold col-lg-5 float"
										for="assetCatId">Accessible Location<span
										class="text-danger"></span>:
									</label>
									<div class="col-lg-6 float">
										<select name="locId" data-placeholder="Select Location"
											id="locId"
											class="form-control form-control-select2 select2-hidden-accessible">
											<option value="0">All</option>
											<c:forEach items="${locationList}" var="locationList">
												<option value="${locationList.locId}">${locationList.locName}</option>
											</c:forEach>
										</select>
									</div>
								</div>
								<button type="submit" class="btn blue_btn" id="submtbtn">
									Search <i class="icon-paperplane ml-2"></i>
								</button>
							</div>

						</form>
						<table class="table ">
							<thead>
								<tr class="bg-blue">

									<th width="10%">Sr. No.</th>
									<th>Code</th>
									<th>Name</th>
									<th>Description</th>
									<th>Category</th>
									<th>Asset Make</th>
									<th>Model</th>
									<th>Serial No.</th>
									<th>Purchase Date</th>
									<th>Vendor</th>
									<th width="10%" class="text-center">Actions</th>
								</tr>
							</thead>
							<tbody>




								<c:forEach items="${assetsList}" var="assetList"
									varStatus="count">
									<tr class="accordion-toggle collapsed"
										id1="accordion${count.index+1}" data-toggle1="collapse"
										data-parent1="#accordion${count.index+1}">
										<td><a href="#collapseOne${count.index+1}" onclick="getAssetInfo('${assetList.exVar1}',${count.index+1})"
											id="accordion${count.index+1}" data-toggle="collapse"
											data-parent="#accordion${count.index+1}"><span
											class="expand-button"></span></a></td>
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
													class="list-icons-item text-primary-600"
													data-popup="tooltip" data-original-title="Edit"><i
													class="icon-pencil7"></i></a>
											</c:if> <c:if test="${deleteAccess == 0}">


												<a href="javascript:void(0)"
													class="list-icons-item text-danger-600 bootbox_custom bootbox_custom2"
													data-uuid="${assetList.exVar1}" data-popup="tooltip"
													title="" data-original-title="Delete"><i
													class="icon-trash"></i></a>
											</c:if> <a href="${pageContext.request.contextPath}/addAssetAmc?assetId=${assetList.exVar1}"
											class="list-icons-item text-primary-600" data-popup="tooltip"
											title="" data-original-title="Add Asset AMC"><i
												class="icon-enlarge5"></i></a>
												 <a
											href="${pageContext.request.contextPath}/scrapAsset?assetId=${assetList.exVar1}"
											class="list-icons-item text-primary-600" data-popup="tooltip"
											title="" data-original-title="Scrap Asset"><i
												class="fa fa-recycle"></i></a></td>
									</tr>


									<tr class="hide-table-padding">
										<!-- <td></td> -->
										<td colspan="12"><div id="collapseOne${count.index+1}"
												class="collapse in p-3">
 																<table
																	class="table datatable-scroller-buttons dataTable no-footer"
																	width="100%" role="grid" id="amcdatatable${count.index+1}">
																	<thead>
																		<tr role="row" class="bg-blue">
																			<th>Sr.No.</th>
																			<th>Vendor Name</th>
																			<th>AMC Period</th>
																			<th>Amt</th>
																			<th>Status</th>
																			<th>Actions</th>
																		</tr>
																	</thead>
																	<tbody>
																	<%-- <tr>
																		<td>1</td>
																		<td>Vendor2</td>
																		<td>01-03-2020 to 06-03-2020</td>
																		<td>2500</td>
																		<td>Pending</td>
																		<td class="text-center"><a
																			href="${pageContext.request.contextPath}/editAssetAmc?assetAMCId=18"
																			class="list-icons-item text-primary-600"
																			data-popup="tooltip" data-original-title="Edit"><i
																				class="icon-pencil7"></i></a> <a
																			href="${pageContext.request.contextPath}/renewAssetAmc?assetAMCId=18"
																			class="list-icons-item text-primary-600" data-uuid=""
																			data-popup="tooltip" title=""
																			data-original-title="Renew"><i
																				class="icon-history"></i></a> <a
																			href="javascript:void(0)"
																			class="list-icons-item text-danger-600 bootbox_custom bootbox_custom2"
																			data-uuid="" data-popup="tooltip" title=""
																			data-original-title="Terminate"><i
																				class="fa fa-ban"></i></a></td>
																	</tr>    --%>
																</tbody>
																</table>
													</div>
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

	<script>
function getAssetInfo(assetId,countIndex){  
 //  alert(assetId)
			$
					.getJSON(
							'${getAssetsAMCs}',
							{
								assetId : assetId,
								ajax : 'true',

							},
							function(data) {
								//alert("Data  " +JSON.stringify(data));
								
								var dataTable = $('#amcdatatable'+countIndex).DataTable();
								dataTable.clear().draw();
								
								$
										.each(
												data,
												function(i, v) {
													
													
													/* var acButton = '<a href="${pageContext.request.contextPath}/editAssetAmc?encodedAMCId='
														+ v.exVar1
														+'class="list-icons-item text-primary-600" data-popup="tooltip" data-original-title="Edit">'
														+'<i class="icon-pencil7"></i></a>';  */
														var acButton = '<a href="${pageContext.request.contextPath}/editAssetAmc?encodedAMCId='
															+ v.exVar1
															+ '" class="list-icons-item text-primary-600" data-popup="tooltip" title="" data-original-title="Edit"><i class="icon-pencil7"></i></a>'
															+'&nbsp; &nbsp;<a href="${pageContext.request.contextPath}/renewAssetAmc?assetAMCId='
															+ v.exVar1
															+ '" class="list-icons-item text-primary-600" data-popup="tooltip" title="" data-original-title="Renew"><i class="icon-history"></i></a>'
															+'&nbsp; &nbsp;<a href="${pageContext.request.contextPath}/lostAssetAmc?encodeAssetId='
															+ v.exVar2
															+ '" class="list-icons-item text-primary-600" data-popup="tooltip" title="" data-original-title="Renew"><i class="fa fa-question-circle"></i></a>'
															+'&nbsp; &nbsp; <a href="javascript:void(0)" onClick=\'bootbox_ban("'+v.exVar1+'")\' class="list-icons-item text-danger-600 bootbox_custom bootbox_custom1" data-uuid="'+v.exVar1+'" data-popup="tooltip" title=""' 
															+'data-original-title="Terminate"><i class="fa fa-ban"></i></a>';
												dataTable.row
															.add(
																	[
																			i + 1,
																			v.compName,
																			v.amcFrDate+' to '+v.amcToDate,											
																			v.amcAmt,
																			v.statusText,
																			acButton 
																	]).draw();
												}); 
								
							 
								
							});
	}
</script>
	<script>
		// Custom bootbox dialog
		// Terminate Asset
		function bootbox_ban(uuid){
			 
			//alert(uuid);
			bootbox.confirm({
				title : 'Confirm ',
				message : 'Are you sure you want to terminate this Asset AMC ?',
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
						location.href = "${pageContext.request.contextPath}/terminateAsset?assetAMCId="
								+uuid;

					}
				}
			});
		}
		$('.bootbox_custom1')
				.on(
						'click',
						function() {
							var uuid = $(this).data("uuid") // will return the number 123
										bootbox.confirm({
										title : 'Confirm ',
										message : 'Are you sure you want to terminate this Asset AMC ?',
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
												location.href = "${pageContext.request.contextPath}/terminateAsset?assetAMCId="
														+uuid;

											}
										}
									});
						});
		
		// Delete Asset
		$('.bootbox_custom2')
				.on(
						'click',
						function() {
							var uuid = $(this).data("uuid") // will return the number 123
										bootbox.confirm({
										title : 'Confirm ',
										message : 'Are you sure you want to delete this Asset ?',
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
														+uuid;

											}
										}
									});
						});
	</Script>
</body>
</html>
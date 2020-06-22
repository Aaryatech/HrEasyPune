<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>

	

</head>

<body onload="drawChart()">
	
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
			<!-- <div class="card">


				<div class="card-header header-elements-inline"></div>

				<div class="card-body">
					<h6>Dashboard</h6>
				</div>

			</div>-->
			<div class="content">
			  <div class="row">
			    <div id="barchart_values" class="col-md-6">
			   <!--  <div  style="width: 900px; height: 500px;"></div> -->
			</div>
			
			 <div id="barchart_values2" class="col-md-6">
			   <!--  <div  style="width: 900px; height: 500px;"></div> -->
			</div>
				<!-- new html start here -->
				
			
				<!-- 1st birthday row start here -->
				
				
				<!--  -->
				
				
				
				<!-- 1st birthday row start here -->
				<!-- pie chart box -->
				  
				


				<!-- Highlighting rows and columns -->
				
			</div>

			<!-- /content area -->
			
			
	           <div class="row">
									<div class="late_employee">
										<h3 class="bg-pink-400 employee_title">Asset Return Pending</h3>
										
										<div class="late_one fix_scroll">
											
											<div class="datatable-scroll-wrap">
											<table class="table table-bordered table-hover datatable-highlight1" >
							<thead>
								<tr class="bg-pink-400" role="row">
								<th class="sorting_desc">Employee</th>
								<th class="sorting">Mobile No</th>
								<th class="sorting">Email</th>
								<th class="sorting">Asset Detail</th>
								<th class="sorting">Usage Period</th>
								<th class="sorting">Return Days-Alarm Days</th>
								</tr>
							</thead>
							<tbody>
								
							<c:forEach items="${assetRtnPndngList}" var="assetList"
									varStatus="count">
							<tr role="row" class="odd">
								<td><a href="#" data-toggle="modal" data-target="#modal_full">${assetList.firstName} ${assetList.surname}</a></td>
								<td>${assetList.mobileNo1}</td>
								<td>${assetList.emailId}</td>
								<td>${assetList.assetCode} - ${assetList.assetName}</td>	
								<td>${assetList.useToDate} - ${assetList.useFromDate}</td>	
								<td>${assetList.returtnInDays} - ${assetList.returnNotifctnDays}</td>							
							</tr>
							</c:forEach>
							</tbody>
						</table></div>
											
										</div>
										
									</div>
								</div>
								
								
								<div class="row">
									<div class="late_employee">
										<h3 class="bg-blue-400 employee_title">Asset AMC Expiration (Prior to 30 Days)</h3>
										
										<div class="late_one fix_scroll">
											
											<div class="datatable-scroll-wrap">
											<table class="table table-bordered table-hover datatable-highlight1" >
							<thead>
								<tr class="bg-blue-400" role="row">
								<th class="sorting">Asset Detail</th>
								<th class="sorting">AMC Period</th>
								<th class="sorting">Vendor Name-Contact Person</th>
								<th class="sorting">Contact Person Mobile/Email</th>
								<th class="sorting">Return Days-Alarm Days</th>
								</tr>
							</thead>
							<tbody>
								
							<c:forEach items="${assetAMCExpiryList}" var="assetList"
									varStatus="count">
							<tr role="row" class="odd">
								<td><a href="#" data-toggle="modal" data-target="#modal_full">${assetList.assetCode} - ${assetList.assetName}</a></td>
								<td>${assetList.amcFrDate} - ${assetList.amcToDate}</td>
								<td>${assetList.compName} - ${assetList.conatctPersonName}</td>	
								<td>${assetList.contactPersonNo} - ${assetList.contactPersonEmail}</td>	
								<td>${assetList.amcDueDays} - ${assetList.alarmDays}</td>																		
							</tr>
							</c:forEach>							
							</tbody>
						</table></div>
											
										</div>
										
									</div>
								</div>
				
				
				
			
			

			<script type="text/javascript">
				$(document).ready(
						function($) {

							//btn_go_next_tab
							$(".btn_go_next_tab").click(
									function(e) {
										$('.nav-tabs > .nav-item > .active')
												.parent().next('li').find('a')
												.trigger('click');

									});
							$(".btn_go_prev_tab").click(
									function(e) {
										$('.nav-tabs > .nav-item > .active')
												.parent().prev('li').find('a')
												.trigger('click');

									});

						});
				// Single picker
				/* $('#leaveDate').daterangepicker({
				    "autoUpdateInput": false,
					singleDatePicker : true,
					selectMonths : true,
					selectYears : true,
					locale : {
						format : 'DD-MM-YYYY'
					}
				}, function (start_date) {
				    $('#leaveDate').val(start_date.format('DD-MM-YYYY'));
				}); */
				$('.datepickerclass').daterangepicker({
					"autoUpdateInput" : false,
					singleDatePicker : true,
					selectMonths : true,
					selectYears : true,
					locale : {
						format : 'DD-MM-YYYY'
					}
				}, function(start_date) {
					$(this.element).val(start_date.format('DD-MM-YYYY'));
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
			google.charts.load("current", {packages:["corechart"]});
		    google.charts.setOnLoadCallback(drawChart);
		    function drawChart() {
		      var data = google.visualization.arrayToDataTable([
		        ["Element", "Total Assets", { role: "style" } ],
		        ["Computers", 700, "#b87333"],
		        ["Hard Disk", 150, "silver"],
		        ["Laptop", 230, "gold"],
		        ["Pen Drives", 260, "color: #e5e4e2"]
		      ]);

		      var view = new google.visualization.DataView(data);
		      view.setColumns([0, 1,
		                       { calc: "stringify",
		                         sourceColumn: 1,
		                         type: "string",
		                         role: "annotation" },
		                       2]); 

		      var options = {
		        title: "Total No of Assets By Category",
		        width: 600,
		        height: 400,
		        bar: {groupWidth: "95%"},
		        legend: { position: "none" },
		      };
		      var chart = new google.visualization.BarChart(document.getElementById("barchart_values"));
		      chart.draw(view, options);
		      drawChart1();
		  }
    </script>
    <script type="text/javascript">
    google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart1() {
	      var data = google.visualization.arrayToDataTable([
	    	  ['Category', 'Assigned', 'Unassigned', 'Scrapped','Lost'],
	          ['Computers', 1000, 400, 200,100],
	          ['Laptop', 1170, 460, 250,20],
	          ['Hard Disk', 660, 1120, 300,50],
	          ['Pen Drive', 1030, 540, 150,12]
	      ]);

	      var options = {
	              chart: {
	                title: 'Category wise Asset Distibution',
	                subtitle: 'Asset Detail Count',
	              }
	            };
	      var chart = new google.charts.Bar(document.getElementById('barchart_values2'));
	        chart.draw(data, google.charts.Bar.convertOptions(options));
	  }
    </script>
			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
			<!-- /footer -->

		</div>
		<!-- /main content -->

	</div>
	<!-- /page content -->

</body>
</html>
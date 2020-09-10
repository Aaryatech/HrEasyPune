<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:url var="getLateMarkGraph" value="/getLateMarkGraph" />
<c:url var="getEmpAdvanceGraph" value="/getEmpAdvanceGraph" />
<c:url var="getEmpLoanGraph" value="/getEmpLoanGraph" />
<c:url var="getEmpDefaultSalGraph" value="/getEmpDefaultSalGraph" />
<c:url var="getEmpGrossSalGraph" value="/getEmpGrossSalGraph" />
<div class="row">
	<div class="col-md-3">
		<img
			src="https://aeealberta.org/wp-content/uploads/2018/10/profile.png"
			class="late_pic" style="width: 45%;">
	</div>
	<div class="col-md-9">
		<div class="row pop_one_row">
			<div class="col-md-4 emp_nm">Employee Name :</div>
			<div class="col-md-8">${empInfoForDashBoard.empName}</div>
		</div>
		<div class="row pop_one_row">
			<div class="col-md-4 emp_nm">Designation :</div>
			<div class="col-md-8">${empInfoForDashBoard.designationName}</div>
		</div>
		<div class="row pop_one_row">
			<div class="col-md-4 emp_nm">Department :</div>
			<div class="col-md-8">${empInfoForDashBoard.departmentName}</div>
		</div>
		<div class="row pop_one_row">
			<div class="col-md-4 emp_nm">Mobile No :</div>
			<div class="col-md-8">${empInfoForDashBoard.contactNo}</div>
		</div>

		<!-- <div class="row pop_one_row">
			<div class="col-md-4 emp_nm">Leave Authorities :</div>
			<div class="col-md-8">Human Resource Person (HR)</div>
		</div> -->

	</div>

</div>

<div class="row">

	<div class="col-md-10" id="attn_div">
		<div class="box box-primary">
			<div class="box-header with-border">
				<!-- <h3 class="box-title">Employee Attendance Graph</h3> -->

			</div>
			<div class="box-body chart-responsive">
				<div class="chart" id="emp_attn_graph" style="height: 300px;"></div>
			</div>

		</div>
	</div>





</div>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		getGraphs();
	});
	function getGraphs() {

		var empId = "${empInfoForDashBoard.empId}";
		var graphType = "${graphType}";

		$.getJSON('${getLateMarkGraph}',

		{
			empId : empId,
			ajax : 'true'

		}, function(data) {

			if (graphType == 1) {
				google.charts.load('current', {
					'packages' : [ 'corechart' ]
				});
				google.charts.setOnLoadCallback(drawChart);
				function drawChart() {

					var dataTable = new google.visualization.DataTable();

					dataTable.addColumn('string', 'month Year'); // Implicit domain column.

					dataTable.addColumn('number', 'Late Min');
					dataTable.addColumn('number', 'Late Mark');

					$.each(data, function(key, dt) {

						dataTable.addRows([

						[ dt.month, parseFloat(dt.lateMin),
								parseFloat(dt.lateMark) ]

						]);

					})

					/* slantedTextAngle: 60 */
					var options = {
						hAxis : {
							title : "Month Year",
							textPosition : 'out',
							slantedText : true
						},
						vAxis : {
							title : 'Min/Days',
							minValue : 0,
							viewWindow : {
								min : 0
							},
							format : '0',
						},
						colors : [ 'orange', 'blue' ],
						theme : 'material'
					};
					var chart = new google.visualization.ColumnChart(document
							.getElementById('emp_attn_graph'));

					chart.draw(dataTable, options);
				}
			} else {
				google.charts.load('current', {
					'packages' : [ 'corechart' ]
				});
				google.charts.setOnLoadCallback(drawChart);
				function drawChart() {

					var dataTable = new google.visualization.DataTable();

					dataTable.addColumn('string', 'month Year'); // Implicit domain column.

					dataTable.addColumn('number', 'PAID LEAVE');
					dataTable.addColumn('number', 'LWP');
					dataTable.addColumn('number', 'ABSENT');

					$.each(data, function(key, dt) {

						dataTable.addRows([

						[ dt.month, dt.leaveCount, dt.lwp, parseFloat(dt.ab) ]

						]);

					})

					/* slantedTextAngle: 60 */
					var options = {
						hAxis : {
							title : "Month Year",
							textPosition : 'out',
							slantedText : true
						},
						vAxis : {
							title : 'Days',
							minValue : 0,
							viewWindow : {
								min : 0
							},
							format : '0',
						},
						colors : [ 'orange', 'blue','red' ],
						theme : 'material'
					};
					var chart = new google.visualization.ColumnChart(document
							.getElementById('emp_attn_graph'));

					chart.draw(dataTable, options);
				}
			}

		});

	}
</script>
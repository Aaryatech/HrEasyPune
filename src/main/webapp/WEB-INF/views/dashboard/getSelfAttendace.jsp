<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="row">
	<div class="table-responsive">
		<table class="table   table-bordered  table-hover   table-striped"
			width="100%" id="printtable1">


			<thead>
				<tr class="bg-blue" style="text-align: center;">

					<th class="text-center">Date</th>
					<th class="text-center">Status</th>
					<th class="text-center">In Time</th>
					<th class="text-center">Out Time</th>
					<th class="text-center">Working HRS</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="list">
					<tr>
						<td class="text-center">${list.attDate}</td>
						<td class="text-center">${list.attStatus}</td>
						<td class="text-center">${list.inTime}</td>
						<td class="text-center">${list.outTime}</td>
						<td class="text-center">${list.workingHrs}</td>
					</tr>
				</c:forEach>




			</tbody>
		</table>
	</div>


</div>
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
	$(document).ready(
			function() {
				$('a[data-toggle="tab"]').on(
						'shown.bs.tab',
						function(e) {
							$($.fn.dataTable.tables(true)).DataTable().columns
									.adjust().responsive.recalc();
						});
			});
</script>
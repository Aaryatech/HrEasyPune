<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="row">
	<div class="table-responsive">
		<table
			class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
			width="100%" id="printtable1">


			<thead>
				<tr class="bg-blue" style="text-align: center;">

					<th class="text-center">Date</th>
					<th class="text-center">Status</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="list">
					<tr>
						<td class="text-center">${list.attDate}</td>
						<td class="text-center">${list.attStatus}</td>
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
</script>
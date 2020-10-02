<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><div
	class="row">
	<div class="table-responsive">
		<table
			class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
			width="100%" id="printtable1">
			<thead>
				<tr class="bg-blue">

					<th class="text-center" width="10%">Sr. No.</th>
					<!-- <th class="text-center">Emp Code</th>
				<th class="text-center">Designation</th>
				<th class="text-center">Name</th> -->
					<th class="text-center">Voucher No.</th>
					<th class="text-center">Adv. Date</th>
					<th class="text-center">Advance Amount</th>
					<th class="text-center">Deduction Month/Year</th>
					<th class="text-center">is Deducted</th>
				</tr>
			</thead>
			<tbody>


				<c:forEach items="${getAdvance}" var="empdetList" varStatus="count">
					<tr>
						<td>${count.index+1}</td>
						<%-- <td>${empdetList.empCode}</td>
					<td>${empdetList.designation}</td>
					<td>${empdetList.surname}&nbsp;${empdetList.middleName}&nbsp;${empdetList.firstName}</td> --%>
						<td>${empdetList.voucherNo}</td>
						<td>${empdetList.advDate}</td>
						<td class="text-right">${empdetList.advAmount}</td>
						<td>${empdetList.dedMonth}-${empdetList.dedYear}</td>
						<td><c:choose>
								<c:when test="${empdetList.isDed==1}">Yes</c:when>
								<c:otherwise>No</c:otherwise>
							</c:choose></td>

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
			leftColumns : 0,
			rightColumns : 0
		}

	});
</script>
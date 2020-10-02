<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><div
	class="row">

	<div class="table-responsive">
		<c:choose>

			<c:when test="${type==1}">
				<table
					class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
					width="100%" id="printtable1">
					<thead>
						<tr class="bg-blue">

							<th class="text-center" width="10%">Sr. No.</th>
							<th class="text-center">Voucher No.</th>
							<th class="text-center">Adv. Date</th>
							<th class="text-center">Advance Amount</th>
							<th class="text-center">Deduction Month/Year</th>
							<th class="text-center">is Deducted</th>
						</tr>
					</thead>
					<tbody>


						<c:forEach items="${getAdvance}" var="empdetList"
							varStatus="count">
							<tr>
								<td>${count.index+1}</td>
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
			</c:when>
			<c:when test="${type==3}">
				<table
					class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
					width="100%" id="printtable1">
					<thead>
						<tr class="bg-blue">

							<th width="10%">Sr. No.</th>
							<th class="text-center">Deduction Type</th>
							<th class="text-center">Deduction AMT</th>
							<th class="text-center">Deduction Month-Year</th>
							<th>Is Paid</th>
						</tr>
					</thead>
					<tbody>


						<c:forEach items="${payDeductionlList}" var="deductList"
							varStatus="count">
							<tr>
								<td>${count.index+1}</td>
								<td>${deductList.typeName}</td>
								<td>${deductList.dedRate}</td>
								<td>${deductList.month}-${deductList.year}</td>
								<td><c:choose>
										<c:when test="${deductList.empCode==1}">Yes</c:when>
										<c:otherwise>No</c:otherwise>
									</c:choose></td>
							</tr>
						</c:forEach>

					</tbody>
				</table>
			</c:when>
			<c:when test="${type==4}">
				<table
					class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
					width="100%" id="printtable1">
					<thead>
						<tr class="bg-blue">

							<th width="10%">Sr. No.</th>
							<!-- <th>Employee Name</th> -->
							<th>Reward Type</th>
							<th>Reward Rate</th>
							<th>Reward Month Year</th>
							<th>Is Paid</th>
							<!-- <th width="10%" class="text-center">Actions</th> -->
						</tr>
					</thead>
					<tbody>


						<c:forEach items="${payBonusDetails}" var="rewardList"
							varStatus="count">
							<tr>
								<td>${count.index+1}</td>
								<%-- <td>${rewardList.payLoginName}</td> --%>
								<td>${rewardList.payApprovalRemark}</td>
								<td>${rewardList.payRate}</td>
								<td>${rewardList.month}-${rewardList.year}</td>
								<td><c:choose>
										<c:when test="${rewardList.isPaid==1}">Yes</c:when>
										<c:otherwise>No</c:otherwise>
									</c:choose></td>
							</tr>
						</c:forEach>

					</tbody>
				</table>
			</c:when>
			<c:when test="${type==2}">
				<table
					class="table datatable-fixed-left_custom table-bordered  table-hover   table-striped"
					width="100%" id="printtable1">
					<thead>
						<tr class="bg-blue">

							<th width="10%" class="text-center">Sr. No.</th>
							<th class="text-center">Application No.</th>
							<th class="text-center">Loan Date</th>
							<th class="text-center">Loan Amount</th>
							<th class="text-center">Repay Amount</th>
							<th class="text-center">Loan EMI</th>
							<th class="text-center">Current Outstanding</th>
							<th class="text-center">Status</th>
							<th class="text-center">Action</th>
						</tr>
					</thead>
					<tbody>


						<c:forEach items="${loanMainList}" var="empdetList"
							varStatus="count">
							<tr>
								<td>${count.index+1}</td>
								<td>${empdetList.loanApplNo}</td>
								<td>${empdetList.loanAddDate}</td>
								<td>${empdetList.loanAmt}</td>
								<td>${empdetList.loanRepayAmt}</td>
								<td>${empdetList.loanEmi}</td>
								<td>${empdetList.currentOutstanding}</td>
								<td>${empdetList.loanStatus}</td>
								<td class="text-center"><a
									href="${pageContext.request.contextPath}/showRepayLoanDetailEmployee?id=${empdetList.exVar1}&empId=${empdetList.exVar2}"
									class="list-icons-item text-primary-600" data-popup="tooltip"
									title="" data-original-title="Repay Schedule"><i
										class="icon-sort-time-desc"></i></a></td>


							</tr>
						</c:forEach>

					</tbody>
				</table>
			</c:when>
		</c:choose>

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
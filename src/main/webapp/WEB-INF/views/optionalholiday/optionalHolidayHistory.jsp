<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<!-- Page content -->



<!-- Main content -->


<!-- Page header -->
<div class="page-header page-header-light"></div>
<!-- /page header -->


<!-- Content area -->
<div class="content">


	<!-- Highlighting rows and columns -->
	<div class="card">


		<div class="card-header header-elements-inline">
			<h5 class="pageTitle">
				<i class="icon-list-unordered"></i>Optional Holiday History
			</h5>
		</div>

		<div class="card-body fixed_height">
			<div class="table-responsive">

				<table class="table datatable-scroll-y" id="printtable2">

					<!-- <table class="table datatable-scroll-y" width="100%"
									id="printtable1"> -->
					<thead>
						<tr class="bg-blue">

							<th width="10%">Sr.no</th>
							<th width="10%" style="text-align: center;">Emp Code</th>
							<th style="text-align: center;">Emp Name</th>
							<th style="text-align: center;">Holiday</th>
							<th style="text-align: center;">Remark</th>

						</tr>
					</thead>
					<tbody>


						<c:forEach items="${historyList}" var="historyList"
							varStatus="count">


							<tr>

								<td>${count.index+1}</td>

								<td>${historyList.empCode}</td>
								<td>${historyList.empName}</td>
								<td>${historyList.holidayName}&nbsp;(${historyList.holidate})</td>
								<td>${historyList.remark}</td>

							</tr>
						</c:forEach>

					</tbody>
				</table>
			</div>
		</div>
		<!-- /highlighting rows and columns -->

	</div>
	<!-- /content area -->



</div>
<!-- /main content -->



<!-- /page content -->

<script type="text/javascript">
	$(document).ready(function() {
		// Add smooth scrolling to all links
		$("a").on('click', function(event) {

			// Make sure this.hash has a value before overriding default behavior
			if (this.hash !== "") {
				// Prevent default anchor click behavior
				event.preventDefault();

				// Store hash
				var hash = this.hash;

				// Using jQuery's animate() method to add smooth page scroll
				// The optional number (800) specifies the number of milliseconds it takes to scroll to the specified area
				$('html, body').animate({
					scrollTop : $(hash).offset().top
				}, 800, function() {

					// Add hash (#) to URL when done scrolling (default click behavior)
					window.location.hash = hash;
				});
			} // End if
		});
	});
</script>

</body>
</html>
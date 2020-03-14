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
			<div class="card">


				<div class="card-header header-elements-inline"></div>

				<div class="card-body">
					<h6>Dashboard</h6>
				</div>

			</div>
			<div class="content">


				<!-- Highlighting rows and columns -->
				<div class="card"></div>
			</div>

			<!-- /content area -->

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
			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
			<!-- /footer -->

		</div>
		<!-- /main content -->

	</div>
	<!-- /page content -->

</body>
</html>
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
			<!-- <div class="card">


				<div class="card-header header-elements-inline"></div>

				<div class="card-body">
					<h6>Dashboard</h6>
				</div>

			</div>-->
			<div class="content">


				<!-- Highlighting rows and columns -->
				<div class="card">

					<form action="${pageContext.request.contextPath}/dashboard">
						<div class="card-body">
							<div class="form-group row title_row">
								<label
									class="col-form-label text-info font-weight-bold spacing_filed"
									for="dob">Date <span class="text-danger">*</span>:
								</label>
								<div>
									<input type="text" class="form-control datepickerclass"
										placeholder=" " id="fiterdate" name="fiterdate"
										value="${fiterdate}" autocomplete="off" onchange1="trim(this)">
									<span class="hidedefault  validation-invalid-label"
										id="error_empDob" style="display: none;">This field is
										required.</span>
								</div>
								<div>
									<button type="submit" class="btn bg-blue ml-3 legitRipple"
										id="submtbtn">
										Submit <i class="icon-paperplane ml-2"></i>
									</button>
								</div>
							</div>
						</div>
						<div class="card-body fixed_height">
						
						
							<!-- new code start here -->
							<div class="row">
							<div class="col-lg-4">

								<!-- Members online -->
								<div class="card bg-teal-400">
									<div class="card-body">
										<div class="d-flex">
											<h3 class="font-weight-semibold mb-0">3,450</h3>
											<span class="badge bg-teal-800 badge-pill align-self-center ml-auto">+53,6%</span>
					                	</div>
					                	
					                	<div>
											Members online
											<div class="font-size-sm opacity-75">489 avg</div>
										</div>
									</div>

									<div class="container-fluid">
										<div id="members-online"><svg width="202.38333129882812" height="50"><g width="202.38333129882812"><rect class="d3-random-bars" width="5.829972506550603" x="2.4985596456645442" style="fill: rgba(255, 255, 255, 0.5);" height="42.5" y="7.5"></rect><rect class="d3-random-bars" width="5.829972506550603" x="10.827091797879692" style="fill: rgba(255, 255, 255, 0.5);" height="32.5" y="17.5"></rect><rect class="d3-random-bars" width="5.829972506550603" x="19.155623950094842" style="fill: rgba(255, 255, 255, 0.5);" height="37.5" y="12.5"></rect><rect class="d3-random-bars" width="5.829972506550603" x="27.48415610230999" style="fill: rgba(255, 255, 255, 0.5);" height="30" y="20"></rect><rect class="d3-random-bars" width="5.829972506550603" x="35.812688254525135" style="fill: rgba(255, 255, 255, 0.5);" height="47.5" y="2.5"></rect><rect class="d3-random-bars" width="5.829972506550603" x="44.14122040674028" style="fill: rgba(255, 255, 255, 0.5);" height="47.5" y="2.5"></rect><rect class="d3-random-bars" width="5.829972506550603" x="52.469752558955435" style="fill: rgba(255, 255, 255, 0.5);" height="27.500000000000004" y="22.499999999999996"></rect><rect class="d3-random-bars" width="5.829972506550603" x="60.79828471117058" style="fill: rgba(255, 255, 255, 0.5);" height="25" y="25"></rect><rect class="d3-random-bars" width="5.829972506550603" x="69.12681686338573" style="fill: rgba(255, 255, 255, 0.5);" height="42.5" y="7.5"></rect><rect class="d3-random-bars" width="5.829972506550603" x="77.45534901560087" style="fill: rgba(255, 255, 255, 0.5);" height="42.5" y="7.5"></rect><rect class="d3-random-bars" width="5.829972506550603" x="85.78388116781602" style="fill: rgba(255, 255, 255, 0.5);" height="37.5" y="12.5"></rect><rect class="d3-random-bars" width="5.829972506550603" x="94.11241332003117" style="fill: rgba(255, 255, 255, 0.5);" height="25" y="25"></rect><rect class="d3-random-bars" width="5.829972506550603" x="102.44094547224633" style="fill: rgba(255, 255, 255, 0.5);" height="40" y="10"></rect><rect class="d3-random-bars" width="5.829972506550603" x="110.76947762446147" style="fill: rgba(255, 255, 255, 0.5);" height="50" y="0"></rect><rect class="d3-random-bars" width="5.829972506550603" x="119.09800977667662" style="fill: rgba(255, 255, 255, 0.5);" height="47.5" y="2.5"></rect><rect class="d3-random-bars" width="5.829972506550603" x="127.42654192889177" style="fill: rgba(255, 255, 255, 0.5);" height="50" y="0"></rect><rect class="d3-random-bars" width="5.829972506550603" x="135.75507408110693" style="fill: rgba(255, 255, 255, 0.5);" height="47.5" y="2.5"></rect><rect class="d3-random-bars" width="5.829972506550603" x="144.0836062333221" style="fill: rgba(255, 255, 255, 0.5);" height="47.5" y="2.5"></rect><rect class="d3-random-bars" width="5.829972506550603" x="152.41213838553722" style="fill: rgba(255, 255, 255, 0.5);" height="32.5" y="17.5"></rect><rect class="d3-random-bars" width="5.829972506550603" x="160.74067053775238" style="fill: rgba(255, 255, 255, 0.5);" height="47.5" y="2.5"></rect><rect class="d3-random-bars" width="5.829972506550603" x="169.0692026899675" style="fill: rgba(255, 255, 255, 0.5);" height="27.500000000000004" y="22.499999999999996"></rect><rect class="d3-random-bars" width="5.829972506550603" x="177.39773484218267" style="fill: rgba(255, 255, 255, 0.5);" height="50" y="0"></rect><rect class="d3-random-bars" width="5.829972506550603" x="185.7262669943978" style="fill: rgba(255, 255, 255, 0.5);" height="25" y="25"></rect><rect class="d3-random-bars" width="5.829972506550603" x="194.05479914661296" style="fill: rgba(255, 255, 255, 0.5);" height="40" y="10"></rect></g></svg></div>
									</div>
								</div>
								<!-- /members online -->

							</div>

							<div class="col-lg-4">

								<!-- Current server load -->
								<div class="card bg-pink-400">
									<div class="card-body">
										<div class="d-flex">
											<h3 class="font-weight-semibold mb-0">49.4%</h3>
											<div class="list-icons ml-auto">
						                		<div class="dropdown">
						                			<a href="#" class="list-icons-item dropdown-toggle" data-toggle="dropdown"><i class="icon-cog3"></i></a>
													<div class="dropdown-menu dropdown-menu-right">
														<a href="#" class="dropdown-item"><i class="icon-sync"></i> Update data</a>
														<a href="#" class="dropdown-item"><i class="icon-list-unordered"></i> Detailed log</a>
														<a href="#" class="dropdown-item"><i class="icon-pie5"></i> Statistics</a>
														<a href="#" class="dropdown-item"><i class="icon-cross3"></i> Clear list</a>
													</div>
						                		</div>
					                		</div>
					                	</div>
					                	
					                	<div>
											Current server load
											<div class="font-size-sm opacity-75">34.6% avg</div>
										</div>
									</div>

									<div id="server-load"><svg width="222.38333129882812" height="50"><g transform="translate(0,0)" width="222.38333129882812"><defs><clipPath id="load-clip-server-load"><rect class="load-clip" width="222.38333129882812" height="50"></rect></clipPath></defs><g clip-path="url(#load-clip-server-load)"><path d="M-8.553205049954927,30.333333333333332L-7.12767087496244,30.77777777777778C-5.702136699969952,31.22222222222222,-2.851068349984976,32.111111111111114,0,30.333333333333336C2.851068349984976,28.555555555555557,5.702136699969952,24.11111111111111,8.553205049954927,21C11.404273399939903,17.888888888888886,14.25534174992488,16.111111111111107,17.106410099909855,14.333333333333332C19.95747844989483,12.555555555555554,22.808546799879807,10.777777777777777,25.65961514986478,12.333333333333334C28.51068349984976,13.88888888888889,31.361751849834732,18.77777777777778,34.21282019981971,21.666666666666668C37.06388854980469,24.555555555555557,39.914956899789665,25.444444444444443,42.76602524977464,22.11111111111111C45.61709359975961,18.777777777777775,48.46816194974459,11.222222222222218,51.31923029972957,8.555555555555552C54.17029864971454,5.888888888888886,57.02136699969951,8.111111111111109,59.87243534968449,11.22222222222222C62.723503699669465,14.333333333333332,65.57457204965445,18.333333333333332,68.42564039963942,22.11111111111111C71.27670874962439,25.888888888888886,74.12777709960938,29.444444444444443,76.97884544959435,30.77777777777778C79.82991379957932,32.111111111111114,82.6809821495643,31.22222222222222,85.53205049954929,28.11111111111111C88.38311884953426,25,91.23418719951923,19.666666666666664,94.08525554950421,16.555555555555554C96.93632389948918,13.444444444444441,99.78739224947415,12.555555555555554,102.63846059945914,14.33333333333333C105.48952894944411,16.111111111111107,108.34059729942908,20.555555555555554,111.19166564941406,18.77777777777777C114.04273399939903,16.999999999999996,116.893802349384,8.999999999999996,119.74487069936897,4.9999999999999964C122.59593904935394,0.9999999999999964,125.44700739933893,0.9999999999999964,128.2980757493239,2.111111111111108C131.1491440993089,3.2222222222222197,134.00021244929385,5.444444444444443,136.85128079927884,9.888888888888888C139.7023491492638,14.333333333333332,142.55341749924878,21,145.40448584923377,22.555555555555554C148.25555419921872,24.111111111111107,151.1066225492037,20.555555555555554,153.9576908991887,22.111111111111107C156.80875924917365,23.666666666666664,159.65982759915863,30.33333333333333,162.51089594914362,32.55555555555555C165.3619642991286,34.77777777777777,168.2130326491136,32.55555555555556,171.06410099909857,30.999999999999996C173.91516934908356,29.444444444444443,176.7662376990685,28.555555555555554,179.6173060490535,26.11111111111111C182.46837439903845,23.666666666666664,185.31944274902344,19.666666666666664,188.17051109900842,15.666666666666666C191.0215794489934,11.666666666666666,193.87264779897836,7.666666666666664,196.72371614896335,8.111111111111109C199.5747844989483,8.555555555555554,202.4258528489333,13.444444444444445,205.27692119891827,18.555555555555557C208.12798954890323,23.666666666666668,210.9790578988882,29,213.83012624887317,31.88888888888889C216.68119459885816,34.77777777777778,219.53226294884314,35.22222222222222,222.38333129882812,32.33333333333333C225.2343996488131,29.444444444444443,228.0854679987981,23.22222222222222,230.93653634878308,20.333333333333332C233.78760469876804,17.444444444444443,236.638673048753,17.88888888888889,238.06420722374548,18.111111111111114L239.48974139873798,18.333333333333336L239.48974139873798,50L238.06420722374548,49.999999999999986C236.638673048753,49.99999999999999,233.78760469876804,49.99999999999999,230.93653634878308,49.999999999999986C228.0854679987981,49.99999999999999,225.2343996488131,49.99999999999999,222.38333129882812,49.999999999999986C219.53226294884314,49.99999999999999,216.68119459885816,49.99999999999999,213.83012624887317,49.999999999999986C210.9790578988882,49.99999999999999,208.12798954890323,49.99999999999999,205.27692119891827,49.999999999999986C202.4258528489333,49.99999999999999,199.5747844989483,49.99999999999999,196.72371614896335,49.999999999999986C193.87264779897836,49.99999999999999,191.0215794489934,49.99999999999999,188.17051109900842,49.999999999999986C185.31944274902344,49.99999999999999,182.46837439903845,49.99999999999999,179.6173060490535,49.999999999999986C176.7662376990685,49.99999999999999,173.91516934908356,49.99999999999999,171.06410099909857,49.999999999999986C168.2130326491136,49.99999999999999,165.3619642991286,49.99999999999999,162.51089594914362,49.999999999999986C159.65982759915863,49.99999999999999,156.80875924917365,49.99999999999999,153.9576908991887,49.999999999999986C151.1066225492037,49.99999999999999,148.25555419921872,49.99999999999999,145.40448584923377,49.999999999999986C142.55341749924878,49.99999999999999,139.7023491492638,49.99999999999999,136.85128079927884,49.999999999999986C134.00021244929385,49.99999999999999,131.1491440993089,49.99999999999999,128.2980757493239,49.999999999999986C125.44700739933893,49.99999999999999,122.59593904935394,49.99999999999999,119.74487069936897,49.999999999999986C116.893802349384,49.99999999999999,114.04273399939903,49.99999999999999,111.19166564941406,49.999999999999986C108.34059729942908,49.99999999999999,105.48952894944411,49.99999999999999,102.63846059945914,49.999999999999986C99.78739224947415,49.99999999999999,96.93632389948918,49.99999999999999,94.08525554950421,49.999999999999986C91.23418719951923,49.99999999999999,88.38311884953426,49.99999999999999,85.53205049954929,49.999999999999986C82.6809821495643,49.99999999999999,79.82991379957932,49.99999999999999,76.97884544959436,49.999999999999986C74.12777709960938,49.99999999999999,71.27670874962439,49.99999999999999,68.42564039963942,49.999999999999986C65.57457204965445,49.99999999999999,62.723503699669465,49.99999999999999,59.87243534968449,49.999999999999986C57.02136699969951,49.99999999999999,54.17029864971454,49.99999999999999,51.31923029972956,49.999999999999986C48.46816194974459,49.99999999999999,45.61709359975961,49.99999999999999,42.76602524977464,49.999999999999986C39.914956899789665,49.99999999999999,37.06388854980469,49.99999999999999,34.21282019981971,49.999999999999986C31.361751849834732,49.99999999999999,28.51068349984976,49.99999999999999,25.659615149864784,49.999999999999986C22.808546799879807,49.99999999999999,19.95747844989483,49.99999999999999,17.106410099909855,49.999999999999986C14.25534174992488,49.99999999999999,11.404273399939903,49.99999999999999,8.553205049954927,49.999999999999986C5.702136699969952,49.99999999999999,2.851068349984976,49.99999999999999,0,49.999999999999986C-2.851068349984976,49.99999999999999,-5.702136699969952,49.99999999999999,-7.12767087496244,49.999999999999986L-8.553205049954927,50Z" class="d3-area" style="fill: rgba(255, 255, 255, 0.5); opacity: 1;" transform="translate(-8.553205490112305,0)"></path></g></g></svg></div>
								</div>
								<!-- /current server load -->

							</div>

							<div class="col-lg-4">

								<!-- Today's revenue -->
								<div class="card bg-blue-400">
									<div class="card-body">
										<div class="d-flex">
											<h3 class="font-weight-semibold mb-0">$18,390</h3>
											<div class="list-icons ml-auto">
						                		<a class="list-icons-item" data-action="reload"></a>
						                	</div>
					                	</div>
					                	
					                	<div>
											Today's revenue
											<div class="font-size-sm opacity-75">$37,578 avg</div>
										</div>
									</div>

									<div id="today-revenue"><svg width="222.38333129882812" height="50"><g transform="translate(0,0)" width="222.38333129882812"><defs><clipPath id="clip-line-small"><rect class="clip" width="222.38333129882812" height="50"></rect></clipPath></defs><path d="M20,8.46153846153846L50.397221883138016,25.76923076923077L80.79444376627603,5L111.19166564941406,15.384615384615383L141.58888753255206,5L171.98610941569012,36.15384615384615L202.38333129882812,8.46153846153846" clip-path="url(#clip-line-small)" class="d3-line d3-line-medium" style="stroke: rgb(255, 255, 255);"></path><g><line class="d3-line-guides" x1="20" y1="50" x2="20" y2="8.46153846153846" style="stroke: rgba(255, 255, 255, 0.3); stroke-dasharray: 4px, 2px; shape-rendering: crispedges;"></line><line class="d3-line-guides" x1="50.397221883138016" y1="50" x2="50.397221883138016" y2="25.76923076923077" style="stroke: rgba(255, 255, 255, 0.3); stroke-dasharray: 4px, 2px; shape-rendering: crispedges;"></line><line class="d3-line-guides" x1="80.79444376627603" y1="50" x2="80.79444376627603" y2="5" style="stroke: rgba(255, 255, 255, 0.3); stroke-dasharray: 4px, 2px; shape-rendering: crispedges;"></line><line class="d3-line-guides" x1="111.19166564941406" y1="50" x2="111.19166564941406" y2="15.384615384615383" style="stroke: rgba(255, 255, 255, 0.3); stroke-dasharray: 4px, 2px; shape-rendering: crispedges;"></line><line class="d3-line-guides" x1="141.58888753255206" y1="50" x2="141.58888753255206" y2="5" style="stroke: rgba(255, 255, 255, 0.3); stroke-dasharray: 4px, 2px; shape-rendering: crispedges;"></line><line class="d3-line-guides" x1="171.98610941569012" y1="50" x2="171.98610941569012" y2="36.15384615384615" style="stroke: rgba(255, 255, 255, 0.3); stroke-dasharray: 4px, 2px; shape-rendering: crispedges;"></line><line class="d3-line-guides" x1="202.38333129882812" y1="50" x2="202.38333129882812" y2="8.46153846153846" style="stroke: rgba(255, 255, 255, 0.3); stroke-dasharray: 4px, 2px; shape-rendering: crispedges;"></line></g><g><circle class="d3-line-circle d3-line-circle-medium" cx="20" cy="8.46153846153846" r="3" style="stroke: rgb(255, 255, 255); fill: rgb(255, 255, 255); opacity: 1;"></circle><circle class="d3-line-circle d3-line-circle-medium" cx="50.397221883138016" cy="25.76923076923077" r="3" style="stroke: rgb(255, 255, 255); fill: rgb(255, 255, 255); opacity: 1;"></circle><circle class="d3-line-circle d3-line-circle-medium" cx="80.79444376627603" cy="5" r="3" style="stroke: rgb(255, 255, 255); fill: rgb(255, 255, 255); opacity: 1;"></circle><circle class="d3-line-circle d3-line-circle-medium" cx="111.19166564941406" cy="15.384615384615383" r="3" style="stroke: rgb(255, 255, 255); fill: rgb(255, 255, 255); opacity: 1;"></circle><circle class="d3-line-circle d3-line-circle-medium" cx="141.58888753255206" cy="5" r="3" style="stroke: rgb(255, 255, 255); fill: rgb(255, 255, 255); opacity: 1;"></circle><circle class="d3-line-circle d3-line-circle-medium" cx="171.98610941569012" cy="36.15384615384615" r="3" style="stroke: rgb(255, 255, 255); fill: rgb(255, 255, 255); opacity: 1;"></circle><circle class="d3-line-circle d3-line-circle-medium" cx="202.38333129882812" cy="8.46153846153846" r="3" style="stroke: rgb(255, 255, 255); fill: rgb(255, 255, 255); opacity: 1;"></circle></g></g></svg></div>
								</div>
								<!-- /today's revenue -->

							</div>
						</div>
							
							<!-- new code end here -->
						
						
						
						
						
						

							<div class="row">
								<div class="col-md-4">
									<div class="card bg-primary">
										<div class="card-header header-elements-inline">
											<h6 class="card-title dash_title">Today's Birthday</h6>

										</div>

										<div class="card-body white_bg">
										
											<div class="dashboard_bx">
												<c:forEach items="${birth.birthListToday}" var="birth" varStatus="count">
												<div class="dashboard_one">
													
	<div class="dashboard_single"><a href="#" class="text-white"><i class="icon-gift "> [${birth.empCode}]${birth.name}</i></a></div>
													
													
												</div>
												</c:forEach>
											</div>
											
																				
												
										</div>
									</div>

								</div>

								<div class="col-md-4">
									<div class="card bg-purple-300 text-white">
										<div class="card-header header-elements-inline">
											<h6 class="card-title dash_title">Upcomming Birthday(next 7 days)</h6>

										</div>

										<div class="card-body white_bg">
											<div class="dashboard_bx">
												<c:forEach items="${birth.birthListUpcoming}" var="birth" varStatus="count">
												<div class="dashboard_one">
													
	<div class="dashboard_single"><a href="#" class="text-white"><i class="icon-gift "> [${birth.empCode}] ${birth.name}</i></a></div>
													
													
												</div>
												</c:forEach>
											</div>
											
											
										</div>
									</div>



								</div>

								<div class="col-md-4">
									<div class="card bg-warning">
										<div class="card-header header-elements-inline">
											<h6 class="card-title dash_title">Upcoming Holidays (next 30 days)</h6>

										</div>

										<div class="card-body white_bg">
											
											<div class="dashboard_bx">
												<c:forEach items="${birth.holiList}" var="birth" varStatus="count">
												<div class="dashboard_one">													
													<div class="dashboard_l"><a href="#" class="text-white">${birth.holidayName}</a></div>
													<div class="dashboard_r"><a href="#" class="text-white">${birth.holidayDate}</a></div>
													<div class="clr"></div>													
												</div>
												</c:forEach>
											</div>
										
										</div>
									</div>

								</div>


							</div>
							<c:if test="${userType == 2}">

								<div class="row">
									<div class="col-md-4">
										<div class="card bg-primary">
											<div class="card-header header-elements-inline">
												<h6 class="card-title dash_title">New Hires (Past 30 days)</h6>

											</div>

											<div class="card-body white_bg">
												<div class="table-responsive">
												
												<div class="dashboard_bx">												
													<div class="dashboard_one">													
														<div class="dashboard_l"><a href="#" class="text-white">Total</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${newHire.maleEmp+newHire.femaleEmp+newHire.othEmp}</a></div>
														<div class="clr"></div>													
													</div>
													
													<div class="dashboard_one">													
														<div class="dashboard_l"><a href="#" class="text-white">Male</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${newHire.maleEmp}</a></div>
														<div class="clr"></div>													
													</div>
													
													<div class="dashboard_one">													
														<div class="dashboard_l"><a href="#" class="text-white">Female</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${newHire.femaleEmp}</a></div>
														<div class="clr"></div>													
													</div>
													
													<div class="dashboard_one">													
														<div class="dashboard_l"><a href="#" class="text-white">Other</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${newHire.othEmp}</a></div>
														<div class="clr"></div>													
													</div>												
												</div>
													
												</div>
											</div>
										</div>

									</div>

									<div class="col-md-4">
										<div class="card bg-purple-300 text-white">
											<div class="card-header header-elements-inline">
												<h6 class="card-title dash_title">Leave Application Pending</h6>

											</div>

											<div class="card-body white_bg">
											
												<div class="dashboard_bx">												
													<div class="dashboard_one">													
														<div class="dashboard_l"><a href="#" class="text-white">New Application</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${lvDet.newApp}</a></div>
														<div class="clr"></div>													
													</div>
													
													<div class="dashboard_one">													
														<div class="dashboard_l"><a href="#" class="text-white">Initial Authority Pending/Approved</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${lvDet.newApp}/${lvDet.finalPending}</a></div>
														<div class="clr"></div>													
													</div>
													
													<div class="dashboard_one">													
														<div class="dashboard_l"><a href="#" class="text-white">Final Authority Pending</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${lvDet.finalPending}</a></div>
														<div class="clr"></div>													
													</div>
												</div>
											
												
											</div>
										</div>



									</div>



									<div class="col-md-4">
										<div class="card bg-primary">
											<div class="card-header header-elements-inline">
												<h6 class="card-title dash_title">Attendance Previous Day(Date:
													${attnDet.attnDate})</h6>

											</div>

											<div class="card-body white_bg">											
												
												
													<div class="dashboard_bx">
														<div class="dashboard_one">
															<div class="dashboard_l"><a href="#" class="text-white">Total Emp</a></div>
															<div class="dashboard_r"><a href="#" class="text-white">${attnDet.preEmp+attnDet.lvEmp+attnDet.woEmp+attnDet.absentEmp}</a></div>
															<div class="clr"></div>
														</div>
													
													
													
														<div class="dashboard_one">
															<div class="dashboard_l"><a href="#" class="text-white">Present</a></div>
															<div class="dashboard_r"><a href="#" class="text-white">${attnDet.preEmp}</a></div>
															<div class="clr"></div>
														</div>
													
													
													
														<div class="dashboard_one">
															<div class="dashboard_l"><a href="#" class="text-white">Leave</a></div>
															<div class="dashboard_r"><a href="#" class="text-white">${attnDet.lvEmp}</a></div>
															<div class="clr"></div>
														</div>
													
													
													
														<div class="dashboard_one">
															<div class="dashboard_l"><a href="#" class="text-white">Weekly Off Taken</a></div>
															<div class="dashboard_r"><a href="#" class="text-white">${attnDet.woEmp}</a></div>
															<div class="clr"></div>
														</div>
													
													
													
														<div class="dashboard_one">
															<div class="dashboard_l"><a href="#" class="text-white">Absent</a></div>
															<div class="dashboard_r"><a href="#" class="text-white">${attnDet.absentEmp}</a></div>
															<div class="clr"></div>
														</div>
													</div>											
													
											
											
											</div>
										</div>

									</div>



								</div>

							</c:if>
							<c:if test="${userType == 2 || isAuth >0 }">

								<div class="row">

									<div class="col-md-4">
										<div class="card bg-purple-300 text-white">
											<div class="card-header header-elements-inline">
												<h6 class="card-title dash_title">Pay Deduction (Current Month)</h6>

											</div>

											<div class="card-body white_bg">
												<div class="dashboard_bx">
													<div class="dashboard_one">
														<div class="dashboard_l"><a href="#" class="text-white">Total Emp/amount</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${dedDet.empCount}/${dedDet.tot}</a></div>
														<div class="clr"></div>
													</div>
												</div>												

											</div>
										</div>



									</div>



									<div class="col-md-4">
										<div class="card bg-warning">
											<div class="card-header header-elements-inline">
												<h6 class="card-title dash_title">Today Leavs/Absent(Total:)</h6>

											</div>

											<div class="card-body white_bg">
												<div class="dashboard_bx">
													<c:forEach items="${deptWiseLvAbLList}" var="deptWiseLvAbLList" varStatus="count">
													<div class="dashboard_one">
														<div class="dashboard_l"><a href="#" class="text-white">${deptWiseLvAbLList.nameSd}</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${deptWiseLvAbLList.empCount}</a></div>
														<div class="clr"></div>
													</div>
													</c:forEach>
												</div>											
											
												
											</div>
										</div>

									</div>



									<div class="col-md-4">
										<div class="card bg-warning">
											<div class="card-header header-elements-inline">
												<h6 class="card-title dash_title">Today Weekly Off(Total:)</h6>

											</div>

											<div class="card-body white_bg">
											
												<div class="dashboard_bx">
													<c:forEach items="${deptwiseWkoff}" var="deptwiseWkoff" varStatus="count">
													<div class="dashboard_one">
														<div class="dashboard_l"><a href="#" class="text-white">${deptwiseWkoff.nameSd}</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${deptwiseWkoff.empCount}</a></div>
														<div class="clr"></div>
													</div>
													</c:forEach>
												</div>
											
											
											
												</div>
										</div>

									</div>


								</div>
							</c:if>
							<c:if test="${userType == 2}">

								<div class="row">
									<div class="col-md-4">
										<div class="card bg-primary">
											<div class="card-header header-elements-inline">
												<h6 class="card-title dash_title">Advance Deduction (Current Moth)</h6>

											</div>

											<div class="card-body white_bg">
											
												<div class="dashboard_bx">
													
													<div class="dashboard_one">
														<div class="dashboard_l"><a href="#" class="text-white">Total Emp/amount</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${advDet.emp}/${advDet.advTot}</a></div>
														<div class="clr"></div>
													</div>
													
													<div class="dashboard_one">
														<div class="dashboard_l"><a href="#" class="text-white">Total Skip Emp/Amt</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${advDet.skipId}/${advDet.skipTott}</a></div>
														<div class="clr"></div>
													</div>
													
												</div>
																						
												
											</div>
										</div>

									</div>

									<div class="col-md-4">
										<div class="card bg-purple-300 text-white">
											<div class="card-header header-elements-inline">
												<h6 class="card-title dash_title">Loan Deduction (Current Moth)</h6>

											</div>

											<div class="card-body white_bg">
												<div class="dashboard_bx">													
													<div class="dashboard_one">
														<div class="dashboard_l"><a href="#" class="text-white">Total Emp/amount</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${loanDet.emp}/${loanDet.advTot}</a></div>
														<div class="clr"></div>
													</div>
													
													<div class="dashboard_one">
														<div class="dashboard_l"><a href="#" class="text-white">Total Skip Emp/Amt</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${loanDet.skipId}/${loanDet.skipTott}</a></div>
														<div class="clr"></div>
													</div>
												</div>	

											</div>
										</div>



									</div>

									<div class="col-md-4">
										<div class="card bg-warning">
											<div class="card-header header-elements-inline">
												<h6 class="card-title">Pending Master one time</h6>

											</div>

											<div class="card-body white_bg">
												<div class="table-responsive">
												
													<div class="dashboard_bx">	
													<c:if test="${masterDet.companyCount==0}">												
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/companySubAdd"
																	class="text-white"> Add Company:0</a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.emptypeCount==0}">											
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/mstEmpTypeAdd"
																	class="text-white"> Add Emp Type:0 </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.locCount==0}">									
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/locationAdd"
																	class="text-white"> Add Location:0 </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.desnCount==0}">									
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/dsesignationAdd"
																	class="text-white"> Add Designation:0 </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.deptCount==0}">							
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/departmentAdd"
																	class="text-white"> Add Department:0 </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.hoCount==0}">						
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/holidayAdd"
																	class="text-white"> Add Holiday:0 </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.hocatCount==0}">					
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/holidayCategoryAdd"
																	class="text-white"> Add Holiday Cat:0 </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.wocatCount==0}">				
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/weekoffCategoryAdd"
																	class="text-white"> Add Weekly off Cat:0 </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.shiftCount==0}">				
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/addShift"
																	class="text-white"> Add Shift:0 </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.lvtypeCount==0}">				
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/leaveTypeAdd"
																	class="text-white"> Add Leave Type:0 </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.lvstructCount==0}">			
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/addLeaveStructure"
																	class="text-white"> Add Leave Structure:0 </a>
													</div>
													</c:if>
													
													<!--Pending  -->
													
													<c:if test="${masterDet.compPending!=0}">			
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/assignSubCompany"
																	class="text-white"> Assign Company:${masterDet.compPending} </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.typePending!=0}">		
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/showAssignEmpType"
																	class="text-white"> Assign Emp Type:${masterDet.typePending} </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.locPending!=0}">	
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/showAssignLocation"
																	class="text-white">
																		Assign Location:${masterDet.locPending} </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.desnPending!=0}">
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/showAssignDesignation"
																	class="text-white"> Assign Designation:${masterDet.desnPending}
																</a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.deptPending!=0}">
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/assignDept"
																	class="text-white">
																		Assign Department:${masterDet.deptPending}
																</a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.hocatPending!=0}">
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}//assignHolidayCategory"
																	class="text-white">
																		Assign Holiday:${masterDet.hocatPending}
																</a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.wocatPending!=0}">
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/assignWeekoffCategory"
																	class="text-white">
																		Assign Weekly off
																			Cat:${masterDet.wocatPending}
																</a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.shiftPending!=0}">
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/showEmpListToAssignShift"
																	class="text-white">
																		Assign Shift:${masterDet.shiftPending}
																</a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.lvStruvtPending!=0}">
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/leaveStructureAllotment"
																	class="text-white"> Assign Leave Type:${masterDet.lvStruvtPending} </a>
													</div>
													</c:if>
													
													<c:if test="${masterDet.lvAuthPending!=0}">
													<div class="dashboard_single">
														<a href="${pageContext.request.contextPath}/leaveAuthorityList"
																	class="text-white"> Assign Leave
																			Structure:${masterDet.lvAuthPending}
																</a>
													</div>
													</c:if>
													
													</div>
												</div>
											</div>
										</div>

									</div>


								</div>
							</c:if>


							<c:if test="${userType == 2 || isAuth > 0 }">

								<div class="row">
									<div class="col-md-4">
										<div class="card bg-primary">
											<div class="card-header header-elements-inline">
												<h6 class="card-title dash_title">My Attendance (Current Month)</h6>

											</div>

											<div class="card-body white_bg">
											
												<div class="dashboard_bx">													
													<div class="dashboard_one">
														<div class="dashboard_l"><a href="#" class="text-white">Present</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${attnLastMon.presentDays}</a></div>
														<div class="clr"></div>
													</div>
													
													<div class="dashboard_one">
														<div class="dashboard_l"><a href="#" class="text-white">LWP Leaves</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${attnLastMon.unpaidLeave}</a></div>
														<div class="clr"></div>
													</div>
													
													<div class="dashboard_one">
														<div class="dashboard_l"><a href="#" class="text-white">Paid Leaves</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${attnLastMon.paidLeave}</a></div>
														<div class="clr"></div>
													</div>
												</div>	
												
											</div>
										</div>

									</div>

									<c:if test="${userType == 2}">
										<div class="col-md-4">
											<div class="card bg-primary">
												<div class="card-header header-elements-inline">
													<h6 class="card-title dash_title">Today's Task</h6>

												</div>

												<div class="card-body white_bg">
													<div class="dashboard_bx">													
														<div class="dashboard_one">
															<div class="dashboard_l"><a href="#" class="text-white">Total Pending Application</a></div>
															<div class="dashboard_r"><a href="#" class="text-white">${list1Count}</a></div>
															<div class="clr"></div>
														</div>
													</div>
													
												</div>
											</div>

										</div>
									</c:if>

								</div>
							</c:if>



							<div class="row">

								<div class="col-md-4">
									<div class="card bg-warning">
										<div class="card-header header-elements-inline">
											<h6 class="card-title dash_title">My Deductions</h6>

										</div>

										<div class="card-body white_bg">
										
											<div class="dashboard_bx">	
												<c:forEach items="${dedWiseDedList}" var="dedWiseDedList" varStatus="count">												
												<div class="dashboard_one">
													<div class="dashboard_l"><a href="#" class="text-white">${dedWiseDedList.nameSd}</a></div>
													<div class="dashboard_r"><a href="#" class="text-white">${dedWiseDedList.empCount}</a></div>
													<div class="clr"></div>
												</div>
												</c:forEach>
												
												<div class="dashboard_one">
													<div class="dashboard_l"><a href="#" class="text-white">Total Advance</a></div>
													<div class="dashboard_r"><a href="#" class="text-white">${icent.perfIncentive}</a></div>
													<div class="clr"></div>
												</div>
												
												<div class="dashboard_one">
													<div class="dashboard_l"><a href="#" class="text-white">Total Loan</a></div>
													<div class="dashboard_r"><a href="#" class="text-white">${icent.prodIncentive}</a></div>
													<div class="clr"></div>
												</div>
											</div>
										
											
										</div>
									</div>

								</div>


								<div class="col-md-4">
									<div class="card bg-warning">
										<div class="card-header header-elements-inline">
											<h6 class="card-title dash_title">My Rewards</h6>

										</div>

										<div class="card-body white_bg">
										
											<div class="dashboard_bx">	
												<c:forEach items="${rewardWiseDedList}"
														var="rewardWiseDedList" varStatus="count">	
												<div class="dashboard_one">
													<div class="dashboard_l"><a href="#" class="text-white">${rewardWiseDedList.nameSd}</a></div>
													<div class="dashboard_r"><a href="#" class="text-white">${rewardWiseDedList.empCount}</a></div>
													<div class="clr"></div>
												</div>
												</c:forEach>
												
												<div class="dashboard_one">
													<div class="dashboard_l"><a href="#" class="text-white">Performance Incentive(Amt/Days)</a></div>
													<div class="dashboard_r"><a href="#" class="text-white">${perfList.prodAmt}/${perfList.prodDays}</a></div>
													<div class="clr"></div>
												</div>
												
												<div class="dashboard_one">
													<div class="dashboard_l"><a href="#" class="text-white">Production Incentive(Amt/Days)</a></div>
													<div class="dashboard_r"><a href="#" class="text-white">${prodList.prodAmt}/${prodList.prodDays}</a></div>
													<div class="clr"></div>
												</div>
												
												</div>
										
											
										</div>
									</div>

								</div>


								<div class="col-md-4">
									<div class="card bg-primary">
										<div class="card-header header-elements-inline">
											<h6 class="card-title dash_title">Important Links</h6>

										</div>

										<div class="card-body white_bg">
											<div class="dashboard_bx">
												<div class="dashboard_single">
													<a href="${pageContext.request.contextPath}/showApplyForLeave"
															class="text-white"> Apply Leave </a>
												</div>
												
												<c:if test="${isAuth > 0 || userType==2}">
												
												<div class="dashboard_single">
													<a href="${pageContext.request.contextPath}//viewPayDeduction"
																class="text-white"> Pay Deduction</a>
												</div>
												<div class="dashboard_single">
													<a href="${pageContext.request.contextPath}/viewEmpRewarAddList"
																class="text-white"> Add Reward </a>
												</div>
												<div class="dashboard_single">
													<a href="${pageContext.request.contextPath}/showEmpListToAddAdvance"
																class="text-white"> Add Advance </a>
												</div>
												
												<div class="dashboard_single">
													<a href="${pageContext.request.contextPath}/showEmpListToAddLoan"
																class="text-white"> Add Loan </a>
												</div>
												
												<c:if test="${userType==2}">
												<div class="dashboard_single">
													<a href="${pageContext.request.contextPath}/attendanceSelectMonth"
																	class="text-white"> Upload Attendence </a>
												</div>
												</c:if>
												<div class="dashboard_single">
													<a href="#" class="text-white"> Add OT Hour </a>
												</div>
												
												
												</c:if>
											</div>
										</div>
									</div>

								</div>

							</div>

							<!-- HR Dash  -->

							<c:if test="${userType ==2}">
								<div class="row">


									<div class="col-md-4">
										<div class="card bg-warning">
											<div class="card-header header-elements-inline">
												<h6 class="card-title dash_title">Reward (Current Month)</h6>

											</div>

											<div class="card-body white_bg">
											
												<div class="dashboard_bx">													
													<div class="dashboard_one">
														<div class="dashboard_l"><a href="#" class="text-white">Total Emp/amount</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${rewardDet.empCount}/${rewardDet.tot}</a></div>
														<div class="clr"></div>
													</div>
												</div>
											
												
											</div>
										</div>

									</div>


									<div class="col-md-4">
										<div class="card bg-warning">
											<div class="card-header header-elements-inline">
												<h6 class="card-title dash_title">Performance Bonus (Current
													Month)</h6>

											</div>
											<div class="card-body white_bg">
												
												<div class="dashboard_bx">	
													<c:forEach items="${perfListDept}" var="perfListDept" varStatus="count">
																									
													<div class="dashboard_one">
														<div class="dashboard_l"><a href="#" class="text-white">${perfListDept.nameSd}</a></div>
														<div class="dashboard_r"><a href="#" class="text-white">${perfListDept.empCount}</a></div>
														<div class="clr"></div>
													</div>
													</c:forEach>													
												</div>
											
											
											
												
											</div>
										</div>

									</div>





								</div>
							</c:if>
							<!--Leave Details -->

							<div class="row">
								<div class="col-md-12">
									<div class="table-responsive marg_btm">
										<table
											class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
											id="printtable22">


											<thead>
												<tr class="bg-blue">

													<th>Leave Type</th>
													<th>Opening Leave</th>
													<th>Earned</th>
													<th>Approved</th>
													<th>Applied</th>
													<th>Balanced</th>


												</tr>
											</thead>
											<tbody>
												<c:forEach items="${leaveHistoryList}"
													var="leaveHistoryList">


													<c:choose>
														<c:when test="${leaveHistoryList.lvTypeId==1}">
															<c:if test="${mstEmpType.whWork eq 'Compoff'}">
																<tr>
																	<td>${leaveHistoryList.lvTitle}</td>
																	<td style="text-align: right;">${leaveHistoryList.balLeave}</td>
																	<td style="text-align: right;">${leaveHistoryList.lvsAllotedLeaves}</td>
																	<td style="text-align: right;">${leaveHistoryList.sactionLeave}</td>
																	<td style="text-align: right;">${leaveHistoryList.aplliedLeaeve}</td>
																	<td style="text-align: right;">${leaveHistoryList.balLeave+leaveHistoryList.lvsAllotedLeaves-leaveHistoryList.sactionLeave-leaveHistoryList.aplliedLeaeve}</td>

																</tr>
															</c:if>

														</c:when>
														<c:otherwise>
															<tr>
																<td>${leaveHistoryList.lvTitle}</td>
																<td style="text-align: right;">${leaveHistoryList.balLeave}</td>
																<td style="text-align: right;">${leaveHistoryList.lvsAllotedLeaves}</td>
																<td style="text-align: right;">${leaveHistoryList.sactionLeave}</td>
																<td style="text-align: right;">${leaveHistoryList.aplliedLeaeve}</td>
																<td style="text-align: right;">${leaveHistoryList.balLeave+leaveHistoryList.lvsAllotedLeaves-leaveHistoryList.sactionLeave-leaveHistoryList.aplliedLeaeve}</td>

															</tr>
														</c:otherwise>

													</c:choose>

												</c:forEach>




											</tbody>
										</table>
									</div>

								</div>
								<!--Leave History -->
							</div>

							<div class="row">
								<div class="col-md-12">
									<div class="table-responsive">
										<table
											class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
											id="printtable11">


											<thead>
												<tr class="bg-blue">

													<th>Sr. No.</th>
													<th>Leave Type</th>
													<th>Dates</th>
													<th>Days</th>
													<th>Remark</th>
													<th>Status</th>


												</tr>
											</thead>
											<tbody>
												<c:forEach items="${lvApplList}" var="lvApplList"
													varStatus="count">



													<tr>
														<td>${count.index+1}</td>
														<td>${lvApplList.lvTitleShort}</td>
														<td>${lvApplList.leaveFromdt}to
															${lvApplList.leaveTodt}</td>
														<td style="text-align: right;">${lvApplList.leaveNumDays}</td>


														<td>${lvApplList.leaveEmpReason}</td>
														<td>${lvApplList.exInt1==1 ? 'Applied': lvApplList.exInt1==7 ? 'cancelled by employee': lvApplList.exInt1==2 ? ' ia approval' : lvApplList.exInt1==8 ? 'ia reject' : lvApplList.exInt1==3 ? 'fa approval & leave confirmed' :lvApplList.exInt1==9 ? 'fa reject'   : ''}</td>

													</tr>


												</c:forEach>




											</tbody>
										</table>
									</div>
								</div>
							</div>
							<c:if test="${userType ==2}">

								<div class="row">
									<div class="col-md-12">
										<div class="card bg-primary">
											<div class="card-header header-elements-inline">
												<h6 class="card-title">Employee Diversity Report</h6>

											</div>

											<div class="card-body">

												<div class="row">
													<div class="col-md-3">Gender</div>
													<div class="col-md-3">Age</div>
													<div class="col-md-3">Experience</div>
													<div class="col-md-3">Salary</div>
												</div>


												<div class="row">
													<div class="col-md-3">
														Male:${ageDiv.maleEmp} <br>
														Female:${ageDiv.femaleEmp} <br>
														Other:${ageDiv.othEmp} <br>------<br>
														<c:forEach items="${deptWiseEmpCntList}"
															var="deptWiseEmpCntList" varStatus="count">
															<c:if test="${deptWiseEmpCntList.empCount >0}">
 													
													 ${deptWiseEmpCntList.nameSd}:   ${deptWiseEmpCntList.empCount}
													 
													 
													 <br>
															</c:if>

														</c:forEach>

													</div>
													<div class="col-md-3">

														18-20: ${ageDiversity.ageRange1}<br> 21-25:
														${ageDiversity.ageRange2}<br> 26-30:
														${ageDiversity.ageRange3}<br> 31-35:
														${ageDiversity.ageRange5}<br> 36-40:
														${ageDiversity.ageRange6}<br> 41-45:
														${ageDiversity.ageRange7}<br> 46-50:
														${ageDiversity.ageRange8}<br> 51-55:
														${ageDiversity.ageRange9}<br> 56-60:
														${ageDiversity.ageRange10}<br> 60-65:
														${ageDiversity.ageRange11}<br>

													</div>
													<div class="col-md-3">

														0 Year: ${expDiversity.ageRange1}<br> 1
														Year:${expDiversity.ageRange2}<br> 2
														Year:${expDiversity.ageRange3}<br> 5
														Year:${expDiversity.ageRange4}<br> 10
														Year:${expDiversity.ageRange5}<br> 10+ :
														${expDiversity.ageRange6}<br>

													</div>
													<div class="col-md-3">
														up to 10000 : ${salDiversity.ageRange1}<br>
														10000-20000: ${salDiversity.ageRange2}<br>
														21000-30000: ${salDiversity.ageRange3}<br>

														31000-40000:${salDiversity.ageRange4}<br>
														41000-50000: ${salDiversity.ageRange5}<br>
														51000-60000: ${salDiversity.ageRange6}<br>
														61000-70000 : ${salDiversity.ageRange7}<br>
														71000-80000: ${salDiversity.ageRange8}<br>
														81000-9000: ${salDiversity.ageRange9}<br>
														91000-100000: ${salDiversity.ageRange10}<br>
													</div>
												</div>
											</div>
										</div>
									</div>

								</div>
							</c:if>

						</div>

						<!-- /highlighting rows and columns -->
					</form>
				</div>
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
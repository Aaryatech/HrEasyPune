<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="org.springframework.util.LinkedMultiValueMap"%>
<%@ page import="org.springframework.util.MultiValueMap"%>
<%@ page import="com.ats.hreasy.model.EmpSalInfoDaiyInfoTempInfo"%>
<%@ page import="com.ats.hreasy.common.Constants"%>
<%@ page import="com.ats.hreasy.common.ReportCostants"%>
<%@ page import="com.ats.hreasy.model.Setting"%>
<%@ page import="com.ats.hreasy.model.LoginResponse"%>
<%@ page import="com.ats.hreasy.model.PayRollDataForProcessing"%>
<%@ page import="com.ats.hreasy.model.GetPayrollGeneratedList"%>
<%@ page import="com.ats.hreasy.model.Allowances"%>

<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>
<!-- <link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css"> -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/bootstrap-datepicker.css"
	type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-datepicker.js"></script>

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

			<!-- Page header -->
			<div class="page-header page-header-light"></div>
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">


				<!-- Highlighting rows and columns -->
				<div class="card">
					<div class="card-header header-elements-inline">
						<h5 class="pageTitle">
							<i class="icon-list-unordered"></i> List Of Generated Payroll
						</h5>
						<!-- <div class="header-elements">
							<div class="list-icons">
								<a class="list-icons-item" data-action="collapse"></a>
							</div> 
						</div>-->
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
						<form
							action="${pageContext.request.contextPath}/listOfGeneratedPayroll"
							id="listOfGeneratedPayroll" method="get">
							<div class="form-group row">
								<label
									class="col-form-label text-info font-weight-bold col-lg-2"
									for="datepicker"> Select Month <span style="color: red">*
								</span> :
								</label>
								<div class="col-md-2">
									<input type="text" name="selectMonth" id="datepicker"
										class="form-control" value="${date}" required />
								</div>
								<label
									class="col-form-label text-info font-weight-bold col-lg-2"
									for="subCmpId"> Select Company <span style="color: red">*
								</span> :
								</label>
								<div class="col-lg-2">
									<select name="subCmpId" data-placeholder="Select Company"
										id="subCmpId"
										class="form-control form-control-select2 select2-hidden-accessible">
										<option value="0">All</option>
										<c:forEach items="${companyList}" var="companySubList">
											<c:choose>
												<c:when test="${companySubList.companyId==companyId}">
													<option selected="selected"
														value="${companySubList.companyId}">${companySubList.companyName}</option>
												</c:when>
												<c:otherwise>
													<option value="${companySubList.companyId}">${companySubList.companyName}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select> <span class="hidedefault   validation-invalid-label"
										style="display: none;" id="error_subCmpId">This field
										is required.</span>
								</div>
								<button type="submit" class="btn blue_btn ml-3 legitRipple"
									id="submtbtn">
									Search <i class="icon-paperplane ml-2"></i>
								</button>

							</div>
						</form>
						<form action="${pageContext.request.contextPath}/#"
							id="submitInsertLeave" method="post">

							<input type="hidden" name="searchDate" id="searchDate"
								value="${date}" />
							<div id="loader" style="display: none;">
								<img
									src="${pageContext.request.contextPath}/resources/assets/images/giphy.gif"
									width="150px" height="150px"
									style="display: block; margin-left: auto; margin-right: auto">
							</div>

							<div class="table-responsive">
								<table
									class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic1  datatable-button-print-columns1"
									id="bootstrap-data-table1">
									<thead>
										<%
											session = request.getSession();
											String mnth = (String) request.getAttribute("month");
											List<Allowances> allowancelist = new ArrayList<Allowances>();
											List<GetPayrollGeneratedList> list = new ArrayList<GetPayrollGeneratedList>();
											int amount_round = 0;

											MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
											map = new LinkedMultiValueMap<String, Object>();
											map.add("limitKey", "ammount_format_show");
											Setting getSettingByKey = Constants.getRestTemplate().postForObject(Constants.url + "/getSettingByKey", map,
													Setting.class);
											amount_round = Integer.parseInt(getSettingByKey.getValue());

											map = new LinkedMultiValueMap<String, Object>();
											map.add("limitKey", "ab_deduction");
											Setting abDeduction = Constants.getRestTemplate().postForObject(Constants.url + "/getSettingByKey", map,
													Setting.class);
											int ab_deduction = Integer.parseInt(abDeduction.getValue());

											session.setAttribute("amount_round", amount_round);
											session.setAttribute("ab_deduction", ab_deduction);

											map = new LinkedMultiValueMap<String, Object>();
											map.add("group", "PAYROLLHIDESHOW");
											Setting[] setting = Constants.getRestTemplate().postForObject(Constants.url + "/getSettingListByGroup", map,
													Setting[].class);
											List<Setting> settingList = new ArrayList<>(Arrays.asList(setting));

											int payroll_claim_show = 0;
											int payroll_advance_show = 0;
											int payroll_loan_show = 0;
											int payroll_payded_show = 0;
											int payroll_reward_show = 0;
											int payroll_bhatta_show = 0;

											for (int k = 0; k < settingList.size(); k++) {
												if (settingList.get(k).getKey().equalsIgnoreCase("payroll_claim_show")) {
													payroll_claim_show = Integer.parseInt(settingList.get(k).getValue());
												} else if (settingList.get(k).getKey().equalsIgnoreCase("payroll_advance_show")) {
													payroll_advance_show = Integer.parseInt(settingList.get(k).getValue());
												} else if (settingList.get(k).getKey().equalsIgnoreCase("payroll_loan_show")) {
													payroll_loan_show = Integer.parseInt(settingList.get(k).getValue());
												} else if (settingList.get(k).getKey().equalsIgnoreCase("payroll_payded_show")) {
													payroll_payded_show = Integer.parseInt(settingList.get(k).getValue());
												} else if (settingList.get(k).getKey().equalsIgnoreCase("payroll_reward_show")) {
													payroll_reward_show = Integer.parseInt(settingList.get(k).getValue());
												} else if (settingList.get(k).getKey().equalsIgnoreCase("payroll_bhatta_show")) {
													payroll_bhatta_show = Integer.parseInt(settingList.get(k).getValue());
												}
											}
											session.setAttribute("payroll_claim_show", payroll_claim_show);
											session.setAttribute("payroll_advance_show", payroll_advance_show);
											session.setAttribute("payroll_loan_show", payroll_loan_show);
											session.setAttribute("payroll_payded_show", payroll_payded_show);
											session.setAttribute("payroll_reward_show", payroll_reward_show);
											session.setAttribute("payroll_bhatta_show", payroll_bhatta_show);
										%>
										<tr class="bg-blue">

											<th width="5%" class="text-center">Sr.no</th>
											<th width="5%" class="text-center">All <input
												type="checkbox" name="selectAll" id="selectAll"></th>
											<th class="text-center">Full Salary Slip</th>
											<th class="text-center">EMP Code</th>
											<th class="text-center">EMP Name</th>
											<th class="text-center">EMP Type</th>
											<th class="text-center">Department</th>
											<th class="text-center">Designation</th>
											<th class="text-center">Payable Days</th>
											<th class="text-center">Gross Salary</th>
											<th class="text-center">Basic</th>
											<%
												if (mnth != "" && mnth != null) {

													int locId = (int) session.getAttribute("liveLocationId");

													map = new LinkedMultiValueMap<String, Object>();
													map.add("month", request.getAttribute("month"));
													map.add("year", request.getAttribute("year"));
													map.add("companyId", request.getAttribute("companyId"));
													map.add("locId", locId);
													//System.out.println(map);
													PayRollDataForProcessing payRollDataForProcessing = Constants.getRestTemplate()
															.postForObject(Constants.url + "/getPayrollGenratedList", map, PayRollDataForProcessing.class);
													list = payRollDataForProcessing.getPayrollGeneratedList();

													session.setAttribute("payRollDataForProcessing", payRollDataForProcessing);

													session.setAttribute("monthAndYear",
															request.getAttribute("month") + "-" + request.getAttribute("year"));
													allowancelist = payRollDataForProcessing.getAllowancelist();

													//System.out.println(list);

												} else {
													Allowances[] allowances = Constants.getRestTemplate().getForObject(Constants.url + "/getAllAllowances",
															Allowances[].class);
													allowancelist = new ArrayList<>(Arrays.asList(allowances));
												}
											%>
											<%
												for (int i = 0; i < allowancelist.size(); i++) {
											%><th class="text-center"
												title="<%out.println(allowancelist.get(i).getName());%>">
												<%
													out.println(allowancelist.get(i).getName());
												%>
											</th>
											<%
												}
											%>
											<%
												if (ab_deduction == 1) {
											%><th class="text-center">Absent Deduction</th>
											<%
												}
											%>

											<th class="text-center">Gross Earning</th>
											<%
												if (payroll_claim_show == 1) {
											%><th class="text-center">Claim ADD</th>
											<%
												}
											%>
											<th class="text-center">Production Incentive</th>
											<th class="text-center">Performance Incentive <!-- (OT AMT) --></th>
											<th class="text-center">Night Allowance</th>
											<th class="text-center">Performance Bonus</th>
											<%
												if (payroll_bhatta_show == 1) {
											%>
											<th class="text-center">BHATTA</th>
											<%
												}
											%>
											<th class="text-center">Other1</th>
											<%
												if (payroll_reward_show == 1) {
											%><th class="text-center">Reward</th>
											<%
												}
											%>
											<%
												if (payroll_advance_show == 1) {
											%><th class="text-center">Adv</th>
											<%
												}
											%>
											<%
												if (payroll_loan_show == 1) {
											%><th class="text-center">Loan</th>
											<%
												}
											%>

											<th class="text-center">TDS</th>
											<%
												if (payroll_payded_show == 1) {
											%><th class="text-center">Pay Ded</th>
											<%
												}
											%>

											<th class="text-center">PT</th>
											<th class="text-center">PF</th>
											<th class="text-center">ESIC</th>
											<th class="text-center">LWF</th>
											<!-- <th class="text-center">Society Contribution</th> -->
											<th class="text-center">Deduction AMT</th>
											<th class="text-center">Net Salary</th>

										</tr>

									</thead>

									<tbody>
										<%
											try {

												if (mnth != "" && mnth != null) {

													for (int i = 0; i < list.size(); i++) {
										%><tr>
											<td>
												<%
													out.println(i + 1);
												%>
											</td>
											<td><input type="checkbox" name="selectEmp"
												id="selectEmp<%out.println(list.get(i).getEmpId());%>"
												value="<%out.println(list.get(i).getEmpId());%>"></td>
											<td class="text-center"><a target="_blank"
												href="${pageContext.request.contextPath}/pdfForReport?url=/pdf/generatedFullPayslip/<%out.println(list.get(i).getEmpId());%>/${date}"
												class="list-icons-item text-primary-600"
												data-popup="tooltip" title=""
												data-original-title="Full Slip PDF"><i
													class="fa fa-file"></i></a></td>
											<td>
												<%
													out.println(list.get(i).getEmpCode());
												%>
											</td>
											<td>
												<%
													out.println(list.get(i).getName());
												%>
											</td>
											<td>
												<%
													out.println(list.get(i).getEmpTypeName());
												%>
											</td>
											<td>
												<%
													out.println(list.get(i).getDepartName());
												%>
											</td>
											<td>
												<%
													out.println(list.get(i).getDesignName());
												%>
											</td>

											<td class="text-right">
												<%
													out.println(list.get(i).getPayableDays());
												%>
											</td>
											<td class="text-right">
												<%
													out.println(list.get(i).getGrossSalDefault());
												%>
											</td>
											<td class="text-right">
												<%
													out.println(String.format("%.2f",
																		ReportCostants.castNumber(list.get(i).getBasicCal(), amount_round)));
												%>
											</td>


											<%
												for (int k = 0; k < allowancelist.size(); k++) {

																int find = 0;
											%><td class="text-right">
												<%
													for (int j = 0; j < list.get(i).getPayrollAllownceList().size(); j++) {
																		if (list.get(i).getPayrollAllownceList().get(j).getAllowanceId() == allowancelist.get(k)
																				.getAllowanceId()) {
																			out.println(String.format("%.2f",
																					ReportCostants.castNumber(
																							list.get(i).getPayrollAllownceList().get(j).getAllowanceValueCal(),
																							amount_round)));
																			find = 1;
																			break;

																		}
																	}
																	if (find == 0) {
																		out.println(String.format("%.2f", ReportCostants.castNumber(0, amount_round)));
																	}
												%>
											</td>
											<%
												}
											%>

											<%
												if (ab_deduction == 1) {
											%><td class="text-right">
												<%
													out.println(String.format("%.2f",
																			ReportCostants.castNumber(list.get(i).getAbDeduction(), amount_round)));
												%>
											</td>
											<%
												}
											%>

											<td class="text-right">
												<%
													out.println(String.format("%.2f",
																		ReportCostants.castNumber(list.get(i).getGrossSalary(), amount_round)));
												%>
											</td>

											<%
												if (payroll_claim_show == 1) {
											%><td class="text-right">
												<%
													out.println(String.format("%.2f",
																			ReportCostants.castNumber(list.get(i).getMiscExpAdd(), amount_round)));
												%>
											</td>
											<%
												}
											%>
											<td class="text-right">
												<%
													out.println(String.format("%.2f",
																		ReportCostants.castNumber(list.get(i).getOtWages(), amount_round)));
												%>
											</td>
											<td class="text-right">
												<%
													out.println(String.format("%.2f",
																		ReportCostants.castNumber(list.get(i).getProductionInsentive(), amount_round)));
												%>
											</td>
											<td class="text-right">
												<%
													out.println(String.format("%.2f",
																		ReportCostants.castNumber(list.get(i).getNightAllow(), amount_round)));
												%>
											</td>
											<td class="text-right">
												<%
													out.println(String.format("%.2f",
																		ReportCostants.castNumber(list.get(i).getPerformanceBonus(), amount_round)));
												%>
											</td>
											<%
												if (payroll_bhatta_show == 1) {
											%><td class="text-right">
												<%
													out.println(String.format("%.2f",
																			ReportCostants.castNumber(list.get(i).getBhatta(), amount_round)));
												%>
											</td>
											<%
												}
											%>
											<td class="text-right">
												<%
													out.println(String.format("%.2f",
																		ReportCostants.castNumber(list.get(i).getOther1(), amount_round)));
												%>
											</td>
											<%
												if (payroll_reward_show == 1) {
											%><td class="text-right">
												<%
													out.println(String.format("%.2f",
																			ReportCostants.castNumber(list.get(i).getReward(), amount_round)));
												%>
											</td>
											<%
												}
											%>

											<%
												if (payroll_advance_show == 1) {
											%><td class="text-right">
												<%
													out.println(String.format("%.2f",
																			ReportCostants.castNumber(list.get(i).getAdvanceDed(), amount_round)));
												%>
											</td>
											<%
												}
											%>

											<%
												if (payroll_loan_show == 1) {
											%><td class="text-right">
												<%
													out.println(String.format("%.2f",
																			ReportCostants.castNumber(list.get(i).getLoanDed(), amount_round)));
												%>
											</td>
											<%
												}
											%>

											<td class="text-right">
												<%
													out.println(
																		String.format("%.2f", ReportCostants.castNumber(list.get(i).getItded(), amount_round)));
												%>
											</td>

											<%
												if (payroll_payded_show == 1) {
											%><td class="text-right">
												<%
													out.println(String.format("%.2f",
																			ReportCostants.castNumber(list.get(i).getPayDed(), amount_round)));
												%>
											</td>
											<%
												}
											%>

											<td class="text-right">
												<%
													out.println(
																		String.format("%.2f", ReportCostants.castNumber(list.get(i).getPtDed(), amount_round)));
												%>
											</td>
											<td class="text-right">
												<%
													out.println(String.format("%.2f",
																		ReportCostants.castNumber(list.get(i).getEmployeePf(), amount_round)));
												%>
											</td>
											<td class="text-right">
												<%
													out.println(
																		String.format("%.2f", ReportCostants.castNumber(list.get(i).getEsic(), amount_round)));
												%>
											</td>
											<td class="text-right">
												<%
													out.println(
																		String.format("%.2f", ReportCostants.castNumber(list.get(i).getMlwf(), amount_round)));
												%>
											</td>
											<%-- <td class="text-right">
												<%
													out.println(String.format("%.2f",
																		ReportCostants.castNumber(list.get(i).getSocietyContribution(), amount_round)));
												%>
											</td> --%>
											<td class="text-right">
												<%
													double finalDed = list.get(i).getAdvanceDed() + list.get(i).getLoanDed()
																		+ list.get(i).getItded() + list.get(i).getPayDed() + list.get(i).getPtDed()
																		+ list.get(i).getEmployeePf() + list.get(i).getEsic() + list.get(i).getMlwf()
																		+ list.get(i).getSocietyContribution();
																out.println(String.format("%.2f", ReportCostants.castNumber(finalDed, amount_round)));
												%>
											</td>

											<td class="text-right">
												<%
													out.println(String.format("%.2f",
																		ReportCostants.castNumber(list.get(i).getNetSalary(), amount_round)));
												%>
											</td>

										</tr>
										<%
											}
												}
											} catch (Exception e) {
												e.printStackTrace();
											}
										%>

									</tbody>
								</table>
							</div>
							<span class="validation-invalid-label" id="error_emp"
								style="display: none;">Select Minimum one employee.</span>
							<c:if test="${date!=null}">
								<%
									if (list.size() > 0) {
								%>
								<br>
								<div class="text-center">

									<button type="button" class="btn blue_btn ml-3 legitRipple"
										id="payslip" onclick="commonPdf()">Pay slip</button>
									<button type="button" class="btn blue_btn ml-3 legitRipple"
										id="salarydetail" onclick="salaryDetailPdf()">Salary
										Detail</button>
									<button type="button" class="btn blue_btn ml-3 legitRipple"
										id="excel"
										onclick="getProgReport(0,'excelForGeneratedPayroll')">
										Excel</button>
								</div>
								<%
									}
								%>
							</c:if>
						</form>
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
	<script type="text/javascript">
		//use this function for all reports just get mapping form action name dynamically as like of prm from every report pdf,excel function	
		function getProgReport(prm, mapping) {

			var checkboxes = document.getElementsByName('selectEmp');
			var vals = "0";
			for (var i = 0; i < checkboxes.length; i++) {
				if (checkboxes[i].checked) {
					vals = vals + "," + checkboxes[i].value;
				}
			}
			/* if (vals)
				vals = vals.substring(1); */

			window.open("${pageContext.request.contextPath}/" + mapping + "/"
					+ vals + "/", "_blank");

		}
	</script>

	<script type="text/javascript">
		function commonPdf() {
			$("#error_emp").hide();
			var selectMonth = document.getElementById("datepicker").value;
			var list = [];

			$("input:checkbox[name=selectEmp]:checked").each(function() {
				list.push($(this).val());
			});

			if (list.length > 0) {
				window.open('pdfForReport?url=/pdf/generatedPayrollPdf/' + list
						+ '/' + selectMonth);
			} else {
				$("#error_emp").show();
			}

		}
		function salaryDetailPdf() {
			$("#error_emp").hide();
			var selectMonth = document.getElementById("datepicker").value;
			var list = [];

			$("input:checkbox[name=selectEmp]:checked").each(function() {
				list.push($(this).val());
			});

			if (list.length > 0) {
				window.open('pdfForReport?url=/pdf/generatedSalaryDetailPdf/'
						+ list + '/' + selectMonth);
			} else {
				$("#error_emp").show();
			}

		}
	</script>

	<script type="text/javascript">
		// Single picker
		/* $(function() {
			$("#datepicker").datepicker({
				changeMonth : true,
				changeYear : true,
				yearRange : "-50:+50",
				dateFormat : "mm-yy"
			});
		}); */

		$('#selectAll').click(function(event) {
			if (this.checked) {
				// Iterate each checkbox
				$(':checkbox').each(function() {
					this.checked = true;
				});
			} else {
				$(':checkbox').each(function() {
					this.checked = false;
				});
			}
		});
	</script>


	<script type="text/javascript">
		// Single picker
		/* $("#datepicker").datepicker({
			changeMonth : true,
			changeYear : true,
			yearRange : "-50:+50",
			dateFormat : "mm-yy"
		}); */

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
		$(document).ready(function() {
			// month selector
			$('#datepicker').datepicker({
				autoclose : true,
				format : "mm-yyyy",
				viewMode : "months",
				minViewMode : "months"

			});

		});
	</script>
</body>
</html>
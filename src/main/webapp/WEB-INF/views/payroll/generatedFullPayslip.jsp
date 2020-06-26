<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Payment Slip</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->


<style type="text/css">
table {
	border-color: black;
	font-size: 14;
	width: 100%;
	page-break-inside: auto !important;
	display: block;
}

p {
	color: black;
	font-family: arial;
	font-size: 14;
	margin-top: 0;
	padding: 0;
	font-weight: bold;
}

.pn {
	color: black;
	font-family: arial;
	font-size: 10%;
	margin-top: 0;
	padding: 0;
	font-weight: normal;
}

h4 {
	color: black;
	font-family: sans-serif;
	font-size: 100%;
	font-weight: bold;
	padding-bottom: 10px;
	margin: 0;
}

h5 {
	color: black;
	font-family: sans-serif;
	font-size: 70%;
	font-weight: normal;
	margin: 0;
}

h6 {
	color: black;
	font-family: arial;
	font-size: 60%;
	font-weight: normal;
	margin: 10%;
}

th {
	color: black;
}

hr {
	height: 1px;
	border: none;
	color: rgb(60, 90, 180);
	background-color: rgb(60, 90, 180);
}

.invoice-box table tr.information table td {
	padding-bottom: 0px;
	align-content: center;
}

.set-height td {
	position: relative;
	overflow: hidden;
	height: 2em;
}

.set-height t {
	position: relative;
	overflow: hidden;
	height: 2em;
}

.set-height p {
	position: absolute;
	margin: .1em;
	left: 0;
	top: 0;
}
</style>

</head>
<body>


	<c:set value="0" var="index"></c:set>
	<c:forEach items="${list}" var="list" varStatus="count">

		<c:set value="${index+1}" var="index"></c:set>

		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			style="border-top: 1px solid #313131; border-right: 1px solid #313131; margin-left: 60px; margin-right: 60px; margin-top: 20px;">
			<tr>
				<td colspan="2"
					style="border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 8px; color: #000;"
					align="center"><table width="100%">

						<c:set value="" var="logo"></c:set>
						<c:set value="-" var="companyName"></c:set>
						<c:set value="-" var="longAdd1"></c:set>
						<c:forEach items="${companyList}" var="companyList">
							<c:if test="${companyList.companyId==list.subCmpId}">
								<c:set value="${companyList.logo}" var="logo"></c:set>
								<c:set value="${companyList.companyName}" var="companyName"></c:set>
								<c:set value="${companyList.longAdd1}" var="longAdd1"></c:set>
							</c:if>
						</c:forEach>
						<tr>
							<td width="22.33%"><img src="${logoUrl}${logo}" width="80"
								height="50" /></td>

							<td width="53.33%" valign="top"
								style="font-weight: bold; margin: 0px;" align="center">
								<h4 align="center" style="font-size: 16px;">${companyName}</h4>
								<h6 style="font-weight: bold; margin: 0px; font-size: 10px;"
									align="center">${longAdd1}</h6>
								<h5 style="font-weight: bold; margin: 0px; font-size: 14px;"
									align="center">Payment Slip for the month of ${monthName}
									${year}</h5>
							</td>

							<td width="22.33%" valign="top"
								style="font-weight: bold; margin: 0px;" align="right"></td>

						</tr>

					</table></td>
			</tr>


			<tr>
				<td colspan="2"
					style="border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 8px; color: #000;"
					align="center"><c:set value="-" var="pfNo"></c:set> <c:set
						value="-" var="esicNo"></c:set> <c:set value="-"
						var="cmpJoiningDate"></c:set> <c:set value="-" var="uan"></c:set>
					<c:set value="-" var="remLoanAmt"></c:set> <c:set value="-"
						var="panCardNo"></c:set> <c:set value="-" var="locName"></c:set> <c:set
						value="-" var="accNo"></c:set> <c:set value="-" var="bankName"></c:set>
					<c:forEach items="${empDetailList}" var="empDetailList">
						<c:if test="${list.empId==empDetailList.empId}">
							<c:set value="${empDetailList.pfNo}" var="pfNo"></c:set>
							<c:set value="${empDetailList.esicNo}" var="esicNo"></c:set>
							<c:set value="${empDetailList.panCardNo}" var="panCardNo"></c:set>
							<c:set value="${empDetailList.cmpJoiningDate}"
								var="cmpJoiningDate"></c:set>
							<c:set value="${empDetailList.uan}" var="uan"></c:set>
							<c:set value="${empDetailList.remLoanAmt}" var="remLoanAmt"></c:set>
							<c:set value="${empDetailList.bankName}" var="bankName"></c:set>
							<c:set value="${empDetailList.accNo}" var="accNo"></c:set>
							<c:set value="${empDetailList.locName}" var="locName"></c:set>
						</c:if>
					</c:forEach>
					<table width="100%">
						<tr>

							<td width="5%"></td>
							<td width="15%" valign="top" style="color: #000;" align="left">Name
								& Code</td>
							<td valign="top" style="color: #000;" align="left" width="40%">:
								${list.name}-${list.empCode}</td>
							<td valign="top" style="color: #000;" align="left" width="15%">Date
								of Joining</td>
							<td valign="top" style="color: #000;" align="left">:
								${cmpJoiningDate}</td>
						</tr>
						<tr>

							<td width="5%"></td>
							<td width="15%" valign="top" style="color: #000;" align="left">Designation</td>
							<td valign="top" style="color: #000;" align="left" width="40%">:
								${list.designName}</td>
							<td valign="top" style="color: #000;" align="left" width="15%">Loan
								Balance</td>
							<td valign="top" style="color: #000;" align="left">:
								${remLoanAmt}</td>
						</tr>

						<tr>
							<td width="5%"></td>
							<td width="15%" valign="top" style="color: #000;" align="left">Department</td>
							<td valign="top" style="color: #000;" align="left" width="40%">:
								${list.departName}</td>
							<td valign="top" style="color: #000;" align="left" width="15%">Weekly
								Holiday</td>
							<td valign="top" style="color: #000;" align="left">:
								${list.weeklyOff}</td>
						</tr>

					</table> <br>
					<table width="100%">
						<tr>

							<td width="5%"></td>
							<td width="15%" valign="top" style="color: #000;" align="left">PF
								Number</td>
							<td valign="top" style="color: #000;" align="left" width="40%">:
								${pfNo}</td>
							<td valign="top" style="color: #000;" align="left" width="15%">Days
								worked</td>
							<td valign="top" style="color: #000;" align="left">:
								${list.presentDays}</td>
						</tr>
						<tr>

							<td width="5%"></td>
							<td width="15%" valign="top" style="color: #000;" align="left">UAN
								No.</td>
							<td valign="top" style="color: #000;" align="left" width="40%">:
								${uan}</td>
							<td valign="top" style="color: #000;" align="left" width="15%">Days
								Paid</td>
							<td valign="top" style="color: #000;" align="left">:
								${list.payableDays}</td>
						</tr>

						<tr>
							<td width="5%"></td>
							<td width="15%" valign="top" style="color: #000;" align="left">PAN
								No.</td>
							<td valign="top" style="color: #000;" align="left" width="40%">:
								${panCardNo}</td>
							<td valign="top" style="color: #000;" align="left" width="15%">Bank
								A/c No</td>
							<td valign="top" style="color: #000;" align="left">:
								${accNo}</td>
						</tr>

						<tr>
							<td width="5%"></td>
							<td width="15%" valign="top" style="color: #000;" align="left">ESIC
								No</td>
							<td valign="top" style="color: #000;" align="left" width="40%">:
								${esicNo}</td>
							<td valign="top" style="color: #000;" align="left" width="15%"></td>
							<td valign="top" style="color: #000;" align="left"></td>
						</tr>

						<tr>
							<td width="5%"></td>
							<td width="15%" valign="top" style="color: #000;" align="left">Division/Location</td>
							<td valign="top" style="color: #000;" align="left" width="40%">:
								${locName}</td>
							<td valign="top" style="color: #000;" align="left" width="15%"></td>
							<td valign="top" style="color: #000;" align="left"></td>
						</tr>
						<tr>
							<td width="5%"></td>
							<td width="15%" valign="top" style="color: #000;" align="left">Bank
								Name</td>
							<td valign="top" style="color: #000;" align="left" width="40%">:
								${bankName}</td>
							<td valign="top" style="color: #000;" align="left" width="15%"></td>
							<td valign="top" style="color: #000;" align="left"></td>
						</tr>
					</table></td>
			</tr>
			<tr>
				<td
					style="border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 8px; color: #000;"
					align="center" valign="top"><c:set var="rateTotal" value="0"></c:set>
					<c:set var="earningTotal" value="0"></c:set>
					<table width="100%"
						style="border-top: 1px solid #313131; border-right: 1px solid #313131; border-left: 1px solid #313131; border-bottom: 1px solid #313131;">
						<tr>
							<th width="33.33%" valign="top"
								style="color: #000; border-right: 1px solid #313131; border-bottom: 1px solid #313131;"
								align="center">PAY HEAD</th>

							<th width="33.33%" valign="top"
								style="color: #000; border-right: 1px solid #313131; border-bottom: 1px solid #313131;"
								align="center">RATE</th>
							<th width="33.33%" valign="top"
								style="color: #000; border-bottom: 1px solid #313131;"
								align="center">EARNINGS</th>


						</tr>
						<c:set var="rateTotal" value="${rateTotal+list.basicDefault}"></c:set>
						<c:set var="earningTotal" value="${earningTotal+list.basicCal}"></c:set>
						<tr>
							<td valign="top"
								style="color: #000; border-right: 1px solid #313131; padding-left: 5px;"
								align="left">Basic</td>
							<td valign="top"
								style="color: #000; border-right: 1px solid #313131; padding-right: 5px;"
								align="right">${list.basicDefault}</td>
							<td valign="top"
								style="color: #000; padding-left: 5px; padding-right: 5px;"
								align="right">${list.basicCal}</td>

						</tr>
						<c:forEach items="${list.payrollAllownceList}"
							var="payrollAllownceList">

							<c:set var="rateTotal"
								value="${rateTotal+payrollAllownceList.allowanceValue}"></c:set>
							<c:set var="earningTotal"
								value="${earningTotal+payrollAllownceList.allowanceValueCal}"></c:set>
							<tr>
								<td valign="top"
									style="color: #000; border-right: 1px solid #313131; padding-left: 5px;"
									align="left">${payrollAllownceList.shortName}</td>

								<td valign="top"
									style="color: #000; border-right: 1px solid #313131; padding-right: 5px;"
									align="right">${payrollAllownceList.allowanceValue}</td>
								<td valign="top"
									style="color: #000; padding-left: 5px; padding-right: 5px;"
									align="right">${payrollAllownceList.allowanceValueCal}</td>
							</tr>
						</c:forEach>

						<c:if test="${payroll_claim_show==1}">
							<tr>
								<td valign="top"
									style="color: #000; border-right: 1px solid #313131; padding-left: 5px;"
									align="left">Claim ADD</td>
								<td valign="top"
									style="color: #000; border-right: 1px solid #313131; padding-right: 5px;"
									align="right">-</td>
								<td valign="top"
									style="color: #000; padding-left: 5px; padding-right: 5px;"
									align="right">${list.miscExpAdd}</td>

							</tr>

							<c:set var="earningTotal" value="${earningTotal+list.miscExpAdd}"></c:set>
						</c:if>

						<tr>
							<td valign="top"
								style="color: #000; border-right: 1px solid #313131; padding-left: 5px;"
								align="left">Performance Bonus</td>
							<td valign="top"
								style="color: #000; border-right: 1px solid #313131; padding-right: 5px;"
								align="right">-</td>
							<td valign="top"
								style="color: #000; padding-left: 5px; padding-right: 5px;"
								align="right">${list.performanceBonus}</td>
							<c:set var="earningTotal"
								value="${earningTotal+list.performanceBonus}"></c:set>
						</tr>

						<tr>
							<td valign="top"
								style="color: #000; border-right: 1px solid #313131; padding-left: 5px;"
								align="left">Production Incentive</td>
							<td valign="top"
								style="color: #000; border-right: 1px solid #313131; padding-right: 5px;"
								align="right">-</td>
							<td valign="top"
								style="color: #000; padding-left: 5px; padding-right: 5px;"
								align="right">${list.otWages}</td>
							<c:set var="earningTotal" value="${earningTotal+list.otWages}"></c:set>
						</tr>
						<tr>
							<td valign="top"
								style="color: #000; border-right: 1px solid #313131; padding-left: 5px;"
								align="left">Performance Incentive</td>
							<td valign="top"
								style="color: #000; border-right: 1px solid #313131; padding-right: 5px;"
								align="right">-</td>
							<td valign="top"
								style="color: #000; padding-left: 5px; padding-right: 5px;"
								align="right">${list.productionInsentive}</td>
							<c:set var="earningTotal"
								value="${earningTotal+list.productionInsentive}"></c:set>
						</tr>

						<c:if test="${payroll_reward_show==1}">
							<tr>
								<td valign="top"
									style="color: #000; border-right: 1px solid #313131; padding-left: 5px;"
									align="left">Reward</td>
								<td valign="top"
									style="color: #000; border-right: 1px solid #313131; padding-right: 5px;"
									align="right">-</td>
								<td valign="top"
									style="color: #000; padding-left: 5px; padding-right: 5px;"
									align="right">${list.reward}</td>
								<c:set var="earningTotal" value="${earningTotal+list.reward}"></c:set>
							</tr>
						</c:if>

						<tr>
							<td valign="top"
								style="color: #000; border-right: 1px solid #313131; padding-left: 5px;"
								align="left">Night Allowance</td>
							<td valign="top"
								style="color: #000; border-right: 1px solid #313131; padding-right: 5px;"
								align="right">-</td>
							<td valign="top"
								style="color: #000; padding-left: 5px; padding-right: 5px;"
								align="right">${list.nightAllow}</td>
							<c:set var="earningTotal" value="${earningTotal+list.nightAllow}"></c:set>
						</tr>
						<tr>
							<th width="33.33%" valign="top"
								style="color: #000; border-right: 1px solid #313131; border-top: 1px solid #313131;"
								align="center">TOTAL</th>

							<th width="33.33%" valign="top"
								style="color: #000; border-right: 1px solid #313131; border-top: 1px solid #313131;"
								align="right">${rateTotal}</th>
							<th width="33.33%" valign="top"
								style="color: #000; border-top: 1px solid #313131;"
								align="right">${earningTotal}</th>


						</tr>
					</table> <br> <c:set var="deductTotal" value="0"></c:set>
					<table width="100%"
						style="border-top: 1px solid #313131; border-right: 1px solid #313131; border-left: 1px solid #313131; border-bottom: 1px solid #313131;">
						<tr>

							<th width="50%" valign="top"
								style="color: #000; border-right: 1px solid #313131; border-bottom: 1px solid #313131;"
								align="center">DEDUCTION HEAD</th>
							<th width="50%" valign="top"
								style="color: #000; border-bottom: 1px solid #313131;"
								align="center">DEDUCTION</th>
						</tr>
						<c:set var="deductTotal" value="${deductTotal+list.employeePf}"></c:set>
						<tr>
							<td valign="top"
								style="color: #000; border-right: 1px solid #313131; padding-left: 5px;"
								align="left">PROVIDENT FUND</td>

							<td valign="top"
								style="color: #000; padding-left: 5px; padding-right: 5px;"
								align="right">${list.employeePf}</td>

						</tr>
						<tr>
							<td valign="top"
								style="color: #000; border-right: 1px solid #313131; padding-left: 5px;"
								align="left">PROF TAX</td>

							<td valign="top"
								style="color: #000; padding-left: 5px; padding-right: 5px;"
								align="right">${list.ptDed}</td>

						</tr>
						<c:set var="deductTotal" value="${deductTotal+list.ptDed}"></c:set>
						<tr>
							<td valign="top"
								style="color: #000; border-right: 1px solid #313131; padding-left: 5px;"
								align="left">ESIC</td>

							<td valign="top"
								style="color: #000; padding-left: 5px; padding-right: 5px;"
								align=right>${list.esic}</td>

						</tr>
						<c:set var="deductTotal" value="${deductTotal+list.esic}"></c:set>
						<tr>
							<td valign="top"
								style="color: #000; border-right: 1px solid #313131; padding-left: 5px;"
								align="left">MLWF</td>

							<td valign="top"
								style="color: #000; padding-left: 5px; padding-right: 5px;"
								align="right">${list.mlwf}</td>

						</tr>
						<c:set var="deductTotal" value="${deductTotal+list.mlwf}"></c:set>
						<c:if test="${payroll_advance_show==1}">
							<tr>

								<td valign="top"
									style="color: #000; border-right: 1px solid #313131; padding-left: 5px;"
									align="left">ADVANCE</td>

								<td valign="top"
									style="color: #000; padding-left: 5px; padding-right: 5px;"
									align="right">${list.advanceDed}</td>

							</tr>
							<c:set var="deductTotal" value="${deductTotal+list.advanceDed}"></c:set>
						</c:if>
						<tr>
							<td valign="top"
								style="color: #000; border-right: 1px solid #313131; padding-left: 5px;"
								align="left">TDS</td>

							<td valign="top"
								style="color: #000; padding-left: 5px; padding-right: 5px;"
								align="right">${list.itded}</td>

						</tr>
						<c:set var="deductTotal" value="${deductTotal+list.itded}"></c:set>
						<c:if test="${payroll_loan_show==1}">
							<tr>
								<td valign="top"
									style="color: #000; border-right: 1px solid #313131; padding-left: 5px;"
									align="left">LOAN</td>

								<td valign="top"
									style="color: #000; padding-left: 5px; padding-right: 5px;"
									align="right">${list.loanDed}</td>

							</tr>
							<c:set var="deductTotal" value="${deductTotal+list.loanDed}"></c:set>
						</c:if>
						<c:if test="${payroll_payded_show==1}">
							<tr>
								<td valign="top"
									style="color: #000; border-right: 1px solid #313131; padding-left: 5px;"
									align="left">PAY DED</td>

								<td valign="top"
									style="color: #000; padding-left: 5px; padding-right: 5px;"
									align="right">${list.payDed}</td>

							</tr>
							<c:set var="deductTotal" value="${deductTotal+list.payDed}"></c:set>
						</c:if>
						<tr>
							<th valign="top"
								style="color: #000; border-right: 1px solid #313131; border-top: 1px solid #313131; padding-left: 5px;"
								align="left">TOTAL</th>

							<th valign="top"
								style="color: #000; padding-left: 5px; border-top: 1px solid #313131; padding-right: 5px;"
								align="right">${deductTotal}</th>


						</tr>
					</table> <br>
					<p style="color: #000;" align="left">Net Payable :
						${list.netSalary} (Rupees ${list.moneyInword} Only)</p>
					<p style="color: #000;" align="left">Transfered into BANK
						A/c.No. : ${accNo}</p></td>

			</tr>
			<tr>
				<td colspan="2"
					style="border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 2px; color: #000;"
					align="center">
					<table width="100%">
						<tr>
							<td style="color: #000; text-transform: capitalize;"><p
									style="color: #000;" align="center">THIS IS A COMPUTER
									GENERATED PAYSLIP, NOT REQUIRING SIGNATURE</p></td>


						</tr>

					</table>
				</td>
			</tr>
		</table>

		<!-- END Main Content -->
		<br>

		<c:if test="${index==2}">
			<c:set value="0" var="index"></c:set>
			<div style="page-break-after: always;"></div>
		</c:if>

	</c:forEach>
</body>
</html>
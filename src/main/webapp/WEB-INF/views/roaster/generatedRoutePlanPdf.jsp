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
<title>Route Plan List</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->


<style type="text/css">
table {
	border-color: black;
	font-size: 16;
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


	<c:set value="${index+1}" var="index"></c:set>

	<table width="100%" border="0" cellpadding="0" cellspacing="0"
		style="border-top: 0px solid #313131; border-right: 0px solid #313131; margin-left: 60px; margin-right: 60px; margin-top: 20px;">
		<tr>
			<td colspan="2"
				style="border-left: 0px solid #313131; border-bottom: 0px solid #313131; padding: 8px; color: #000;"
				align="center"><table width="100%">

					<%-- <c:set value="" var="logo"></c:set>
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

						</tr> --%>
					<tr>
						<td width="22.33%"><img src="${logoUrl}${logo}" width="80"
							height="50" /></td>

						<td width="53.33%" valign="top"
							style="font-weight: bold; margin: 0px;" align="center">
							<h4 style="font-weight: bold; margin: 0px; font-size: 14px;"
								align="center">Route Plan List</h4>
						</td>

						<td width="22.33%" valign="top"
							style="font-weight: bold; margin: 0px;" align="right"></td>

					</tr>
				</table></td>
		</tr>

	</table>


	<table width="100%" border="0" cellpadding="0" cellspacing="0"
		style="border-top: 1px solid #313131; border-right: 1px solid #313131; margin-left: 60px; margin-right: 20px; margin-top: 0px;">

		<tr>
			<th align="center"
				style="border-bottom: 1px solid #313131; border-left: 1px solid #313131;"
				valign="top" width="10%">SR. No.</th>
			<th align="center"
				style="border-bottom: 1px solid #313131; border-left: 1px solid #313131;"
				valign="top" width="15%">Date</th>
			<th align="center"
				style="border-bottom: 1px solid #313131; border-left: 1px solid #313131;"
				valign="top">Driver Name</th>
			<th align="center"
				style="border-bottom: 1px solid #313131; border-left: 1px solid #313131;"
				valign="top">Duty</th>

		</tr>
		<c:forEach items="${list}" var="list" varStatus="count">
			<tr>
				<td
					style="border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 5px;"
					valign="top" width="10%" align="center">${count.index+1}</td>
				<td
					style="border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 5px;"
					valign="top" width="15%" align="center">${date}</td>
				<td
					style="border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 5px;"
					valign="top">${list.firstName}&nbsp;${list.surname}</td>
				<td
					style="border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 5px;"
					valign="top"><c:choose>
						<c:when test="${list.routeId!=0}">${list.routeName}</c:when>
						<c:when test="${list.isoffdayIsff==1}">Off Day</c:when>
						<c:when test="${list.isoffdayIsff==2}">FF</c:when>
						<c:otherwise>NA</c:otherwise>
					</c:choose></td>
			</tr>
		</c:forEach>


	</table>

	<!-- END Main Content -->
</body>
</html>
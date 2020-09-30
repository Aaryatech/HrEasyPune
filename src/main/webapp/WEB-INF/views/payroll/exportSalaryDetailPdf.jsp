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
<title>SALARY DETAIL</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->


<style type="text/css">
table {
	border-collapse: collapse;
	font-size: 12;
	width: 100%;
	page-break-inside: auto !important
}

p {
	color: black;
	font-family: arial;
	font-size: 60%;
	margin-top: 0;
	padding: 0;
}

h6 {
	color: black;
	font-family: arial;
	font-size: 80%;
}

th {
	background-color: #EA3291;
	color: white;
}
</style>

</head>
<body>
	<!-- <h3 align="center">Galdhar Foods Pvt Ltd</h3>
	<p align="center">A-89, Shendra M.I.D.C., Aurangabad</p> -->
	<div align="center">
		<h5>SALARY DETAIL</h5>
	</div>
	<table align="center" border="1" cellspacing="0" cellpadding="1"
		id="table_grid" class="table table-bordered">

		<thead>
			<tr class="bgpink">
				<th>Sr.No.</th>
				<th>Name (Code)</th>
				<th>Basic</th>
				<c:forEach items="${allownceList}" var="allownceList">
					<th>${allownceList.name}</th>
				</c:forEach>
				<th>Gross</th>
			</tr>
		</thead>
		<tbody>



			<c:forEach items="${list}" var="list" varStatus="count">
				<tr>
					<td align="center"><c:out value="${count.index+1}" /></td>
					<td>${list.firstName}<br>${list.surname}<br>
						(${list.empCode})
					</td>
					<td align="right"><fmt:formatNumber type="number"
							maxFractionDigits="2" value="${list.woCatName}" /></td>
					<c:forEach items="${allownceList}" var="allownceList">
						<c:set var="find" value="0"></c:set>
						<c:forEach items="${alloList}" var="alloList">
							<c:if
								test="${alloList.empId==list.empId && allownceList.allowanceId==alloList.allowanceId}">
								<td align="right"><fmt:formatNumber type="number"
										maxFractionDigits="2" value="${alloList.allowanceValue}" /></td>
								<c:set var="find" value="1"></c:set>
							</c:if>
						</c:forEach>
						<c:if test="${find==0}">
							<td align="right"><fmt:formatNumber type="number"
									maxFractionDigits="2" value="0" /></td>

						</c:if>
					</c:forEach>
					<td align="right"><fmt:formatNumber type="number"
							maxFractionDigits="2" value="${list.grossSalary}" /></td>
				</tr>

			</c:forEach>
		</tbody>
	</table>

	<!-- END Main Content -->

</body>
</html>
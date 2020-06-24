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
<title>Experience Letter</title>
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
	font-family: arial;
	padding: 0;
	margin-left: 60px;
	margin-right: 0px;
	text-align: justify;
	font-size: 18px;
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
	<!-- border-top: 1px solid #313131; border-right: 1px solid #313131; border-left: 1px solid #313131; -->
	<table width="100%"
		style="margin-left: 0px; margin-right: 0px; margin-top: 20px;">
		<tr>
			<td colspan="2" align="center"><table width="100%">



					<tr>
						<td width="100%">
							<p style="color: #000; margin-top: 70px;">Date-${date}</p>
						</td>

					</tr>

					<tr>
						<td width="100%">
							<p
								style="color: #000; text-align: center; text-decoration: underline; line-height: 50px; font-size: 22px;">To
								whom so ever it may concern</p>
						</td>

					</tr>

					<tr>
						<td width="100%">
							<p style="color: #000;">This is to certify that Mr./ Mrs./
								Miss. ${empDetail.firsName}&nbsp;${empDetail.surname} started
								worked as ${empDetail.subCompName} with ${cmpName} since
								${expJointDate} He worked with us for ${expYear} years and
								during this period he demonstrated himself as a dedicated person
								with good skills and abilities. He has been very helpful to us
								throughout these years. He left our organization on
								${leavingDate} We wish him all the good luck for his future
								prospects.</p>
						</td>

					</tr>
					<tr>
						<td width="100%">
							<p style="color: #000;"></p>
						</td>

					</tr>

				</table></td>
		</tr>

	</table>

</body>
</html>
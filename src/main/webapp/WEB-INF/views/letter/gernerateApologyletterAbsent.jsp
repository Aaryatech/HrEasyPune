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
<title>Apology Letter - Absent</title>
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
	margin-left: 30px;
	margin-right: 30px;
	text-align: justify;
	font-size: 26px;
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
		style="margin-left: 0px; margin-right: 60px; margin-top: 20px;">
		<tr>
			<td colspan="2" align="center"><table width="100%">

					<tr>
						<td width="100%"><p style="color: #000;">
								प्रति,<br>एच. आर इन्चार्ज<br> गलधर फूड्स, औरंगाबाद.<br>
							</p> <br></td>

					</tr>

					<tr>
						<td width="100%"><p style="color: #000;">विषय- गैरहजर
								असल्याबद्दल माफीनामा</p></td>

					</tr>

					<tr>
						<td width="100%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<p style="color: #000;">
								आदरणीय सर,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; मी
								${empDetail.firsName}&nbsp;${empDetail.surname} ,<br>
								${empDetail.deptName} या डिपार्टमेंट मध्ये काम करीत आहे. <br>मी
								${fromdate} या तारखेपासून तर ${toDate} या तारखेपर्यंत
								${noOfDays} दिवस न सांगता गैरहजर होतो .हि पूर्णपणे माझी चूक आहे
								व मला मान्य आहे.यानंतर अशी चूक पुन्हा केल्यास व्यवस्थापन
								माझ्याबद्दल जो निर्णय घेईल तो मला मान्य असेल. या वेळेस मला माफ
								करावे हि नम्र विनंती.
							</p>
						</td>

					</tr>
					<tr>
						<td width="100%">
							<p style="color: #000;">
								नाव - ${empDetail.firsName}&nbsp;${empDetail.surname} <br>
								<br>दिनांक - ${date} <br> <br>सही--
							</p>
						</td>

					</tr>

				</table></td>
		</tr>

	</table>

</body>
</html>
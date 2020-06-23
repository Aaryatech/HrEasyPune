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
<title>Cash Received Letter</title>
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
							<p style="color: #000;">
								मी ${empDetail.firsName}&nbsp;${empDetail.surname},<br> रा.
								${city}, दि.${fromdate}, या दिवसा पासून ${contractorName},
								(प्रॉप- ${ownerName}) या लेबर कॉन्ट्रॅक्ट कंपनीत काम करीत आहे व
								मी नौकरी ${noOfMonth} महिने न सोडण्याची हमी देतो . मी ज्या
								कंपनीत नैकारी ,काम करणार आहे त्या कंपनीत ${designationAs} म्हणून
								काम करणार आहे, ${noOfMonth} महिन्या आधी मला काम सोडता येणार नाही
								व तसे केल्यास माझा एक महिन्याचा पगार कापण्यात यावा. ${noOfMonth}
								महिने झाल्यानंतर मी काम सोडण्यासाठी एक महिन्याची नोटीस देईन व
								नोटीस नाही दिली तर माझा ${noticeMonth} महिन्याचा पगार कापावा .
								माझा पगार नेहमी पुढील महिन्याच्या ${payDate} तारखेलाच होणार. मी
								कुठल्याही शिफ्ट मध्ये काम करण्यास तयार आहे .वरील प्रमाणे शिस्त
								पाळली नाही(न सांगता सुट्टी मारणे, फोन बंद ठेवणे,फोन न
								उचलने,कोणतेही बेकायदेशीर काम केल्यास)तर मला कंपणी बंद करेल व
								माझा पगार मिळणार नाही, तसेच माझ्यावर कायदेशीर कारवाई करावी. मी
								आजारी पणा मुले सुट्टी मारली तर मला डॉक्टरांचे मेडिकल सर्टिफिकेट
								किंवा डॉक्टरांचे गोळ्या औषधांची चिठी आणून HR ला दाखवणे बंधन कारक
								आहे व तसे नाही केल्यास मी न सांगता सुट्टी मारली आहे असे गृहित
								धरले जाईल.कंपनीत काम करीत असताना कंपनीच्या युनिफॉर्म व दिलेल्या
								लॉकर ची पूर्ण जिम्मेदारी माझी असेल. युनिफॉर्म व लॉकर चे काही
								नुकसान झाले तर माझ्या हजेरीतून कापून घ्यावे.
							</p>
						</td>

					</tr>
					<tr>
						<td width="100%">
							<p style="color: #000;">
								सही-- <br> <br>नाव-
								${empDetail.firsName}&nbsp;${empDetail.surname} <br> <br>दिनांक
								- ${date} <br> <br>मोबाईल नंबर - ${mobileNo}

							</p>
						</td>

					</tr>

				</table></td>
		</tr>

	</table>

</body>
</html>
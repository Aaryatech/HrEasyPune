<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.UUID"%>
<%@ page import="java.security.MessageDigest"%>
<%@ page import="java.math.BigInteger"%> 
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>HR Management</title>
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/global_assets/images/companylogo.png"
	type="image/x-icon" />
<!-- Global stylesheets -->
<link
	href="https://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700,900"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath}/resources/global_assets/css/icons/icomoon/styles.min.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.min.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath}/resources/assets/css/loginstyle.css"
	rel="stylesheet" type="text/css">

<link
	href="${pageContext.request.contextPath}/resources/assets/css/bootstrap_limitless.min.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath}/resources/assets/css/layout.min.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath}/resources/assets/css/components.min.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath}/resources/assets/css/colors.min.css"
	rel="stylesheet" type="text/css">
<!-- /global stylesheets -->

<!-- Core JS files -->
<script
	src="${pageContext.request.contextPath}/resources/global_assets/js/main/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/global_assets/js/main/bootstrap.bundle.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/global_assets/js/plugins/loaders/blockui.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/global_assets/js/plugins/ui/ripple.min.js"></script>
<!-- /core JS files -->

<link
	href="https://fonts.googleapis.com/css2?family=Oxygen:wght@300;400;700&display=swap"
	rel="stylesheet">
<!-- font-family: 'Oxygen', sans-serif; -->

</head>
<style>
.login_bg {
	background-image:
		url("${pageContext.request.contextPath}/resources/global_assets/images/login_bg1.jpg");
	background-repeat: no-repeat;
	background-size: cover;
	position: relative;
	height: 100vh;
}

body1 {
	/* background-image:
		url("${pageContext.request.contextPath}/resources/global_assets/images/bg3.jpeg"); */
	background-position: center;
	background-repeat: no-repeat;
	background-size: cover;
	position: relative;
}

.no-background1 {
	background-image:
		url("${pageContext.request.contextPath}/resources/global_assets/images/bg2.jpg");
}
</style>
<body>
	<div class="login_bg">

		<div class="page_loader"></div>

		<div class="power_logo">
			<a href="https://aaryatechindia.in/" target="_blank"> <img
				src="${pageContext.request.contextPath}/resources/global_assets/images/powerd_logo.png"
				alt="">
			</a>
		</div>

		<!-- login-form -->
		<form id="form-login"  method="post">
			<%
											UUID uuid = UUID.randomUUID();
											MessageDigest md = MessageDigest.getInstance("MD5");
											byte[] messageDigest = md.digest(String.valueOf(uuid).getBytes());
											BigInteger number = new BigInteger(1, messageDigest);
											String hashtext = number.toString(16);
											session = request.getSession();
											session.setAttribute("generatedKey", hashtext);
										%>
			<input type="hidden" value="<%out.println(hashtext);%>" name="token"
				id="token"> <input type="hidden"
				value="${sessionScope.userEmail}" name="userEmail">

			<!-- forgot password form -->
			<div class="loginInner">
				<div class="login_l">
					<a href=""><img
						src="${pageContext.request.contextPath}/resources/global_assets/images/monginis1.png"
						alt=""></a>
					<p class="login_txt">
						Welcome to India’s one of most preferred bakery brand ! <span>Lets
							make Monginis a part of everybody’s celebration!!</span>
					</p>
				</div>

				<div class="login_r forgot" id="pass_form">

					<img
						src="${pageContext.request.contextPath}/resources/global_assets/images/logo_white.png"
						alt="">
					<h2 class="login_head_one">Change Password</h2>
					<div class="clr"></div>
					<!-- class="login-form" -->

					<c:if test="${sessionScope.errorPassMsg1!=null}">
						<div class="alert alert-danger">${sessionScope.errorPassMsg1}</div>

						<%
							session.removeAttribute("errorPassMsg1");
						%>
					</c:if>
					<div
						class="form-group form-group-feedback form-group-feedback-left">
						<input type="text" id="newPass" name="newPass" onkeyup="return passwordChanged();"
							class="form-control form_lgn" placeholder="Enter new Password "
							style="border-radius: 5px;">
						<div class="form-control-feedback" style="padding-left: 10px;">
							<i class="icon-envelop text-muted"></i>
						</div>
					</div>
					<span id="strength"></span> <span class="validation-invalid-label" id="error_password"
					style="display: none;">This field is required.</span>
					<div
						class="form-group form-group-feedback form-group-feedback-left">
						<input type="text" id="newConfPass" name="newConfPass"
							class="form-control form_lgn" placeholder="Confirm password"
							style="border-radius: 5px;">
						<div class="form-control-feedback" style="padding-left: 10px;">
							<i class="icon-envelop text-muted"></i>
						</div>
					</div>
					<span class="form-text text-muted">contain minimum 8
													characters,one capital character,one small character, one number, one
													special symbol</span>

					<div class="form-group" style="margin: 0;">
						<button type="button" onclick="subPassForForm()"
							class="buttonlogin">Submit</button>
						<div class="forgot_pass" style="text-align: left;">
							<a href="${pageContext.request.contextPath}/">Back</a>
						</div>
					</div>
				</div>
				<div class="clr"></div>

			</div>
		</form>
	</div>

	<script type="text/javascript">
function subPassForForm(){
	//alert("Hi")
	var form = document.getElementById("form-login")
    form.action ="chngNewPassword";
    form.submit();
}
function showForgotWindow(){
	document.getElementById("pass_form").style.display="block";
} 

</script>

<script>
		function passwordChanged() {

			var strength = document.getElementById("strength");
			$("#error_password").hide();

			var strongRegex = /^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\W).*$/;
			var mediumRegex = /^(?=.{6,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$/;
			var enoughRegex = /(?=.{6,}).*/;

			var pwd = document.getElementById("newPass").value;

			if (pwd.length == 0) {
				document.getElementById("strength").innerHTML = "Type Password";
				document.getElementById("allowPass").value = 0;
			} else if (false == enoughRegex.test(pwd)) {
				document.getElementById("strength").innerHTML = "More Characters";
				document.getElementById("allowPass").value = 0;
			} else if (strongRegex.test(pwd)) {
				document.getElementById("strength").innerHTML = "<span style='color:green'>Strong!</span>";
				document.getElementById("allowPass").value = 1;
			} else if (mediumRegex.test(pwd)) {
				document.getElementById("strength").innerHTML = "<span style='color:orange'>Medium!</span>";
				document.getElementById("allowPass").value = 0;
			} else {
				document.getElementById("strength").innerHTML = "<span style='color:red'>Weak!</span>";
				document.getElementById("allowPass").value = 0;
			}
		}
	</script>
	
</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link
	href="https://fonts.googleapis.com/css2?family=Oxygen:wght@300;400;700&display=swap"
	rel="stylesheet">
<!-- font-family: 'Oxygen', sans-serif; -->
<div
	class="navbar navbar-expand-md navbar-dark bg-primary navbar-static">
	<!-- bg-indigo -->
	<div class="navbar-brand">
		<a href="${pageContext.request.contextPath}/dashboard"
			class="d-inline-block"> <%-- <img src="${pageContext.request.contextPath}/resources/global_assets/images/logo_light.png" alt=""> --%>
			<img
			src="${pageContext.request.contextPath}/resources/global_assets/images/logo_white.png"
			alt="" style="height: 50px; width: 150px;">
		</a>
	</div>

	<div class="d-md-none">
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbar-mobile">
			<i class="icon-tree5"></i>
		</button>
		<button class="navbar-toggler sidebar-mobile-main-toggle"
			type="button">
			<i class="icon-paragraph-justify3"></i>
		</button>
	</div>

	<div class="collapse navbar-collapse" id="navbar-mobile">
		<ul class="navbar-nav">
			<li class="nav-item"><a href="#"
				class="navbar-nav-link sidebar-control sidebar-main-toggle d-none d-md-block">
					<i class="icon-paragraph-justify3"></i>
			</a></li>
		</ul>

		<!-- <span class="navbar-text ml-md-3">
				<span class="badge badge-mark border-orange-300 mr-2"></span>
				Morning, Victoria!
			</span> -->




		<%-- <ul class="navbar-nav ml-md-auto">
				<li class="nav-item">
					<a href="${pageContext.request.contextPath}/logout" class="navbar-nav-link">
						<i class="icon-switch2"></i>
						<span class="d-md-none ml-2">Logout</span>
					</a>
				</li>
			</ul> --%>
	</div>

	<style>
.white-txt.select2-selection--single {
	color: #FFF !important;
}
</style>
	<ul class="navbar-nav"
		style="verticle-align: middle; padding: 15px 0 0 0">

		<!-- <li class="nav-item">
			<div class="dataTables_length">
				<label><span>Company Combo:</span>

					<div class="select-style">
						<select>
							<option value="one">1 Company</option>
							<option value="two">2 Company</option>
							<option value="three">3 Company</option>
							<option value="four">4 Company</option>
						</select>
					</div>
			</div>
		</li> -->


		<li class="nav-item dropdown dropdown-user"><a href="#"
			class="navbar-nav-link d-flex align-items-center dropdown-toggle"
			data-toggle="dropdown" aria-expanded="false"> <i
				class="icon-location3"></i><span style="margin: 0 0 0 5px;">
					<c:forEach items="${sessionScope.globalLocationList}"
						var="globalLocationList">
						<c:if test="${globalLocationList.locId==liveLocationId}"> ${globalLocationList.locName}
						</c:if>
					</c:forEach>
			</span>
		</a> <c:choose>
				<c:when test="${showLoc==0}">

				</c:when>
				<c:otherwise>
					<div class="dropdown-menu dropdown-menu-right">
						<c:forEach items="${sessionScope.liveAccesibleLoc}"
							var="liveAccesibleLoc">
							<c:forEach items="${sessionScope.globalLocationList}"
								var="globalLocationList">

								<c:if test="${globalLocationList.locId==liveAccesibleLoc}">

									<c:choose>
										<c:when test="${globalLocationList.locId==liveLocationId}">
											<a href="#" class="dropdown-item"
												onclick="setLocation(${globalLocationList.locId})"
												style="background: #f5f5f5;"><i class="icon-location3"></i>
												${globalLocationList.locName}</a>
										</c:when>
										<c:otherwise>
											<a href="#" class="dropdown-item"
												onclick="setLocation(${globalLocationList.locId})"><i
												class="icon-location3"></i> ${globalLocationList.locName}</a>
										</c:otherwise>
									</c:choose>

								</c:if>
							</c:forEach>

						</c:forEach>

					</div>
				</c:otherwise>
			</c:choose></li>

		<li class="nav-item dropdown dropdown-user"><a href="#"
			class="navbar-nav-link d-flex align-items-center dropdown-toggle"
			data-toggle="dropdown" aria-expanded="false"> <img
				src="${sessionScope.imgViewUrl}${sessionScope.userInfo.empPhoto}"
				width="36" height="36" class="rounded-circle" alt=""
				onerror="imgError(this);"> <span style="margin: 0 0 0 5px;">${sessionScope.userInfo.firstName}&nbsp;
					${sessionScope.userInfo.surname}</span>
		</a>

			<div class="dropdown-menu dropdown-menu-right">
				<a href="${pageContext.request.contextPath}/getUserProfile"
					class="dropdown-item"><i class="icon-profile"></i> Profile</a> <a
					href="${pageContext.request.contextPath}/logout"
					class="dropdown-item"><i class="icon-switch2"></i> Logout</a>
			</div></li>
	</ul>


</div>
<script>
	function imgError(image) {
		image.onerror = "";
		image.src = "${pageContext.request.contextPath}/resources/global_assets/images/default-user.jpg";
		return true;
	}
	function setLocation(locationId) {
 
		var fd = new FormData();
		fd.append('locationId', locationId); 

		$.ajax({
			url : '${pageContext.request.contextPath}/setLocation',
			type : 'post',
			dataType : 'json',
			data : fd,
			contentType : false,
			processData : false,
			success : function(response) {

				location.reload(true);

			},
		});
		  
	}
</script>
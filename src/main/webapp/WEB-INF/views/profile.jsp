<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
<link
	href="${pageContext.request.contextPath}/resources/assets/css/dashboard.css"
	rel="stylesheet" type="text/css">
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

			<!-- Page header -->
			<div class="page-header page-header-light"></div>
			<!-- /page header -->


			<!-- Content area -->
			<div class="content">


				<!-- Highlighting rows and columns -->
				<div class="card">


					<div class="card-header header-elements-inline">
						<h5 class="card-title"> Profile</h5>
					</div>

					<div class="card-body fixed_height">
						<div class="row">
							<div class="col-md-4 prof_pic">
<img src="https://buffer.com/library/wp-content/uploads/2015/03/adjust-tie-1024x683.jpeg" alt="">								
							</div>
							<div class="col-md-8">
								
								<!-- basic information -->
								<div class="basic_info">
									<h3 class="info_title">Basic Information 
									<span>
										<a href="#"><i class="icon-pencil7"></i></a>
										<a href="#"><i class="icon-history"></i></a>
									</span></h3>
								
									<div class="row">
										<div class="col-md-4">
											<div class="profile_one">Emp Code : <span>AD001</span></div>
										</div>
										<div class="col-md-4">
											&nbsp;
										</div>
										<div class="col-md-4">
											&nbsp;
										</div>
										<div class="col-md-4">
											<div class="profile_one">First Name : <span>Akshay</span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Middle Name : <span>Madhukar</span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Last Name : <span>Raoandore</span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Company : <span>Lutf Foods Pvt. Ltd.</span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Location : <span>Kondwa, Budruk, Pune</span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Designation : <span>Account Manager</span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Department : <span>Quality Control</span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Contractor : <span>Vijeya Interprises</span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Emp Type : <span>Staff</span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Contact No. : <span>3112131212</span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Other Mobile No. : <span>1234567890</span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Emp Category (Access Role) : <span>Admin</span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">UAN Number : <span>100235072792</span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">ESIC Number : <span>NA</span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">dAadhaar Number : <span>477787712211</span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">PAN Number :  <span>477787712211</span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">PF Number :  <span>127.0</span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Accessible Location :  <span>Kondwa, Budruk, Pune</span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Designation Type : <span>Employee</span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Skill : <span>Semiskilled</span></div>
										</div>
									</div>
									
									
								
								
							</div>
						</div>
					</div>
					
					<!-- basic information -->
					<div class="basic_info">
					<h3 class="info_title">Personal Information </h3>
					<div class="row">
						<div class="col-md-3"><div class="profile_one">Middle Name :  <span>Madhukar</span></div></div>
						<div class="col-md-3"><div class="profile_one">Relation : <span>Father</span></div></div>
						<div class="col-md-3"><div class="profile_one">Date of Birth : <span>18-07-1974</span></div></div>
						<div class="col-md-3"><div class="profile_one">Gender : <span>Male</span></div></div>
						
						<div class="col-md-3"><div class="profile_one">Marital Status :  <span>Unmarried</span></div></div>
						<div class="col-md-3"><div class="profile_one">Email Address : <span>akshayaaryatech@gmail.com</span></div></div>
						<div class="col-md-3"><div class="profile_one">Current Address : <span>Flat No.10, Chandra park Society S.N. 11/2, Kondhwa Bk. Opp Kantini Apt. Pune.411048</span></div></div>
						<div class="col-md-3"><div class="profile_one">Parmanent Address : <span>Flat No.10, Chandra park Society S.N. 11/2, Kondhwa Bk. Opp Kantini Apt. Raighad.411048- </span></div></div>
						
						<div class="col-md-3"><div class="profile_one">Qualification : <span>Bachlor of Arts</span></div></div>
						<div class="col-md-3"><div class="profile_one">Name : <span>Ravindra</span></div></div>
						<div class="col-md-3"><div class="profile_one">Emergency Contact 1 :  <span>+91 9730703269</span></div></div>
						<div class="col-md-3"><div class="profile_one">Emergency Contact 2 :  <span>+91 9730703269</span></div></div>
						
						<div class="col-md-3"><div class="profile_one">Emergency Person Address :  <span>Flat No.10, Chandra park Society S.N. 11/2, Kondhwa Bk. Opp Kantini Apt. Pune.411048</span></div></div>
						<div class="col-md-3"><div class="profile_one">Blood Group :  <span>AB+</span></div></div>
						<div class="col-md-3"><div class="profile_one">Uniform Size :  <span>XXL</span></div></div>
					</div>
				
				</div>
				
				<!-- basic information -->
				<div class="basic_info">
				<h3 class="info_title">Relative Information </h3>
				<div class="row">
					<div class="col-md-3"><div class="profile_one">Person Name :<span>Madhukar</span></div></div>
					<div class="col-md-3"><div class="profile_one">Date of Birth :  <span>18-07-1974</span></div></div>
					<div class="col-md-3"><div class="profile_one">Relation :  <span>Father</span></div></div>
					<div class="col-md-3"><div class="profile_one">Occupation :  <span>Farming</span></div></div>
					
					<div class="col-md-3"><div class="profile_one">Person Name :<span>Madhukar</span></div></div>
					<div class="col-md-3"><div class="profile_one">Date of Birth :  <span>18-07-1974</span></div></div>
					<div class="col-md-3"><div class="profile_one">Relation :  <span>Mother</span></div></div>
					<div class="col-md-3"><div class="profile_one">Occupation :  <span>House Wife</span></div></div>
					
					<div class="col-md-3"><div class="profile_one">Person Name :<span>Madhukar</span></div></div>
					<div class="col-md-3"><div class="profile_one">Date of Birth :  <span>18-07-1997</span></div></div>
					<div class="col-md-3"><div class="profile_one">Relation :  <span>Spuse</span></div></div>
					<div class="col-md-3"><div class="profile_one">Occupation :  <span>Student</span></div></div>
					
					<div class="col-md-3"><div class="profile_one">Person Name :<span>Madhukar</span></div></div>
					<div class="col-md-3"><div class="profile_one">Date of Birth :  <span>18-07-1990</span></div></div>
					<div class="col-md-3"><div class="profile_one">Relation :  <span>Brother</span></div></div>
					<div class="col-md-3"><div class="profile_one">Occupation :  <span>Businesman</span></div></div>
					
					<div class="col-md-3"><div class="profile_one">Person Name :<span>Madhukar</span></div></div>
					<div class="col-md-3"><div class="profile_one">Date of Birth :  <span>18-07-1999</span></div></div>
					<div class="col-md-3"><div class="profile_one">Relation :  <span>Sister</span></div></div>
					<div class="col-md-3"><div class="profile_one">Occupation :  <span>Student</span></div></div>
					
					
					
				</div>
				</div>	
				
				<!-- Employee Bank Details -->
				<div class="basic_info">
				<h3 class="info_title">Employee Bank Details </h3>
				<div class="row">
					<div class="col-md-3"><div class="profile_one">Account No :<span>20030650986</span></div></div>
					<div class="col-md-3"><div class="profile_one">Bank :  <span>State Bank of India</span></div></div>					
				</div>
				</div>
				
				<!-- Employee Salary Details -->
				<div class="basic_info">
				<h3 class="info_title">Employee Salary Details </h3>
				<div class="row">
					<div class="col-md-3"><div class="profile_one">Gross Salary Rs : <span>15000.0</span></div></div>
					<div class="col-md-3"><div class="profile_one">Basic Rs :  <span>7000.0</span></div></div>
					<div class="col-md-3"><div class="profile_one">Society Contribution Rs. :   <span>2000.0</span></div></div>
					<div class="col-md-3"><div class="profile_one">DA (0.0 %) :  <span>1000.0</span></div></div>
					
					<div class="col-md-3"><div class="profile_one">FA (0.0 %) : <span>1000.0</span></div></div>
					<div class="col-md-3"><div class="profile_one">HRA (20.0 %) :  <span>1000.0</span></div></div>
					<div class="col-md-3"><div class="profile_one">CA (0.0 %) :  <span>1000.0</span></div></div>
					<div class="col-md-3"><div class="profile_one">EA (0.0 %) :  <span>1000.0</span></div></div>
					
					<div class="col-md-3"><div class="profile_one">TA (0.0 %) : <span>1000.0</span></div></div>
					<div class="col-md-3"><div class="profile_one">OTH (20.0 %) :  <span>1000.0</span></div></div>
					<div class="col-md-3"><div class="profile_one">MA (20.0 %) :  <span>1000.0</span></div></div>
					<div class="col-md-3"><div class="profile_one">Total :  <span>15000.0</span></div></div>
					
					<div class="col-md-3"><div class="profile_one">PF Applicable :  <span>Yes</span></div></div>
					<div class="col-md-3"><div class="profile_one">PF Type :  <span>Statutory</span></div></div>
					<div class="col-md-3"><div class="profile_one">PF Employee Per :   <span>0.12</span></div></div>
					<div class="col-md-3"><div class="profile_one">ESIC Applicable :  <span>Yes</span></div></div>
					
					<div class="col-md-3"><div class="profile_one">MLWF Applicable : <span>Yes</span></div></div>
					<div class="col-md-3"><div class="profile_one">PT Applicable :  <span>Yes</span></div></div>
					<div class="col-md-3"><div class="profile_one">Salary Basis :   <span>Monthly</span></div></div>
					<div class="col-md-3"><div class="profile_one">EPF Joining Date :  <span>01-12-2003</span></div></div>
					
					<div class="col-md-3"><div class="profile_one">Joining Date : <span>01-12-2003</span></div></div>
					<div class="col-md-3"><div class="profile_one">Leaving Date :  <span>Leaving Date</span></div></div>
					<div class="col-md-3"><div class="profile_one">Leaving Reason :  <span>Leaving Reason</span></div></div>
					<div class="col-md-3"><div class="profile_one">LR For ESIC :  <span>4 Out of Courage</span></div></div>
					
					<div class="col-md-3"><div class="profile_one">LR For PF : <span>P-Permanent Disablement</span></div></div>
							
				</div>
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

</body>
</html>
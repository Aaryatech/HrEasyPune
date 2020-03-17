<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="/WEB-INF/views/include/metacssjs.jsp"></jsp:include>
</head>

<body>
<c:url var="getEmployeeProfile" value="/getEmployeeProfile"></c:url>
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
						<table width="100%">
							<tr width="100%">
								<td width="60%"><h5 class="card-title">Employee List</h5></td>
								<td width="40%" align="right"><a
									href="${pageContext.request.contextPath}/showEmpFileUpload"
									class="breadcrumb-elements-item">
										<button type="button" class="btn btn-success">Import
											Emp Excel</button>
								</a> <a href="${pageContext.request.contextPath}/showEmpSalUpload"
									class="breadcrumb-elements-item">
										<button type="button" class="btn btn-success">Upload
											Salary Data</button>
								</a> <c:if test="${addAccess==0}">
										<a href="${pageContext.request.contextPath}/employeeAdd"
											class="breadcrumb-elements-item">
											<button type="button" class="btn btn-primary">Add
												Employee</button>
										</a>
									</c:if></td>
							</tr>
						</table>
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
						<table
							class="table table-bordered table-hover datatable-highlight1 datatable-button-html5-basic  datatable-button-print-columns1"
							id="printtable1">
							<thead>
								<tr class="bg-blue">

									<th width="10%">Sr. No.</th>
									<th>Emp Code</th>
									<th>Name</th>
									<th>Emp Type</th>
									<th>Dept.</th>
									<th>Desig</th>
									<th>Location</th>
									<th width="10%" class="text-center">Actions</th>
								</tr>
							</thead>
							<tbody>


								<c:forEach items="${empList}" var="empList" varStatus="count">
									<tr>
										<td>${count.index+1}</td>
										<td>${empList.empCode}</td>
										
										<td>
										<a href="#" onclick="getEmpData('${empList.exVar1}')"
											class="breadcrumb-elements-item"  data-toggle="modal" data-target="#modal_large">
										${empList.firstName}&nbsp;${empList.middleName}&nbsp;${empList.surname}</a>
										</td>
										<td>${empList.empTypeName}</td>
										<td>${empList.deptName}</td>
										<td>${empList.empDesgn}</td>
										<td>${empList.locName}</td>
										<%-- <td>${empList.micrCode}</td>
										<td>${empList.ifscCode}</td>  --%>

										<td class="text-center"><c:if test="${editAccess == 0}">
												<a
													href="${pageContext.request.contextPath}/employeeEdit?empId=${empList.exVar1}"
													class="list-icons-item text-primary-600"
													data-popup="tooltip" title="" data-original-title="Edit"><i
													class="icon-pencil7"></i></a>
											</c:if> <c:if test="${deleteAccess == 0}">

												<a href="javascript:void(0)"
													class="list-icons-item text-danger-600 bootbox_custom"
													data-uuid="${empList.exVar1}" data-popup="tooltip" title=""
													data-original-title="Delete"><i class="icon-trash"></i></a>
											</c:if> <a
											href="${pageContext.request.contextPath}/showEmpGraphs?empId=${empList.exVar1}"
											class="list-icons-item text-primary-600" data-popup="tooltip"
											title="" data-original-title="Graphs & Reports"><i
												class="icon-history" style="color: black;"></i></a></td>
									</tr>
								</c:forEach>

							</tbody>
						</table>

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
		<!-- Large modal -->
	<div id="modal_large" class="modal fade" tabindex="-1">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Large modal</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<div class="modal-body">
					
				

					<div class="card-header header-elements-inline">
						<h5 class="card-title"> Profile</h5>
					</div>

					<div class="card-body fixed_height">
						<div class="row">
							<div class="col-md-4 prof_pic">
<img src="https://buffer.com/library/wp-content/uploads/2015/03/adjust-tie-1024x683.jpeg" alt="" width="100%"> 								
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
											<div class="profile_one">Emp Code : <span id="emp_code"></span></div>
										</div>
										<div class="col-md-4">
											&nbsp;
										</div>
										<div class="col-md-4">
											&nbsp;
										</div>
										<div class="col-md-4">
											<div class="profile_one">First Name : <span id="emp_fname"></span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Middle Name : <span id="emp_mname"></span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Last Name : <span id="emp_lname"></span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Company : <span id="emp_comp"></span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Location : <span id="emp_loc"></span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Designation : <span id="emp_desig"></span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Department : <span id="emp_depart"></span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Contractor : <span id="emp_contractor"></span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Emp Type : <span id="emp_type"></span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Contact No. : <span id="emp_mob1"></span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Other Mobile No. : <span id="emp_mob2"></span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Emp Category (Access Role) : <span id="emp_cat"></span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">UAN Number : <span id="emp_uan"></span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">ESIC Number : <span id="emp_esic"></span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Aadhaar Number : <span id="emp_aadhar"></span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">PAN Number :  <span id="emp_pan"></span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">PF Number :  <span id="emp_pf"></span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Accessible Location :  <span id="emp_access_loc">Kondwa, Budruk, Pune*</span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Designation Type : <span id="emp_desig_type"></span></div>
										</div>
										<div class="col-md-4">
											<div class="profile_one">Skill : <span id="emp_skill"></span></div>
										</div>
									</div>
									
									
								
								
							</div>
						</div>
					</div>
					
					<!-- basic information -->
					<div class="basic_info">
					<h3 class="info_title">Personal Information </h3>
					<div class="row">
						<div class="col-md-3"><div class="profile_one">Middle Name :  <span id="mid_name"></span></div></div>
						<div class="col-md-3"><div class="profile_one">Relation : <span id="relation"></span></div></div>
						<div class="col-md-3"><div class="profile_one">Date of Birth : <span id="dob"></span></div></div>
						<div class="col-md-3"><div class="profile_one">Gender : <span id="gender"></span></div></div>
						
						<div class="col-md-3"><div class="profile_one">Marital Status :  <span id="marital_status"></span></div></div>
						<div class="col-md-3"><div class="profile_one">Email Address : <span id="email"></span></div></div>
						<div class="col-md-3"><div class="profile_one">Current Address : <span id="curr_address"></span></div></div>
						<div class="col-md-3"><div class="profile_one">Parmanent Address : <span id="permnt_address"></span></div></div>
						
						<div class="col-md-3"><div class="profile_one">Qualification : <span id="qualification"></span></div></div>
						<div class="col-md-3"><div class="profile_one">Name : <span id="emerName"></span ></div></div>
						<div class="col-md-3"><div class="profile_one">Emergency Contact 1 : <span id="emerContact1"></span></div></div>
						<div class="col-md-3"><div class="profile_one">Emergency Contact 2 : <span id="emerContact2"></span></div></div>
						
						<div class="col-md-3"><div class="profile_one">Emergency Person Address : <span id="emerPersonAdd">Flat No.10, Chandra park Society S.N. 11/2, Kondhwa Bk. Opp Kantini Apt. Pune.411048</span></div></div>
						<div class="col-md-3"><div class="profile_one">Blood Group : <span id="blood_group"></span></div></div>
						<div class="col-md-3"><div class="profile_one">Uniform Size : <span id="uniform"></span></div></div>
					</div>
				
				</div>
				
				<!-- basic information -->
				<div class="basic_info">
				<h3 class="info_title">Relative Information </h3>
				<div class="row">
					<div class="col-md-3"><div class="profile_one">Person Name :<span id="person1"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Date of Birth :  <span id="nom_dob1"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Relation :  <span id="relation1"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Occupation :  <span id="occupation1"></span></div></div>
					
					<div class="col-md-3"><div class="profile_one">Person Name :<span id="person2"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Date of Birth :  <span id="nom_dob2"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Relation :  <span id="relation2"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Occupation :  <span id="occupation2"></span></div></div>
					
					<div class="col-md-3"><div class="profile_one">Person Name :<span id="person3"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Date of Birth :  <span id="nom_dob3"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Relation :  <span id="relation3"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Occupation :  <span id="occupation3"></span></div></div>
					
					<div class="col-md-3"><div class="profile_one">Person Name :<span id="person4"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Date of Birth :  <span id="nom_dob4"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Relation :  <span id="relation4"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Occupation :  <span id="occupation4"></span></div></div>
					
					<div class="col-md-3"><div class="profile_one">Person Name :<span id="person5"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Date of Birth :  <span id="nom_dob5"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Relation :  <span id="relation5"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Occupation :  <span id="occupation5"></span></div></div>
					
					<div class="col-md-3"><div class="profile_one">Person Name :<span id="person6"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Date of Birth :  <span id="nom_dob6"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Relation :  <span id="relation6"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Occupation :  <span id="occupation6"></span></div></div>
					
					
					
				</div>
				</div>	
				
				<!-- Employee Bank Details -->
				<div class="basic_info">
				<h3 class="info_title">Employee Bank Details </h3>
				<div class="row">
					<div class="col-md-3"><div class="profile_one">Account No :<span id="ac_no"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Bank :  <span id="bank_name"></span></div></div>					
				</div>
				</div>
				
				<!-- Employee Salary Details -->
				<div class="basic_info">
				<h3 class="info_title">Employee Salary Details </h3>
				<div class="row">
					<div class="col-md-3"><div class="profile_one">Gross Salary Rs : <span id="gross_sal"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Basic Rs :  <span id="basic_sal"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Society Contribution Rs. : <span id="society_Contri"></span></div></div>
					<div class="col-md-3"><div class="profile_one">DA (0.0 %) :  <span id="allwnce_DA"></span></div></div>
					
					<div class="col-md-3"><div class="profile_one">FA (0.0 %) : <span id="allwnce_FA"></span></div></div>
					<div class="col-md-3"><div class="profile_one">HRA (20.0 %) : <span id="allwnce_HRA"></span></div></div>
					<div class="col-md-3"><div class="profile_one">CA (0.0 %) :  <span id="allwnce_CA"></span></div></div>
					<div class="col-md-3"><div class="profile_one">EA (0.0 %) :  <span id="allwnce_EA"></span></div></div>
					
					<div class="col-md-3"><div class="profile_one">TA (0.0 %) : <span id="allwnce_TA"></span></div></div>
					<div class="col-md-3"><div class="profile_one">OTH (20.0 %) :  <span id="allwnce_OTH"></span></div></div>
					<div class="col-md-3"><div class="profile_one">MA (20.0 %) :  <span id="allwnce_MA"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Total :  <span id="alwncTtl"></span></div></div>
					
					<div class="col-md-3"><div class="profile_one">PF Applicable :  <span id="pf_applicable"></span></div></div>
					<div class="col-md-3"><div class="profile_one">PF Type :  <span id="pf_type"></span></div></div>
					<div class="col-md-3"><div class="profile_one">PF Employee Per :   <span id="pf_emp_per"></span></div></div>
					<div class="col-md-3"><div class="profile_one">ESIC Applicable :  <span id="esic_applicable"></span></div></div>
					
					<div class="col-md-3"><div class="profile_one">MLWF Applicable : <span id="mlwf_applicable"></span></div></div>
					<div class="col-md-3"><div class="profile_one">PT Applicable :  <span id="pt_applicable"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Salary Basis :   <span id="salary_basis"></span></div></div>
					<div class="col-md-3"><div class="profile_one">EPF Joining Date :  <span id="epf_join_date"></span></div></div>
					
					<div class="col-md-3"><div class="profile_one">Joining Date : <span id="cmp_join_date"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Leaving Date :  <span id="cmp_leave_date"></span></div></div>
					<div class="col-md-3"><div class="profile_one">Leaving Reason :  <span id="leave_reason"></span></div></div>
					<div class="col-md-3"><div class="profile_one">LR For ESIC :  <span id="esic_leave_reason"></span></div></div>
					
					<div class="col-md-3"><div class="profile_one">LR For PF : <span id="lr_pf"></span></div></div>
							
				</div>
				</div>
					

				</div>
				<!-- /highlighting rows and columns -->

			
					
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
					<button type="button" class="btn bg-primary">Save changes</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /large modal -->
	<!-- /page content -->
	<script>
		// Custom bootbox dialog
		$('.bootbox_custom')
				.on(
						'click',
						function() {
							var uuid = $(this).data("uuid") // will return the number 123
							bootbox
									.confirm({
										title : 'Confirm ',
										message : 'Are you sure you want to delete selected records ?',
										buttons : {
											confirm : {
												label : 'Yes',
												className : 'btn-success'
											},
											cancel : {
												label : 'Cancel',
												className : 'btn-link'
											}
										},
										callback : function(result) {
											if (result) {
												location.href = "${pageContext.request.contextPath}/deleteEmp?empId="
														+ uuid;

											}
										}
									});
						});
	</Script>
	<script type="text/javascript">
	function getEmpData(empId) {
		//alert(empId)
		
				$.getJSON('${getEmployeeProfile}',

			{

				empId : empId,
				ajax : 'true'

			}, function(data) {
				//alert(JSON.stringify( data.empAllowncDtl));
				document.getElementById("emp_code").innerHTML = data.empDtl.empCode;
				document.getElementById("emp_fname").innerHTML = data.empDtl.firstName;
				document.getElementById("emp_mname").innerHTML = data.empDtl.middleName;
				document.getElementById("emp_lname").innerHTML = data.empDtl.surname;
				document.getElementById("emp_comp").innerHTML = data.empDtl.compName;
				document.getElementById("emp_type").innerHTML = data.empDtl.empWorkType;
				document.getElementById("emp_depart").innerHTML = data.empDtl.departName;
				document.getElementById("emp_desig").innerHTML = data.empDtl.desingntn;
				document.getElementById("emp_contractor").innerHTML = data.empDtl.contractorName;
				document.getElementById("emp_cat").innerHTML = data.empDtl.empCat;
				document.getElementById("emp_skill").innerHTML = data.empDtl.skillType;
				document.getElementById("emp_loc").innerHTML = data.empDtl.location;
				document.getElementById("emp_mob1").innerHTML = data.empDtl.mobileNo1;
				document.getElementById("emp_mob2").innerHTML = data.empDtl.mobileNo2;
				document.getElementById("emp_uan").innerHTML = data.empDtl.uan;
				document.getElementById("emp_aadhar").innerHTML = data.empDtl.aadharNo;
				document.getElementById("emp_esic").innerHTML = data.empDtl.esicNo;
				document.getElementById("emp_pan").innerHTML = data.empDtl.panCardNo;
				document.getElementById("emp_pf").innerHTML = data.empDtl.pfNo;
				
				if(data.empDtl.exInt1==0){
					document.getElementById("emp_desig_type").innerHTML = 'Employee';
				}else if(data.empDtl.exInt1==1){
					document.getElementById("emp_desig_type").innerHTML = 'HOD';
				}else if(data.empDtl.exInt1==2){
					document.getElementById("emp_desig_type").innerHTML = 'HR';
				}else{
					document.getElementById("emp_desig_type").innerHTML = 'NA';
				}
				
				
				 /*  Personal Information*/
				document.getElementById("mid_name").innerHTML = data.empPersDtl.middleName;
				document.getElementById("marital_status").innerHTML = data.empPersDtl.maritalStatus;
				document.getElementById("dob").innerHTML = data.empPersDtl.dob;
				document.getElementById("gender").innerHTML = data.empPersDtl.gender;
				if(data.empPersDtl.middleNameRelation=='father'){
					document.getElementById("relation").innerHTML = 'Father';
				}else if(data.empPersDtl.middleNameRelation=='husband'){
					document.getElementById("relation").innerHTML = 'Husband';
				}else{
					document.getElementById("relation").innerHTML = 'NA';
				}
				document.getElementById("email").innerHTML = data.empPersDtl.email;
				document.getElementById("curr_address").innerHTML = data.empPersDtl.address;
				document.getElementById("permnt_address").innerHTML = data.empPersDtl.permanentAddress;
				document.getElementById("qualification").innerHTML = data.empPersDtl.empQualification;
				document.getElementById("emerName").innerHTML = data.empPersDtl.emerName;
				document.getElementById("emerContact1").innerHTML = data.empPersDtl.emerContactNo1;
				document.getElementById("emerContact2").innerHTML = data.empPersDtl.emerContactNo2;
				document.getElementById("emerPersonAdd").innerHTML = data.empPersDtl.emerContactAddr;
				document.getElementById("blood_group").innerHTML = data.empPersDtl.bloodGroup;
				
				if(data.empPersDtl.uniformSize=='medium'){
					document.getElementById("uniform").innerHTML = 'MEDIUM';
				}else if(data.empPersDtl.uniformSize=='large'){
					document.getElementById("uniform").innerHTML = 'LARGE';
				}else if(data.empPersDtl.uniformSize=='xl'){
					document.getElementById("uniform").innerHTML = 'XL';
				}else if(data.empPersDtl.uniformSize=='xxl'){
					document.getElementById("uniform").innerHTML = 'XXL';
				}else if(data.empPersDtl.uniformSize=='xxxl'){
					document.getElementById("uniform").innerHTML = 'XXXL';
				}else{
					document.getElementById("uniform").innerHTML = 'NA';
				}
				
				/*  Personal Information*/
				document.getElementById("person1").innerHTML = data.empNomDtl.name;
				document.getElementById("person2").innerHTML = data.empNomDtl.name2;
				document.getElementById("person3").innerHTML = data.empNomDtl.name3;
				document.getElementById("person4").innerHTML = data.empNomDtl.name4;
				document.getElementById("person5").innerHTML = data.empNomDtl.name5;
				document.getElementById("person6").innerHTML = data.empNomDtl.name6;
				
				document.getElementById("nom_dob1").innerHTML = data.empNomDtl.dob;
				document.getElementById("nom_dob2").innerHTML = data.empNomDtl.dob2;
				document.getElementById("nom_dob3").innerHTML = data.empNomDtl.dob3;
				document.getElementById("nom_dob4").innerHTML = data.empNomDtl.dob4;
				document.getElementById("nom_dob5").innerHTML = data.empNomDtl.dob5;
				document.getElementById("nom_dob6").innerHTML = data.empNomDtl.dob6;
				
				/* Relation 1 */
				if(data.empNomDtl.relation=='f'){
					document.getElementById("relation1").innerHTML = 'Father';
				}else if(data.empNomDtl.relation=='m'){
					document.getElementById("relation1").innerHTML = 'Mother';
				}else if(data.empNomDtl.relation=='s1'){
					document.getElementById("relation1").innerHTML = 'Spouse';
				}else if(data.empNomDtl.relation=='b'){
					document.getElementById("relation1").innerHTML = 'Brother';
				}else if(data.empNomDtl.relation=='s2'){
					document.getElementById("relation1").innerHTML = 'Sister';
				}else if(data.empNomDtl.relation=='s3'){
					document.getElementById("relation1").innerHTML = 'Son';
				}else if(data.empNomDtl.relation=='d'){
					document.getElementById("relation1").innerHTML = 'Daughter';
				}else{
					document.getElementById("relation1").innerHTML = 'NA';
				}
				
				
				/* Relation 2 */				
				if(data.empNomDtl.relation2=='f'){
					document.getElementById("relation2").innerHTML = 'Father';
				}else if(data.empNomDtl.relation2=='m'){
					document.getElementById("relation2").innerHTML = 'Mother';
				}else if(data.empNomDtl.relation2=='s1'){
					document.getElementById("relation2").innerHTML = 'Spouse';
				}else if(data.empNomDtl.relation2=='b'){
					document.getElementById("relation2").innerHTML = 'Brother';
				}else if(data.empNomDtl.relation2=='s2'){
					document.getElementById("relation2").innerHTML = 'Sister';
				}else if(data.empNomDtl.relation2=='s3'){
					document.getElementById("relation2").innerHTML = 'Son';
				}else if(data.empNomDtl.relation2=='d'){
					document.getElementById("relation2").innerHTML = 'Daughter';
				}else{
					document.getElementById("relation2").innerHTML = 'NA';
				}
				
				/* Relation 3 */				
				if(data.empNomDtl.relation3=='f'){
					document.getElementById("relation3").innerHTML = 'Father';
				}else if(data.empNomDtl.relation3=='m'){
					document.getElementById("relation3").innerHTML = 'Mother';
				}else if(data.empNomDtl.relation3=='s1'){
					document.getElementById("relation3").innerHTML = 'Spouse';
				}else if(data.empNomDtl.relation3=='b'){
					document.getElementById("relation3").innerHTML = 'Brother';
				}else if(data.empNomDtl.relation3=='s2'){
					document.getElementById("relation3").innerHTML = 'Sister';
				}else if(data.empNomDtl.relation3=='s3'){
					document.getElementById("relation3").innerHTML = 'Son';
				}else if(data.empNomDtl.relation3=='d'){
					document.getElementById("relation3").innerHTML = 'Daughter';
				}else{
					document.getElementById("relation3").innerHTML = 'NA';
				}
				
				/* Relation 4 */
				if(data.empNomDtl.relation4=='f'){
					document.getElementById("relatio4n").innerHTML = 'Father';
				}else if(data.empNomDtl.relation4=='m'){
					document.getElementById("relation4").innerHTML = 'Mother';
				}else if(data.empNomDtl.relation4=='s1'){
					document.getElementById("relation4").innerHTML = 'Spouse';
				}else if(data.empNomDtl.relation4=='b'){
					document.getElementById("relation4").innerHTML = 'Brother';
				}else if(data.empNomDtl.relation4=='s2'){
					document.getElementById("relation4").innerHTML = 'Sister';
				}else if(data.empNomDtl.relation4=='s3'){
					document.getElementById("relation4").innerHTML = 'Son';
				}else if(data.empNomDtl.relation4=='d'){
					document.getElementById("relation4").innerHTML = 'Daughter';
				}else{
					document.getElementById("relation4").innerHTML = 'NA';
				}
				
				/* Relation 5 */
				if(data.empNomDtl.relation5=='f'){
					document.getElementById("relation5").innerHTML = 'Father';
				}else if(data.empNomDtl.relation5=='m'){
					document.getElementById("relation5").innerHTML = 'Mother';
				}else if(data.empNomDtl.relation5=='s1'){
					document.getElementById("relation5").innerHTML = 'Spouse';
				}else if(data.empNomDtl.relation5=='b'){
					document.getElementById("relation5").innerHTML = 'Brother';
				}else if(data.empNomDtl.relation5=='s2'){
					document.getElementById("relation5").innerHTML = 'Sister';
				}else if(data.empNomDtl.relation5=='s3'){
					document.getElementById("relation5").innerHTML = 'Son';
				}else if(data.empNomDtl.relation5=='d'){
					document.getElementById("relation5").innerHTML = 'Daughter';
				}else{
					document.getElementById("relation5").innerHTML = 'NA';
				}
				
				/* Relation 6 */
				if(data.empNomDtl.relation6=='f'){
					document.getElementById("relation6").innerHTML = 'Father';
				}else if(data.empNomDtl.relation6=='m'){
					document.getElementById("relation6").innerHTML = 'Mother';
				}else if(data.empNomDtl.relation6=='s1'){
					document.getElementById("relation6").innerHTML = 'Spouse';
				}else if(data.empNomDtl.relation6=='b'){
					document.getElementById("relation6").innerHTML = 'Brother';
				}else if(data.empNomDtl.relation6=='s2'){
					document.getElementById("relation6").innerHTML = 'Sister';
				}else if(data.empNomDtl.relation6=='s3'){
					document.getElementById("relation6").innerHTML = 'Son';
				}else if(data.empNomDtl.relation6=='d'){
					document.getElementById("relation6").innerHTML = 'Daughter';
				}else{
					document.getElementById("relation").innerHTML = 'NA';
				}
				
				document.getElementById("occupation1").innerHTML = data.empNomDtl.occupation1;
				document.getElementById("occupation2").innerHTML = data.empNomDtl.occupation2;
				document.getElementById("occupation3").innerHTML = data.empNomDtl.occupation3;
				document.getElementById("occupation4").innerHTML = data.empNomDtl.occupation4;
				document.getElementById("occupation5").innerHTML = data.empNomDtl.occupation5;
				document.getElementById("occupation6").innerHTML = data.empNomDtl.occupation6;
				
				
				
				/* Bank Details */
				document.getElementById("ac_no").innerHTML = data.empBankDtl.accNo;
				document.getElementById("bank_name").innerHTML = data.empBankDtl.exVar1;
				
				/* Salary And Allowance Details */
				document.getElementById("basic_sal").innerHTML = data.empSalDtl.basic;
				document.getElementById("gross_sal").innerHTML = data.empSalDtl.grossSalary;
				document.getElementById("society_Contri").innerHTML = data.empSalDtl.societyContribution;
				
				var allowanceTtl = 0;;
				for (var i = 0; i < data.empAllowncDtl.length; i++) {
					
					if(data.empAllowncDtl[i].allowanceId==1){
						
						document.getElementById("allwnce_DA").innerHTML = data.empAllowncDtl[i].allowanceValue;
						allowanceTtl = allowanceTtl+data.empAllowncDtl[i].allowanceValue;
					} else if(data.empAllowncDtl[i].allowanceId==5){
						document.getElementById("allwnce_FA").innerHTML = data.empAllowncDtl[i].allowanceValue;
						allowanceTtl = allowanceTtl+data.empAllowncDtl[i].allowanceValue;
					}else if(data.empAllowncDtl[i].allowanceId==9){
						document.getElementById("allwnce_HRA").innerHTML = data.empAllowncDtl[i].allowanceValue;
						allowanceTtl = allowanceTtl+data.empAllowncDtl[i].allowanceValue;
					}else if(data.empAllowncDtl[i].allowanceId==11){
						document.getElementById("allwnce_CA").innerHTML = data.empAllowncDtl[i].allowanceValue;
						allowanceTtl = allowanceTtl+data.empAllowncDtl[i].allowanceValue;
					}else if(data.empAllowncDtl[i].allowanceId==14){
						document.getElementById("allwnce_EA").innerHTML = data.empAllowncDtl[i].allowanceValue;
						allowanceTtl = allowanceTtl+data.empAllowncDtl[i].allowanceValue;
					}else if(data.empAllowncDtl[i].allowanceId==19){
						document.getElementById("allwnce_OTH").innerHTML = data.empAllowncDtl[i].allowanceValue;
						allowanceTtl = allowanceTtl+data.empAllowncDtl[i].allowanceValue;
					}else if(data.empAllowncDtl[i].allowanceId==173){
						document.getElementById("allwnce_MA").innerHTML = data.empAllowncDtl[i].allowanceValue;
						allowanceTtl = allowanceTtl+data.empAllowncDtl[i].allowanceValue;
					} 
					
				}
				
				document.getElementById("alwncTtl").innerHTML =allowanceTtl;
				
				if(data.empSalDtl.pfApplicable=="yes"){
					document.getElementById("pf_applicable").innerHTML = 'YES';
				}else{
					document.getElementById("pf_applicable").innerHTML = 'NO';
				}
				document.getElementById("pf_type").innerHTML = data.empSalDtl.pfType;
				document.getElementById("pf_emp_per").innerHTML = data.empSalDtl.pfEmpPer;
				if(data.empSalDtl.esicApplicable=='yes'){
					document.getElementById("esic_applicable").innerHTML = 'YES';
				}else{
					document.getElementById("esic_applicable").innerHTML = 'NO';
				}
				
				if(data.empSalDtl.mlwfApplicable=='yes'){
					document.getElementById("mlwf_applicable").innerHTML = 'YES';
				}else{
					document.getElementById("mlwf_applicable").innerHTML = 'NO';	
				}
				
				if(data.empSalDtl.salBasis=='monthly'){
					document.getElementById("salary_basis").innerHTML = 'Monthly';
				}else{
					document.getElementById("salary_basis").innerHTML = 'Daily';
				}
				
				if(data.empSalDtl.ptApplicable=='yes'){
					document.getElementById("pt_applicable").innerHTML = 'YES';
				}else{
					document.getElementById("pt_applicable").innerHTML = 'NO';
				}
				
				document.getElementById("epf_join_date").innerHTML = data.empSalDtl.epfJoiningDate;				
				document.getElementById("cmp_join_date").innerHTML = data.empSalDtl.cmpJoiningDate;
				document.getElementById("cmp_leave_date").innerHTML = data.empSalDtl.cmpLeavingDate;
				document.getElementById("leave_reason").innerHTML = data.empSalDtl.leavingReason;
				
				if(data.empSalDtl.leavingReasonEsic==0){
					document.getElementById("esic_leave_reason").innerHTML = 'Without Reason';
				}else if(data.empSalDtl.leavingReasonEsic==1){
					document.getElementById("esic_leave_reason").innerHTML = 'On Leave';
				}else if(data.empSalDtl.leavingReasonEsic==2){
					document.getElementById("esic_leave_reason").innerHTML = 'Self Service';
				}else if(data.empSalDtl.leavingReasonEsic==3){
					document.getElementById("esic_leave_reason").innerHTML = 'Retired';
				}else if(data.empSalDtl.leavingReasonEsic==4){
					document.getElementById("esic_leave_reason").innerHTML = 'Out of Coverage';
				}else if(data.empSalDtl.leavingReasonEsic==5){
					document.getElementById("esic_leave_reason").innerHTML = 'Expired';
				}else if(data.empSalDtl.leavingReasonEsic==6){
					document.getElementById("esic_leave_reason").innerHTML = 'Non Implemented Area';
				}else if(data.empSalDtl.leavingReasonEsic==7){
					document.getElementById("esic_leave_reason").innerHTML = 'Compliance by immediate Employer';
				}else if(data.empSalDtl.leavingReasonEsic==8){
					document.getElementById("esic_leave_reason").innerHTML = 'Suspension Reason';
				}else if(data.empSalDtl.leavingReasonEsic==9){
					document.getElementById("esic_leave_reason").innerHTML = 'Strike/Lockout';
				}else if(data.empSalDtl.leavingReasonEsic==10){
					document.getElementById("esic_leave_reason").innerHTML = 'Retrenchment';
				}else if(data.empSalDtl.leavingReasonEsic==11){
					document.getElementById("esic_leave_reason").innerHTML = 'No Work';
				}else if(data.empSalDtl.leavingReasonEsic==12){
					document.getElementById("esic_leave_reason").innerHTML = 'Does not belong to this Employer';
				}
				
				
				if(data.empSalDtl.leavingReasonPf==1){
					document.getElementById("lr_pf").innerHTML = 'Cessation';
				}else if(data.empSalDtl.leavingReasonPf==2){
					document.getElementById("lr_pf").innerHTML = 'Superannuation';
				}else if(data.empSalDtl.leavingReasonPf==3){
					document.getElementById("lr_pf").innerHTML = 'Retirement';
				}else if(data.empSalDtl.leavingReasonPf==4){
					document.getElementById("lr_pf").innerHTML = 'Death in Service';
				}else if(data.empSalDtl.leavingReasonPf==5){
					document.getElementById("lr_pf").innerHTML = 'Permanent Disablement';
				}
			});
	}
	</script>
</body>
</html>
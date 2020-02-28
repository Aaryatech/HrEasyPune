package com.ats.hreasy.common;

import org.springframework.http.client.support.BasicAuthorizationInterceptor;
import org.springframework.web.client.RestTemplate;

public class Constants {

	//local
	public static final String url = "http://localhost:8094/";
	public static String REPORT_SAVE = "/home/lenovo/Documents/pdf/Report.pdf"; 
	public static final String ReportURL = "http://localhost:8082/hreasy/";
	public static final String attsDocSaveUrl = "/home/lenovo/Downloads/old/apache-tomcat-8.5.37/webapps/media/";
	public static final String docSaveUrl= "/home/lenovo/Downloads/old/apache-tomcat-8.5.37/webapps/media/";
	
	public static final String companyLogoSaveUrl = "/home/lenovo/Downloads/old/apache-tomcat-8.5.37/webapps/media/";
	public static final String empDocSaveUrl = "/home/lenovo/Downloads/old/apache-tomcat-8.5.37/webapps/media/";
	public static final String leaveDocSaveUrl = "/home/lenovo/Downloads/old/apache-tomcat-8.5.37/webapps/media/"; 
	public static final String imageSaveUrl = "/home/lenovo/Downloads/old/apache-tomcat-8.5.37/webapps/media/";
	
	public static final String companyLogoShowUrl = "http://localhost:8080/media/";
	public static final String empDocShowUrl = "http://localhost:8080/media/"; 
	public static final String leaveDocShowUrl = "http://localhost:8080/media/";
	public static final String imageShowUrl = "http://localhost:8080/media/"; 
	
	 //monginispune
	/*public static final String ReportURL = "http://192.168.1.25:8080/HrEasy/";
	public static final String url="http://192.168.1.25:8080/HrEsayWebApi/"; 
	public static String REPORT_SAVE = "/home/supertom/apache-tomcat-8.5.35/webapps/HrEasy/report.pdf";
	public static final String attsDocSaveUrl = "/home/supertom/apache-tomcat-8.5.35/webapps/hrdocument/attendancedoc/";
	public static final String docSaveUrl= "/home/supertom/apache-tomcat-8.5.35/webapps/hrdocument/updatedoc/";
	
	public static final String companyLogoSaveUrl = "/home/supertom/apache-tomcat-8.5.35/webapps/hrdocument/companylogo/";
	public static final String empDocSaveUrl = "/home/supertom/apache-tomcat-8.5.35/webapps/hrdocument/empdoc/";
	public static final String leaveDocSaveUrl = "/home/supertom/apache-tomcat-8.5.35/webapps/hrdocument/leavedoc/"; 
	public static final String imageSaveUrl = "/home/supertom/apache-tomcat-8.5.35/webapps/hrdocument/mixDoc/";
	
	public static final String companyLogoShowUrl = "http://192.168.1.25:8080/companylogo/";
	public static final String empDocShowUrl = "http://192.168.1.25:8080/empdoc/"; 
	public static final String leaveDocShowUrl = "http://192.168.1.25:8080/leavedoc/";
	public static final String imageShowUrl = "http://192.168.1.25:8080/mixDoc/";*/
	
	
	//atsserver
		/*public static final String url = "http://107.180.88.121:8080/HrEsayWebApi/";
		public static String REPORT_SAVE = "/opt/apache-tomcat-8.5.47/webapps/hrdocument/Report.pdf"; 
		public static final String ReportURL = "http://107.180.88.121:8080/HrEasy/";//gfpl 
		public static final String attsDocSaveUrl = "/opt/apache-tomcat-8.5.47/webapps/hrdocument/attendancedoc/";
		public static final String docSaveUrl= "/opt/apache-tomcat-8.5.47/webapps/hrdocument/updatedoc/";
		
		public static final String companyLogoSaveUrl = "/opt/apache-tomcat-8.5.47/webapps/hrdocument/companylogo/";
		public static final String empDocSaveUrl = "/opt/apache-tomcat-8.5.47/webapps/hrdocument/empdoc/";
		public static final String leaveDocSaveUrl = "/opt/apache-tomcat-8.5.47/webapps/hrdocument/leavedoc/"; 
		public static final String imageSaveUrl = "/opt/apache-tomcat-8.5.47/webapps/hrdocument/mixDoc/";
		
		public static final String companyLogoShowUrl = "http://107.180.88.121:8080/companylogo/";
		public static final String empDocShowUrl = "http://107.180.88.121:8080/empdoc/"; 
		public static final String leaveDocShowUrl = "http://107.180.88.121:8080/leavedoc/";
		public static final String imageShowUrl = "http://107.180.88.121:8080/mixDoc/";*/
	
	public static RestTemplate rest = new RestTemplate();
	public static String[] allextension = { "txt", "doc", "pdf", "xls", "jpg", "jpeg", "gif", "png" };
	public static String[] values = { "jpg", "jpeg", "gif", "png" }; 
	
	
	

	public static RestTemplate getRestTemplate() {
		rest = new RestTemplate();
		rest.getInterceptors().add(new BasicAuthorizationInterceptor("aaryatech", "Aaryatech@1cr"));
		return rest;

	}

}
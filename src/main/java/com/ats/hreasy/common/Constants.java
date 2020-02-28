package com.ats.hreasy.common;

import org.springframework.http.client.support.BasicAuthorizationInterceptor;
import org.springframework.web.client.RestTemplate;

public class Constants {

	//local
	 public static final String url = "http://localhost:8094/";
	public static String REPORT_SAVE = "/home/lenovo/Documents/pdf/Report.pdf";
	//public static final String imageSaveUrl = "/home/lenovo/Documents/attendance/";
	//public static final String imageShowUrl = "http://localhost:8082/attendance/";
	public static final String ReportURL = "http://localhost:8082/hreasy/";  
	public static final String imageSaveUrl = "/home/lenovo/Downloads/old/apache-tomcat-8.5.37/webapps/media/";
	public static final String imageShowUrl = "http://localhost:8080/media/";
	
	//monginis
	/*public static final String url="http://107.180.95.11:8080/HrEsayWebApi/"; 
	public static String REPORT_SAVE = "/opt/tomcat-latest/webapps/hruploads/hrreport/Report.pdf"; 
	public static final String ReportURL = "http://107.180.95.11:8080/HrEasy/";//gfpl 
	public static final String imageSaveUrl = "/opt/tomcat-latest/webapps/hruploads/emppic/";
	public static final String imageShowUrl = "http://107.180.95.11:8080/hruploads/emppic/";*/
  
	//atsserver
	/*public static final String url = "http://107.180.88.121:8080/HrEsayWebApi/";
	public static String REPORT_SAVE = "/opt/apache-tomcat-8.5.47/webapps/hr/Report.pdf"; 
	public static final String ReportURL = "http://107.180.88.121:8080/HrEasy/";//gfpl 
	public static final String imageSaveUrl = "/opt/apache-tomcat-8.5.47/webapps/hr/";
	public static final String imageShowUrl = "http://107.180.88.121:8080/hr/" ;*/
	
	/*public static final String ReportURL = "http://192.168.1.25:8080/HrEasy/";
	public static final String url="http://192.168.1.25:8080/HrEsayWebApi/"; 
	public static String REPORT_SAVE = "/home/supertom/apache-tomcat-8.5.35/webapps/HrEasy/report.pdf";
	public static final String imageShowUrl = "http://192.168.1.25:8080/hruploads/";
	public static final String imageSaveUrl = "/home/supertom/apache-tomcat-8.5.35/webapps/hruploads/";*/
	
	
	public static RestTemplate rest = new RestTemplate();
	public static String[] allextension = { "txt", "doc", "pdf", "xls", "jpg", "jpeg", "gif", "png" };
	public static String[] values = { "jpg", "jpeg", "gif", "png" };
	public static Object getImageSaveUrl;

	public static RestTemplate getRestTemplate() {
		rest = new RestTemplate();
		rest.getInterceptors().add(new BasicAuthorizationInterceptor("aaryatech", "Aaryatech@1cr"));
		return rest;

	}

}
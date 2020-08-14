package com.ats.hreasy.common;

import org.springframework.http.client.support.BasicAuthorizationInterceptor;
import org.springframework.web.client.RestTemplate;

public class Constants {

	// local
	public static final String opsWebApiUrl = "http://107.180.95.11:8080/webapi/";

	/*
	 * public static final String url = "http://localhost:8094/"; public static
	 * String REPORT_SAVE = "/home/lenovo/Documents/pdf/Report.pdf"; public static
	 * final String ReportURL = "http://localhost:8082/hreasy/"; public static final
	 * String attsDocSaveUrl =
	 * "/home/lenovo/Downloads/old/apache-tomcat-8.5.37/webapps/media/"; public
	 * static final String docSaveUrl =
	 * "/home/lenovo/Downloads/old/apache-tomcat-8.5.37/webapps/media/";
	 * 
	 * public static final String companyLogoSaveUrl =
	 * "/home/lenovo/Downloads/old/apache-tomcat-8.5.37/webapps/media/"; public
	 * static final String empDocSaveUrl = "/home/maddy/ats-11/"; static final
	 * String leaveDocSaveUrl1 =
	 * "/home/lenovo/Downloads/old/apache-tomcat-8.5.37/webapps/media/"; public
	 * static final String leaveDocSaveUrl =
	 * "/home/lenovo/Downloads/old/apache-tomcat-8.5.37/webapps/media/"; public
	 * static final String imageSaveUrl =
	 * "/home/lenovo/Downloads/old/apache-tomcat-8.5.37/webapps/media/";
	 * 
	 * public static final String companyLogoShowUrl =
	 * "http://localhost:8080/media/"; public static final String empDocShowUrl =
	 * "http://localhost:8080/home/maddy/ats-11/"; public static final String
	 * leaveDocShowUrl = "http://localhost:8080/media/"; public static final String
	 * imageShowUrl = "http://localhost:8080/media/"; public static final String
	 * templateShowUrl = "http://localhost:8080/hrdocument/templatedoc/";
	 */

	// monginispune

	/*
	 * public static final String ReportURL = "http://192.168.1.25:8080/HrEasy/";
	 * public static final String url = "http://192.168.1.25:8080/HrEsayWebApi/";
	 * public static String REPORT_SAVE =
	 * "/home/supertom/apache-tomcat-8.5.35/webapps/HrEasy/report.pdf"; public
	 * static final String attsDocSaveUrl =
	 * "/home/supertom/apache-tomcat-8.5.35/webapps/hrdocument/attendancedoc/";
	 * public static final String docSaveUrl =
	 * "/home/supertom/apache-tomcat-8.5.35/webapps/hrdocument/updatedoc/";
	 * 
	 * public static final String companyLogoSaveUrl =
	 * "/home/supertom/apache-tomcat-8.5.35/webapps/hrdocument/companylogo/"; public
	 * static final String empDocSaveUrl =
	 * "/home/supertom/apache-tomcat-8.5.35/webapps/hrdocument/empdoc/"; public
	 * static final String leaveDocSaveUrl =
	 * "/home/supertom/apache-tomcat-8.5.35/webapps/hrdocument/leavedoc/"; public
	 * static final String imageSaveUrl =
	 * "/home/supertom/apache-tomcat-8.5.35/webapps/hrdocument/mixDoc/";
	 * 
	 * public static final String companyLogoShowUrl =
	 * "http://192.168.1.25:8080/hrdocument/companylogo/"; public static final
	 * String empDocShowUrl = "http://192.168.1.25:8080/hrdocument/empdoc/"; public
	 * static final String leaveDocShowUrl =
	 * "http://192.168.1.25:8080/hrdocument/leavedoc/"; public static final String
	 * imageShowUrl = "http://192.168.1.25:8080/hrdocument/mixDoc/"; public static
	 * final String templateShowUrl =
	 * "http://192.168.1.25:8080/hrdocument/templatedoc/";
	 */

	// atsserver

	/*
	 * public static final String url = "http://107.180.88.121:8080/HrEsayWebApi/";
	 * public static String REPORT_SAVE =
	 * "/opt/apache-tomcat-8.5.47/webapps/hrdocument/Report.pdf"; public static
	 * final String ReportURL = "http://107.180.88.121:8080/HrEasy/"; public static
	 * final String attsDocSaveUrl =
	 * "/opt/apache-tomcat-8.5.47/webapps/hrdocument/attendancedoc/"; public static
	 * final String docSaveUrl =
	 * "/opt/apache-tomcat-8.5.47/webapps/hrdocument/updatedoc/";
	 * 
	 * public static final String companyLogoSaveUrl =
	 * "/opt/apache-tomcat-8.5.47/webapps/hrdocument/companylogo/"; public static
	 * final String empDocSaveUrl =
	 * "/opt/apache-tomcat-8.5.47/webapps/hrdocument/empdoc/"; public static final
	 * String leaveDocSaveUrl =
	 * "/opt/apache-tomcat-8.5.47/webapps/hrdocument/leavedoc/"; public static final
	 * String imageSaveUrl = "/opt/apache-tomcat-8.5.47/webapps/hrdocument/mixDoc/";
	 * 
	 * public static final String companyLogoShowUrl =
	 * "http://107.180.88.121:8080/hrdocument/companylogo/"; public static final
	 * String empDocShowUrl = "http://107.180.88.121:8080/hrdocument/empdoc/";
	 * public static final String leaveDocShowUrl =
	 * "http://107.180.88.121:8080/hrdocument/leavedoc/"; public static final String
	 * imageShowUrl = "http://107.180.88.121:8080/hrdocument/mixDoc/"; public static
	 * final String templateShowUrl =
	 * "http://107.180.88.121:8080/hrdocument/templatedoc/";
	 */

	// Mumbai hr

	public static final String url = "http://107.180.91.43:8080/HrEsayWebApi/";
	public static String REPORT_SAVE = "/opt/apache-tomcat-8.5.49/webapps/hrdocument/Report.pdf";
	public static final String ReportURL = "http://107.180.91.43:8080/HrEasy/";// gfpl public
	public static final String attsDocSaveUrl = "/opt/apache-tomcat-8.5.49/webapps/hrdocument/attendancedoc/";
	public static final String docSaveUrl = "/opt/apache-tomcat-8.5.49/webapps/hrdocument/updatedoc/";

	public static final String companyLogoSaveUrl = "/opt/apache-tomcat-8.5.49/webapps/hrdocument/companylogo/";
	public static final String empDocSaveUrl = "/opt/apache-tomcat-8.5.49/webapps/hrdocument/empdoc/";
	public static final String leaveDocSaveUrl = "/opt/apache-tomcat-8.5.49/webapps/hrdocument/leavedoc/";
	public static final String imageSaveUrl = "/opt/apache-tomcat-8.5.49/webapps/hrdocument/mixDoc/";

	public static final String companyLogoShowUrl = "http://107.180.91.43:8080/hrdocument/companylogo/";
	public static final String empDocShowUrl = "http://107.180.91.43:8080/hrdocument/empdoc/";
	public static final String leaveDocShowUrl = "http://107.180.91.43:8080/hrdocument/leavedoc/";
	public static final String imageShowUrl = "http://107.180.91.43:8080/hrdocument/mixDoc/";
	public static final String templateShowUrl = "http://107.180.91.43:8080/hrdocument/templatedoc/";

	// Aurangabad Hr

	/*
	 * public static final String url = "http://107.180.95.11:8080/HrEsayWebApi/";
	 * public static String REPORT_SAVE =
	 * "/opt/tomcat-latest/webapps/hrdocument/Report.pdf"; public static final
	 * String ReportURL = "http://107.180.95.11:8080/HrEasy/";// gfpl public public
	 * public static final String attsDocSaveUrl =
	 * "/opt/tomcat-latest/webapps/hrdocument/attendancedoc/"; public static final
	 * String docSaveUrl = "/opt/tomcat-latest/webapps/hrdocument/updatedoc/";
	 * 
	 * public static final String companyLogoSaveUrl =
	 * "/opt/tomcat-latest/webapps/hrdocument/companylogo/"; public static final
	 * String empDocSaveUrl = "/opt/tomcat-latest/webapps/hrdocument/empdoc/";
	 * public static final String leaveDocSaveUrl =
	 * "/opt/tomcat-latest/webapps/hrdocument/leavedoc/"; public static final String
	 * imageSaveUrl = "/opt/tomcat-latest/webapps/hrdocument/mixDoc/";
	 * 
	 * public static final String companyLogoShowUrl =
	 * "http://107.180.95.11:8080/hrdocument/companylogo/"; public static final
	 * String empDocShowUrl = "http://107.180.95.11:8080/hrdocument/empdoc/"; public
	 * static final String leaveDocShowUrl =
	 * "http://107.180.95.11:8080/hrdocument/leavedoc/"; public static final String
	 * imageShowUrl = "http://107.180.95.11:8080/hrdocument/mixDoc/"; public static
	 * final String templateShowUrl =
	 * "http://107.180.95.11:8080/hrdocument/templatedoc/";
	 */

	public static RestTemplate rest = new RestTemplate();
	public static String[] allextension = { "txt", "doc", "pdf", "xls", "jpg", "jpeg", "gif", "png" };
	public static String[] values = { "jpg", "jpeg", "gif", "png" };
	public static String empLoanAgrDocViewUrl;
	public static String empLoanAgrDocSaveUrl;

	public static RestTemplate getRestTemplate() {
		rest = new RestTemplate();
		rest.getInterceptors().add(new BasicAuthorizationInterceptor("aaryatech", "Aaryatech@1cr"));
		return rest;

	}
}
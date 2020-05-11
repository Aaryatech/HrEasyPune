package com.ats.hreasy;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ats.hreasy.common.AcessController;
import com.ats.hreasy.common.Constants;
import com.ats.hreasy.common.DateConvertor;
import com.ats.hreasy.common.EmailUtility;
import com.ats.hreasy.common.RandomString;
import com.ats.hreasy.model.AccessRightModule;
import com.ats.hreasy.model.Designation;
import com.ats.hreasy.model.EmployeeMaster;
import com.ats.hreasy.model.GetEmployeeDetails;
import com.ats.hreasy.model.Info;
import com.ats.hreasy.model.LoginResponse;

@Controller
@Scope("session")
public class ForgotPassController {

	LinkedHashMap<String, String> userOtpMap = new LinkedHashMap<>();
	LinkedHashMap<String, Calendar> userTimeMap = new LinkedHashMap<>();

	@RequestMapping(value = "/checkUserAndSendOtpEmail", method = RequestMethod.POST)
	public String checkUserAndSendOtpEmail(HttpServletRequest request, HttpServletResponse response) {
		String c = null;
		System.err.println("Hiii  checkValue  ");
		Info info = new Info();
		ModelAndView model = new ModelAndView();
		HttpSession session = request.getSession();

		String token = request.getParameter("token");
		String key = (String) session.getAttribute("generatedKey");

		if (token.trim().equals(key.trim())) {
			try {
				// model = new ModelAndView("forgotPassword");

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

				String inputValue = request.getParameter("usernameFp");
				System.err.println("Info inputValue  " + inputValue);

				map.add("username", inputValue);
				LoginResponse empMast = Constants.getRestTemplate().postForObject(Constants.url + "getUserForForgPass",
						map, LoginResponse.class);
				if (empMast.getIsError() == false) {
//Email OTP Send Logic;
					String genOTP = EmailUtility.getOTP(6);
					System.err.println("genOTP " +genOTP +" userEmail" +empMast.getEmailId());

					userOtpMap.put(empMast.getEmailId(), genOTP);
					userTimeMap.put(empMast.getEmailId(), DateConvertor.getTimePlusSpecMin(2));

					EmailUtility.sendEmailWithSubMsgAndToAdd("OTP For Forgot Password Request HR Application",
							" Enter the OTP as " + genOTP + ". do not share otp with anyone. OTP valid for 2 Minutes.",
							empMast.getEmailId());

					c = "redirect:/showOTPPage";
					System.err.println("OTP send ");
					session.setAttribute("errorPassMsg1", "OTP sent to your Email");
					session.setAttribute("userId", empMast.getEmpId());
					session.setAttribute("userEmail", empMast.getEmailId());
				} else {
					// model.addObject("msg", "Password has been sent to your email");

					// model = new ModelAndView("forgotPassword");
					c = "redirect:/";
					// model.addObject("msg", "Invalid User Name");
					session.setAttribute("errorMsg", "Invalid User Name !");
				}
				SessionKeyGen.changeSessionKey(request);
			} catch (Exception e) {
				SessionKeyGen.changeSessionKey(request);
				session.setAttribute("errorMsg", "Invalid User Name !");
				c = "redirect:/";
				
			}
		} else {
			SessionKeyGen.changeSessionKey(request);
			c = "redirect:/accessDenied";
		}
		return c;

	}

	@RequestMapping(value = "/showOTPPage", method = RequestMethod.GET)
	public ModelAndView showOTPPage(Locale locale, Model model) {
		ModelAndView mav = new ModelAndView("otpPage");
		return mav;
	}

	@RequestMapping(value = "/validateOTP", method = RequestMethod.POST)
	public String validateOTP(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("otpPage");
		HttpSession session = request.getSession();
		String c = new String();
		String token = request.getParameter("token");
		String key = (String) session.getAttribute("generatedKey");
		try {
			if (token.trim().equals(key.trim())) {

				String otp = request.getParameter("otp");
				String userKey = (String) session.getAttribute("userEmail");
System.err.println("otp " +otp +" userKey ie email " +userKey);
				Calendar time = Calendar.getInstance();
				time = DateConvertor.getCurTime();
				try {
					time = userTimeMap.get(userKey);
				} catch (Exception e) {
					time = DateConvertor.getCurTime();
					System.err.println("in catch " + e.getMessage());
					e.printStackTrace();
				}
				int valid = 0;
				if (DateConvertor.getCurTime().getTime().after(time.getTime())) {
					System.err.println("time exceed");
					valid = -1;
					System.err.println("OTP Time out !!");
					c = "redirect:/changePass";
					// model.addObject("msg", "Invalid User Name");
					session.setAttribute("errorPassMsg", "OTP Time out !!");
				}
				if (valid < 0) {

				} else if (userOtpMap.get(userKey).equals(otp)) {
					System.err.println("OTP Matched");
					// session.setAttribute("userId", empLogin.getEmpId());
					c = "redirect:/changePassPage";
				} else {
					System.err.println("OTP Not Matched");
					c = "redirect:/";
					// model.addObject("msg", "Invalid User Name");
					session.setAttribute("errorMsg", "OTP Not Matched. Try Again");
				}

			} else {
				c = "redirect:/accessDenied";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return c;
	}

	@RequestMapping(value = "/changePassPage", method = RequestMethod.GET)
	public ModelAndView changePassPage(Locale locale, Model model) {
		ModelAndView mav = new ModelAndView("changePass");
		return mav;
	}

	@RequestMapping(value = "/chngNewPassword", method = RequestMethod.POST)
	public String changePassForm(HttpServletRequest request, HttpServletResponse response, Model model) {
		System.out.println("Got me");

		try {
			HttpSession session = request.getSession();
			String password = request.getParameter("newPass");
			String newConfPass = request.getParameter("newConfPass");

			int userId = (int) session.getAttribute("userId");
			System.out.println("Password Found" + password + "  " + userId);
			if (password.equals(newConfPass)) {
				System.err.println("Pass Matched");
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				
				Pattern p = Pattern.compile("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$");
				Matcher m = p.matcher(password);

				MessageDigest md = MessageDigest.getInstance("MD5");
				byte[] messageDigest = md.digest(password.getBytes());
				BigInteger number = new BigInteger(1, messageDigest);
				String hashtext1 = number.toString(16);
				
				if (m.matches()) {

					 md = MessageDigest.getInstance("MD5");
					 messageDigest = md.digest(password.getBytes());
					 number = new BigInteger(1, messageDigest);
					 String hashtext = number.toString(16);
					 map.add("password", hashtext);
					 map.add("empId", userId);
					 map.add("isVisit", 0); //ie Ex Int1 in m_user 
					Info errMsg = Constants.getRestTemplate().postForObject(Constants.url + "/updateUserPassAndExInt1", map, Info.class);
					session.removeAttribute("userId");

					session.setAttribute("errorMsg", "Password Changed Successfully");
					//session.invalidate();
					return "redirect:/logout";
				}else {
					System.err.println("Pass does not contain Standard valid characters");
					
					session.setAttribute("userId", userId);
					session.setAttribute("errorPassMsg1", "Password does not contain characters of standard format.");
					return "redirect:/changePassPage";
				}
				
				
			} else {
				System.err.println("Pass does not Matched");
				
				session.setAttribute("userId", userId);
				session.setAttribute("errorPassMsg1", "Password and Confirm password Does not matched.");
				return "redirect:/changePassPage";
			}
		} catch (Exception e) {

			System.err.println("exception In chngNewPassword at Home Contr" + e.getMessage());

			e.printStackTrace();
			HttpSession session = request.getSession();
			session.invalidate();
		}
		model.addAttribute("errorMsg", "Password Changed Successfully");

		return "redirect:/";

	}
	
	
	@RequestMapping(value = "/showAssignLogin", method = RequestMethod.GET)
	public String showAssignLogin(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();
		String ret = new String();
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info view = AcessController.checkAccess("showAssignLogin", "showAssignLogin", 1, 0, 0, 0,
				newModuleList);

		if (view.isError() == true) {
			ret = "accessDenied";

		} else {

			ret = "master/assignLogin";

			try {

				GetEmployeeDetails[] empdetList1 = Constants.getRestTemplate()
						.getForObject(Constants.url + "/getAllEmployeeDetailForLoginType", GetEmployeeDetails[].class);

				List<GetEmployeeDetails> empdetList = new ArrayList<GetEmployeeDetails>(Arrays.asList(empdetList1));
				model.addAttribute("empdetList", empdetList);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return ret;
	}
	
	@RequestMapping(value = "/submitAssignLoginType", method = RequestMethod.POST)
	public String submitAssignDesnToEmp(HttpServletRequest request, HttpServletResponse response) {
		String ret=new String();
		HttpSession session = request.getSession();

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		
		List<AccessRightModule> newModuleList = (List<AccessRightModule>) session.getAttribute("moduleJsonList");
		Info addEdit = AcessController.checkAccess("showAssignLogin", "showAssignLogin", 0, 1, 0, 0,
				newModuleList);

		if (addEdit.isError() == true) {
			ret = "redirect:/aceessDenied";
		}else {
			ret ="redirect:/showAssignLogin";
		}
		
		try {

			String loginType = null;
			try {
				loginType = request.getParameter("login_type");
			} catch (Exception e) {
				e.printStackTrace();
			}

			String[] empId = request.getParameterValues("empId");

			StringBuilder sb = new StringBuilder();

			List<Integer> empIdList = new ArrayList<>();

			for (int i = 0; i < empId.length; i++) {
				sb = sb.append(empId[i] + ",");
				empIdList.add(Integer.parseInt(empId[i]));

			}

			String items = sb.toString();

			items = items.substring(0, items.length() - 1);
			
			map.add("empIdList", items);
			map.add("loginType", loginType);

			Info info = Constants.getRestTemplate().postForObject(Constants.url + "/assignEmpLoginType", map,
					Info.class);

			if(info.isError()==false) {
				session.setAttribute("successMsg", "Login Type Assigned Successfully");
			}else {
				session.setAttribute("errorMsg", "Failed to Assign Login Type");
			}

		} catch (Exception e) {
			System.err.println("Exce in submitAssignLoginType  " + e.getMessage());
			e.printStackTrace();
		}

		return ret;
	}
	
	//sendUserCredByEmail
	@RequestMapping(value = "/sendUserCredByEmail", method = RequestMethod.GET)
	public @ResponseBody Info sendUserCredByEmail(Locale locale, Model model,
			HttpServletRequest request, HttpServletResponse response) {
	
		Info info=new Info();
		
		try {
			RandomString rs=new RandomString();
			String password=  rs.nextString();
			System.err.println("password " +password);
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			
			int empId=Integer.parseInt(request.getParameter("empId"));
			String empEmail= request.getParameter("empEmail");
			System.err.println("empEmail " +empEmail);

			EmailUtility.sendEmailWithSubMsgAndToAdd("HR Application Credentials ", "Your credentials to use the HR Application as below "
					+ "\n User name: " + empEmail + " \n Password : " + password,empEmail);
			
			MessageDigest md = MessageDigest.getInstance("MD5");
			byte[] messageDigest = md.digest(password.getBytes());
			BigInteger number = new BigInteger(1, messageDigest);
			String hashtext = number.toString(16);
			
			 map.add("password", hashtext);
			 map.add("empId", empId);
			 map.add("isVisit", 1); 
			 info = Constants.getRestTemplate().postForObject(Constants.url + "/updateUserPassAndExInt1", map, Info.class);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return info;
	}

}

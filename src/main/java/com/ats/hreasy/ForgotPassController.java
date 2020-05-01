package com.ats.hreasy;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.util.Calendar;
import java.util.LinkedHashMap;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
import org.springframework.web.servlet.ModelAndView;

import com.ats.hreasy.common.Constants;
import com.ats.hreasy.common.DateConvertor;
import com.ats.hreasy.common.EmailUtility;
import com.ats.hreasy.model.EmployeeMaster;
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
					session.setAttribute("errorPassMsg1", "Invalid User Name !");
				}
				SessionKeyGen.changeSessionKey(request);
			} catch (Exception e) {
				SessionKeyGen.changeSessionKey(request);
				System.err.println("Exce in checkUserAndSendOtpEmail  " + e.getMessage());
				e.printStackTrace();
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

					Info errMsg = Constants.getRestTemplate().postForObject(Constants.url + "/updateUserPass", map, Info.class);
					session.removeAttribute("userId");

					session.setAttribute("errorMsg", "Password Changed Successfully");
					//session.invalidate();
					return "redirect:/";
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

}

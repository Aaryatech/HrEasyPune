package com.ats.hreasy.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@Scope("session")
public class HandleError {

	@RequestMapping(value = "errors", method = RequestMethod.GET)
	public String renderErrorPage(HttpServletRequest httpRequest, Model model) {

		String errorPage = "error404";
		String errorMsg = "";
		int httpErrorCode = getErrorCode(httpRequest);

		switch (httpErrorCode) {
		case 400: {
			errorMsg = "Bad Request";
			break;
		}
		case 401: {
			errorMsg = "Unauthorized";
			break;
		}
		case 404: {
			errorMsg = "Resource not found";
			break;
		}
		case 500: {
			errorMsg = "Internal Server Error";
			break;
		}
		}
		model.addAttribute("errorMsg", errorMsg);
		return errorPage;
	}

	private int getErrorCode(HttpServletRequest httpRequest) {
		System.err.println("Hi");

		return (Integer) httpRequest.getAttribute("javax.servlet.error.status_code");
	}

}

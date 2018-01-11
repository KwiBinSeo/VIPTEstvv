package com.cglab.smartplace;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	/*
	@RequestMapping(value = "/menu1by2", method = {RequestMethod.GET,RequestMethod.POST})
	public String menu1by2(Locale locale, Model model) throws SQLException{	
		String URL = "jdbc:mysql://220.69.209.170/smartplace";
		String DB_NAME = "cglab";
		String DB_PW = "clws";
		Connection con = DriverManager.getConnection(URL,DB_NAME,DB_PW);
		PreparedStatement occu;
		ResultSet rs = null, rs2=null;
		int i=0, count=0;

		occu = con.prepareStatement("select construction from construction");

		rs2 = occu.executeQuery();
		while(rs2.next())
		{
			
			model.addAttribute("temp", rs2.getString(1) );
			count++;
			
		}
		//인원 행 개수
		model.addAttribute("count", count);
		
		//인원 db 내보내기
		rs = occu.executeQuery();
		String[] rsarray = new String[count];
		while(rs.next())
		{
			rsarray[i] =  rs.getString(1);
			model.addAttribute("occu"+i, rsarray[i]);
			
			i++;
			
		}
		model.addAttribute("rsarray",rsarray);
			
		return "menu1by2";

	}
	*/
	
}

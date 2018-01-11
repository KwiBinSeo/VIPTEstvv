package com.cglab.smartplace;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cglab.smartplace.AllData; // Data 객체 입력 부분 추가

/**
 * Servlet implementation class menu1by1Toby2
 */
public class menu1by1Toby2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	/**
     * @see HttpServlet#HttpServlet()
     */
    public menu1by1Toby2() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		response.setCharacterEncoding("euc-kr");
		//AllData AD = new AllData(); // AllData 객체 생성
		
		HttpSession session = request.getSession(); //세션 객체 생성
		request.setCharacterEncoding("utf-8"); // request된 데이터 utf-8로 인코딩
		
		PrintWriter out = response.getWriter();
		
		//AD.today_issue = request.getParameter("issue"); // issue 값을 입력받아 AllData 객체의 today_issue 변수에 초기화
		session.setAttribute("today_issue", request.getParameter("issue")); // issue 값을 받아 today_issue session 객체를 생성하고 저장한다.
		
		String weather_check = request.getParameter("weather"); // weather 값을 입력받아 string형 변수 weather_check 변수에 초기화
		
		if(weather_check.equals("1")) {
			//AD.today_weather = "맑음";
			session.setAttribute("today_weather", "맑음");
		} else if(weather_check.equals("2")) {
			//AD.today_weather = "구름 많음";
			session.setAttribute("today_weather", "구름 많음");
		} else if(weather_check.equals("3")) {
			//AD.today_weather = "비";
			session.setAttribute("today_weather", "비");
		} else if(weather_check.equals("4")) {
			//AD.today_weather = "눈";
			session.setAttribute("today_weather", "눈");
		} else {
			System.out.println("이상한 날짜 데이터가 들어왔습니다!!");
		}
		
		//AD.setTodayIssue(request.getParameter("issue")); // issue 값을 입력받아 AllData 객체의 today_issue 변수에 초기화
		//out.println(AD.getTodayIssue());
		//response.sendRedirect("menu1by2.jsp");
		// today_issue에 데이터가 있으면 실행
		
		String today_weather_session_check = (String) session.getAttribute("today_weather");
		
		System.out.println("금일 날씨 : " + today_weather_session_check);
		
		if(today_weather_session_check == null || today_weather_session_check.equals("")) {
			out.println("<script>");
			out.println("alert(금일 예정사 사항을 입력하세요.)");
			out.println("history.go(-1)"); //이전 페이지 이동
			out.println("</script>");
			response.sendRedirect("menu1by1.jsp"); //로그인 실패 시 index.jsp 이동
		
		} else {
			response.sendRedirect("menu1by2.jsp");
		}
	}
}

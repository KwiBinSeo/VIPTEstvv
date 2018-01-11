package com.cglab.smartplace;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Calendar;
import java.util.GregorianCalendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class TotalInsertData
 */
public class TotalInsertData extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	AllData AD = new AllData();
	
	// 변수 선언
	private String User_ID = "";
	private String User_PW = "";
	private boolean Login_Check = false; // 로그인 체크
	private boolean Input_Check = false; // 입력 받는 데이터(아이디, 비밀번호) 체크
	
	// DB 연결 관련 변수
	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;
	ResultSet rs = null;
	String URL = "jdbc:mysql://220.69.209.170/smartplace";
	String DB_NAME = "cglab";
	String DB_PW = "clws";
	String query = "";
	
	// 날짜
	String today = "";
    
	/**
     * @see HttpServlet#HttpServlet()
     */
    public TotalInsertData() {
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
		
		HttpSession session = request.getSession(); //세션 객체 생성
		
		// 오늘 날짜를 구하는 부분
		GregorianCalendar calendar = new GregorianCalendar();
		User_ID = (String) session.getAttribute("User_ID");
		User_PW = (String) session.getAttribute("User_PW");
		AD.name = (String) session.getAttribute("User_NAME");
		AD.position = (String) session.getAttribute("User_POSITION");
		AD.area_number = (String) session.getAttribute("User_AREA_NUMBER");
		AD.management_area = (String) session.getAttribute("User_AREA");
		
		String[] weekDay = {"일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"};
		calendar.add(Calendar.DATE, 0); // 금일 날짜 가져오기
	 	int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH) + 1;
		int date = calendar.get(Calendar.DATE);
		int num = calendar.get(Calendar.DAY_OF_WEEK);
		today = Integer.toString(year) + "년 " + Integer.toString(month) + "월 " + Integer.toString(date) + "일 " + weekDay[num]; // 오늘 날짜	
		// 오늘 날짜를 구하는 부분
		
		//AD.today_issue = "he";
		//AD.today_weather = "맑음";
		
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			
			conn = DriverManager.getConnection(URL, DB_NAME, DB_PW);
			
			// 작업일보 데이터 삽입
			query = "insert into workissue(date,id,issue,weather) values(?,?,?,?)";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,today);
			pstmt.setString(2,User_ID);
			pstmt.setString(3,AD.today_issue);
			pstmt.setString(4,AD.today_weather);
			
			pstmt.executeUpdate();
			pstmt.close();
			
			// 공종 작업현황 데이터 삽입 및 갱신
			
			// 인원 현황 데이터 삽입
			
			// 장비투입 현황 데이터 삽입
			//query = "select area_number, id from construction_list where id="+"User_ID";
			//pstmt = conn.prepareStatement(query);
			
			//pstmt.setString(1, User_ID);
			//rs = pstmt.executeQuery();
			stmt = conn.createStatement(); 
			for(int index = 0; index < AD.construction_list_count; index++) {
				String sql = "update construction_list set today_result = "+"AD.today_result.get("+index+")"+" where id = "+"'"+"User_ID" +"'" + " AND " + "construction_number = " +"'"+ "AD.construction_number.get("+index+")" +"'";
				stmt.executeUpdate(sql);
			}
			
			// 자재 투입 현황 데이터 삽입
			
			//stmt = conn.createStatement(); // 상태 확인
			//stmt.executeUpdate(query); // 쿼리문 실행
		} catch(Exception e) {
			e.printStackTrace();
		}
		response.sendRedirect("menu1by1.jsp");
	}

}
